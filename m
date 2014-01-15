From: Jeff King <peff@peff.net>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Wed, 15 Jan 2014 05:46:13 -0500
Message-ID: <20140115104612.GE14335@sigill.intra.peff.net>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
 <20140106152742.GA26221@sigill.intra.peff.net>
 <xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
 <20140106193625.GA27062@sigill.intra.peff.net>
 <xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
 <20140106230348.GA7811@sigill.intra.peff.net>
 <xmqq4n5ghf0z.fsf@gitster.dls.corp.google.com>
 <7vtxdg1nsg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 11:46:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3NzK-0007eb-FU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 11:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbaAOKqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 05:46:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:32769 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750705AbaAOKqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 05:46:17 -0500
Received: (qmail 15467 invoked by uid 102); 15 Jan 2014 10:46:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 04:46:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 05:46:13 -0500
Content-Disposition: inline
In-Reply-To: <7vtxdg1nsg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240450>

On Mon, Jan 06, 2014 at 07:19:43PM -0800, Junio C Hamano wrote:

> Actually, I think the above recollection of mine was completely
> bogus.  The && is there because we do allow things like "HEAD" (they
> are the funny ones) as well as things inside refs/, and the latter
> is the only thing we had a check-ref-format to dictate the format
> when the code was written.
> 
> I do not mind tightening things a bit (e.g. outside refs/, only
> allow HEAD and nothing else).  A good first step might be to enforce
> allow-onelevel outside refs/ (so that we can allow "HEAD") and for
> those inside refs/ check without allow-onelevel but without skipping
> the prefix.
> 
> It is a separate story if it makes much sense to allow fetching
> refs/stash or ignoring when running "git clone".  Operationally, I
> think it makes more sense to ignore refs/stash, not because it is a
> one-level name, but because what a stash is.

This discussion stalled, but I finally got around to looking at it
today. I agree that we should leave aside more complex policy for now,
and start with bringing the "fetch" and "fetch-pack" filters into
harmony. That turns off format-checking for things outside "refs/" (so
allows "HEAD"), and checks the whole string for things inside "refs/"
(so it does not fall afoul of the one-level check).

I ended up with the patch below, which converts fetch-pack to match
fetch. However, reading the original one-level check in 03feddd
(git-check-ref-format: reject funny ref names., 2005-10-13), it does
seem like it was meant to reject "refs/foo". It contains:

        if (level < 2)
                return -1; /* at least of form "heads/blah" */

It seems like the meaning of this check changed over the years. I am not
sure if that was intentional or not. :)

So we could go the other direction, and harmonize on disallowing
"refs/foo". I don't particularly care that much. The nasty thing now is
the mismatch between the two spots, which means that "fetch" doesn't
just ignore the ref, but bombs out with a missing object.


-- >8 --
Subject: fetch-pack: do not filter out one-level refs

Currently fetching a one-level ref like "refs/foo" does not
work consistently. The outer "git fetch" program filters the
list of refs, checking each against check_refname_format.
Then it feeds the result to do_fetch_pack to actually
negotiate the haves/wants and get the pack. The fetch-pack
code does its own filter, and it behaves differently.

The fetch-pack filter looks for refs in "refs/", and then
feeds everything _after_ the slash (i.e., just "foo") into
check_refname_format.  But check_refname_format is not
designed to look at a partial refname. It complains that the
ref has only one component, thinking it is at the root
(i.e., alongside "HEAD"), when in reality we just fed it a
partial refname.

As a result, we omit a ref like "refs/foo" from the pack
request, even though "git fetch" then tries to store the
resulting ref.  If we happen to get the object anyway (e.g.,
because the ref is contained in another ref we are
fetching), then the fetch succeeds. But if it is a unique
object, we fail when trying to update "refs/foo".

We can fix this by just passing the whole refname into
check_refname_format; we know the part we were omitting is
"refs/", which is acceptable in a refname. This at least
makes the checks consistent with each other.

This problem happens most commonly with "refs/stash", which
is the only one-level ref in wide use. However, our test
does not use "refs/stash", as we may later want to restrict
it specifically (not because it is one-level, but because
of the semantics of stashes).

We may also want to do away with the multiple levels of
filtering (which can cause problems when they are out of
sync), or even forbid one-level refs entirely. However,
those decisions can come later; this fixes the most
immediate problem, which is the mismatch between the two.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c     |  2 +-
 t/t5510-fetch.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 760ed16..b28ccd1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -505,7 +505,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		next = ref->next;
 
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name + 5, 0))
+		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else {
 			while (i < nr_sought) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 12674ac..ab28594 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -640,4 +640,15 @@ test_expect_success 'branchname D/F conflict resolved by --prune' '
 	test_cmp expect actual
 '
 
+test_expect_success 'fetching a one-level ref works' '
+	test_commit extra &&
+	git reset --hard HEAD^ &&
+	git update-ref refs/foo extra &&
+	git init one-level &&
+	(
+		cd one-level &&
+		git fetch .. HEAD refs/foo
+	)
+'
+
 test_done
-- 
1.8.5.2.500.g8060133
