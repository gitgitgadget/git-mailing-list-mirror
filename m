From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 29/35] resolve_symlink(): use a strbuf for internal scratch space
Date: Tue, 16 Sep 2014 21:33:50 +0200
Message-ID: <1410896036-12750-30-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydy-0003lx-3u
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbaIPTmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60020 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755176AbaIPTmV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:21 -0400
X-AuditID: 1207440d-f797f6d000000a4a-84-541890e4139e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 72.91.02634.4E098145; Tue, 16 Sep 2014 15:35:00 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcX001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:59 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqPtkgkSIwd7tkhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdsfG/dUEDX8W3OfdYGhjncXUxcnJICJhIvDr4hBnC
	FpO4cG89WxcjF4eQwGVGieaZP5ghnBNMEs+6DoFVsQnoSizqaWYCSYgItDFK7Lq4mRXEYRbo
	ZpR4f+I0E0iVsECIxK+FVxm7GDk4WARUJb5uKQcJ8wq4Sny+epENYp2cxIbd/8FKOIHiX/cV
	gJhCAi4SB+/6TWDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10gvN7NELzWldBMjJOh4
	dzD+XydziFGAg1GJh9fjkXiIEGtiWXFl7iFGSQ4mJVHef90SIUJ8SfkplRmJxRnxRaU5qcWH
	GCU4mJVEeH/4AuV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8fMDo
	EhIsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUV8MTAyQFI8QHu1Qdp5iwsSc4Gi
	EK2nGHU51nV+62cSYsnLz0uVEue16QcqEgApyijNg1sBSzGvGMWBPhaGGMUDTE9wk14BLWEC
	WnK2RwxkSUkiQkqqgXGO9c29j6eZrHxZ88bIsXdJtWpmrchX33JTPr6exbaHztUK+u1ddomv
	LX6fcIrAs+R5mrJXViwPXBfP/nPXbfXv7lp33zJE6nAIzGuKFJc6vvu29zaVWwvq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257175>

Aside from shortening and simplifying the code, this removes another
place where the path name length is arbitrarily limited.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index eecb526..ae55f33 100644
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
2.1.0
