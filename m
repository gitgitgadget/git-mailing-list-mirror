From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode == true
Date: Sun, 12 Oct 2008 14:44:46 -0400
Message-ID: <1223837086-2864-1-git-send-email-mlevedahl@gmail.com>
References: <20081012133934.GB21650@dpotapov.dyndns.org>
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 12 20:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5wy-0003vd-4T
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbYJLSo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYJLSo2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:44:28 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:39237 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYJLSo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:44:28 -0400
Received: by gxk9 with SMTP id 9so2776803gxk.13
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o8Vg/Hb6VqNPqRP5TPE3XGVEk0RoRkqjAuwWRyLcpkU=;
        b=k1nEEuQNekhPkklguJ0VJkBLHK8YMa4J97ORKRjRYmdj1TSkztQIvFNP1xHoBvLXWh
         NmoJVf6nmZZZfDQUOvHbWZwKsMyI/MDN3eeAlBtAliynvidtjBq5dVS5nDfxl/Ri4Guk
         wHQo0wEOmGxI8o2pkAYWeq48GTMmsxcFrbNRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FEsjKAmUV4l3Lo7IVNPxDfOJdAm39sxLCpjZPpE1s+dQp2zz2xhPNDEGm5tCXIinIj
         PzAO/6fQCAh4R0d47+ckSbV5Fx1NHtLnzGEOLta5Rr6ma4oYBovnLdPHMNWTkBb1FnwJ
         athm026MDGOVL8yNXam3n2rYeCvG7qppEHJ60=
Received: by 10.151.42.18 with SMTP id u18mr6497307ybj.57.1223837066403;
        Sun, 12 Oct 2008 11:44:26 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-157-161.washdc.fios.verizon.net [72.83.157.161])
        by mx.google.com with ESMTPS id 6sm4096547ywi.1.2008.10.12.11.44.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 11:44:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.535.g81f8.dirty
In-Reply-To: <20081012133934.GB21650@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98046>

Cygwin's POSIX emulation allows use of core.filemode true, unlike native
Window's implementation of stat / lstat, and Cygwin/git users who have
configured core.filemode true in various repositories will be very
unpleasantly surprised to find that git is no longer honoring that option.
So, this patch forces use of Cygwin's stat functions if core.filemode is
set true, regardless of any other considerations.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
Updated to use trust_executable_bit as suggested on the list.

 Documentation/config.txt |    4 +++-
 compat/cygwin.c          |   16 +++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7161597..a3a9495 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -124,7 +124,9 @@ core.ignoreCygwinFSTricks::
 	one hierarchy using Cygwin mount. If true, Git uses native Win32 API
 	whenever it is possible and falls back to Cygwin functions only to
 	handle symbol links. The native mode is more than twice faster than
-	normal Cygwin l/stat() functions. True by default.
+	normal Cygwin l/stat() functions. True by default, unless core.filemode
+	is true, in which case ignoreCygwinFSTricks is ignored as Cygwin's
+	POSIX emulation is required to support core.filemode.

 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 423ff20..221d2f5 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -91,12 +91,17 @@ static int cygwin_stat(const char *path, struct stat *buf)
  * functions should be used. The choice is determined by core.ignorecygwinfstricks.
  * Reading this option is not always possible immediately as git_dir may be
  * not be set yet. So until it is set, use cygwin lstat/stat functions.
+ * However, if core.filemode is true, we *must* use the Cygwin posix stat as
+ * the Windows stat fuctions do not determine posix filemode.
  */
 static int native_stat = 1;
+extern int trust_executable_bit;

 static int git_cygwin_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "core.ignorecygwinfstricks"))
+	if (!strcmp(var, "core.filemode"))
+		trust_executable_bit = git_config_bool(var, value);
+	else if (!strcmp(var, "core.ignorecygwinfstricks"))
 		native_stat = git_config_bool(var, value);
 	return 0;
 }
@@ -105,8 +110,13 @@ static int init_stat(void)
 {
 	if (have_git_dir()) {
 		git_config(git_cygwin_config, NULL);
-		cygwin_stat_fn = native_stat ? cygwin_stat : stat;
-		cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
+		if (!trust_executable_bit && native_stat) {
+			cygwin_stat_fn = cygwin_stat;
+			cygwin_lstat_fn = cygwin_lstat;
+		} else {
+			cygwin_stat_fn = stat;
+			cygwin_lstat_fn = lstat;
+		}
 		return 0;
 	}
 	return 1;
--
1.6.0.2.535.g81f8.dirty
