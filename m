From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v2] MSVC: link in invalidcontinue.obj for better POSIX compatibility
Date: Sat, 29 Mar 2014 00:08:02 +0400
Message-ID: <1396037282-26081-1-git-send-email-marat@slonopotamus.org>
References: <xmqqlhvu9m8x.fsf@gitster.dls.corp.google.com>
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 21:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTd5g-0003b6-LV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 21:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbaC1UJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 16:09:19 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:55090 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbaC1UJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 16:09:18 -0400
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WTd5O-000342-HI; Sat, 29 Mar 2014 00:09:08 +0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <xmqqlhvu9m8x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245425>

By default, Windows abort()'s instead of setting
errno=EINVAL when invalid arguments are passed to standard functions.

For example, when PAGER quits and git detects it with
errno=EPIPE on write(), check_pipe() in write_or_die.c tries raise(SIGPIPE)
but since there is no SIGPIPE on Windows, it is treated as invalid argument,
causing abort() and crash report window.

Linking in invalidcontinue.obj (provided along with MS compiler) allows
raise(SIGPIPE) to return with errno=EINVAL.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 38c60af..8e7ec6e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -366,7 +366,7 @@ ifeq ($(uname_S),Windows)
 		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
-	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
 	PTHREAD_LIBS =
 	lib =
 ifndef DEBUG
-- 
1.8.3.2
