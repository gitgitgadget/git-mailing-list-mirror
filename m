From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode == true
Date: Sat, 11 Oct 2008 18:56:46 -0400
Message-ID: <1223765806-3332-1-git-send-email-mlevedahl@gmail.com>
References: <7v1vymke85.fsf@gitster.siamese.dyndns.org>
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 12 00:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KonP9-0003Me-KZ
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 00:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbYJKW4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbYJKW4b
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 18:56:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:32456 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbYJKW4a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 18:56:30 -0400
Received: by wr-out-0506.google.com with SMTP id 69so700276wri.5
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wAHcxZjnNJ7OsG5NJg3eeP2eJcM/9169u38uDlnonqE=;
        b=OZRefYWtQG4NSPONszvB5qHenTCcuV64BX6+uqu6gQcXVEUwBqKVWcpxGr1vfazFMC
         V7HQNFU9NCBBNHpJ01Kff90Gw2wbCTxB3FNUYOau5TPmuHbkrA09vGYqtGb/NtX0nMOt
         k4MrEbNSA462vUsyG7nXt5kgC6OpJZ11lEhOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lAbSw/ixhhHWIlELBGwsKjOoJZTWgxS61VKuIfgNZ2wxZPSjeq3wsSxDbd+/2Hfu5s
         MJUeJAA5oIwcALkUQ8Q2oMEW1F+a2nuUPlPWSXT+59RkYR6y4L6+2iSF9xpIc6p6QQz8
         ReytMuVozgBrukCXZkNIo0Aiz7VcRVN6uLDt0=
Received: by 10.100.241.20 with SMTP id o20mr2919869anh.31.1223765789429;
        Sat, 11 Oct 2008 15:56:29 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-157-161.washdc.fios.verizon.net [72.83.157.161])
        by mx.google.com with ESMTPS id c9sm10029194ana.9.2008.10.11.15.56.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 15:56:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.536.ga36e
In-Reply-To: <7v1vymke85.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97996>

Cygwin's POSIX emulation allows use of core.filemode true, unlike native
Window's implementation of stat / lstat, and Cygwin/git users who have
configured core.filemode true in various repositories will be very
unpleasantly surprised to find that git is no longer honoring that option.
So, this patch forces use of Cygwin's stat functions if core.filemode is
set true, regardless of any other considerations.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/config.txt |    4 +++-
 compat/cygwin.c          |   18 +++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

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
index 423ff20..1fed265 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -91,13 +91,20 @@ static int cygwin_stat(const char *path, struct stat *buf)
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
-	if (!strcmp(var, "core.ignorecygwinfstricks"))
+	if (!strcmp(var, "core.filemode"))
+		core_filemode = git_config_bool(var, value);
+
+	else if (!strcmp(var, "core.ignorecygwinfstricks"))
 		native_stat = git_config_bool(var, value);
+
 	return 0;
 }
 
@@ -105,8 +112,13 @@ static int init_stat(void)
 {
 	if (have_git_dir()) {
 		git_config(git_cygwin_config, NULL);
-		cygwin_stat_fn = native_stat ? cygwin_stat : stat;
-		cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
+		if (!core_filemode && native_stat) {
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
1.6.0.2.536.ga36e
