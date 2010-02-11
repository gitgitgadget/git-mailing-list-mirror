From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 2/4] git-mailsplit: add `mailsplit.keepcr` configuration variable.
Date: Thu, 11 Feb 2010 22:26:17 +0100
Message-ID: <1265923579-24900-3-git-send-email-stefan.hahn@s-hahn.de>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgZH-0004pW-AJ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853Ab0BKV1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:27:11 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:54710 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab0BKV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:27:09 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MYLIX-1NB2kq2eOH-00VFCQ; Thu, 11 Feb 2010 22:27:06 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BLR4tT025029;
	Thu, 11 Feb 2010 22:27:04 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BLR4FN025025;
	Thu, 11 Feb 2010 22:27:04 +0100
X-Mailer: git-send-email 1.7.0.rc2.17.g39385
In-Reply-To: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1+uH64kGYIpy8bVxZANHx6uIuMe893cItGnQmu
 Rkmctc9M1FpkN+MA8Xwnu5xMd9OlaLmk4/2OgmMSZsq4IfuZJE
 r8HFGmuREJCU6UfnF++EQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139633>

If using git-mailsplit in environments where files with dos and unix
line ending stay in one repository mbox patches must be split with
additional parameter '--keep-cr', because the behaviour of
git-mailsplit have been changed in commit c2ca1d79.

With this patch the behaviour of git-mailsplit can be set via
configuration file.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 Documentation/config.txt |    4 ++++
 builtin-mailsplit.c      |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c36aa9..37a4968 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1246,6 +1246,10 @@ mailmap.file::
 	subdirectory, or somewhere outside of the repository itself.
 	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
 
+mailsplit.keepcr::
+	If true git-mailsplit will not remove `\r` from lines ending
+	with `\r\n`. See linkgit:git-mailsplit[1].
+
 man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index cdfc1b7..e76974d 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -210,6 +210,15 @@ out:
 	return ret;
 }
 
+static int git_mailsplit_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "mailsplit.keepcr")) {
+		keep_cr = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
 	int nr = 0, nr_prec = 4, num = 0;
@@ -218,6 +227,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 	const char **argp;
 	static const char *stdin_only[] = { "-", NULL };
 
+	git_config(git_mailsplit_config, NULL);
 	for (argp = argv+1; *argp; argp++) {
 		const char *arg = *argp;
 
-- 
1.7.0.rc2.17.g39385
