From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 3/3] difftool --dir-diff: symlink all files matching the working tree
Date: Thu, 14 Mar 2013 20:19:41 +0000
Message-ID: <ae17a152cadc650920c6446a4493384cc2e77309.1363291949.git.john@keeping.me.uk>
References: <cover.1363206651.git.john@keeping.me.uk>
 <cover.1363291949.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 21:21:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGEeB-0007Eh-Va
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 21:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3CNUUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 16:20:39 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:49096 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab3CNUUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 16:20:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4B36A161E53A;
	Thu, 14 Mar 2013 20:20:36 +0000 (GMT)
X-Quarantine-ID: <KH8Cro2r2rDN>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KH8Cro2r2rDN; Thu, 14 Mar 2013 20:20:35 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2A796161E4DB;
	Thu, 14 Mar 2013 20:20:24 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.396.g36b63d6
In-Reply-To: <cover.1363291949.git.john@keeping.me.uk>
In-Reply-To: <cover.1363291949.git.john@keeping.me.uk>
References: <cover.1363291949.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218167>

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

Signed-off-by: John Keeping <john@keeping.me.uk>

---
 Documentation/git-difftool.txt |  4 +++-
 git-difftool.perl              | 21 ++++++++++++++++++---
 t/t7800-difftool.sh            | 22 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 4 deletions(-)

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
index e594f9c..663640d 100755
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
index 3aab6e1..70e09b6 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -340,6 +340,28 @@ test_expect_success PERL 'difftool --dir-diff' '
 	stdin_contains file <output
 '
 
+write_script .git/CHECK_SYMLINKS <<\EOF
+for f in file file2 sub/sub
+do
+	echo "$f"
+	readlink "$2/$f"
+done >actual
+EOF
+
+test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+	cat <<EOF >expect &&
+file
+$(pwd)/file
+file2
+$(pwd)/file2
+sub/sub
+$(pwd)/sub/sub
+EOF
+	git difftool --dir-diff --symlink \
+		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
+	test_cmp actual expect
+'
+
 test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
 	git difftool --dir-diff --prompt --extcmd ls branch >output &&
 	stdin_contains sub <output &&
-- 
1.8.2.396.g36b63d6
