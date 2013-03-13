From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] difftool --dir-diff: symlink all files matching the working tree
Date: Wed, 13 Mar 2013 20:33:09 +0000
Message-ID: <796eafb6816b302c87873c8f4a1bd2225ce40c55.1363206651.git.john@keeping.me.uk>
References: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
 <cover.1363206651.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 21:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFsNo-0005gH-MG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 21:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389Ab3CMUeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 16:34:15 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:59688 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178Ab3CMUeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 16:34:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C585722FB8;
	Wed, 13 Mar 2013 20:34:13 +0000 (GMT)
X-Quarantine-ID: <vj7uPNXNhX4c>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vj7uPNXNhX4c; Wed, 13 Mar 2013 20:34:09 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 45B8A22FC4;
	Wed, 13 Mar 2013 20:33:58 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
In-Reply-To: <cover.1363206651.git.john@keeping.me.uk>
In-Reply-To: <cover.1363206651.git.john@keeping.me.uk>
References: <cover.1363206651.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218091>

Some users like to edit files in their diff tool when using "git
difftool --dir-diff --symlink" to compare against the working tree but
difftool currently only created symlinks when a file contains unstaged
changes.

Change this behaviour so that symlinks are created whenever the
right-hand side of the comparison has the same SHA1 as the file in the
working tree.

Note that textconv filters are handled in the same way as by git-diff
and if a clean filter is not the inverse of its smudge filter we already
get a null SHA1 from "diff --raw" and will symlink the file without
going through the new hash-object based check.

Reported-by: Matt McClure <matthewlmcclure@gmail.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-difftool.txt |  4 +++-
 git-difftool.perl              | 21 ++++++++++++++++++---
 t/t7800-difftool.sh            | 14 ++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index e575fea..8361e6e 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -72,7 +72,9 @@ with custom merge tool commands and has the same value as `$MERGED`.
 --symlinks::
 --no-symlinks::
 	'git difftool''s default behavior is create symlinks to the
-	working tree when run in `--dir-diff` mode.
+	working tree when run in `--dir-diff` mode and the right-hand
+	side of the comparison yields the same content as the file in
+	the working tree.
 +
 Specifying `--no-symlinks` instructs 'git difftool' to create copies
 instead.  `--no-symlinks` is the default on Windows.
diff --git a/git-difftool.perl b/git-difftool.perl
index 0a90de4..5f093ae 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -83,6 +83,21 @@ sub exit_cleanup
 	exit($status | ($status >> 8));
 }
 
+sub use_wt_file
+{
+	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
+	my $null_sha1 = '0' x 40;
+
+	if ($sha1 eq $null_sha1) {
+		return 1;
+	} elsif (not $symlinks) {
+		return 0;
+	}
+
+	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
+	return $sha1 eq $wt_sha1;
+}
+
 sub setup_dir_diff
 {
 	my ($repo, $workdir, $symlinks) = @_;
@@ -159,10 +174,10 @@ EOF
 		}
 
 		if ($rmode ne $null_mode) {
-			if ($rsha1 ne $null_sha1) {
-				$rindex .= "$rmode $rsha1\t$dst_path\0";
-			} else {
+			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
 				push(@working_tree, $dst_path);
+			} else {
+				$rindex .= "$rmode $rsha1\t$dst_path\0";
 			}
 		}
 	}
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index eb1d3f8..8102ce1 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -370,6 +370,20 @@ test_expect_success PERL 'difftool --dir-diff' '
 	echo "$diff" | stdin_contains file
 '
 
+write_script .git/CHECK_SYMLINKS <<\EOF &&
+#!/bin/sh
+test -L "$2/file" &&
+test -L "$2/file2" &&
+test -L "$2/sub/sub"
+echo $?
+EOF
+
+test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+	result=$(git difftool --dir-diff --symlink \
+		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD) &&
+	test "$result" = 0
+'
+
 test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
 	diff=$(git difftool --dir-diff --prompt --extcmd ls branch) &&
 	echo "$diff" | stdin_contains sub &&
-- 
1.8.2.rc2.4.g7799588
