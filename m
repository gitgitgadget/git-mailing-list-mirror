From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/8] upload/receive-pack: allow hiding ref hierarchies
Date: Wed, 6 Feb 2013 06:31:12 -0500
Message-ID: <20130206113112.GB5267@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-4-git-send-email-gitster@pobox.com>
 <20130205085047.GA24973@sigill.intra.peff.net>
 <7vwqumvk76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 12:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U33E3-0007mz-F0
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 12:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab3BFLbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 06:31:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36541 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab3BFLbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 06:31:16 -0500
Received: (qmail 4480 invoked by uid 107); 6 Feb 2013 11:32:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 06:32:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 06:31:12 -0500
Content-Disposition: inline
In-Reply-To: <7vwqumvk76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215575>

On Tue, Feb 05, 2013 at 07:45:01AM -0800, Junio C Hamano wrote:

> > In the earlier review, I mentioned making this per-service, but I see
> > that is not the case here. Do you have an argument against doing so?
> 
> Perhaps then I misunderstood your intention.  By reminding me of the
> receive-pack side, I thought you were hinting to unify these two
> into one, which I did.  There is no argument against it.

What I meant was that there should be transfer.hiderefs, and an
individual {receive,uploadpack}.hiderefs, similar to the way we have
transfer.unpacklimit. That makes the easy case (hiding the refs
completely) easy, but leaves the flexibility for more.

Like this:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a8248d9..131c163 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -59,7 +59,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static int receive_pack_config(const char *var, const char *value, void *cb)
 {
-	int status = parse_hide_refs_config(var, value, cb);
+	int status = parse_hide_refs_config(var, value, "receive");
 
 	if (status)
 		return status;
diff --git a/refs.c b/refs.c
index e3574ca..9bfea58 100644
--- a/refs.c
+++ b/refs.c
@@ -2560,9 +2560,13 @@ int parse_hide_refs_config(const char *var, const char *value, void *unused)
 
 static struct string_list *hide_refs;
 
-int parse_hide_refs_config(const char *var, const char *value, void *unused)
+int parse_hide_refs_config(const char *var, const char *value, void *vsection)
 {
-	if (!strcmp("transfer.hiderefs", var)) {
+	const char *section = vsection;
+
+	if (!strcmp("transfer.hiderefs", var) ||
+	    (!prefixcmp(var, section) &&
+	     !strcmp(var + strlen(section), ".hiderefs"))) {
 		char *ref;
 		int len;
 
diff --git a/upload-pack.c b/upload-pack.c
index 37977e2..c0390af 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -794,7 +794,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var))
 		allow_tip_sha1_in_want = git_config_bool(var, value);
-	return parse_hide_refs_config(var, value, unused);
+	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
 int main(int argc, char **argv)


As an aside, I wonder if there is any point to the void pointer
parameter of parse_hide_refs_config. It is not used as a git_config
callback anywhere.

> > And I
> > have not seen complaints about the current system.
> 
> Immediately after I added github to the set of places I push into,
> which I think is long before you joined GitHub, I noticed that _my_
> repository gets contaminated by second rate commits called pull
> requests, and I may even have complained, but most likely I didn't,
> as I could easily tell that, even though I know it is _not_ the only
> way, nor even the best way [*1*], to implement the GitHub's pull
> request workflow, I perfectly well understood that it would be the
> most expedient way for GitHub folks to implement this feature.
> 
> I think you should take lack of complaints with a huge grain of
> salt.  It does not suggest much.

Sure, I do not pretend that nobody cares. But it is certainly not a
pressing issue, or there would probably be more outcry. And we must also
weigh it against the silent majority that are perfectly happy with the
status quo, that lets them fetch refs/pull/* as any other ref.

In your case, I really think the problem is less that you have a problem
with PR refs in the repository, and more that you do not care about the
pull request feature at all. To you it is useless noise, both in the
repo and on the web. Your arguments about provenance could apply equally
well to PRs accessible via the web interface.

I think the refs/ clutter is only an issue if you want to do mirroring,
and then you have an obvious conflict: did the fetcher want to mirror
everything, including refs/pull, or do they consider that to be clutter?
Only the client knows, which is why I think refspecs are the right place
to deal with clutter (the fact that we cannot say "everything except
refs/pull/*" is a weakness in our refspecs).

> *1* From the ownership point of view, objects that are only
> reachable from these refs/pull/* refs do *not* belong to the
> requestee, until the requestee chooses to accept the changes.
> 
> A malicious requestor can fork your repository, add an objectionable
> blob to it, and throw a pull request at you.  GitHub shows that the
> blob now belongs to your repository, so the requestor turns around
> and file a DMCA takedown complaint against your repository.  A
> clueful judge would then agree with the complaint after running a
> "clone --mirror" and seeing the blob in your repository.  Oops?

I don't think this is a problem in practice. DMCA notices do not go to
the repository owner; they go to GitHub. And as far as I know, our
support staff deals with them on a case by case basis (and knows what a
pull request is, and who is responsible for the content in question). It
is not like they see a report of something in refs/pull and lock down
the parent repository; they can see where the request came from and deal
with it appropriately.

But again, such a notice could just as easily come from the list of open
PRs against your repo in the web interface.

> A funny thing is that you cannot "push :refs/pull/1/head" to remove
> it anymore (I think in the early days, I took them out by doing this
> a few times, but I may be misremembering),

We block updates to them explicitly in a hook; it looks like that went
in around mid-2011.

> The e-mail sent to you to let you know about outstanding pull
> requests and the web UI could just point at that forked repository,
> not your own (you also could choose to leave the outging pull
> requests in the requestor's repository, but that is only OK if you
> do not worry about (1) a requestor sending a pull request, then
> updating the branch the pull request talks about later, to trick you
> with bait-and-switch, or (2) a requestor sending a pull request,
> thinks he is done with the topic and removes the repository).

Yes, point (2) is the main reason they are not simply attached to the
sender's repository.

-Peff
