From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/3] builtin-merge: refactor to use git_config_option_string
Date: Fri,  6 Mar 2009 17:15:14 -0500
Message-ID: <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	jean-luc malet <jeanluc.malet@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 23:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfiS5-0000ZB-0m
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbZCFWWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbZCFWWH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:22:07 -0500
Received: from mail-qy0-f122.google.com ([209.85.221.122]:35522 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbZCFWWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:22:04 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2009 17:22:03 EST
Received: by qyk28 with SMTP id 28so344160qyk.33
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/8k/ABPmUJ3dcVDyha7YG67RAWUHWPIoTXhYeYV6WIw=;
        b=sd5cMP9ckvFE3NhtE+oBmipGjIN10riiCJERNcDInDPuS4MCX4n8MpijkrB6FxPNHO
         YVtb7fD8TSvq65AgfkiHUd2fImYl8XAGifBn+Uvgzc3x9Qg15mF0qqsGBW4ROSWF0SOc
         2TQjjIUkr3+ykvx5ZF0sRC7quWH863lxcnRlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aB6RApe356JCflsyG/3Jk7sd5BNrYFaIUxrsG2Yr02/hZfbLd7ewVJLLYF0g8xocrh
         2Hgdbmx2z1AWHV+CajIeY2erkPMXTx+fF3qis+ni6NThj6aLTQANgwVegREbnLJHbQZ3
         /w0WNz8YfVg0fdZxnW0e5/ZHpZP6/KKIbSTUU=
Received: by 10.224.80.134 with SMTP id t6mr4537770qak.246.1236377733082;
        Fri, 06 Mar 2009 14:15:33 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 7sm1354261qwf.10.2009.03.06.14.15.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 14:15:32 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1236377358.git.jaysoffian@gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112486>

This patch teaches builtin-merge to use git_config_option_string() for
parsing branch.<name>.mergeoptions

As a side-effect, setting branch.<name>.mergeoptions to "" is no longer
supported. The tests have been modified to reflect this fact, along with
some minor refactoring to support additional tests in the next patch.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I think the side-effect is fine, since why would anyone have an empty
mergeoptions in their config? But if the list disagrees, it's trivial to
modify the preceeding patch to skip over an empty config w/o it being an
error.

Also, it seems like the with_config() utility function here might be
useful for other test scripts, so perhaps it should go into test-lib.sh?

 builtin-merge.c  |   14 +---------
 t/t7600-merge.sh |   74 +++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 6d2160d..504f2be 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -452,20 +452,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
 		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
-		const char **argv;
-		int argc;
-		char *buf;
-
-		buf = xstrdup(v);
-		argc = split_cmdline(buf, &argv);
-		if (argc < 0)
+		if (git_config_option_string(builtin_merge_options, 0, k, v))
 			die("Bad branch.%s.mergeoptions string", branch);
-		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
-		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
-		argc++;
-		parse_options(argc, argv, builtin_merge_options,
-			      builtin_merge_usage, 0);
-		free(buf);
 	}
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5b210b..9db8bb4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -188,6 +188,37 @@ verify_no_mergehead() {
 	fi
 }
 
+with_config() {
+	names_to_unset=
+	retval=0
+	while test $# -gt 1
+	do
+		if test "$1" = "--"
+		then
+			shift
+			break
+		fi
+		if git config "$1" "$2"
+		then
+			names_to_unset="$names_to_unset $1"
+			shift
+			shift
+		else
+			retval=1
+			break
+		fi
+	done
+	if test $retval = 0
+	then
+		git "$@"
+		retval=$?
+	fi
+	for name in $names_to_unset
+	do
+		git config --unset "$name"
+	done
+	return $retval
+}
 
 test_expect_success 'setup' '
 	git add file &&
@@ -327,8 +358,8 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c2 (no-commit in config)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--no-commit" &&
-	git merge c2 &&
+	with_config branch.master.mergeoptions --no-commit -- \
+		merge c2 &&
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
 	verify_mergeheads $c2
