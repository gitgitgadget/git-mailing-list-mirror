From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/14] builtin_diff(): detect errors when parsing --unified argument
Date: Tue, 17 Mar 2015 17:00:10 +0100
Message-ID: <1426608016-2978-9-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvW-0001I3-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbbCQQBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:01:04 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43300 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932388AbbCQQAe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:34 -0400
X-AuditID: 12074414-f797f6d000004084-3f-55084fa0955d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 27.3C.16516.0AF48055; Tue, 17 Mar 2015 12:00:32 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSj023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:31 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqLvAnyPUYMYtLouuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZux57Fqzn
	rrh4+Q9TA2M3ZxcjJ4eEgInEiz+H2SFsMYkL99azgdhCApcZJS7cqe9i5AKyTzJJ3Fo/CSzB
	JqArsainmQnEFhFQk5jYdogFxGYWSJHo/HMHbJCwQIjE8v6VzCA2i4CqxPbZN8HqeQWcJX52
	TmWCWCYncf74T7AaTgEXoCNeM0IsdpZYO20y2wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz
	8lKLdC30cjNL9FJTSjcxQkJHZAfjkZNyhxgFOBiVeHgb8thDhVgTy4orcw8xSnIwKYny5nlw
	hArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b3jDpTjTUmsrEotyodJSXOwKInzflus7ickkJ5Y
	kpqdmlqQWgSTleHgUJLg1fEDahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUV8
	MTAyQFI8QHs/gbTzFhck5gJFIVpPMSpKifO+8QVKCIAkMkrz4MbCEsIrRnGgL4V5RYDpQYgH
	mEzgul8BDWYCGtzSzgYyuCQRISXVwLiwNrFmznztfRVzq1ec7H935VNBrcmdc9lWj094OsUH
	iTJ9KjS8ojlPNsRBRXuO/N4/j3+WzfX/wfxEh2XRjN+9XaIuvXONOR99N/EtLjvX+kJ6w+rr
	qkrLj2iGLdqkGLK1SGOxveGJ0kyOrwpFzzybJWxDwp5/NJK09D8fMJeZV9wps7kp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265641>

The previous code used strtoul() without any checks that it succeeded.
Instead use convert_l(), in strict mode, and die() if there is an
error. This tightens up the parsing:

* Leading whitespace is no longer allowed
* '+' and '-' are no longer allowed
* Trailing junk is not allowed

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index abc32c8..a350677 100644
--- a/diff.c
+++ b/diff.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "numparse.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -2393,12 +2394,12 @@ static void builtin_diff(const char *name_a,
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
-		if (!diffopts)
-			;
-		else if (skip_prefix(diffopts, "--unified=", &v))
-			xecfg.ctxlen = strtoul(v, NULL, 10);
-		else if (skip_prefix(diffopts, "-u", &v))
-			xecfg.ctxlen = strtoul(v, NULL, 10);
+		if (diffopts
+		    && (skip_prefix(diffopts, "--unified=", &v) ||
+			skip_prefix(diffopts, "-u", &v))) {
+			if (convert_l(v, 10, &xecfg.ctxlen))
+				die("--unified argument must be a non-negative integer");
+		}
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
-- 
2.1.4
