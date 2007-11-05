From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 5 Nov 2007 18:46:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711051803231.7357@iabervon.org>
References: <20071105175654.GD6205@artemis.corp> <Pine.LNX.4.64.0711051259580.7357@iabervon.org>
 <20071105210711.GA9176@sigill.intra.peff.net> <Pine.LNX.4.64.0711051620230.7357@iabervon.org>
 <20071105225540.GA10988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBeD-00038R-8t
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbXKEXqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbXKEXqL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:46:11 -0500
Received: from iabervon.org ([66.92.72.58]:47222 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbXKEXqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:46:10 -0500
Received: (qmail 31917 invoked by uid 1000); 5 Nov 2007 23:46:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 23:46:08 -0000
In-Reply-To: <20071105225540.GA10988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63590>

On Mon, 5 Nov 2007, Jeff King wrote:

> On Mon, Nov 05, 2007 at 04:41:37PM -0500, Daniel Barkalow wrote:
> 
> > > Nope, that's not the problem. We _only_ update any tracking refs at all
> > > if ret == 0, and if we fail to push, then we are setting ret to -2.
> > 
> > That's an odd combination of behavior: we update some of the refs, leave 
> > the ones that didn't work alone, report success on the ones that worked, 
> > but then we forget that some things worked?
> 
> I think the current behavior is more odd. We mark some errors, and then
> if there were any possible pushes, we replace the marked errors with the
> status of the actual push, forgetting about the previous errors. Thus
> the behavior where if 'next' needs pushing, then we don't mark any errors
> at all (even though we spewed an error to stderr), but if it doesn't,
> then we return an error.
> 
> I don't mind being conservative with updating tracking refs; they really
> are just an optimization to avoid an extra git-fetch. But the most
> sensible behavior would be to mark errors for _each_ ref individually,
> try to push or update tracking branches where appropriate, and then
> return an error status based on all refs (whether they had an error in
> prep time or at push time).
> 
> Which I guess is what you were trying to accomplish by removing the
> peer_ref, though I think that doesn't distinguish between "didn't match
> a remote ref" and "had an error." Perhaps we just need an error flag in
> the ref struct?

That's possible, but I think we currently only care about per-ref stuff 
for whether we actually did a push to that ref, and we care about whether 
we had a failure that affects all refs, and we care (for the return value) 
whether we have any errors at all.

> > If we're going to refuse to update local tracking refs, whose state 
> > doesn't matter much, we should certainly refuse to update the remote refs, 
> > which are probably public and extremely important. If we just pushed and 
> 
> I would also be fine with that: if your intended push has _any_
> problems, then abort the push.
> 
> > we fetch, we should see exclusively changes that somebody else (including 
> > hooks remotely) did, not anything that we ourselves did.
> 
> I don't necessarily agree, just because the notion of "we" and "somebody
> else" is sort of pointless in a distributed system. I consider local
> tracking ref updates to be a "best guess" attempt to optimize and avoid
> a fetch (but one that will always be overwritten by the _actual_
> contents when you do fetch).

I think it's actually very significant what commits made locally have 
or haven't been made public.

> > I'd guess -2 is supposed to indicate that there were some errors but some 
> > things may have worked. If pack_objects() or receive_status() fails, we 
> 
> In that case, I think the simple fix is:
> 
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 947c42b..f773dc8 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -338,7 +338,7 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
>  
>  	packet_flush(out);
>  	if (new_refs && !args.dry_run)
> -		ret = pack_objects(out, remote_refs);
> +		ret |= pack_objects(out, remote_refs);
>  	close(out);
>  
>  	if (expect_status_report) {
> 
> and then we accept that we don't know _which_ refs shouldn't have their
> tracking branches updated (and we don't update any). But at least we
> don't forget that the error occured.
> 
> And the better solution is an error flag (or bitfield) in struct ref.

How about this, in addition to my previous dropping peer_ref:

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 947c42b..1b7206c 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -337,8 +343,10 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 	}
 
 	packet_flush(out);
-	if (new_refs && !args.dry_run)
-		ret = pack_objects(out, remote_refs);
+	if (new_refs && !args.dry_run) {
+		if (pack_objects(out, remote_refs))
+			ret = -4;
+	}
 	close(out);
 
 	if (expect_status_report) {
@@ -346,7 +354,7 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 			ret = -4;
 	}
 
-	if (!args.dry_run && remote && ret == 0) {
+	if (!args.dry_run && remote && ret != -4) {
 		for (ref = remote_refs; ref; ref = ref->next)
 			update_tracking_ref(remote, ref);
 	}

That is, -2 means that we've done less than was asked, but nothing blew 
up; -4 means something blew up. When we skip something, we drop peer_ref 
from it, so there's nothing to update (and it's dropped from the set of 
mappings, in case we cared further about it with respect to reporting the 
actions we actually took). Then we update all refs that were acted on if 
ret isn't -4, and we return non-zero if ret is either -2 or -4.

	-Daniel
*This .sig left intentionally blank*
