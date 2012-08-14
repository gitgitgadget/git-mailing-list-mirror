From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 22:02:10 -0400
Message-ID: <20120814020210.GB7891@sigill.intra.peff.net>
References: <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
 <20120813205423.GA31630@sigill.intra.peff.net>
 <7v628mcxdf.fsf@alter.siamese.dyndns.org>
 <20120813211109.GA32688@sigill.intra.peff.net>
 <20120814015927.GA7891@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 04:02:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T16SZ-0001Qh-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 04:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab2HNCCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 22:02:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36757 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820Ab2HNCCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 22:02:12 -0400
Received: (qmail 32172 invoked by uid 107); 14 Aug 2012 02:02:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Aug 2012 22:02:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2012 22:02:10 -0400
Content-Disposition: inline
In-Reply-To: <20120814015927.GA7891@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203380>

On Mon, Aug 13, 2012 at 09:59:27PM -0400, Jeff King wrote:

> So if we want to avoid the allocation, then this is how I would do it:
> by returning the feature's _value_ and not the whole key. Since we know
> that the beginning part must obviously match what we fed it anyway, it
> is not that interesting.
> 
> -- >8 --
> Subject: [PATCH] parse_feature_request: make it easier to see feature values

And here is the rebased 4/4 on top of that.

At this point, I think this part of the topic has received more than
enough attention. Please feel free to apply these patches, your patches,
or even just drop it altogether (and when somebody has a more compelling
reason to actually parse such a value, they can resurrect the
infrastructure patch).

-- >8 --
Subject: [PATCH] fetch-pack: mention server version with verbose output

Fetch-pack's verbose mode is more of a debugging mode (and
in fact takes two "-v" arguments to trigger via the
porcelain layer). Let's mention the server version as
another possible item of interest.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bc7a0f9..3b2b5a4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -787,6 +787,8 @@ static struct ref *do_fetch_pack(int fd[2],
 {
 	struct ref *ref = copy_ref_list(orig_ref);
 	unsigned char sha1[20];
+	const char *agent_feature;
+	int agent_len;
 
 	sort_ref_list(&ref, ref_compare_name);
 
@@ -823,8 +825,14 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (server_supports("agent"))
+
+	if ((agent_feature = server_feature_value("agent", &agent_len))) {
 		agent_supported = 1;
+		if (args.verbose && agent_len) {
+			fprintf(stderr, "Server version is %.*s\n",
+				agent_len, agent_feature);
+		}
+	}
 
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
-- 
1.7.12.rc2.11.gf0a1e27
