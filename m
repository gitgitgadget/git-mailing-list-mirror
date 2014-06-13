From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/2] blame: simplify prepare_lines()
Date: Fri, 13 Jun 2014 21:54:59 +0200
Message-ID: <539B5713.10300@web.de>
References: <539B569F.1090800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvXZL-0003Wj-SO
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbaFMTzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 15:55:19 -0400
Received: from mout.web.de ([212.227.17.11]:60960 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbaFMTzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 15:55:18 -0400
Received: from [192.168.178.27] ([79.253.165.171]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lcy1k-1WVJYI3jX6-00iCtN; Fri, 13 Jun 2014 21:55:14
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539B569F.1090800@web.de>
X-Provags-ID: V03:K0:GVNyInwrLzpqri/Rro722sB0edd8DLpfmA0qFyVdUakggP3hw0G
 nsA+9FojU8VMK6+GBvUqnSpLm9hsJ4cDsTxBVJMJk9P7uro8bdJWRPv39xsWVkl01IZ/gYO
 BtJuALNjaGmUDXNgADz2PPje0NxcNMcigr5YkIblqh3QDQHwv/aU5unDew+qO9hD+Y7+ZNY
 DUCP9vtX3EL3gj4k5irYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251633>

Changing get_next_line() to return the end pointer instead of NULL in
case no newline character is found treats allows us to treat complete
and incomplete lines the same, simplifying the code.  Switching to
counting lines instead of EOLs allows us to start counting at the
first character, instead of having to call get_next_line() first.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/blame.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ad37edc..662e3fe 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2011,7 +2011,7 @@ static void output(struct scoreboard *sb, int option)
 static const char *get_next_line(const char *start, const char *end)
 {
 	const char *nl = memchr(start, '\n', end - start);
-	return nl ? nl + 1 : NULL;
+	return nl ? nl + 1 : end;
 }
 
 /*
@@ -2025,25 +2025,19 @@ static int prepare_lines(struct scoreboard *sb)
 	const char *end = buf + len;
 	const char *p;
 	int *lineno;
-	int num = 0, incomplete = 0;
+	int num = 0;
 
-	for (p = get_next_line(buf, end); p; p = get_next_line(p, end))
+	for (p = buf; p < end; p = get_next_line(p, end))
 		num++;
 
-	if (len && end[-1] != '\n')
-		incomplete++; /* incomplete line at the end */
+	sb->lineno = lineno = xmalloc(sizeof(*sb->lineno) * (num + 1));
 
-	sb->lineno = xmalloc(sizeof(*sb->lineno) * (num + incomplete + 1));
-	lineno = sb->lineno;
-
-	*lineno++ = 0;
-	for (p = get_next_line(buf, end); p; p = get_next_line(p, end))
+	for (p = buf; p < end; p = get_next_line(p, end))
 		*lineno++ = p - buf;
 
-	if (incomplete)
-		*lineno++ = len;
+	*lineno = len;
 
-	sb->num_lines = num + incomplete;
+	sb->num_lines = num;
 	return sb->num_lines;
 }
 
-- 
2.0.0
