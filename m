Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298AD207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbcJEHrM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 03:47:12 -0400
Received: from mx5-phx2.redhat.com ([209.132.183.37]:48317 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbcJEHrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 03:47:12 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u957lB78019857
        for <git@vger.kernel.org>; Wed, 5 Oct 2016 03:47:11 -0400
Date:   Wed, 5 Oct 2016 03:47:11 -0400 (EDT)
From:   Josef Ridky <jridky@redhat.com>
To:     git@vger.kernel.org
Message-ID: <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
In-Reply-To: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.4.141]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF48 (Linux)/8.0.6_GA_5922)
Thread-Topic: Feature Request: user defined suffix for temp files created by git-mergetool
Thread-Index: A+voVj8tnKTYRSU9gTivl6CydTDZDWbBH6y3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

I have just realize, that my attachment has been cut off from my previous message.
Below you can find patch with requested change.

Add support for user defined suffix part of name of temporary files
created by git mergetool
---
 Documentation/git-mergetool.txt | 26 ++++++++++++++++++++-
 git-mergetool.sh                | 52 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e846c2e..6cf5935 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -8,7 +8,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 SYNOPSIS
 --------
 [verse]
-'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
+'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [--local=<name>] [--remote=<name>] [--backup=<name>] [--base=<name>] [<file>...]
 
 DESCRIPTION
 -----------
@@ -79,6 +79,30 @@ success of the resolution after the custom tool has exited.
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
+--local=<name>::
+	Use string from <name> as part of suffix of name of temporary
+	file (local) for merging. If not used or is equal with any
+	other (remote|backup|base), default value is used.
+	Default suffix is LOCAL.
+
+--remote=<name>::
+	Use string from <name> as part of suffix of name of temporary
+	file (remote) for merging. If not used or is equal with any
+	other (local|backup|base), default value is used.
+	Default suffix is REMOTE.
+
+--backup=<name>::
+	Use string from <name> as part of suffix of name of temporary
+	file (backup) for merging. If not used or is equal with any
+	other (local|remote|base), default value is used.
+	Default suffix is BACKUP.
+
+--base=<name>::
+	Use string from <name> as part of suffix of name of temporary
+	file (base) for merging. If not used or is equal with any
+	other (local|remote|backup), default value is used.
+	Default suffix is BASE.
+
 TEMPORARY FILES
 ---------------
 `git mergetool` creates `*.orig` backup files while resolving merges.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index bf86270..e3433ee 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,11 +8,18 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [--local=name] [--remote=name] [--backup=name] [--base=name] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 NONGIT_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
+
+#optional name space convention
+local_name=""
+remote_name=""
+base_name=""
+backup_name=""
+
 . git-sh-setup
 . git-mergetool--lib
 
@@ -271,10 +278,33 @@ merge_file () {
 		BASE=${BASE##*/}
 	fi
 
-	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
-	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
-	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
-	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
+	if [ "$local_name" != "" ]  && [ "$local_name" != "$remote_name" ] && [ "$local_name" != "$backup_name" ] && [ "$local_name" != "$base_name" ]
+	then
+		LOCAL="$MERGETOOL_TMPDIR/${BASE}_${local_name}_$$$ext"
+	else
+		LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
+	fi
+
+	if [ "$remote_name" != "" ] && [ "$remote_name" != "$local_name" ] && [ "$remote_name" != "$backup_name" ] && [ "$remote_name" != "$base_name" ]
+	then
+		REMOTE="$MERGETOOL_TMPDIR/${BASE}_${remote_name}_$$$ext"
+	else
+		REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
+	fi
+
+	if [ "$backup_name" != "" ] && [ "$backup_name" != "$local_name" ] && [ "$backup_name" != "$remote_name" ] && [ "$backup_name" != "$base_name" ]
+	then
+		BACKUP="$MERGETOOL_TMPDIR/${BASE}_${backup_name}_$$$ext"
+	else
+		BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
+	fi
+
+	if [ "$base_name" != "" ] && [ "$base_name" != "$local_name" ] && [ "$base_name" != "$remote_name" ] && [ "$base_name" != "$backup_name" ]
+	then
+		BASE="$MERGETOOL_TMPDIR/${BASE}_${base_name}_$$$ext"
+	else
+		BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
+	fi
 
 	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
 	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
@@ -396,6 +426,18 @@ do
 	--prompt)
 		prompt=true
 		;;
+	--local=*)
+		local_name=${1#--local=}
+		;;
+	--remote=*)
+		remote_name=${1#--remote=}
+		;;
+	--base=*)
+		base_name=${1#--base=}
+		;;
+	--backup=*)
+		backup_name=${1#--backup=}
+		;;
 	--)
 		shift
 		break
-- 
2.7.4
