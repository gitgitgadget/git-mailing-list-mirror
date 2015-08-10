From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/16] credential-cache--daemon: delete socket from main()
Date: Mon, 10 Aug 2015 11:47:50 +0200
Message-ID: <ad910765be1335dab4c8545f76dc48519725d174.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh9-00021w-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbbHJJs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:29 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63301 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754746AbbHJJsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:16 -0400
X-AuditID: 1207440e-f79516d0000012b3-d3-55c8735d7235
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.1B.04787.D5378C55; Mon, 10 Aug 2015 05:48:13 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx5021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:12 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqBtbfCLU4PsJDouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGSv3vWUs
	+MpWcf7jZtYGxjOsXYycHBICJhIPV/5khrDFJC7cW88GYgsJXGaUmNij08XIBWSfYJK4P/cf
	WIJNQFdiUU8zE4gtIqAmMbHtEAuIzSyQLnFiQTuYLSzgK7Fl4k+wehYBVYmW2R/BlvEKREks
	mNnJ2MXIAbRMTmLBhXSQMKeAhcT2xg2sEHvNJR7PO88+gZF3ASPDKka5xJzSXN3cxMyc4tRk
	3eLkxLy81CJdY73czBK91JTSTYyQ4OHbwdi+XuYQowAHoxIP74zNx0OFWBPLiitzDzFKcjAp
	ifJa5J8IFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCG58BlONNSaysSi3Kh0lJc7AoifOqLVH3
	ExJITyxJzU5NLUgtgsnKcHAoSfDKFwE1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZk
	xIPiIr4YGBkgKR6gvXYg7bzFBYm5QFGI1lOMuhwLftxeyyTEkpeflyolzvunEKhIAKQoozQP
	bgUsVbxiFAf6WJi3EWQUDzDNwE16BbSECWRJINiSkkSElFQDo1LLiuRtLWFz/jmGxcZW7AzY
	MV/medzLry2vcxw3+656YJRR45t1YtPfyVYrr267wbzSdLl+5xynRT32B7XKPzEJv5k09zeT
	aFO5/tNWPd2qpaVRIfOvTU898zXwssp/nYZVe6dUxT3T9BHt2d5wveKwyxQn3YkL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275598>

main() is responsible for cleaning up the socket in the case of
errors, so it is reasonable to also make it responsible for cleaning
it up when there are no errors. This change also makes the next step
easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 credential-cache--daemon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index c2f0049..a671b2b 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -221,7 +221,6 @@ static void serve_cache(const char *socket_path, int debug)
 		; /* nothing */
 
 	close(fd);
-	unlink(socket_path);
 }
 
 static const char permissions_advice[] =
@@ -280,5 +279,7 @@ int main(int argc, const char **argv)
 
 	serve_cache(socket_path, debug);
 
+	unlink(socket_path);
+
 	return 0;
 }
-- 
2.5.0
