From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] config: --replace-all with one argument exits properly
	with a better message.
Date: Sat, 14 Mar 2009 03:42:32 +0100
Message-ID: <1236998552.9952.2.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, johannes.schindelin@gmx.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 14 03:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiJzM-00022z-Vz
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 03:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbZCNCth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 22:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbZCNCtg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 22:49:36 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:40754 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZCNCtf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 22:49:35 -0400
Received: by fxm24 with SMTP id 24so2848141fxm.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=tGdOvZqTGjsYNwqIsA/OyonAdNXqTh8WA7mR80wcbXo=;
        b=FMCz7h1xPgCMsDnhHorvlL5JonVze7DKMFD6YmtC00EaTjOfznEzP1mhseOcdaFb88
         qwvwE8fjbun0gxwckARR8VAWJWflFsxzb5IWnZSxV7x5QJ3e8ZtKMUnqfAI+i68x/DNZ
         hOFx3rF/FslTCDv+TTVybFyOxaEFzX5+C2Ae0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=WVC71TpInlsReZ7yq/C9+fqzCpGebXMS147SLZ8dsbButUbsX+EeOpWNChDMWB2XbM
         gWePLRHDNJEzzdeEaI2/blLzanOQGJzlUeLIlRZQbLD2Y7CF9Rue8xccxMXCN/vtW9KR
         mHbXvr31YSK1UVH2Oe3XcHtyfdS9RhZ63No0I=
Received: by 10.103.160.3 with SMTP id m3mr941783muo.25.1236998585089;
        Fri, 13 Mar 2009 19:43:05 -0700 (PDT)
Received: from ?192.168.0.194? ([212.145.102.186])
        by mx.google.com with ESMTPS id j6sm4934193mue.4.2009.03.13.19.43.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Mar 2009 19:43:04 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113232>

'config --replace-all ONE_ARG' was being treated as 'config NAME VALUE',
showing the error "key does not contain a section: --replace-all".

Now it exits before with an error message asking for the missing value.
Documentation is updated and a new test is added to ensure that
configuration remains the same when no value is provided.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 Documentation/git-config.txt |    2 +-
 builtin-config.c             |    2 ++
 t/t1300-repo-config.sh       |    9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 82ce89e..7131ee3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git config' [<file-option>] [type] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [type] --add name value
-'git config' [<file-option>] [type] --replace-all name [value [value_regex]]
+'git config' [<file-option>] [type] --replace-all name value [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-regexp name_regex [value_regex]
diff --git a/builtin-config.c b/builtin-config.c
index d52a057..005b6ea 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -386,6 +386,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return git_config_set_multivar(argv[2], NULL, NULL, 1);
 		else if (!strcmp(argv[1], "--get"))
 			return get_value(argv[2], NULL);
+		else if (!strcmp(argv[1], "--replace-all"))
+			return error("missing value for --replace-all");
 		else if (!strcmp(argv[1], "--get-all")) {
 			do_all = 1;
 			return get_value(argv[2], NULL);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c06842..9c81e04 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -118,7 +118,14 @@ EOF
 
 test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
 
-mv .git/config2 .git/config
+cp .git/config2 .git/config
+
+test_expect_success '--replace-all missing value' '
+	test_must_fail git config --replace-all beta.haha &&
+	test_cmp .git/config2 .git/config
+'
+
+rm .git/config2
 
 test_expect_success '--replace-all' \
 	'git config --replace-all beta.haha gamma'
-- 
1.5.4.3
