From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH RFC] Add a config verbose option fetch and push
Date: Fri, 21 May 2010 08:26:11 -0500
Message-ID: <4bf69283.47c1f10a.1ecf.1183@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 16:03:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFSoc-0003tk-Pa
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 16:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab0EUOCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 10:02:46 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:48127 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0EUOCp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 10:02:45 -0400
Received: by qyk1 with SMTP id 1so1456039qyk.5
        for <git@vger.kernel.org>; Fri, 21 May 2010 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:date:subject
         :to;
        bh=Gqr1VlG7W0/jWQ0XKG8VLSTMsjHZU6b9bAgm9z8LNL0=;
        b=wR2vItNOT+inOpXKUfwAYFklPNhKd8z2dl/vRX29JLCVB2IIFwasrRHBq/X9SBDUFL
         uDkXWbCaeh6jYnNqkNvUQwbEkAtwZ9xFBdqVbS5XffyUpPnrwyNejGepMyBoe3EyH9Kp
         iEbTEbeGE/6Vk5Ji6CXBdZJefDWEI/3hX0AxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=uS4B8uxqtaTB8C5QICLdZmZvIhJsiskqo6rfo1bqU37GhS3S0oiJzpqPt/vE6poGH4
         TSAc3HRgSqO8nvl674p2XIB/6gWDoc5s+iBfeuF6AFPv+TtHTM1fXTd3VSXED7eEgYqb
         NRgpskeubGMbMMjMmmfWc3k+Kyhf4o1y43MFc=
Received: by 10.224.85.196 with SMTP id p4mr1131035qal.6.1274450564286;
        Fri, 21 May 2010 07:02:44 -0700 (PDT)
Received: from localhost ([76.201.150.206])
        by mx.google.com with ESMTPS id 7sm2729971qwb.4.2010.05.21.07.02.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 07:02:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147456>

---
There are a couple projects that I follow where I find it useful to always
set the verbose flag.  Setting this in the configuration file would let me 
avoid the times I forget to set it on the command line. I decided to do both
push and fetch at the same time.

 Documentation/config.txt |   10 ++++++++++
 builtin/fetch.c          |    7 +++++++
 builtin/push.c           |    7 +++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 39140ba..8e8a760 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -860,6 +860,11 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+fetch.verbose::
+	If true, it is the same as setting "-v" on the command line. If it is
+	false or not defined, git will use the command line parameters to
+	decide the verboseness of fetch.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
@@ -1495,6 +1500,11 @@ push.default::
 * `tracking` push the current branch to its upstream branch.
 * `current` push the current branch to a branch of the same name.
 
+push.verbose::
+	If true, it is the same as using the '-v' flag on the command
+	line. If it is false, git will use the command line to determine
+	the verboseness of a push.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8470850..b2891b1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,6 +885,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	return exit_code;
 }
 
+static int git_fetch_verbose_config(const char *var,const char *value, void *dummy)
+{
+	if(!strcmp("fetch.verbose",var) && !verbosity)
+		verbosity = git_config_maybe_bool(NULL,value);
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -899,6 +905,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+	git_config(git_fetch_verbose_config,NULL);
 
 	if (all) {
 		if (argc == 1)
diff --git a/builtin/push.c b/builtin/push.c
index f4358b9..6779031 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,6 +202,12 @@ static int do_push(const char *repo, int flags)
 	return !!errs;
 }
 
+static int git_push_verbose_config(const char *var, const char *value, void *d)
+{
+	if(!strcmp("push.verbose",var) && !verbosity)
+		verbosity = git_config_maybe_bool(NULL,value);
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -230,6 +236,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	git_config(git_push_verbose_config,NULL);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die("--delete is incompatible with --all, --mirror and --tags");
-- 
1.7.1
