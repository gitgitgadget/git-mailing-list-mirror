From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 01:52:07 -0500
Message-ID: <20110111065207.GF10094@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
 <7vipy0483h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 07:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcY5Z-0005vL-90
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 07:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab1AKGwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 01:52:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60529 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab1AKGwL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 01:52:11 -0500
Received: (qmail 11845 invoked by uid 111); 11 Jan 2011 06:52:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 06:52:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 01:52:07 -0500
Content-Disposition: inline
In-Reply-To: <7vipy0483h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164913>

On Fri, Jan 07, 2011 at 03:17:22PM -0800, Junio C Hamano wrote:

> ... And this comes on top (should probably be squashed into one) to really
> favor a branch over a tag.
> 
>  builtin/checkout.c               |   26 ++++++++++----------------
>  t/t2019-checkout-amiguous-ref.sh |    2 +-
>  2 files changed, 11 insertions(+), 17 deletions(-)

Yeah, that looks sane to me (assuming all three patches squashed
together). It took me a minute to figure out one subtlety, though:

> +		if ((check_ref_format(new.path) != CHECK_REF_FORMAT_OK) ||
> +		    !resolve_ref(new.path, rev, 1, NULL))
> +			new.path = NULL; /* not an existing branch */
> +
> +		if (!(new.commit = lookup_commit_reference_gently(rev, 1))) {

We are relying on the fact that resolve_ref leaves "rev" alone in the
case that it does not find anything. Which is mostly true (the only
exception seems to be if you have a ref with non-hex garbage in it, in
which case you will get some bogus sha1 in the output). I dunno if it is
worth making it more explicit, like:

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f6f6172..afff56f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -678,7 +678,7 @@ static const char *unique_tracking_name(const char *name)
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	unsigned char rev[20];
+	unsigned char rev[20], branch_rev[20];
 	const char *arg;
 	struct branch_info new;
 	struct tree *source_tree = NULL;
@@ -834,8 +834,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		new.name = arg;
 		setup_branch_path(&new);
 
-		if ((check_ref_format(new.path) != CHECK_REF_FORMAT_OK) ||
-		    !resolve_ref(new.path, rev, 1, NULL))
+		if ((check_ref_format(new.path) == CHECK_REF_FORMAT_OK) &&
+		     resolve_ref(new.path, branch_rev, 1, NULL))
+			hashcpy(rev, branch_rev);
+		else
 			new.path = NULL; /* not an existing branch */
 
 		if (!(new.commit = lookup_commit_reference_gently(rev, 1))) {

My version somehow looks uglier, but I just worry about resolve_ref
violating this undocumented subtlety sometime in the future.

Also, one other question while we are on the subject. I think we all
agree that "git checkout $foo" should prefer $foo as a branch. But what
about "git checkout -b $branch $start_point"? Should $start_point follow
the same "prefer branches" rule, or should it use the usual ref lookup
rules?

I was surprised to find that the current behavior is to die(), due to an
explicit case in branch.c:create_branch.

-Peff
