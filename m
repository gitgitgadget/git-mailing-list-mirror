From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] cygwin: Convert paths for html help from posix to windows
Date: Thu, 22 Jan 2009 18:16:05 +0100
Message-ID: <20090122171605.GA16684@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jaeckel@stzedn.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:18:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3C7-0001Tr-E0
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530AbZAVRQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 12:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbZAVRQg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:16:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:34441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754937AbZAVRQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:16:35 -0500
Received: (qmail invoked by alias); 22 Jan 2009 17:16:27 -0000
Received: from i577BA2E2.versanet.de (EHLO atjola.local) [87.123.162.226]
  by mail.gmx.net (mp008) with SMTP; 22 Jan 2009 18:16:27 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/bHYUuBt/brWGdzgic6w3lQgawZstSigtQVV3IJj
	fxzt88mTDcyV1K
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106773>

When using "git help --web" with cygwin, we used to pass the posix path
to the browser, but a native windows browser will expect a windows path
and is unable to make use of the given path.

So the cygwin port gets its own open_html implementation that handles
the path conversion.

Reported-by: Steffen Jaeckel <jaeckel@stzedn.de>
Tested-by: Steffen Jaeckel <jaeckel@stzedn.de>

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
OK, I don't really know if this is the right way to do it. Maybe when
the browser was built for cygwin this breaks? I have no clue, it's
admittedly just the result of a quick glance at the code and some
googling to find the "right" cygwin function... :-/

 compat/cygwin.c |    7 +++++++
 compat/cygwin.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index ebac148..70ecd2d 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -141,3 +141,10 @@ static int cygwin_lstat_stub(const char *file_name=
, struct stat *buf)
 stat_fn_t cygwin_stat_fn =3D cygwin_stat_stub;
 stat_fn_t cygwin_lstat_fn =3D cygwin_lstat_stub;
=20
+void cygwin_open_html(const char *unixpath)
+{
+	char cygpath[PATH_MAX];
+
+	cygwin_conv_to_win32_path(unixpath, cygpath);
+	execl_git_cmd("web--browse", "-c", "help.browser", cygpath, NULL);
+}
diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..7cbefea 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -7,3 +7,6 @@ extern stat_fn_t cygwin_lstat_fn;
=20
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+
+void cygwin_open_html(const char *path);
+#define open_html cygwin_open_html
--=20
1.6.1.230.gf873d
