From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri,  6 Mar 2009 17:15:15 -0500
Message-ID: <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	jean-luc malet <jeanluc.malet@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 23:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfiM0-0006wF-T3
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbZCFWPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbZCFWPi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:15:38 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:2047 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZCFWPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:15:37 -0500
Received: by qw-out-2122.google.com with SMTP id 5so793684qwi.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8Ly9piKMdoNocodgDOTV7ycqRgaukn6USCdYQb9dkU0=;
        b=N++x8/PAWdQvgsBr/6gNmz9PVmxiEsUbmtcv27cmKyBfoZqLxhR8n5xe2AhjipgCd6
         MqT12dcjFiseSCHlcC223GjjdDPeaOggflYOF2AV/E7J/xWPDXFaqBNkACIdmaoIaQ9m
         MDASpLTWFv9boZJOs/PiRRoxiIex/f2dqkp2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=At0pbJYmO17fmCYNE8M8aycf8SjAl2HykdtbJAjh/cjie0bTPoCwC30qR11CHoCNkG
         032CdkMoG16DcWV3rz/N/gGt09bDd8S0D8UWJURCZAOUxuywnC2FYlnYl+oPFPAE334S
         yPdY9Uh5nkjTi74eP2SqFAsoczPGvNas3ZQMY=
Received: by 10.224.54.141 with SMTP id q13mr4547361qag.216.1236377735429;
        Fri, 06 Mar 2009 14:15:35 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm1350881qwh.29.2009.03.06.14.15.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 14:15:34 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1236377358.git.jaysoffian@gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112484>

This patch teaches merge a new setting, merge.options, which is
processed before any of the other merge configuration settings. It may
be used to establish a default which can then be overridden by more
specific branch.<name>.mergeoptions (or, obviously, command-line
switches).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-merge.txt |   11 +++++--
 builtin-merge.c             |   10 ++++++
 t/t7600-merge.sh            |   69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index f7be584..3cb06e7 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -47,10 +47,15 @@ CONFIGURATION
 -------------
 include::merge-config.txt[]
 
+merge.options::
+	Sets default options for merging. The syntax and supported options are
+	equal to that of 'git-merge'. Arguments are split by spaces, and may be
+	quoted in the same way as alias.* config options.
+
 branch.<name>.mergeoptions::
-	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to that of 'git-merge', but option values
-	containing whitespace characters are currently not supported.
+	Sets default options for merging into branch <name>. This setting is
+	handled after `merge.options`, so it may be used to override any
+	settings appearing there. The syntax is identical to `merge.options`.
 
 HOW MERGE WORKS
 ---------------
diff --git a/builtin-merge.c b/builtin-merge.c
index 504f2be..1f124b3 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -447,6 +447,15 @@ cleanup:
 	strbuf_release(&bname);
 }
 
+static int git_merge_config_default(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "merge.options")) {
+		if (git_config_option_string(builtin_merge_options, 0, k, v))
+			die("Bad merge.options string");
+	}
+	return 0;
+}
+
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	if (branch && !prefixcmp(k, "branch.") &&
@@ -838,6 +847,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (is_null_sha1(head))
 		head_invalid = 1;
 
+	git_config(git_merge_config_default, NULL);
 	git_config(git_merge_config, NULL);
 
 	/* for color.ui */
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9db8bb4..aaecdab 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -367,6 +367,16 @@ test_expect_success 'merge c1 with c2 (no-commit in config)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (no-commit in merge.options)' '
+	git reset --hard c1 &&
+	with_config merge.options --no-commit -- merge c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_mergeheads $c2
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
 	with_config branch.master.mergeoptions --squash -- \
@@ -379,6 +389,17 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (squash in merge.options)' '
+	git reset --hard c1 &&
+	with_config merge.options --squash -- merge c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_no_mergehead &&
+	verify_diff squash.1-5 .git/SQUASH_MSG "[OOPS] bad squash message"
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -425,6 +446,54 @@ test_expect_success 'override config option --stat' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'override merge.options -n with branch mergeoptions --summary' '
+	git reset --hard c1 &&
+	test_tick &&
+	with_config merge.options -n branch.master.mergeoptions --summary -- \
+		merge c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if ! grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated with --summary"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override merge.options -n with branch mergeoptions --stat' '
+	git reset --hard c1 &&
+	test_tick &&
+	with_config merge.options -n branch.master.mergeoptions --stat -- \
+		merge c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if ! grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated with --stat"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override merge.options --stat' '
+	git reset --hard c1 &&
+	test_tick &&
+	with_config merge.options --stat branch.master.mergeoptions -n -- \
+		merge c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was generated"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	git reset --hard c1 &&
 	test_tick &&
-- 
1.6.2.rc2.332.g5d21b
