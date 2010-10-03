From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 3/8] Add string comparison functions that respect the ignore_case variable.
Date: Sun,  3 Oct 2010 09:56:41 +0000
Message-ID: <1286099806-25774-4-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LJv-0005Ca-85
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0JCJ5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 05:57:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44676 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0JCJ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so2994753wwj.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HMVrpgtAmVGnrDvvksdetcsM2Kr3nQzfdSWslDtG0s4=;
        b=n77HdPy1vfiAJkBu+f0tpfCzhUes+tPpNtcgbik4/zOaSQ+yJtboYTIx8yIu/1kCrv
         48VKqDafAH8XvovlZgbGetB2w98o1rauJ9t7Y5lIHvYdB94njVN6k/u8bEjHzFAEXtbr
         5HDF5G0HA1sCRXM2PJYkwSrSBSyzUOYzmOisc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xD+p9SJxcTkIiUIGuQps5zen1ge9CJE+ztQ7B5w9qbJMLmegEaARSjO5ssNDBVo64H
         zEP0/NJ5RDEQ+9UFZfI8dT8Y1kgDNgLN3q4MlR4MBQuF9svN4zHDOWTV9/Mm64jJVoxw
         gKEqPmB4p00S2dub2f7pa2Haw2XAfz3oeCOXw=
Received: by 10.227.137.149 with SMTP id w21mr6338696wbt.169.1286099841695;
        Sun, 03 Oct 2010 02:57:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157850>

From: Joshua Jensen <jjensen@workspacewhiz.com>

Multiple locations within this patch series alter a case sensitive
string comparison call such as strcmp() to be a call to a string
comparison call that selects case comparison based on the global
ignore_case variable. Behaviorally, when core.ignorecase=false, the
*_icase() versions are functionally equivalent to their C runtime
counterparts.  When core.ignorecase=true, the *_icase() versions perform
a case insensitive comparison.

Like Linus' earlier ignorecase patch, these may ignore filename
conventions on certain file systems. By isolating filename comparisons
to certain functions, support for those filename conventions may be more
easily met.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |   16 ++++++++++++++++
 dir.h |    4 ++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index d1e5e5e..3432d58 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,22 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
+/* helper string functions with support for the ignore_case flag */
+int strcmp_icase(const char *a, const char *b)
+{
+	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
+}
+
+int strncmp_icase(const char *a, const char *b, size_t count)
+{
+	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+}
+
+int fnmatch_icase(const char *pattern, const char *string, int flags)
+{
+	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
+}
+
 static int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
diff --git a/dir.h b/dir.h
index 278d84c..b3e2104 100644
--- a/dir.h
+++ b/dir.h
@@ -101,4 +101,8 @@ extern int remove_dir_recursively(struct strbuf *path, int flag);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
+extern int strcmp_icase(const char *a, const char *b);
+extern int strncmp_icase(const char *a, const char *b, size_t count);
+extern int fnmatch_icase(const char *pattern, const char *string, int flags);
+
 #endif
-- 
1.7.3.159.g610493