@@ -338,8 +369,8 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--squash" &&
-	git merge c2 &&
+	with_config branch.master.mergeoptions --squash -- \
+		merge c2 &&
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
 	verify_no_mergehead &&
@@ -350,9 +381,9 @@ test_debug 'gitk --all'
 
 test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "-n" &&
 	test_tick &&
-	git merge --summary c2 >diffstat.txt &&
+	with_config branch.master.mergeoptions -n -- \
+		merge --summary c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
 	if ! grep "^ file |  *2 +-$" diffstat.txt
@@ -364,9 +395,9 @@ test_expect_success 'override config option -n with --summary' '
 
 test_expect_success 'override config option -n with --stat' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "-n" &&
 	test_tick &&
-	git merge --stat c2 >diffstat.txt &&
+	with_config branch.master.mergeoptions -n -- \
+		merge --stat c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
 	if ! grep "^ file |  *2 +-$" diffstat.txt
@@ -380,9 +411,9 @@ test_debug 'gitk --all'
 
 test_expect_success 'override config option --stat' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--stat" &&
 	test_tick &&
-	git merge -n c2 >diffstat.txt &&
+	with_config branch.master.mergeoptions --stat -- \
+		merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
 	if grep "^ file |  *2 +-$" diffstat.txt
@@ -396,9 +427,9 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--no-commit" &&
 	test_tick &&
-	git merge --commit c2 &&
+	with_config branch.master.mergeoptions --no-commit -- \
+		merge --commit c2 &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2
 '
@@ -407,9 +438,9 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c2 (override --squash)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--squash" &&
 	test_tick &&
-	git merge --no-squash c2 &&
+	with_config branch.master.mergeoptions --squash -- \
+		merge --no-squash c2 &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2
 '
@@ -418,7 +449,6 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c0 with c1 (no-ff)' '
 	git reset --hard c0 &&
-	git config branch.master.mergeoptions "" &&
 	test_tick &&
 	git merge --no-ff c1 &&
 	verify_merge file result.1 &&
@@ -434,15 +464,16 @@ test_expect_success 'combining --squash and --no-ff is refused' '
 
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
 	git reset --hard c0 &&
-	git config branch.master.mergeoptions "--no-ff" &&
-	git merge --ff c1 &&
+	with_config branch.master.mergeoptions --no-ff -- \
+		merge --ff c1 &&
 	verify_merge file result.1 &&
 	verify_head $c1
 '
 
 test_expect_success 'merge log message' '
 	git reset --hard c0 &&
-	git merge --no-log c2 &&
+	with_config branch.master.mergeoptions --no-ff -- \
+		merge --no-log c2 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
 	verify_diff msg.nolog msg.act "[OOPS] bad merge log message" &&
 
@@ -451,8 +482,8 @@ test_expect_success 'merge log message' '
 	verify_diff msg.log msg.act "[OOPS] bad merge log message" &&
 
 	git reset --hard HEAD^ &&
-	git config merge.log yes &&
-	git merge c3 &&
+	with_config merge.log yes -- \
+		merge c3 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
 	verify_diff msg.log msg.act "[OOPS] bad merge log message"
 '
@@ -461,7 +492,6 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
-       git config branch.master.mergeoptions "" &&
        test_tick &&
        git merge c0 c2 c0 c1 &&
        verify_merge file result.1-5 &&
@@ -472,7 +502,6 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
-       git config branch.master.mergeoptions "" &&
        test_tick &&
        git merge c0 c2 c0 c1 &&
        verify_merge file result.1-5 &&
@@ -483,7 +512,6 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c1 with c1 and c2' '
        git reset --hard c1 &&
-       git config branch.master.mergeoptions "" &&
        test_tick &&
        git merge c1 c2 &&
        verify_merge file result.1-5 &&
-- 
1.6.2.rc2.332.g5d21b
