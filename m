From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: git-mailsplit: add `mailsplit.keep-cr` configuration variable.
Date: Thu, 11 Feb 2010 19:13:54 +0100
Message-ID: <20100211181354.GC15028@scotty.home>
References: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 19:14:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfdYA-0004kX-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0BKSN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 13:13:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:56816 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab0BKSN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 13:13:56 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MOVOL-1NaR1S16Kj-005zqm; Thu, 11 Feb 2010 19:13:55 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BIDsX7015157
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 19:13:54 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BIDssh015155
	for git@vger.kernel.org; Thu, 11 Feb 2010 19:13:54 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
X-Mailer: git-send-email 1.7.0.rc1.50.g84249.dirty
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/DEasidOtp72kFrlTGW7DFRjD8PdZOHOowitC
 v/nXbVTVNVGmPfyQuui0Klii9O9ZdIPVrGEcxSFqs/lLCHeoGE
 NHw/VSe3w+dUXCheOMuuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139612>

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
index 4c36aa9..3ee64a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1246,6 +1246,10 @@ mailmap.file::
 	subdirectory, or somewhere outside of the repository itself.
 	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
 
+mailsplit.keep-cr::
+	If true git-mailsplit will not remove `\r` from lines ending
+	with `\r\n`. See linkgit:git-mailsplit[1].
+
 man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index cdfc1b7..a16de52 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -210,6 +210,15 @@ out:
 	return ret;
 }
 
+static int git_mailsplit_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "mailsplit.keep-cr")) {
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
1.7.0.rc1.50.g84249.dirty
