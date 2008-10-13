From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode == true
Date: Mon, 13 Oct 2008 00:33:31 -0400
Message-ID: <1223872411-3328-1-git-send-email-mlevedahl@gmail.com>
References: <7vd4i5fkny.fsf@gitster.siamese.dyndns.org>
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 13 06:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpF8V-0004uD-VN
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 06:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYJMEdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 00:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYJMEdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 00:33:16 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60888 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYJMEdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 00:33:15 -0400
Received: by gxk9 with SMTP id 9so3138068gxk.13
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=egiCU59GC3khgupNGQY9rFayhdbKX4HA+QpMLHEHIXU=;
        b=DDnTq9/weP5i2rNfF0WnCBuLEkrw/xr0lulVd6BIi+OBB7dx4U1COYWs2xRS5A2cj/
         iVk7qU+AFAOU0sd9J+IMv2UjXhbB/bD9WljcNMl6VSmyrBM0/5nQ69jkWYsLxHAJwvO5
         swaE8I8B/ngrDHmvyKqxxch0lfh/M9Ot8VG5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HjlxLa+4fJovQ29xWiQ7a4m8B7LB+ATKANSzNBjWg3IxNdbKtmhovYERZ3vjdvYcf5
         WANO5o6swMsENPO+u8uHhR1k1rUmVdyYPh8J5ZzCkzYG5MCpHmIHdR34qGHuDB/LuQ6N
         0vOgxU4QEBKjrMUprKRIZnnw9eVXe5zVEBSR4=
Received: by 10.151.102.21 with SMTP id e21mr7184793ybm.244.1223872394101;
        Sun, 12 Oct 2008 21:33:14 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-157-161.washdc.fios.verizon.net [72.83.157.161])
        by mx.google.com with ESMTPS id 6sm4535375ywp.3.2008.10.12.21.33.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 21:33:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.535.ga11fa.dirty
In-Reply-To: <7vd4i5fkny.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98082>

Cygwin's POSIX emulation allows use of core.filemode true, unlike native
Window's implementation of stat / lstat, and Cygwin/git users who have
configured core.filemode true in various repositories will be very
unpleasantly surprised to find that git is no longer honoring that option.
So, this patch forces use of Cygwin's stat functions if core.filemode is
set true, regardless of any other considerations.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/config.txt |    4 +++-
 compat/cygwin.c          |   20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

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
index 423ff20..780375e 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -91,22 +91,32 @@ static int cygwin_stat(const char *path, struct stat *buf)
  * functions should be used. The choice is determined by core.ignorecygwinfstricks.
  * Reading this option is not always possible immediately as git_dir may be
  * not be set yet. So until it is set, use cygwin lstat/stat functions.
+ * However, if the trust_executable_bit is set, we must use the Cygwin posix
+ * stat/lstat as the Windows stat fuctions do not determine posix filemode.
  */
 static int native_stat = 1;
+extern int trust_executable_bit;
 
 static int git_cygwin_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "core.ignorecygwinfstricks"))
-		native_stat = git_config_bool(var, value);
-	return 0;
+	if (!strcmp(var, "core.ignorecygwinfstricks")) {
+			native_stat = git_config_bool(var, value);
+			return 0;
+	}
+	return git_default_config(var, value, cb);
 }
 
 static int init_stat(void)
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
1.6.0.2.535.ga11fa.dirty
