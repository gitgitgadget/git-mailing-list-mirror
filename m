From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/14] cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
Date: Tue, 17 Mar 2015 17:00:04 +0100
Message-ID: <1426608016-2978-3-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtv7-00015M-0a
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbbCQQA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:27 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56417 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753562AbbCQQA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:26 -0400
X-AuditID: 12074412-f79e46d0000036b4-5f-55084f99dc0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 26.42.14004.99F48055; Tue, 17 Mar 2015 12:00:25 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSd023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:25 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqDvTnyPUYNEpC4uuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZM95PZCy4
	yVExf/Em9gbGSexdjBwcEgImEr13zLsYOYFMMYkL99azdTFycQgJXGaUOHhnCpRzkkli3v4n
	7CBVbAK6Eot6mplAbBEBNYmJbYdYQGxmgRSJzj93wGqEBSIlVu3rBqthEVCVOL/0KFicV8BZ
	YsHGtWwQ2+Qkzh//yQxicwq4SLz485oRxBYCqlk7bTLbBEbeBYwMqxjlEnNKc3VzEzNzilOT
	dYuTE/PyUot0zfRyM0v0UlNKNzFCgkdoB+P6k3KHGAU4GJV4eBvy2EOFWBPLiitzDzFKcjAp
	ifLmeXCECvEl5adUZiQWZ8QXleakFh9ilOBgVhLhveMOlONNSaysSi3Kh0lJc7AoifP+XKzu
	JySQnliSmp2aWpBaBJOV4eBQkuBd7gfUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqS
	EQ+KjPhiYGyApHiA9m4HaectLkjMBYpCtJ5iVJQS550PkhAASWSU5sGNhaWEV4ziQF8K8yaA
	VPEA0wlc9yugwUxAg1va2UAGlyQipKQaGJXFL3N95du26fklwV3txbuFP/yVZ91lYXfaY/XG
	KWHxTf12XMzCRy6c+WAscUQ99dDFf3OWpzZnRK1pOrxd8CVDgMUfR4WzgkLXrrMdOFp24EDO
	r4SDi/MMb5eUP4lcGO0R/sV7f0oXx2YfM+0z3M6LUy93CW44p/qlsu/RSbeVzxet 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265631>

Use convert_ui() instead of strtoul_ui() to parse the <mode> argument.
This tightens up the parsing a bit:

* Leading whitespace is no longer allowed
* '+' and '-' are no longer allowed

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5878986..845e944 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "numparse.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
@@ -672,7 +673,7 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 	}
 	if (ctx->argc <= 3)
 		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
-	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
+	if (convert_ui(*++ctx->argv, 8, &mode) ||
 	    get_sha1_hex(*++ctx->argv, sha1) ||
 	    add_cacheinfo(mode, sha1, *++ctx->argv, 0))
 		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
-- 
2.1.4
