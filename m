From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sun, 24 Mar 2013 15:15:57 +0000
Message-ID: <20130324151557.GB2286@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 16:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJmf2-00005B-ND
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 16:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab3CXPQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 11:16:13 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:50447 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab3CXPQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 11:16:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id F3CCC21445;
	Sun, 24 Mar 2013 15:16:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CY4oAf-5Ahao; Sun, 24 Mar 2013 15:16:10 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id BAF2C2149C;
	Sun, 24 Mar 2013 15:15:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218960>

On Sun, Mar 24, 2013 at 09:31:45AM -0400, Matt McClure wrote:
> On Sun, Mar 24, 2013 at 8:36 AM, John Keeping <john@keeping.me.uk> wrote:
> > In the
> > non-symlink case I think a user might find it surprising if the
> > (unmodified) file used by their diff tool were suddenly copied over the
> > working tree wiping out the changes they have just made.
> 
> That's exactly what I was describing here:
> http://thread.gmane.org/gmane.comp.version-control.git/217979/focus=218006

Ahh, I guess I didn't fully register the impact of that at the time and
had to rediscover the problem for myself ;-)

How about doing this (on top of jk/difftool-dir-diff-edit-fix)?

-- >8 --
Subject: [PATCH] difftool: don't overwrite modified files

After running the user's diff tool, git-difftool will copy any files
that differ between the working tree and the temporary tree.  This is
useful when the user edits the file in their diff tool but is wrong if
they edit the working tree file while examining the diff.

Instead of copying unconditionally when the files differ, store the
initial hash of the working tree file and only copy the temporary file
back if it was modified and the working tree file was not.  If both
files have been modified, print a warning and exit with an error.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-difftool.perl   | 35 +++++++++++++++++++++--------------
 t/t7800-difftool.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index c433e86..be82b5a 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -15,7 +15,6 @@ use strict;
 use warnings;
 use File::Basename qw(dirname);
 use File::Copy;
-use File::Compare;
 use File::Find;
 use File::stat;
 use File::Path qw(mkpath rmtree);
@@ -123,7 +122,7 @@ sub setup_dir_diff
 	my $rindex = '';
 	my %submodule;
 	my %symlink;
-	my @working_tree = ();
+	my %working_tree;
 	my @rawdiff = split('\0', $diffrtn);
 
 	my $i = 0;
@@ -175,7 +174,9 @@ EOF
 
 		if ($rmode ne $null_mode) {
 			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
-				push(@working_tree, $dst_path);
+				$working_tree{$dst_path} =
+					$repo->command_oneline('hash-object',
+						"$workdir/$dst_path");
 			} else {
 				$rindex .= "$rmode $rsha1\t$dst_path\0";
 			}
@@ -227,7 +228,7 @@ EOF
 	# not part of the index. Remove any trailing slash from $workdir
 	# before starting to avoid double slashes in symlink targets.
 	$workdir =~ s|/$||;
-	for my $file (@working_tree) {
+	for my $file (keys %working_tree) {
 		my $dir = dirname($file);
 		unless (-d "$rdir/$dir") {
 			mkpath("$rdir/$dir") or
@@ -278,7 +279,7 @@ EOF
 		exit_cleanup($tmpdir, 1) if not $ok;
 	}
 
-	return ($ldir, $rdir, $tmpdir, @working_tree);
+	return ($ldir, $rdir, $tmpdir, %working_tree);
 }
 
 sub write_to_file
@@ -376,7 +377,7 @@ sub dir_diff
 	my $error = 0;
 	my $repo = Git->repository();
 	my $workdir = find_worktree($repo);
-	my ($a, $b, $tmpdir, @worktree) =
+	my ($a, $b, $tmpdir, %worktree) =
 		setup_dir_diff($repo, $workdir, $symlinks);
 
 	if (defined($extcmd)) {
@@ -390,19 +391,25 @@ sub dir_diff
 	# should be copied back to the working tree.
 	# Do not copy back files when symlinks are used and the
 	# external tool did not replace the original link with a file.
-	for my $file (@worktree) {
+	for my $file (keys %worktree) {
 		next if $symlinks && -l "$b/$file";
 		next if ! -f "$b/$file";
 
-		my $diff = compare("$b/$file", "$workdir/$file");
-		if ($diff == 0) {
-			next;
-		} elsif ($diff == -1) {
-			my $errmsg = "warning: Could not compare ";
-			$errmsg += "'$b/$file' with '$workdir/$file'\n";
+		my $wt_hash = $repo->command_oneline('hash-object',
+			"$workdir/$file");
+		my $tmp_hash = $repo->command_oneline('hash-object',
+			"$b/$file");
+		my $wt_modified = $wt_hash ne $worktree{$file};
+		my $tmp_modified = $tmp_hash ne $worktree{$file};
+
+		if ($wt_modified and $tmp_modified) {
+			my $errmsg = "warning: Both files modified: ";
+			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
+			$errmsg .= "warning: Working tree file has been left.\n";
+			$errmsg .= "warning:\n";
 			warn $errmsg;
 			$error = 1;
-		} elsif ($diff == 1) {
+		} elsif ($tmp_modified) {
 			my $mode = stat("$b/$file")->mode;
 			copy("$b/$file", "$workdir/$file") or
 			exit_cleanup($tmpdir, 1);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index db3d3d6..be2042d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -407,4 +407,30 @@ test_expect_success PERL 'difftool --dir-diff from subdirectory' '
 	)
 '
 
+write_script modify-file <<\EOF
+echo "new content" >file
+EOF
+
+test_expect_success PERL 'difftool --no-symlinks does not overwrite working tree file ' '
+	echo "orig content" >file &&
+	git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-file" branch &&
+	echo "new content" >expect &&
+	test_cmp expect file
+'
+
+write_script modify-both-files <<\EOF
+echo "wt content" >file &&
+echo "tmp content" >"$2/file" &&
+echo "$2" >tmpdir
+EOF
+
+test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
+	echo "orig content" >file &&
+	test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-both-files" branch &&
+	echo "wt content" >expect &&
+	test_cmp expect file &&
+	echo "tmp content" >expect &&
+	test_cmp expect "$(cat tmpdir)/file"
+'
+
 test_done
-- 
1.8.2.411.g65a544e
