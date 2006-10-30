X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Mon, 30 Oct 2006 22:29:06 +0100
Message-ID: <200610302229.06957.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 21:30:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SykLirjGDpA6xTgKDdIV2566HwNEXLofbJFhiKGDcmj9wVyL1X03wTJ+uwAEcUFVJ0IOqdtH7SczZ2eXXLMciYOE3iRpb6zZQ7ltcL7nt9dmcim0NnBhhTbdh5yfQ2/g1oqRcVhhaQRBv6vflVWq1zfxJ15Jxt3EX8gRjIuOqo4=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30525>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geegx-0002jw-Vy for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161509AbWJ3V3G (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161508AbWJ3V3G
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:29:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37969 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161511AbWJ3V3C
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:29:02 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1267589ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 13:29:00 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr4922284ugm; Mon, 30 Oct 2006
 13:29:00 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id x26sm3372913ugc.2006.10.30.13.28.59; Mon, 30 Oct
 2006 13:29:00 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add "--" after <commit-ish> or <tree-ish> argument to clearly mark it
as <commit-ish> or <tree-ish> and not pathspec, securing against refs
with the same names as files or directories in [live] repository.

Some wrapping to reduce line length as well.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I uses branch named 'gitweb/test' to test gitweb against files with
funny characters (like '"', '\', TAB, LF) in filenames. I run gitweb
on "live" (not bare) repository, and there is directory 'gitweb/test'
in it. So I had some parts of gitweb not functioning, and errors in
the web server logs. This patch fixes that issue.

 gitweb/gitweb.perl |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0fd1360..4554067 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1141,7 +1141,9 @@ sub parse_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		local $/ = "\0";
-		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", "--max-count=1", $commit_id
+		open my $fd, "-|", git_cmd(), "rev-list",
+			"--header", "--parents", "--max-count=1",
+			$commit_id, "--"
 			or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
@@ -2559,7 +2561,7 @@ sub git_summary {
 	}
 
 	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
-		git_get_head_hash($project)
+		git_get_head_hash($project), "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2970,7 +2972,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash, "--"
 		or die_error(undef, "Open git-ls-tree failed");
 	my @entries = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading tree failed");
@@ -3102,7 +3104,7 @@ sub git_log {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
+	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash, "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -3160,7 +3162,7 @@ sub git_commit {
 		$parent = "--root";
 	}
 	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
-		@diff_opts, $parent, $hash
+		@diff_opts, $parent, $hash, "--"
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -3265,7 +3267,8 @@ sub git_blobdiff {
 	if (defined $hash_base && defined $hash_parent_base) {
 		if (defined $file_name) {
 			# read raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base,
+			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+				$hash_parent_base, $hash_base,
 				"--", $file_name
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
@@ -3279,7 +3282,8 @@ sub git_blobdiff {
 			# try to find filename from $hash
 
 			# read filtered raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base
+			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+				$hash_parent_base, $hash_base, "--"
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
@@ -3349,7 +3353,8 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts, $hash_parent, $hash
+		open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts,
+			$hash_parent, $hash, "--"
 			or die_error(undef, "Open git-diff failed");
 	} else  {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
@@ -3480,8 +3485,8 @@ sub git_commitdiff {
 	my @difftree;
 	if ($format eq 'html') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			"--no-commit-id",
-			"--patch-with-raw", "--full-index", $hash_parent, $hash
+			"--no-commit-id", "--patch-with-raw", "--full-index",
+			$hash_parent, $hash, "--"
 			or die_error(undef, "Open git-diff-tree failed");
 
 		while (chomp(my $line = <$fd>)) {
@@ -3492,7 +3497,7 @@ sub git_commitdiff {
 
 	} elsif ($format eq 'plain') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', $hash_parent, $hash
+			'-p', $hash_parent, $hash, "--"
 			or die_error(undef, "Open git-diff-tree failed");
 
 	} else {
@@ -3669,7 +3674,9 @@ sub git_search {
 	my $alternate = 1;
 	if ($searchtype eq 'commit' or $searchtype eq 'author' or $searchtype eq 'committer') {
 		$/ = "\0";
-		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", $hash or next;
+		open my $fd, "-|", git_cmd(), "rev-list",
+			"--header", "--parents", $hash, "--"
+			or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -3815,7 +3822,7 @@ sub git_shortlog {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
+	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash, "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -3843,7 +3850,8 @@ sub git_shortlog {
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150", git_get_head_hash($project)
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150",
+		git_get_head_hash($project), "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
@@ -3867,7 +3875,7 @@ XML
 		}
 		my %cd = parse_date($co{'committer_epoch'});
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			$co{'parent'}, $co{'id'}
+			$co{'parent'}, $co{'id'}, "--"
 			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd
-- 
1.4.3.3
