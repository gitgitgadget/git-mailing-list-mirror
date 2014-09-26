From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 30/39] resolve_symlink(): use a strbuf for internal scratch space
Date: Fri, 26 Sep 2014 12:08:30 +0200
Message-ID: <1411726119-31598-31-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSaf-0003Kt-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbaIZKRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:17:13 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56890 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755865AbaIZKRL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:17:11 -0400
X-AuditID: 1207440f-f79156d000006a5c-9c-54253b63b6ba
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 96.ED.27228.36B35245; Fri, 26 Sep 2014 06:09:39 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMF013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:37 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1E22Vg0xWL5X2aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyOe2tZChr4Ko73HmNrYJzH1cXI
	wSEhYCLxa6dnFyMnkCkmceHeerYuRi4OIYHLjBLHdqxkgnA2MUn8eXqUFaSKTUBXYlFPMxOI
	LSKgJjGx7RALSBGzwGImiQmHNrGBJIQFQiSW32xiA9nAIqAqMfcfC4jJK+AqseWuMMQyOYkN
	u/8zgticQOHG7dfAbCEBF4mW9ZNZJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6KX
	m1mil5pSuokREoj8Oxi71sscYhTgYFTi4b2xTiVEiDWxrLgy9xCjJAeTkijvFwvVECG+pPyU
	yozE4oz4otKc1OJDjBIczEoivHeMgHK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQleKyugRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQXMQXAyMDJMUD
	tJcLpJ23uCAxFygK0XqKUZdjXee3fiYhlrz8vFQpcd4jlkBFAiBFGaV5cCtgaecVozjQx8K8
	IiCjeIApC27SK6AlTEBLlI4ogywpSURISTUwcntkTskQyXjkmPV/vuRSnpoNtTc2bg5882gF
	U/yz/OaLU/31z0V9eWfMr9zzL4Nh5vzFt+8pZrueduCLnH0keuOBSuk9FR/3eH9l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257541>

Aside from shortening and simplifying the code, this removes another
place where the path name length is arbitrarily limited.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 85c8648..cc9b9cb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -126,44 +126,35 @@ static char *last_path_elm(char *p)
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
2.1.0
