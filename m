From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Tue, 12 Jan 2016 08:57:36 +0100 (CET)
Message-ID: <04a7a497f9a5771d4dbf5fd605f138607b2bae0a.1452585382.git.johannes.schindelin@gmx.de>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:57:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItpw-0000nO-8R
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761924AbcALH5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:57:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:51363 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761870AbcALH5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 02:57:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LfSyv-1ZqOUr44BV-00p4fi; Tue, 12 Jan 2016 08:57:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452585382.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PcakcqPYnim1pHD77o3CwQ5yopCOHdghAzDIrVpyUk9RqjZOjb0
 bk26K9F85BUh3uXy7/q+ZkLjBqOnhSBR3fcCeRhdKj8Z+h9o5xK786xRl4b7iOMU7dEEuYv
 IAVaJqTR+b8gUCMzdGEUZTtPf6TItAVMHNK7s40jbNFM3Mifwjhkd9dux7bwahzJnQlP1lW
 YwzTP0HwCcMiU0TSvuLcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mP//J6uwjwU=:tZz8mWScTexMWidu5D4Q8y
 fOoGLqPmckbYFAwvAZRdM7XhCUErU9Ndgu7W8ntwLC6BOEXvh0EGPKQUvw8d7oCCXNlpfjt5S
 xWiNitWZrA6pNT4tvfauvjRqn6RZbpir30pqRiHsikmzwcW8lmq2L9czOB2gtqu/LJfzkZoI/
 wakzPxFgH15WGFbxLmMQZERJ3KHOgmtVW1ltbZmezDekiC1d0QSy3ZthZR+rhNj/MZltoQ3+R
 nl+ZCSGypqGmH+LmqFKxO70neGKv/VEpRINEpjI953e/qxRRiH1GHqw/JTKsPq2/L2+iwYADr
 fyeot4JTDgwgiRWm2xIRxIyJSZ84/OzuelINWqg8Xzioza0XANftOab0b3xtQVrceloOsiUqH
 W+0J3qujkEjQDGPrADZDR4Z7Z2n6ihTX0d+NyvTK1h8p6+FltXK3QxYIuKBvrV5Qi+Jor7j5x
 KPkOUD2zgbgf5ut0Dv46LReAEM1mdb/BDDmehqD31PBAcLJn4BkkAjo86Qoxs1tqTKCZMQ814
 FzvBm/wlThZP2ZkC18u6j1pnF1FtOL+ZFtosWRIlF3mtQCjid5txSGsJvN6dqFCXjDg6KgS+B
 vBuHMfU9qs1w49zmXRrL1a0wd90WA4eFtEd5MOm9drceaEwA3LJJ958pXRG7gudal7fybkX7c
 gE2QNCUYId19BWkUsYVaMiZxoFknJZ7cKLcrRe4sGY+EeF2RB2KtmdjgyvvssmeK4KQCfQlcm
 aavdWygXUty2PldXljStz529xiDuqMJ4RUkv8muUtJcyh3i3NgvWYoD9IljiarZ/dCuhKobD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283774>

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
 compat/basename.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/compat/basename.c b/compat/basename.c
index 0f1b0b0..96bd953 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../strbuf.h"
 
 /* Adapted from libiberty's basename.c.  */
 char *gitbasename (char *path)
@@ -25,3 +26,46 @@ char *gitbasename (char *path)
 	}
 	return (char *)base;
 }
+
+char *gitdirname(char *path)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	char *p = path, *slash = NULL, c;
+	int dos_drive_prefix;
+
+	if (!p)
+		return ".";
+
+	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p)
+		goto dot;
+
+	/*
+	 * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
+	 * should return "//", but dirname("///") should return "/" again.
+	 */
+	if (is_dir_sep(*p)) {
+		if (!p[1] || (is_dir_sep(p[1]) && !p[2]))
+			return path;
+		slash = ++p;
+	}
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
+	if (slash) {
+		*slash = '\0';
+		return path;
+	}
+
+dot:
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
+	return buf.buf;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index fbb11bb..5f72f1c 100644
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
2.6.3.windows.1.300.g1c25e49
