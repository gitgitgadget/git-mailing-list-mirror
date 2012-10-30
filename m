From: szager@google.com
Subject: [PATCH] Enable parallelism in git submodule update.
Date: Tue, 30 Oct 2012 11:03:59 -0700
Message-ID: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: jens.lehmann@web.de, hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 19:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGAk-0006K9-FN
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141Ab2J3SEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:04:05 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:38855 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759939Ab2J3SEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:04:04 -0400
Received: by mail-bk0-f74.google.com with SMTP id q16so42186bkw.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=GeYm5wfpBxApKv5ybp9BSQyKY3MXeG4vuBeFoZCaSFo=;
        b=eCEtzxcBIcgnQzW/iUQKscNYBgWb55zsclFvdVUgsI4jYtxj3M/YAHrzl4MmDvXsne
         o1TzV42pqwtIKR/JdTR46d8/PTOUVXcWAXE1Hdj+IHVteBImcJOncTaHJcJjOu6CjBuk
         pyRpMItLXGpcHVhyVSTiqe61BvOgk3OoH/V8NFI3D3+upj28l1itQW/bAjvf+B5NmJHj
         ySYdCTut6ZwJGDVOkTafiJZtTXmk5a1NyAcur4+drGfFeDyQa/DgP1c7h4bY4rBuEcn8
         ZceWfjYVz9XyHzvxSimtjf0PguHtdYDBHQsxTZm+tEHvunV3VM7id8Jt6/ADtvLPiio6
         4gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=GeYm5wfpBxApKv5ybp9BSQyKY3MXeG4vuBeFoZCaSFo=;
        b=C857lMH+wbX6FPX6luxQZKjzpoziOZS4KdV0pqGmrpPXrt0B34U2O0S4KpYUi1+o0m
         keJnw61c2JGeFnQFT3euXHZtShCZPfVWmFfJEs+m8HCTDADUGtUrwaR5soYOzt9mAsUW
         MW7GUiXs3AMUSgVoKkAzgWLTRIep9nK2ZAztGNnyZjoUPByNAW0DppM8hjkfB2nD1MXH
         FqmpkPwpKDGuxA4+sOWd+RrRE0DdHDSVPiv56IgtmNTaXteoJszmduF4pNdXedmVIf7v
         AoC3UgihpYVYuz8KO1YwUVglKeF8REGGboNPvZk0CGIJ6bPcsnMSlaeDeyyy4oMT/TMG
         Wt2A==
Received: by 10.14.216.197 with SMTP id g45mr34759368eep.3.1351620241492;
        Tue, 30 Oct 2012 11:04:01 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z47si323178eel.0.2012.10.30.11.04.01
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 30 Oct 2012 11:04:01 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id DE7425C0050;
	Tue, 30 Oct 2012 11:04:00 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id 0A73240BDB; Tue, 30 Oct 2012 11:03:59 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQlHwpqHtBy3TMvn9hc4s5ZZ2Mc0xmFuF4+dbKwmqTouVuOgJsRm4W8Txyx3kJTOGBYYslKR02qcObGGgYmxWP4xDVwR9yKJbl/4h6k7V4DesGWkUFBAC/rUTwxH6p3g/pqK5fE5zSUbjYYFYh18UvmWy0ojjWHdgHEARHFqZMUdWRGg1IrWsnOkVV7tYVyFuxGW6kBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208714>

The --jobs parameter may be used to set the degree of per-submodule
parallel execution.

Signed-off-by: Stefan Zager <szager@google.com>
---
 Documentation/git-submodule.txt |    8 ++++++-
 git-submodule.sh                |   40 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b4683bb..cb23ba7 100644
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
@@ -146,6 +147,11 @@ If the submodule is not yet initialized, and you just want to use the
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
 +
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..60a5f96 100755
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
@@ -500,6 +500,7 @@ cmd_update()
 {
 	# parse $args after "submodule ... update".
 	orig_flags=
+	jobs="1"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -518,6 +519,20 @@ cmd_update()
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
@@ -551,11 +566,34 @@ cmd_update()
 		shift
 	done
 
+	# Correctly handle the case where '-q' came before 'update' on the command line.
+	if test -n "$GIT_QUIET"
+	then
+		orig_flags="$orig_flags -q"
+	fi
+
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
 	fi
 
+	if test "$jobs" != 1
+	then
+		if ( echo test | xargs -P "$jobs" true 2>/dev/null )
+		then
+			if ( echo test | xargs --max-lines=1 true 2>/dev/null ); then
+				max_lines="--max-lines=1"
+			else
+				max_lines="-L 1"
+			fi
+			module_list "$@" | awk '{print $4}' |
+			xargs $max_lines -P "$jobs" git submodule update $orig_flags
+			return
+		else
+			echo "Warn: parallel execution is not supported on this platform."
+		fi
+	fi
+
 	cloned_modules=
 	module_list "$@" | {
 	err=
-- 
1.7.7.3
