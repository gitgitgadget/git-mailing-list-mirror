From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Tue, 4 Nov 2008 21:49:32 -0500
Message-ID: <20081105024932.GA20907@coredump.intra.peff.net>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net> <20081104085630.GA22530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Nov 05 03:50:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxYTr-0007sz-CY
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 03:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbYKECtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 21:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbYKECtg
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 21:49:36 -0500
Received: from peff.net ([208.65.91.99]:3126 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbYKECtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 21:49:35 -0500
Received: (qmail 11425 invoked by uid 111); 5 Nov 2008 02:49:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 21:49:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 21:49:32 -0500
Content-Disposition: inline
In-Reply-To: <20081104085630.GA22530@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100135>

On Tue, Nov 04, 2008 at 09:56:30AM +0100, Clemens Buchacher wrote:

> The other status flags are REF_STATUS_REJECT_NODELETE and
> REF_STATUS_REJECT_NONFASTFORWARD. So in these cases the "new sha1" is going
> to be the "old sha1". The default for new_sha1 is the null sha1. So while
> the sha1 we're trying to push may not be more valid than the null sha1, it's
> not less valid either, is it? And it even makes sense if you interpret
> new_sha1 as the sha1 the client attempts to push.

I have to admit I did not exhaustively look at all of the status cases
when I reviewed earlier, and there are fewer than I realized. So I think
your change is reasonable.

However, I would like to make one additional request.  Since you are
killing off all usage of new_sha1 initial assignment, I think it makes
sense to just get rid of the variable entirely, so it cannot create
confusion later. Like this (on top of your patch):

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 4c17f48..d139eba 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -435,16 +435,13 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	 */
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-		const unsigned char *new_sha1;
-
 		if (!ref->peer_ref) {
 			if (!args.send_mirror)
 				continue;
-			new_sha1 = null_sha1;
+			hashcpy(ref->new_sha1, null_sha1);
 		}
 		else
-			new_sha1 = ref->peer_ref->new_sha1;
-		hashcpy(ref->new_sha1, new_sha1);
+			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 
 		ref->deletion = is_null_sha1(ref->new_sha1);
 		if (ref->deletion && !allow_deleting_refs) {

> > Hmm. I was hoping to see more in update_tracking_ref. With your patch,
> > we end up calling update_ref for _every_ uptodate ref, which results in
> > writing a new unpacked ref file for each one. And that _is_ a
> > performance problem for people with large numbers of refs.
> [...]
> I think update_ref already takes care of that. See this check in
> write_ref_sha1:
> 
>         if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
>                 unlock_ref(lock);
>                 return 0;
>         }

Nope. That check is a concurrency safeguard. It checks that when we are
moving the ref from "A" to "B", that the ref still _is_ "A" when we lock
it.

But more importantly, it is easy to demonstrate the problem with your
patch:

  mkdir parent &&
    (cd parent &&
       git init && touch file && git add file && git commit -m one) &&
  git clone parent child &&
    (cd child &&
       echo BEFORE: && ls -l .git/refs/remotes/origin &&
       git push &&
       echo AFTER:  && ls -l .git/refs/remotes/origin)

I get:

  BEFORE:
  -rw-r--r-- 1 peff peff 32 2008-11-04 21:43 HEAD
  Everything up-to-date
  AFTER:
  -rw-r--r-- 1 peff peff 32 2008-11-04 21:43 HEAD
  -rw-r--r-- 1 peff peff 41 2008-11-04 21:43 master

Oops. With the patch snippet I posted in my previous message, the
'master' ref is not created by the uptodate push.

> > Though I am not happy that we have to look up the tracking ref for every
> > uptodate ref. I think it shouldn't be a big performance problem with
> > packed refs, though, since they are cached (i.e., we pay only to compare
> > the hashes, not touch the filesystem for each ref).
> 
> I don't think we can avoid that, though.

No, you can't avoid it (without totally giving up on your patch's goal,
which I think is a good one). So I think it is worth it, and I was just
being paranoid about hurting performance. Even with packed refs, I think
we do still end up stat()ing for each ref, but we will have to live with
it. I was thinking we might be able to do something clever with values
we had already read for the push, but it is impossible: we have read the
refs we are going to _push_, but we have not looked at the remote
tracking branches, which are what contain the interesting information.

-Peff
