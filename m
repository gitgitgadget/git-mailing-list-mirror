From: Roy Lee <roylee17@gmail.com>
Subject: [PATCH] clone: add --perm option to clone an shared repository
Date: Sun, 21 Jun 2009 20:17:52 +0800
Message-ID: <1245586672-10894-1-git-send-email-roylee17@gmail.com>
Cc: Roy Lee <roylee17@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 14:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MILxk-0008Ld-L2
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 14:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbZFUMPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 08:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbZFUMPn
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 08:15:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:29232 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZFUMPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 08:15:42 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1256838wfd.4
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NmpFEFFfPP5BKMQP2aL1GPfnMqlvEb5e4RJggQKICWc=;
        b=g4b6sOwzBdBs2y3aO594CLw8K9s3VuhGMagE6UT8ItVGF8ugbutT1RNtmGX7hLUfCV
         qj8h6M59WjzzHyiqMlMS8kOU8OB8zYrIxjLXG2MH9gjT6UXOI9RkiPSzXbRH9lwr/R6s
         lAtx6CicL1c9z9SQKsAsXyo1Uxws1+8vDrZI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SLy6hHfTl+AxZoYXeE9MSe051Sn3SFwWoakQJfA5uzV/E8h+XuwzXWg3cEIkTRoyZi
         FuhlvNlP7dSHirU85lyqwvmYgEcQgrl8SGVDFKfH8tht9Cb2abJQRT8gFLLf7ro+Fvbh
         orZ77/vN/8tebLVWGGcXRxG97xDeD11nXfY/M=
Received: by 10.143.42.7 with SMTP id u7mr2158308wfj.288.1245586544382;
        Sun, 21 Jun 2009 05:15:44 -0700 (PDT)
Received: from localhost.localdomain (220-133-5-141.HINET-IP.hinet.net [220.133.5.141])
        by mx.google.com with ESMTPS id 30sm777017wff.9.2009.06.21.05.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Jun 2009 05:15:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.316.gda4e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121984>

The term 'shared' used here is in the same context with git init.
Unfortunately the 'shared' option has been taken, so I took the "perm"
as a place holder in this patch. Any comments?

Signed-off-by: Roy Lee <roylee17@gmail.com>
---
 Documentation/git-clone.txt |   40 +++++++++++++++++++++++++++++++++++++++-
 builtin-clone.c             |    7 +++++++
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b14de6c..b35818d 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--] <repository> [<directory>]
+	  [--depth <depth>] [--perm[=<permissions>]]
+	  [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -139,6 +140,43 @@ then the cloned repository will become corrupt.
 	with a long history, and would want to send in fixes
 	as patches.
 
+--perm[={false|true|umask|group|all|world|everybody|0xxx}]::
+
+Specify that the git repository is to be shared amongst several users.  This
+allows users belonging to the same group to push into that
+repository.  When specified, the config variable "core.sharedRepository" is
+set so that files and directories under `$GIT_DIR` are created with the
+requested permissions.  When not specified, git will use permissions reported
+by umask(2).
+
+The option can have the following values, defaulting to 'group' if no value
+is given:
+
+ - 'umask' (or 'false'): Use permissions reported by umask(2). The default,
+   when `--perm` is not specified.
+
+ - 'group' (or 'true'): Make the repository group-writable, (and g+sx, since
+   the git group may be not the primary group of all users).
+   This is used to loosen the permissions of an otherwise safe umask(2) value.
+   Note that the umask still applies to the other permission bits (e.g. if
+   umask is '0022', using 'group' will not remove read privileges from other
+   (non-group) users). See '0xxx' for how to exactly specify the repository
+   permissions.
+
+ - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
+   readable by all users.
+
+ - '0xxx': '0xxx' is an octal number and each file will have mode '0xxx'.
+   '0xxx' will override users' umask(2) value (and not only loosen permissions
+   as 'group' and 'all' does). '0640' will create a repository which is
+   group-readable, but not group-writable or accessible to others. '0660' will
+   create a repo that is readable and writable to the current user and group,
+   but inaccessible to others.
+
+By default, the configuration flag receive.denyNonFastForwards is enabled
+in shared repositories, so that you cannot force a non fast-forwarding push
+into it.
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,URLS>> section below for more information on specifying
diff --git a/builtin-clone.c b/builtin-clone.c
index 2ceacb7..ee31d64 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -40,6 +40,7 @@ static const char * const builtin_clone_usage[] = {
 static int option_quiet, option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
+static char *option_perm = NULL;
 static char *option_origin = NULL;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbose;
@@ -59,6 +60,9 @@ static struct option builtin_clone_options[] = {
 		    "don't use local hardlinks, always copy"),
 	OPT_BOOLEAN('s', "shared", &option_shared,
 		    "setup as shared repository"),
+	{ OPTION_STRING, 0, "perm", &option_perm, "mode",
+		    "the repository is to be shared amongst several users",
+		    PARSE_OPT_OPTARG, NULL, (intptr_t)"group" },
 	OPT_STRING(0, "template", &option_template, "path",
 		   "path the template repository"),
 	OPT_STRING(0, "reference", &option_reference, "repo",
@@ -376,6 +380,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (option_perm)
+		shared_repository = git_config_perm("arg", option_perm);
+
 	if (!option_origin)
 		option_origin = "origin";
 
-- 
1.6.3.2.316.gda4e.dirty
