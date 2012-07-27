From: Stefan Zager <szager@google.com>
Subject: [PATCH] Enable parallelism in git submodule update.
Date: Fri, 27 Jul 2012 11:37:34 -0700
Message-ID: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
Cc: gitster@pobox.com, jens.lehmann@web.de, hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 20:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuplF-0000p5-5Q
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 20:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab2G0S73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 14:59:29 -0400
Received: from mail-gh0-f202.google.com ([209.85.160.202]:33278 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2G0S71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 14:59:27 -0400
Received: by ghbz15 with SMTP id z15so366601ghb.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:date:subject:to:cc:message-id;
        bh=dFuJBqazYswiHIKPjSE92TBFl1WDWXkCnZ7dFd6wdGY=;
        b=Bw8G77S47qgMDPkppl+cQec2mqfZlKKMH+6nuHI86PGTVtsTt/Hn9iQNxrHUaPW0h5
         HGO7rWo/CyBKBEjqP5iPPO0R/TlGysxeX52cq3OVE2L3RHtxdy9t42DHsF0C85GlN6Tt
         Uc6CMhSO6DJbrzRN++NOUO85wdgqBmyuv/f5pdBYbET6HQL/iwwjtHd4T8CfwqrtXM3d
         B9D26s8UMDwvvJxpAsAa+GvDzWQAO4VUGBYm/U/vMApBEVtA9mNy43iUSbQLSWM8Ijwx
         BthVYgTYov44idtbKy53rXnWJi/V5BanLwPExo6BKre0FK94iZWUGipZhgNIDaqH4Hg+
         kUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:date:subject:to:cc:message-id:x-gm-message-state;
        bh=dFuJBqazYswiHIKPjSE92TBFl1WDWXkCnZ7dFd6wdGY=;
        b=QxEILOa3uFdmXECn53Z+xpGQwvtxyToVPc3xy7CfRrvGRiCAFkiRJAwHrHU6vZCoIb
         FBuem1pNtHFtqheyAqNubeiTaSKXCwEHNSnXnZgUnDwftpRkpV3/cx94B2qjgHJyBPJo
         BEZ2C53yHFS3DLTPBmdlmjWjHP+rY+/drukuToF1G9qaSGoX8x3IFw5RPqOutvmr5gFl
         UmTpy59hvLZxPo5f9VPE9BO85GGi1rC1rtdHWtYA7xTBHKHLn10PiNr922/DkJ6Pb1nG
         w1rNVGK1pIq7nBT5Y03yeMHJ5kKi/rPLhstCPb0fxyGlkMlB708PtFUpqOJ1g42nryXc
         TGxg==
Received: by 10.236.185.226 with SMTP id u62mr1876482yhm.3.1343415566486;
        Fri, 27 Jul 2012 11:59:26 -0700 (PDT)
Received: by 10.236.185.226 with SMTP id u62mr1876479yhm.3.1343415566424;
        Fri, 27 Jul 2012 11:59:26 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id w65si776791yhi.1.2012.07.27.11.59.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Jul 2012 11:59:26 -0700 (PDT)
Received: from stefro.sfo.corp.google.com (stefro.sfo.corp.google.com [172.31.52.143])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 483E5100047
	for <git@vger.kernel.org>; Fri, 27 Jul 2012 11:59:26 -0700 (PDT)
Received: by stefro.sfo.corp.google.com (Postfix, from userid 138314)
	id 793121C0FDC; Fri, 27 Jul 2012 11:59:25 -0700 (PDT)
X-Gm-Message-State: ALoCoQm38EtSgKnnoEmmez3ywgDZ1U+qG9SBPS9Zw4QN6gV/C23KjCgLMNRfjSioPayY4gl5FVHyRJlgAEvHWTZM7MNW/KZNbladCIvcoCVIVYHfltZNHjiss/plUUCTEFYb8u+iotycd/jIQRA3YiWnQe7DtvuMGhjCJVAUrsUnSLfDmTjqc5+4SvvVHQcslqnEUkphpR5e5LCov4V0r642+QRM2PoCsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202366>

The --jobs parameter may be used to set the degree of per-submodule
parallel execution.

Signed-off-by: Stefan Zager <szager@google.com>
---
 Documentation/git-submodule.txt |  8 +++++++-
 git-submodule.sh                | 23 ++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index fbbbcb2..34f81fb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
-	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+	      [--reference <repository>] [--merge] [--recursive]
+	      [-j|--jobs [jobs]] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -147,6 +148,11 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 +
+By default, each submodule is treated serially.  You may specify a degree of
+parallel execution with the --jobs flag.  If a parameter is provided, it is
+the maximum number of jobs to run in parallel; without a parameter, all jobs are
+run in parallel.
++
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 
diff --git a/git-submodule.sh b/git-submodule.sh
index dba4d39..761420a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-j|--jobs [jobs]] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
@@ -473,6 +473,7 @@ cmd_update()
 {
 	# parse $args after "submodule ... update".
 	orig_flags=
+	jobs="1"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -491,6 +492,20 @@ cmd_update()
 		-r|--rebase)
 			update="rebase"
 			;;
+		-j|--jobs)
+			case "$2" in
+			''|-*)
+				jobs="0"
+				;;
+			*)
+				jobs="$2"
+				shift
+				;;
+			esac
+			# Don't preserve this arg.
+			shift
+			continue
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
@@ -529,6 +544,12 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
+	if test "$jobs" != "1"
+	then
+		module_list "$@" | awk '{print $4}' | xargs -L 1 -P "$jobs" git submodule update $orig_args
+		return
+	fi
+
 	cloned_modules=
 	module_list "$@" | {
 	err=
-- 
1.7.11.rc2
