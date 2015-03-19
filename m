From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] fetch_refs_via_pack: free extra copy of refs
Date: Thu, 19 Mar 2015 16:38:35 -0400
Message-ID: <20150319203834.GC7666@peff.net>
References: <20150319203126.GA31663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhDL-0007b5-74
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbbCSUii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:38:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:35428 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbbCSUih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:38:37 -0400
Received: (qmail 3640 invoked by uid 102); 19 Mar 2015 20:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 15:38:37 -0500
Received: (qmail 17289 invoked by uid 107); 19 Mar 2015 20:38:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:38:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 16:38:35 -0400
Content-Disposition: inline
In-Reply-To: <20150319203126.GA31663@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265828>

When fetch_refs_via_pack calls fetch_pack(), we pass a
list of refs to fetch, and the function returns either a
copy of that list, with the fetched items filled in, or
NULL. We check the return value to see whether the fetch was
successful, but do not otherwise look at the copy, and
simply leak it at the end of the function.

Signed-off-by: Jeff King <peff@peff.net>
---
Without patch 2, this segfaults in t5516. :)

 transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/transport.c b/transport.c
index 0694a7c..b1953b2 100644
--- a/transport.c
+++ b/transport.c
@@ -519,7 +519,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
-	const struct ref *refs;
+	struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
@@ -552,15 +552,17 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
-	if (finish_connect(data->conn))
+	if (finish_connect(data->conn)) {
+		free_refs(refs);
 		refs = NULL;
+	}
 	data->conn = NULL;
 	data->got_remote_heads = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 
 	free_refs(refs_tmp);
-
+	free_refs(refs);
 	free(dest);
 	return (refs ? 0 : -1);
 }
-- 
2.3.3.520.g3cfbb5d
