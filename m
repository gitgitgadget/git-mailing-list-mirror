From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] sha1_file.c: Fix a sparse warning
Date: Mon, 11 Feb 2013 19:02:17 +0000
Message-ID: <51194039.4010407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ygD-000196-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 20:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358Ab3BKTES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 14:04:18 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:56511 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758289Ab3BKTER (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 14:04:17 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 3DC6C400575;
	Mon, 11 Feb 2013 19:04:15 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 55BB74000EA;	Mon, 11 Feb 2013 19:04:14 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Mon, 11 Feb 2013 19:04:13 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216075>


Sparse issues an "... was not declared. Should it be static?" warning
against the 'report_pack_garbage' symbol. In order to suppress the
warning, since this symbol requires more than file scope, we add an
extern declaration to the cache.h header file (and remove the now
redundant extern declaration in builtin/count-objects.c).

[As an alternative solution, make the variable a (static) file scope
variable and add an extern function set_report_pack_garbage(), which
would take a function pointer, to set the local variable ... etc.]

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

If you need to re-roll your 'nd/count-garbage' patches, could you
please squash this (or something like it) into commit c2071d7a
("count-objects: report garbage files in pack directory too",
08-02-2013).

Thanks! 

[BTW, I have an unsettling feeling that the above salutation should
read "Hi Duy," and I'm being (unintentionally) offensive. If so,
please let me know and accept my apologies. ;-) ]

ATB,
Ramsay Jones

 builtin/count-objects.c | 1 -
 cache.h                 | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 118b2ae..605c215 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -11,7 +11,6 @@
 
 static unsigned long garbage;
 
-extern void (*report_pack_garbage)(const char *path, int len, const char *name);
 static void real_report_pack_garbage(const char *path, int len, const char *name)
 {
 	if (len && name)
diff --git a/cache.h b/cache.h
index 6818d87..0d687b4 100644
--- a/cache.h
+++ b/cache.h
@@ -779,6 +779,9 @@ extern int has_pack_index(const unsigned char *sha1);
 
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
+/* A hook for count-objects to report invalid files in pack directory */
+extern void (*report_pack_garbage)(const char *path, int len, const char *name);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
-- 
1.8.1
