From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/4] Suppress "statement not reached" warnings under Sun Studio
Date: Wed, 21 Dec 2011 01:18:22 +0000
Message-ID: <1324430302-22441-5-git-send-email-avarab@gmail.com>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:18:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdApb-0001ZJ-1c
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab1LUBSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 20:18:50 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52700 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab1LUBSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:18:50 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so7119243eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uShhUoaM1vsWP1SA+WX0nC/yXYiiHgRj4hvvPPpnsG8=;
        b=ba1nALWg/9dJcak5dLrSkaFIGJsW0lKDNTGnmMh3X55GcPtRUAl//+9Nr4FdK0kZFW
         Qm5CWA5sS6+0T2+vIkenBCYVmJ8v5RkvoaQ5EyDx34lgbl4GgQIW5LIUTSq4E1TIfWNx
         oENgX1ASvHbfqVbxTA0lEL16+GSh8KwYv9x9o=
Received: by 10.14.47.16 with SMTP id s16mr1791607eeb.84.1324430328034;
        Tue, 20 Dec 2011 17:18:48 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id z43sm14054237eef.7.2011.12.20.17.18.47
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 17:18:47 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187544>

Sun Studio 12 Update 1's brain will melt on these two occurances of
using "goto" to jump into a loop. It'll emit these warnings:

    "read-cache.c", line 761: warning: statement not reached (E_STATEME=
NT_NOT_REACHED)
    "xdiff/xutils.c", line 194: warning: statement not reached (E_STATE=
MENT_NOT_REACHED)

Suppress these warnings by using a Sun Studio specific pragma
directive to turn them off, but only do so if __sun is defined, which
is the macro Sun Studio uses to identify itself under both its C and
C++ variants, see http://developers.sun.com/sunstudio/products/faqs/cpp=
=2Ehtml

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 read-cache.c   |    6 ++++++
 xdiff/xutils.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a51bba1..0a4e895 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -758,7 +758,13 @@ int verify_path(const char *path)
 		return 0;
=20
 	goto inside;
+#ifdef __sun
+#	pragma error_messages (off, E_STATEMENT_NOT_REACHED)
+#endif
 	for (;;) {
+#ifdef __sun
+#	pragma error_messages (on, E_STATEMENT_NOT_REACHED)
+#endif
 		if (!c)
 			return 1;
 		if (is_dir_sep(c)) {
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 0de084e..62c3567 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -191,7 +191,13 @@ int xdl_recmatch(const char *l1, long s1, const ch=
ar *l2, long s2, long flags)
 	 */
 	if (flags & XDF_IGNORE_WHITESPACE) {
 		goto skip_ws;
+#ifdef __sun
+#	pragma error_messages (off, E_STATEMENT_NOT_REACHED)
+#endif
 		while (i1 < s1 && i2 < s2) {
+#ifdef __sun
+#	pragma error_messages (on, E_STATEMENT_NOT_REACHED)
+#endif
 			if (l1[i1++] !=3D l2[i2++])
 				return 0;
 		skip_ws:
--=20
1.7.7.3
