From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 5/5] grep: don't extend context to trailing empty lines with
 -W
Date: Sat, 21 May 2016 20:47:06 +0200
Message-ID: <5740AD2A.9030905@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Bvt-00027l-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 20:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcEUSr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 14:47:26 -0400
Received: from mout.web.de ([212.227.15.3]:63037 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbcEUSrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 14:47:25 -0400
Received: from [192.168.178.36] ([79.237.63.247]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lvjoa-1bcBu94AnM-017YHy; Sat, 21 May 2016 20:47:22
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5740AC28.6010202@web.de>
X-Provags-ID: V03:K0:FSyRlnukkHbXZEVZ/sO1CrlWTNf8rb8NA5x0BT/80lJGvM57igY
 7EDSHqNLNotqp6Hzv/A/Ti4FbY+AjpoXObnLI6nSsrePRdmoo2jFpWSshbfdagiTYDDr3n7
 qVE9NhIRWxaB0I5eGAhyuIQSJrABBicLUpA5pQ+hnY4Cu+ttdNPq1sPmZUgcS3PTWxkji5K
 jnQmutYMQ7YuclD3FgZvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YkjrCU3cXRA=:Qc2txN5EiUT1csQwuJYVUR
 wvOZEi/LHXODiNGW3kZ6GEUsBOeU615PddYdesQIep1t3CRvrYgow/libNBFFnesukuxJjPjc
 +nNjgTv1ZEaIrqH4javrIfDbuASEb0kEe89CAv2D7P5R1XERz0CG+6ovH6xDoz8cxnsnud2ow
 6E7nYKOb9rSRHYixvcgcXjRByPU7RYZdavKbMgbkNAK8nZFu0VRok/jFlzZzayTciFuenbOqf
 pHG0cyyeZYBL5oPcpEnY1nydrnoiQWTOvypJYO99qoHC8GbqEq93Z4U0c6UAyJAsivyZ4SwEO
 2UDFVBtvP9xV8sE28WhQCeGExKKswiuXUq1fYDcEd5poYCR6LfNTpps+rIfb0s5lvCjrh9hqx
 vTCFXRSoOiT90eBVoWD11bUYN21cJ5rvNwAMTnFOW1ZrIK8sDFEUu3/VUcGDIKcX640d9WR09
 YrMeB5MnucGxQVx3eACiWnmhpdPqlpXrcsIwGUF9U/Ya9pwbfOtiVmFWB7p0t4rKkhSCme7PG
 7vIsrPQj26IQbsFrlHjR+lneve7++OE9T+NKAOWa6mskxicXJqehrsg1yJl08A+RL+6nKSE7G
 LAtALbvcsa75dwovmCANARRXJg6HcHIK+Mofc0wNT3oiZNN58Ir0HkJ1S7oHab4yUYNzoIgDY
 ks+xD31BoXz/UN5mQ4NGNvuRRGE7Zw5WNYiJ334vKwVDIDuRu8LyAOKw9orSIb4ZTTSowafZV
 cLeZILZCdgY60ujFleLsU181e8//iu8Ky/qswbEtq8UvG/x+L7jK3dhVCDY0k7bv9Ev8akSt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295237>

Empty lines between functions are shown by grep -W, as it considers them
to be part of the function preceding them.  They are not interesting in
most languages.  The previous patches stopped showing them for diff -W.

Stop showing empty lines trailing a function with grep -W.  Grep scans
the lines of a buffer from top to bottom and prints matching lines
immediately.  Thus we need to peek ahead in order to determine if an
empty line is part of a function body and worth showing or not.

Remember how far ahead we peeked in order to avoid having to do so
repeatedly when handling multiple consecutive empty lines.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 grep.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index ec6f7ff..1e15b62 100644
--- a/grep.c
+++ b/grep.c
@@ -1396,9 +1396,17 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 	return 0;
 }
 
+static int is_empty_line(const char *bol, const char *eol)
+{
+	while (bol < eol && isspace(*bol))
+		bol++;
+	return bol == eol;
+}
+
 static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)
 {
 	char *bol;
+	char *peek_bol = NULL;
 	unsigned long left;
 	unsigned lno = 1;
 	unsigned last_hit = 0;
@@ -1543,8 +1551,24 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				show_function = 1;
 			goto next_line;
 		}
-		if (show_function && match_funcname(opt, gs, bol, eol))
-			show_function = 0;
+		if (show_function && (!peek_bol || peek_bol < bol)) {
+			unsigned long peek_left = left;
+			char *peek_eol = eol;
+
+			/*
+			 * Trailing empty lines are not interesting.
+			 * Peek past them to see if they belong to the
+			 * body of the current function.
+			 */
+			peek_bol = bol;
+			while (is_empty_line(peek_bol, peek_eol)) {
+				peek_bol = peek_eol + 1;
+				peek_eol = end_of_line(peek_bol, &peek_left);
+			}
+
+			if (match_funcname(opt, gs, peek_bol, peek_eol))
+				show_function = 0;
+		}
 		if (show_function ||
 		    (last_hit && lno <= last_hit + opt->post_context)) {
 			/* If the last hit is within the post context,
-- 
2.8.3
