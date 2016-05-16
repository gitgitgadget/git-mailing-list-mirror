From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] difftool: handle unmerged files in dir-diff mode
Date: Mon, 16 May 2016 11:05:37 -0700
Message-ID: <20160516180537.22212-2-davvid@gmail.com>
References: <20160516180537.22212-1-davvid@gmail.com>
Cc: Jan Smets <jan@smets.cx>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 20:05:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Mtm-0005O2-6L
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbcEPSFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:05:42 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33255 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbcEPSFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:05:41 -0400
Received: by mail-pa0-f66.google.com with SMTP id gh9so15109261pac.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0jm5zrkuGEV5BlkOsmSdMEnNK3HMTI9aXluSlLLjPUc=;
        b=QigRRxgGJnp6emGS4awtTZO4unn1prrg/wGS/ZouZsGfBeYnmu9YjH7PwrG27OBzk+
         3KptPzvkmTaplSvZqzbzjiSvnWGitU7q9THZqhlzZ7iY3ejzQRw8McaEF+Ax81qNw2eU
         6Qnw1x661M8ZGK7zuX6JBs+w/nkPV6aCDkDgxNhKWeq2J7hZYiScJ9NHIzrLduXNXx+v
         RZRGMcsP8XIeNbIvcDyVQmADn8yOkXaKWsG8Zmd3MdTs8OCxSxg56vpu0KdWNq0fWyJ0
         Skk7sCV6GkdpJ78jApxo3JPHfKpdRxjZyhijAin5Wb+QEAkm1+sL2AvPVxA+e85L81Te
         VBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0jm5zrkuGEV5BlkOsmSdMEnNK3HMTI9aXluSlLLjPUc=;
        b=Go+mTwqZcOgXUMLJj7B198WQB6HFxEKR5XKQgG/rQJnRlfMF9E4NPhJTNWJM+w4lLN
         iDjv/OoWAkmr/BrRfEWgEmv1PjZeVuwsvLdm9VnTDRAJ7OlmzgP0uZiK6eZ8TEtai9ka
         iaToJMPcrf/ErNcrJU4XEmaPjfOdrWBHe7qiqm/Qh9AssEmLv2YIvp1WeeWOV54vdi22
         vXJXR5S95zQLoISNs0CC98UTrP0yoJefotckA9tgk5ocbVfqArrJXmkYWH2OXtPjpAMU
         241SPkDdChvggdUZmzkGxXLq9Y+0WQhZ9B6SG+0aUOiXWI5YJSh18UWU1bVbBqHEwny5
         QWEA==
X-Gm-Message-State: AOPr4FVHiFsIkTZfe6k34Zeez+Cj3/7NtndmLRGk/1VTyVv1J3hqT6FEQelWEJpSVaQQPA==
X-Received: by 10.66.241.73 with SMTP id wg9mr47062507pac.91.1463421941032;
        Mon, 16 May 2016 11:05:41 -0700 (PDT)
Received: from raptor.fas.fa.disney.com. (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id yl5sm48873119pac.38.2016.05.16.11.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:39 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.404.gdfc6a507
In-Reply-To: <20160516180537.22212-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294767>

When files are unmerged they can show up as both unmerged and
modified in the output of `git diff --raw`.  This causes
difftool's dir-diff to create filesystem entries for the same
path twice, which fails when it encounters a duplicate path.

Ensure that each worktree path is only processed once.
Add a test to demonstrate the breakage.

Reported-by: Jan Smets <jan@smets.cx>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl   |  5 +++++
 t/t7800-difftool.sh | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/git-difftool.perl b/git-difftool.perl
index 8cf0040..ebd13ba 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -138,6 +138,7 @@ sub setup_dir_diff
 	my %submodule;
 	my %symlink;
 	my @working_tree = ();
+	my %working_tree_dups = ();
 	my @rawdiff = split('\0', $diffrtn);
 
 	my $i = 0;
@@ -188,6 +189,10 @@ EOF
 		}
 
 		if ($rmode ne $null_mode) {
+			# Avoid duplicate working_tree entries
+			if ($working_tree_dups{$dst_path}++) {
+				next;
+			}
 			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
 							  $dst_path, $rsha1);
 			if ($use) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ff7a9e9..7ce4cd7 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -419,6 +419,29 @@ run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
 	grep file2 output
 '
 
+run_dir_diff_test 'difftool --dir-diff with unmerged files' '
+	test_when_finished git reset --hard &&
+	test_config difftool.echo.cmd "echo ok" &&
+	git checkout -B conflict-a &&
+	git checkout -B conflict-b &&
+	git checkout conflict-a &&
+	echo a >>file &&
+	git add file &&
+	git commit -m conflict-a &&
+	git checkout conflict-b &&
+	echo b >>file &&
+	git add file &&
+	git commit -m conflict-b &&
+	git checkout master &&
+	git merge conflict-a &&
+	test_must_fail git merge conflict-b &&
+	cat >expect <<-EOF &&
+		ok
+	EOF
+	git difftool --dir-diff $symlinks -t echo >actual &&
+	test_cmp expect actual
+'
+
 write_script .git/CHECK_SYMLINKS <<\EOF
 for f in file file2 sub/sub
 do
-- 
2.8.2.404.gdfc6a507
