From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode == true
Date: Sat, 11 Oct 2008 15:04:19 -0400
Message-ID: <1223751859-3540-1-git-send-email-mlevedahl@gmail.com>
References: <1223751280-2104-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: spearce@spearce.org, dpotapov@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 11 21:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kojm9-00021r-Jf
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 21:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762420AbYJKTEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762040AbYJKTEE
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 15:04:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:24469 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759576AbYJKTEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 15:04:02 -0400
Received: by wx-out-0506.google.com with SMTP id h27so412466wxd.4
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NfRT6+iEQBkH1sekowc7Cv29DadfHP5zjMfHHRbuKDU=;
        b=xdDev9foFTnHNCtz2JRyp4g9vIYvigVihCRukqkLPxLxh5CyXzqnTjlXXIVMNB/ZI5
         5oJc5YEiWlrNwjBk+MLRWaISkzd8vR3uIny8r3ERyUseaWdlv2POZbYO0ucZhu5CfNGN
         tPKYhoEJ4rWCM6BoU1HwEnoH4JTugPIH3SG/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jF+ansKc1YU15p3ffQE7qm1KSJzIyj4ANgv8/9CKZE02ADaohcWjwkj5CEhkUSMdqt
         hdb/zGJBeedRviIDnWu46Y2FaqS7iBAkVmj7ekZx/M54JtIkZqMfrHUh63TluSLHwjRW
         nwb3/GljEj1Y8rWgNqznJG2/GKW8rKVVDpx08=
Received: by 10.150.152.17 with SMTP id z17mr3619089ybd.177.1223751838547;
        Sat, 11 Oct 2008 12:03:58 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-157-161.washdc.fios.verizon.net [72.83.157.161])
        by mx.google.com with ESMTPS id 9sm3151994ywf.2.2008.10.11.12.03.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 12:03:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.535.g47d45.dirty
In-Reply-To: <1223751280-2104-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97987>

Cygwin's POSIX emulation allows use of core.filemode true, unlike native
Window's implementation of stat / lstat, and Cygwin/git users who have
configured core.filemode true in various repositories will be very
unpleasantly surprised to find that git is no longer honoring that option.
So, this patch fores use of Cygwin's stat functions if core.filemode is
set true, regardless of any other considerations.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
Resend as I mangled Shawn's email address.

 Documentation/config.txt |    4 +++-
 compat/cygwin.c          |   10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index 423ff20..54028b3 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -91,13 +91,21 @@ static int cygwin_stat(const char *path, struct stat *buf)
  * functions should be used. The choice is determined by core.ignorecygwinfstricks.
  * Reading this option is not always possible immediately as git_dir may be
  * not be set yet. So until it is set, use cygwin lstat/stat functions.
+ * However, if core.filemode is true, we *must* use the Cygwin posix stat as
+ * the Windows stat fuctions do not determine posix filemode.
  */
 static int native_stat = 1;
+static int core_filemode = 0;
 
 static int git_cygwin_config(const char *var, const char *value, void *cb)
 {
+	if (!strcmp(var, "core.filemode")) {
+			core_filemode = git_config_bool(var, value);
+			native_stat &= !core_filemode;
+	}
 	if (!strcmp(var, "core.ignorecygwinfstricks"))
-		native_stat = git_config_bool(var, value);
+		native_stat = git_config_bool(var, value) &&
+			!core_filemode;
 	return 0;
 }
 
-- 
1.6.0.2.535.g47d45.dirty
