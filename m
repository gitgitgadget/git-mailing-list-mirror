From: Jeff King <peff@peff.net>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Tue, 8 Dec 2009 02:38:59 -0500
Message-ID: <20091208073859.GA12049@coredump.intra.peff.net>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
 <7vvdgindo3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHuf8-0001cc-1A
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbZLHHi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZLHHi6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:38:58 -0500
Received: from peff.net ([208.65.91.99]:43490 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbZLHHi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:38:57 -0500
Received: (qmail 9136 invoked by uid 107); 8 Dec 2009 07:43:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 02:43:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 02:38:59 -0500
Content-Disposition: inline
In-Reply-To: <7vvdgindo3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134830>

On Mon, Dec 07, 2009 at 11:11:08PM -0800, Junio C Hamano wrote:

> I was wondering about the same thing while bisecting.  By the current
> definition of "diff --git", removing the "deleted file" or "new file" line
> makes the patch an invalid "git format diff".  See the beginning of
> parse_git_header() where we say "we don't guess" and initialize both
> is_new and is_delete to false (and we flip them upon seeing "deleted file"
> and "new file", but never with "/dev/null").

Hmm. In that case, I think converting it to deletion is definitely
wrong; "diff --git" is about not guessing. So the only question is
whether it should be flagged as an error. I was somewhat worried that
you could produce a patch which would make apply complain by doing "git
diff /dev/null /your/file". But actually that already produces a "new
file" header (and the opposite produces a "deleted file" header).

So I think the patch below would notice both the new and deleted cases,
and is probably a good thing.

diff --git a/builtin-apply.c b/builtin-apply.c
index c8372a0..43a1535 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -673,8 +673,12 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
  */
 static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, const char *oldnew)
 {
-	if (!orig_name && !isnull)
+	if (!orig_name && !isnull) {
+		if (!memcmp(line, "/dev/null\n", 10))
+			die("git apply: bad git-diff - expected filename, got /dev/null on line %d", linenr);
 		return find_name(line, NULL, p_value, TERM_TAB);
+	}
+
 
 	if (orig_name) {
 		int len;

> I think some recent other SCMs produce what they claim to be "diff --git",
> but I don't know if they implement the format correctly enough.  I am not
> worried about their implemention of binary patches (if they do not
> implement it correctly they will most likely get garbage), but do they get
> the abbreviated hash on the "index" line correctly?  You can put garbage
> on the line and most of the time it would work but it will break "am -3"
> by breaking "apply --build-fake-ancestor".
> 
> I just checked "hg diff --git"; at least it shows "deleted file".

Ugh. A whole new source of problems. :) I am not too interested in
seeking out and evaluating other SCM's implementations; I think we
should wait for people who actually use those systems to find
interoperability bugs, determine whether they are or are not simply bugs
in the other people's implementations, and then report the bug to us.

> > That would take some refactoring, though, as pulling the deletion hunk
> > out means we are re-ordering the headers. So right now if you did that
> > your ($head, @hunk) output would be something like:
> >
> >        diff --git a/foo b/foo
> >        index 257cc56..0000000
> >        --- a/foo
> >        +++ /dev/null
> >        deleted file mode 100644
> >        @@ -1 +0,0 @@
> >        -foo
> >
> > which is pretty weird.
> 
> I agree it is weird.

Note that we already do this for mode changes which also have a content
change. They look like:

  diff --git a/foo b/foo
  index 257cc56..19c6cc1
  --- a/foo
  +++ b/foo
  old mode 100644
  new mode 100755
  Stage mode change [y,n,q,a,d,/,j,J,g,?]?
  @@ -1 +1,2 @@
  foo
  +content
  Stage this hunk [y,n,q,a,d,/,K,g,e,?]?

> Interesting.  Does "add -p" (especially its [e]dit codepath) know enough
> about what it is doing?  If so, it should be able to add "deleted file" on
> its own (and remove it when the result of editing and picking hunks makes
> the patch a non-deletion).  For example, if you have a two-liner in the
> index and have deleted one line in the work tree, and run "add -p":

No, it doesn't know enough now. That would be part of the refactoring I
mentioned. I'm not sure how useful it is to support this. I can see
going from "I had hunk A, but I really wanted to tweak it to hunk B". I
can't think of a single time I've wanted "I deleted the entire file, but
I really wanted to keep 2 lines". And if I did, I would probably just:

  git checkout file
  $EDITOR file
  git add -p file

> Perhaps the "add -i" at the end should offer, after noticing that the
> chosen and edited hunks will make the postimage an empty file, a chance
> for the user to say "I not only want to remove the contents from the path,
> but want to remove the path itself" in such a case?
> 
> I dunno.

I would not say no to such a patch, but I really have no interest in
writing it myself.

-Peff
