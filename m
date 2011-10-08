From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Sat, 8 Oct 2011 18:40:15 +0530
Message-ID: <20111008131015.GA28213@sita-lt.atc.tcs.com>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
 <20111006125658.GB18709@sita-lt.atc.tcs.com>
 <7v62k210pj.fsf@alter.siamese.dyndns.org>
 <20111006181522.GA2936@sita-lt.atc.tcs.com>
 <7vwrcgtvh4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 15:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCWfp-0007pl-HF
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 15:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab1JHNKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 09:10:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55668 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1JHNKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 09:10:33 -0400
Received: by yxl31 with SMTP id 31so4341028yxl.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cn4rqtAcHTDegUBa7WoVvh9DxacoG7lYRxZGBZkKz/k=;
        b=IkNANXzyMWoRLlNUy8JKZBZ00pj7edySpMljZYTm8q5cNBTLVFTF5r5HkthRWTK70C
         947ZqdWZEte1s2qgVxDpzzmA7sKxKEGAnB2b0cLKYERWTPSBqKZY3uHbhNmQEJaT9xk3
         sVw7ajEm2pamD4B7igl/n31DUbYJgxm2CYboc=
Received: by 10.68.156.20 with SMTP id wa20mr21297552pbb.58.1318079432753;
        Sat, 08 Oct 2011 06:10:32 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.182.57])
        by mx.google.com with ESMTPS id z1sm42925528pbl.5.2011.10.08.06.10.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 06:10:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrcgtvh4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183141>

This is useful if you forgot to restrict the diff to the paths you want
to see, or selecting precisely the ones you want is too much typing.

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
---

On Fri, Oct 07, 2011 at 01:09:11PM -0700, Junio C Hamano wrote:

> Looks OK from a cursory viewing. Do we want some additional tests?
> 
> For that matter, have you run the test suite with this patch applied (I
> haven't)?

OK; done.  I got some "broken" but nothing "failed":

    make aggregate-results
    make[3]: Entering directory `/home/sitaram/clones/git/t'
    for f in test-results/t*-*.counts; do \
            echo "$f"; \
    done | '/bin/sh' ./aggregate-results.sh
    fixed   0
    success 7377
    failed  0
    broken  49
    total   7461

Hope that is not a problem.

However, I'm not sure the file names that 'git difftool'
comes up with are in a predictable order.  That would mess
up the test, but I can neither make it fail not find
definitive information on the order in which the changed
files are processed.

 git-difftool--helper.sh |    9 +++++----
 t/t7800-difftool.sh     |   44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 8452890..0468446 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -38,15 +38,16 @@ launch_merge_tool () {
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
+	ans=y
 	if should_prompt
 	then
 		printf "\nViewing: '$MERGED'\n"
 		if use_ext_cmd
 		then
-			printf "Hit return to launch '%s': " \
+			printf "Launch '%s' [Y/n]: " \
 				"$GIT_DIFFTOOL_EXTCMD"
 		else
-			printf "Hit return to launch '%s': " "$merge_tool"
+			printf "Launch '%s' [Y/n]: " "$merge_tool"
 		fi
 		read ans
 	fi
@@ -54,9 +55,9 @@ launch_merge_tool () {
 	if use_ext_cmd
 	then
 		export BASE
-		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
+		test "$ans" != "n" && eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
-		run_merge_tool "$merge_tool"
+		test "$ans" != "n" && run_merge_tool "$merge_tool"
 	fi
 }
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 395adfc..f547e0b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -38,7 +38,18 @@ restore_test_defaults()
 prompt_given()
 {
 	prompt="$1"
-	test "$prompt" = "Hit return to launch 'test-tool': branch"
+	test "$prompt" = "Launch 'test-tool' [Y/n]: branch"
+}
+
+stdin_contains()
+{
+	grep >/dev/null "$1"
+}
+
+stdin_doesnot_contain()
+{
+	grep >/dev/null "$1" && return 1
+	return 0
 }
 
 # Create a file on master and change it on branch
@@ -265,4 +276,35 @@ test_expect_success PERL 'difftool --extcmd cat arg2' '
 	test "$diff" = branch
 '
 
+# Create a second file on master and a different version on branch
+test_expect_success PERL 'setup with 2 files different' '
+	echo m2 >file2 &&
+	git add file2 &&
+	git commit -m "added file2" &&
+
+	git checkout branch &&
+	echo br2 >file2 &&
+	git add file2 &&
+	git commit -a -m "branch changed file2" &&
+	git checkout master
+'
+
+test_expect_success PERL 'say no to the first file' '
+	diff=$((echo n; echo) | git difftool -x cat branch) &&
+
+	echo "$diff" | stdin_contains m2 &&
+	echo "$diff" | stdin_contains br2 &&
+	echo "$diff" | stdin_doesnot_contain master &&
+	echo "$diff" | stdin_doesnot_contain branch
+'
+
+test_expect_success PERL 'say no to the second file' '
+	diff=$((echo; echo n) | git difftool -x cat branch) &&
+
+	echo "$diff" | stdin_contains master &&
+	echo "$diff" | stdin_contains branch &&
+	echo "$diff" | stdin_doesnot_contain m2 &&
+	echo "$diff" | stdin_doesnot_contain br2
+'
+
 test_done
-- 
1.7.6
