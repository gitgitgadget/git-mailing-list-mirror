From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Provide a dirname() function when NO_LIBGEN_H=YesPlease
Date: Wed, 30 Sep 2015 16:50:34 +0200
Organization: gmx
Message-ID: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 16:50:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhIiS-0005aG-QE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 16:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbbI3Ouk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 10:50:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:54252 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbbI3Oui (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 10:50:38 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MfBsk-1a0TDd0DwQ-00OpHe; Wed, 30 Sep 2015 16:50:35
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Vkmwx1wAwZFfcpRV1ZHoVEqosapvknrmOi2A720koLEgSBBnE8a
 E3A90CcHanepVsto87dsQNmgeZDsdtGj6KV3YKRUBak6CGtQsaQm090/SNaU1Sho0EUhlrQ
 YOhNLBbL3WIGHUHP759cSDXNDz2bv81Tli6EhKlL0h1t5sVHlxzUhJIx9kukDxj+ueuamDP
 lFzn0bEdpApzFX51SXtHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1BXwAiKTHZc=:xSn9qZ+lBOicxedZU6JEJb
 2mihQ4Xl3Ssv3Mme9nVQv2nQdXzzTB3j08hyDCkefIe6/afclSrLmF4/WVABPIN6UZUZpNKpf
 uKDDpWoAaDnaYsrWE4nigEImAVnoMz76ijuB6T/vSOugwDYz8hgCWjzxyKRshQheAujPWrpgf
 7GGBmqHrjoBU1GsEwSYRbZC0xQf4Ub3iqwegh4OVTZCA2qRF+iTmsgaSIpukQ+HkS+zAXI8SG
 yOjAupvu218/euzp3q4aARpHN6favSswla5wirKnJ1TriFHGTVRPGbPJmIu07IbJPJ3NEW74y
 Yd5M4y5I0J3jDGtmR6zD4SG+oUd8zMzvYIDyYgJB2S8qzeEc40yiz/wvYR2cNz1GBTQDxW5lv
 Y4D/V323bZ6aHXjAeyCvyHbBAHANvzH7lwJ5ZPzBrXBHRtkv3V5xDaqzAV+lxDIdLVPkT4L8J
 IHu1vDXw6nkivvkEg1mF60UnBQ0AVReVxn4Dz8ShZt8bCX+aZRW6B9RMudzeIa/z8ZNFUChez
 NRBQLYSk6n0I6O5JQLhBv/lu/uHzc/UzvTa9PYd3Ck/jSy0Dk423AT3Uokzn1WXSNcis5BzEj
 Sk38Q544J3ppTUWE3xl0r0kzJLgoJ6PDeuLFl+EkmpdFY2eFZPIwwI9h8oY3PsBcvS/11FEhf
 c27/cx+NuCzgUBHz+v1GRIgwUUe8I/3/OXC2L/4nuPtSOifxuJwNK1HGiVn+vgfHd8RTS3vu9
 q6qda9fLJOWb0uvVRhZWwJP5Tg+VZARcZa/MHKi+3EuI4P9MN5SpNjiDP6oQXFxSp7j6+F7k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278847>

When there is no `libgen.h` to our disposal, we miss the `dirname()`
function.

So far, we only had one user of that function: credential-cache--daemon
(which was only compiled when Unix sockets are available, anyway). But
now we also have `builtin/am.c` as user, so we need it.

Since `dirname()` is a sibling of `basename()`, we simply put our very
own `gitdirname()` implementation next to `gitbasename()` and use it
if `NO_LIBGEN_H` has been set.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I stumbled over the compile warning when upgrading Git for Windows
	to 2.6.0. There was a left-over NO_LIBGEN_H=YesPlease (which we
	no longer need in Git for Windows 2.x), but it did point to the
	fact that we use `dirname()` in builtin/am.c now, so we better
	have a fall-back implementation for platforms without libgen.h.

	I tested this implementation a bit, but I still would appreciate
	a few eye-balls to go over it.

 compat/basename.c | 26 ++++++++++++++++++++++++++
 git-compat-util.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/compat/basename.c b/compat/basename.c
index d8f8a3c..10dba38 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -13,3 +13,29 @@ char *gitbasename (char *path)
 	}
 	return (char *)base;
 }
+
+char *gitdirname(char *path)
+{
+	char *p = path, *slash, c;
+
+	/* Skip over the disk name in MSDOS pathnames. */
+	if (has_dos_drive_prefix(p))
+		p += 2;
+	/* POSIX.1-2001 says dirname("/") should return "/" */
+	slash = is_dir_sep(*p) ? ++p : NULL;
+	while ((c = *(p++)))
+		if (is_dir_sep(c)) {
+			char *tentative = p - 1;
+
+			/* POSIX.1-2001 says to ignore trailing slashes */
+			while (is_dir_sep(*p))
+				p++;
+			if (*p)
+				slash = tentative;
+		}
+
+	if (!slash)
+		return ".";
+	*slash = '\0';
+	return path;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index f649e81..8b01aa5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -253,6 +253,8 @@ struct itimerval {
 #else
 #define basename gitbasename
 extern char *gitbasename(char *);
+#define dirname gitdirname
+extern char *gitdirname(char *);
 #endif
 
 #ifndef NO_ICONV
-- 
2.5.3.windows.1.3.gc322723
