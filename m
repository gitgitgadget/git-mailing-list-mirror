From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] mingw: avoid linking to the C library's isalpha()
Date: Mon, 25 Jan 2016 22:47:56 +0100
Message-ID: <56A6980C.6040701@kdbg.org>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
 <56A279DA.8080809@kdbg.org> <xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601230924090.2964@virtualbox> <56A3CE34.20808@kdbg.org>
 <alpine.DEB.2.20.1601241152060.2964@virtualbox> <56A4C534.6040503@kdbg.org>
 <xmqqzivubpac.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNozY-00028j-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 22:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbcAYVsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 16:48:01 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:16389 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbcAYVsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 16:48:00 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pq4Yn2d2tz5tlG;
	Mon, 25 Jan 2016 22:47:57 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0133351D9;
	Mon, 25 Jan 2016 22:47:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqzivubpac.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284758>

The implementation of mingw_skip_dos_drive_prefix() calls isalpha() via
has_dos_drive_prefix(). Since the definition occurs long before isalpha()
is defined in git-compat-util.h, my build environment reports:

    CC alloc.o
In file included from git-compat-util.h:186,
                 from cache.h:4,
                 from alloc.c:12:
compat/mingw.h: In function 'mingw_skip_dos_drive_prefix':
compat/mingw.h:365: warning: implicit declaration of function 'isalpha'

Dscho does not see a similar warning in his build and suspects that
ctype.h is included somehow behind the scenes. This implies that his build
links to the C library's isalpha() and does not use git's isalpha().

To fix both the warning in my build and the inconsistency in Dscho's
build, move the function definition to mingw.c. Then it picks up git's
isalpha() because git-compat-util.h is included at the top of the file.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c | 7 +++++++
 compat/mingw.h | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 10a51c0..0cebb61 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1915,6 +1915,13 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return -1;
 }
 
+int mingw_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
 int mingw_offset_1st_component(const char *path)
 {
 	char *pos = (char *)path;
diff --git a/compat/mingw.h b/compat/mingw.h
index 9b5db4e..2099b79 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -360,12 +360,7 @@ HANDLE winansi_get_osfhandle(int fd);
 
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
-static inline int mingw_skip_dos_drive_prefix(char **path)
-{
-	int ret = has_dos_drive_prefix(*path);
-	*path += ret;
-	return ret;
-}
+int mingw_skip_dos_drive_prefix(char **path);
 #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
-- 
2.7.0.118.g90056ae
