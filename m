From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] fetch-pack: sort incoming heads
Date: Mon, 21 May 2012 18:17:02 -0400
Message-ID: <20120521221702.GA22914@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:17:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWaud-0001cV-I3
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab2EUWRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:17:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51128
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab2EUWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:17:05 -0400
Received: (qmail 6940 invoked by uid 107); 21 May 2012 22:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:17:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:17:02 -0400
Content-Disposition: inline
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198136>

There's no reason to preserve the incoming order of the
heads we're requested to fetch. By having them sorted, we
can replace some of the quadratic algorithms with linear
ones.

Signed-off-by: Jeff King <peff@peff.net>
---
I actually wouldn't be surprised if these were typically sorted already,
as they frequently come from the ref-mapping functions, which in turn
process the lists we get from the remote. But we also might get random
junk on the command-line of fetch-pack, so we need to be careful.

 builtin/fetch-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 10db15b..380743e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1057,6 +1057,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int compare_heads(const void *a, const void *b)
+{
+	return strcmp(*(const char **)a, *(const char **)b);
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
@@ -1076,6 +1081,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
+	qsort(heads, nr_heads, sizeof(*heads), compare_heads);
+
 	if (heads && nr_heads)
 		nr_heads = remove_duplicates(nr_heads, heads);
 	if (!ref) {
-- 
1.7.10.1.19.g711d603
