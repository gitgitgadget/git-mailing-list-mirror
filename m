From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH RFC] Add a config verbose option fetch and push
Date: Fri, 21 May 2010 08:26:11 -0500
Message-ID: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 18:38:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFVEv-0005Wj-RF
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934008Ab0EUQiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 12:38:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54448 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933996Ab0EUQiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:38:17 -0400
Received: by vws9 with SMTP id 9so985493vws.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:date:subject
         :to;
        bh=Qs2+HA+k584qYnSShFtFicOKNLoLe4xJb9jHobicBW0=;
        b=RacEppHMcy++cE6q9Sp7F+0b+hZzafpykQJEEdUQEP4VcZPyfRMutDp0Aaj8TxQ1nd
         sVeWjWvR6uL66qDsu+a9yk/ZyJkgls843YpXsBnZoT80xpk2pwONYKscueT+C7cJLWWL
         a/67h2Ra6sXeKTngxHwWYcukXlUS/F9A+Mf5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=QC+zLaibUmVkqxJEjG59b45ctXNFqE8L7G0j39VRHA/OpGZYB3qwC2Lgma5mRyWTnY
         08s+wx0zt56qVazNK7HgVcUVKJ/Sc8nNuRcGyxWx2hlYCMMID7i8uh65lrIIPYtnIAvP
         DXRc3L0EMWRoSXmg5B0iPOJkYFFes3GalxZrI=
Received: by 10.220.123.68 with SMTP id o4mr1212727vcr.148.1274459894154;
        Fri, 21 May 2010 09:38:14 -0700 (PDT)
Received: from localhost ([144.92.149.203])
        by mx.google.com with ESMTPS id i29sm5212276vcr.0.2010.05.21.09.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 09:38:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147482>

---
>> 
>> +fetch.verbose::
>> +	If true, it is the same as setting "-v" on the command line. If it is
>> +	false or not defined, git will use the command line parameters to
>> +	decide the verboseness of fetch.
>> +
> 
> Don't you usually use the configured option as the default, and 
> then let the command line options override it (e.g., by specifying
> --no-verbose).
> 
> //Peter
> 

This patch fixes this objection.

 Documentation/config.txt |    7 +++++++
 builtin/fetch.c          |    7 +++++++
 builtin/push.c           |    7 +++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 39140ba..fc88d02 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -860,6 +860,9 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+fetch.verbose::
+	If true, it is the same as setting "-v" on the command line.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
@@ -1495,6 +1498,10 @@ push.default::
 * `tracking` push the current branch to its upstream branch.
 * `current` push the current branch to a branch of the same name.
 
+push.verbose::
+	If true, it is the same as using the '-v' flag on the command
+	line.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8470850..f4832fe 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,6 +885,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	return exit_code;
 }
 
+static int git_fetch_verbose_config(const char *var,const char *value, void *dummy)
+{
+	if(!strcmp("fetch.verbose",var))
+		verbosity = git_config_maybe_bool(NULL,value);
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -897,6 +903,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	git_config(git_fetch_verbose_config,NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
diff --git a/builtin/push.c b/builtin/push.c
index f4358b9..e907b11 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,6 +202,12 @@ static int do_push(const char *repo, int flags)
 	return !!errs;
 }
 
+static int git_push_verbose_config(const char *var, const char *value, void *d)
+{
+	if(!strcmp("push.verbose",var))
+		verbosity = git_config_maybe_bool(NULL,value);
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -229,6 +235,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	git_config(git_push_verbose_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-- 
1.7.1.97.gf85c7
