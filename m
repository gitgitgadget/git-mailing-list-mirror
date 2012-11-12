From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-sh-setup: refactor ident-parsing functions
Date: Mon, 12 Nov 2012 14:44:34 -0500
Message-ID: <20121112194434.GB4623@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072522.GA9999@sigill.intra.peff.net>
 <7vpq3ik97i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:44:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXzwD-0004Hz-1X
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 20:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2KLToj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 14:44:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44910 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab2KLToi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 14:44:38 -0500
Received: (qmail 13011 invoked by uid 107); 12 Nov 2012 19:45:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 14:45:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 14:44:34 -0500
Content-Disposition: inline
In-Reply-To: <7vpq3ik97i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209512>

On Mon, Nov 12, 2012 at 09:44:01AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The only ident-parsing function we currently provide is
> > get_author_ident_from_commit. This is not very
> > flexible for two reasons:
> >
> >   1. It takes a commit as an argument, and can't read from
> >      commit headers saved on disk.
> >
> >   2. It will only parse authors, not committers.
> >
> > This patch provides a more flexible interface which will
> > parse multiple idents from a commit provide on stdin. We can
> > easily use it as a building block for the current function
> > to retain compatibility.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Since we are counting processes in this series, I should note that this
> > actually adds a subshell invocation for each call, since it went from:
> >
> >   script='...'
> >   sed $script
> >
> > to:
> >
> >   sed "$(make_script)"
> >
> > For filter-branch, which is really the only high-performance caller we
> > have, this is negated by the fact that it will do author and committer
> > at the same time, saving us an extra subshell (in addition to an extra
> > sed invocation).
> 
> Given that pick-ident-script is a const function, a caller that
> repeatedly call is could call it once and use it in a variable, no?

The problem is that it is a helper called from parse_ident_from_commit.
And that function just passes along its arguments, so it does not know
that it is being called repeatedly with the same arguments. So you'd
have to either change the interface or memoize internally.

I don't think memoization is a good option for two reasons:

  1. Storing the arguments to compare to later is complex. You don't
     want to just store "$*" from the last run and see if we got the
     same arguments. You'd have to quote your delimiter (e.g., you would
     not want to confuse ("foo", "bar") with ("foo bar"). Though in this
     instance, we know that our args do not have spaces, so we could get
     away with that.

  2. If you are in a subshell or even a while loop, your memoized
     variable will not be retained.

So unless somebody has some clever scheme for memoizing shell functions
without any process overhead, it is probably not worth it.

Changing the interface for get_author_ident_from_commit would be a pain,
but if we just wanted to help filter-branch, we could do something like
this:

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5314249..7a693ba 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -74,7 +74,7 @@ finish_ident() {
 }
 
 set_ident () {
-	parse_ident_from_commit author AUTHOR committer COMMITTER
+	parse_ident_from_commit_via_script "$ident_script"
 	finish_ident AUTHOR
 	finish_ident COMMITTER
 }
@@ -93,6 +93,7 @@ if [ "$(is_bare_repository)" = false ]; then
 	require_clean_work_tree 'rewrite branches'
 fi
 
+ident_script=$(pick_ident_script author AUTHOR committer COMMITTER)
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 22f0aed..1e20e17 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -225,10 +225,17 @@ pick_ident_script () {
 	echo '/^$/q'
 }
 
+# Feed a pick_ident_script return value to sed. Use this instead of
+# parse_ident_from_commit below if you are going to be parsing commits in a
+# tight loop and want to save a process.
+parse_ident_from_commit_via_script() {
+	LANG=C LC_ALL=C sed -ne "$1"
+}
+
 # Create a pick-script as above and feed it to sed. Stdout is suitable for
 # feeding to eval.
 parse_ident_from_commit () {
-	LANG=C LC_ALL=C sed -ne "$(pick_ident_script "$@")"
+	parse_ident_from_commit_via_script "$(pick_ident_script "$@")"
 }
 
 # Parse the author from a commit given as an argument. Stdout is suitable for
