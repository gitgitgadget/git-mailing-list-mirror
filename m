From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] for-each-ref: use skip_prefix() to avoid duplicate string
 comparison
Date: Sat, 21 Feb 2015 20:51:28 +0100
Message-ID: <54E8E1C0.5050303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:52:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPG5n-0002WD-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 20:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbbBUTv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 14:51:56 -0500
Received: from mout.web.de ([212.227.17.12]:59718 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbBUTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 14:51:55 -0500
Received: from [192.168.178.27] ([79.253.189.194]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MYw63-1Y403D0rND-00Vedw; Sat, 21 Feb 2015 20:51:48
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:ULJ5wJ9TME5YIjfu3UuWqXytVwDBkOgiSboIQTiu36BI5dApOgQ
 8i9sp/R8zENEU3oHxLlF8GRrMEuq+cZZydgVEUYebX3TuMlaSlVqvR+yaif5RYt80aT8o6b
 qM4MyPA5+sDL/SjGk7DwKArhDtLZC7YI/XS0pmv7MMlpksB7SFTomc/x6E2oL923w4my+iu
 OernD35e6bczDy/vCrbyw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264225>

Use skip_prefix() to get the part after "color:" (if present) and only
compare it with "reset" instead of comparing the whole string again.
This gets rid of the duplicate "color:" part of the string constant.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/for-each-ref.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 19be78a..83f9cf9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -178,11 +178,10 @@ static const char *find_next(const char *cp)
 static int verify_format(const char *format)
 {
 	const char *cp, *sp;
-	static const char color_reset[] = "color:reset";
 
 	need_color_reset_at_eol = 0;
 	for (cp = format; *cp && (sp = find_next(cp)); ) {
-		const char *ep = strchr(sp, ')');
+		const char *color, *ep = strchr(sp, ')');
 		int at;
 
 		if (!ep)
@@ -191,8 +190,8 @@ static int verify_format(const char *format)
 		at = parse_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (starts_with(used_atom[at], "color:"))
-			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
+		if (skip_prefix(used_atom[at], "color:", &color))
+			need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
 	return 0;
 }
-- 
2.3.0
