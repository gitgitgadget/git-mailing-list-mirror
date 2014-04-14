From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 23/25] resolve_symlink(): use a strbuf for internal scratch space
Date: Mon, 14 Apr 2014 15:54:53 +0200
Message-ID: <1397483695-10888-24-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMa-0000nr-HQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbaDNNzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:49 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48570 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235AbaDNNzr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:47 -0400
X-AuditID: 1207440e-f79c76d000003e2c-02-534be8e252bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D9.7E.15916.2E8EB435; Mon, 14 Apr 2014 09:55:46 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09N010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:44 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqPvohXewQf99WYuuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDMeXbzAXtDAV/H+dxdbA+M8ri5G
	Tg4JAROJGdPmMULYYhIX7q1n62Lk4hASuMwo8ejvRXYI5ySTxLvvZ9lBqtgEdCUW9TQzgdgi
	AmoSE9sOsYAUMQu0M0kc2tELlhAWCJFYfOIuC4jNIqAqsfZDB5jNK+Aq8e/nPGaIdXISJ49N
	Zu1i5ODgBIov/JAFEhYScJG4+2UK6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI31
	cjNL9FJTSjcxQoKRbwdj+3qZQ4wCHIxKPLwdc7yDhVgTy4orcw8xSnIwKYnyZtwACvEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhdd0KlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgt
	gsnKcHAoSfDaPwdqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFRnwxMDpAUjxA
	e5NA2nmLCxJzgaIQracYFaXEeUtAEgIgiYzSPLixsBTzilEc6Eth3jSQKh5geoLrfgU0mAlo
	MEs72OCSRISUVANjggW3f2cL13FJy0vuaTGS3hOPl00VXBaWx25x7sW+eVwHz/HtfOen6hxp
	3ejXeeHOv8BfZ2239p0NsUl/Jc1dkF83d6GN5t7om1qsakXPDqUteX/PZrGcmdPh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246231>

Aside from shortening and simplifying the code, this removes another
place where the path name length is arbitrarily limited.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f552e33..59ed758 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -141,44 +141,35 @@ static char *last_path_elm(char *p)
 static char *resolve_symlink(char *p, size_t s)
 {
 	int depth = MAXDEPTH;
+	static struct strbuf link = STRBUF_INIT;
 
 	while (depth--) {
-		char link[PATH_MAX];
-		int link_len = readlink(p, link, sizeof(link));
-		if (link_len < 0) {
-			/* not a symlink anymore */
-			return p;
-		}
-		else if (link_len < sizeof(link))
-			/* readlink() never null-terminates */
-			link[link_len] = '\0';
-		else {
-			warning("%s: symlink too long", p);
-			return p;
-		}
+		if (strbuf_readlink(&link, p, strlen(p)) < 0)
+			break;
 
-		if (is_absolute_path(link)) {
+		if (is_absolute_path(link.buf)) {
 			/* absolute path simply replaces p */
-			if (link_len < s)
-				strcpy(p, link);
+			if (link.len < s)
+				strcpy(p, link.buf);
 			else {
 				warning("%s: symlink too long", p);
-				return p;
+				break;
 			}
 		} else {
 			/*
-			 * link is a relative path, so I must replace the
+			 * link is a relative path, so replace the
 			 * last element of p with it.
 			 */
 			char *r = (char *)last_path_elm(p);
-			if (r - p + link_len < s)
-				strcpy(r, link);
+			if (r - p + link.len < s)
+				strcpy(r, link.buf);
 			else {
 				warning("%s: symlink too long", p);
-				return p;
+				break;
 			}
 		}
 	}
+	strbuf_reset(&link);
 	return p;
 }
 
-- 
1.9.1
