Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4B36A342
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850089; cv=none; b=ro5ikliyLEClhnEsb5SorUl394zqkRv46Lgz5LgGY0p9FJN00pbpirqSR/zFGpYPTHjcgy8nXjFiIs1H+2c2TvjY3TgWpX3SMkovLdiKkOVnRKTuVR/KBatoZyWnUu+95RWSYvUix5cQtXtLCtbkq1TLpY/whl9vjsbiOoqFGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850089; c=relaxed/simple;
	bh=CjPBIhXsRT7GxDO9/N9iQ4I8+gMKeosGZ0Q9YV1NYNw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm0Bafmktgy4p+VuG2+8jmcOuwRaoesOIvbAzlSwuVntyXVJe/dYcoKe7WCGI7V5BNwEGCgNIVCcrrO61erlvkWDe7A1eRVws3RuuEj/NtrE0N2mAc+1xDAAbrxoU7B301jBDe/TT50ozrCzL3+af1ObvIkzOxTqUrz7mlDIogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hW6xH6Zc0zKvy6;
	Thu, 27 Aug 2026 18:51:47 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
From: Wesley Schwengle <wesleys@opperschaap.net>
To: git@vger.kernel.org
Subject: [PATCH 1/2] git-svn: don't print v1-layout migration noise when there's nothing to migrate
Date: Thu, 27 Aug 2026 12:51:33 -0400
Message-ID: <20260827165134.848207-2-wesleys@opperschaap.net>
In-Reply-To: <20260827165134.848207-1-wesleys@opperschaap.net>
References: <20260827165134.848207-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hW6xH6Zc0zKvy6

`migrate_from_v1()' unconditionally announced and created `.git/svn'
when no legacy `refs/remotes/*' metadata existed to migrate. This
happens for example right after a `git init'.

Defer the logic until an actual candidate is found, matching
the existing pattern of `migrate_from_v0'

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 perl/Git/SVN/Migration.pm  | 16 ++++++++++------
 t/t9107-git-svn-migrate.sh |  7 +++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index ed96ac593e..a6de4b14a8 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -84,35 +84,39 @@ sub migrate_from_v0 {
 
 sub migrate_from_v1 {
 	my $git_dir = $ENV{GIT_DIR};
 	my $migrated = 0;
 	return $migrated unless -d $git_dir;
 	my $svn_dir = Git::SVN::svn_dir();
 
 	# just in case somebody used 'svn' as their $id at some point...
 	return $migrated if -d $svn_dir && ! -f "$svn_dir/info/url";
 
-	print STDERR "Migrating from a git-svn v1 layout...\n";
-	mkpath([$svn_dir]);
-	print STDERR "Data from a previous version of git-svn exists, but\n\t",
-	             "$svn_dir\n\t(required for this version ",
-	             "($::VERSION) of git-svn) does not exist.\n";
 	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
 	while (<$fh>) {
 		my $x = $_;
 		next unless $x =~ s#^refs/remotes/##;
 		chomp $x;
 		my $info_url = command_oneline(qw(rev-parse --git-path),
 						"$x/info/url");
 		next unless -f $info_url;
 		my $u = eval { ::file_to_s($info_url) };
 		next unless $u;
+		unless ($migrated) {
+			print STDERR "Migrating from a git-svn v1 layout...\n";
+			mkpath([$svn_dir]);
+			print STDERR "Data from a previous version of ",
+				     "git-svnexists, but\n\t",
+				     "$svn_dir\n\t(required for this version ",
+				     "($::VERSION) of git-svn) does not ",
+				     "exist.\n";
+		}
 		my $dn = dirname("$svn_dir/$x");
 		mkpath([$dn]) unless -d $dn;
 		if ($x eq 'svn') { # they used 'svn' as GIT_SVN_ID:
 			mkpath(["$svn_dir/svn"]);
 			print STDERR " - $git_dir/$x/info => ",
 			                "$svn_dir/$x/info\n";
 			rename "$git_dir/$x/info", "$svn_dir/$x/info" or
 			       croak "$!: $x";
 			# don't worry too much about these, they probably
 			# don't exist with repos this old (save for index,
@@ -120,21 +124,21 @@ sub migrate_from_v1 {
 			foreach my $f (qw/unhandled.log index .rev_db/) {
 				rename "$git_dir/$x/$f", "$svn_dir/$x/$f";
 			}
 		} else {
 			print STDERR " - $git_dir/$x => $svn_dir/$x\n";
 			rename "$git_dir/$x", "$svn_dir/$x" or croak "$!: $x";
 		}
 		$migrated++;
 	}
 	command_close_pipe($fh, $ctx);
-	print STDERR "Done migrating from a git-svn v1 layout\n";
+	print STDERR "Done migrating from a git-svn v1 layout\n" if $migrated;
 	$migrated;
 }
 
 sub read_old_urls {
 	my ($l_map, $pfx, $path) = @_;
 	my @dir;
 	foreach (<$path/*>) {
 		if (-r "$_/info/url") {
 			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
 			my $ref_id = $pfx . basename $_;
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 6d7d2aa491..a27f7f6171 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -1,15 +1,22 @@
 #!/bin/sh
 # Copyright (c) 2006 Eric Wong
 test_description='git svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
+test_expect_success 'migrate is silent when there is nothing to migrate' '
+	git svn migrate 2>err.log &&
+	test_grep ! "Migrating from a git-svn v1 layout" err.log &&
+	test_grep ! "Data from a previous version of git-svn exists" err.log &&
+	! test -d "$GIT_DIR"/svn
+	'
+
 test_expect_success 'setup old-looking metadata' '
 	cp "$GIT_DIR"/config "$GIT_DIR"/config-old-git-svn &&
 	mkdir import &&
 	(
 		cd import &&
 		for i in trunk branches/a branches/b tags/0.1 tags/0.2 tags/0.3
 		do
 			mkdir -p $i &&
 			echo hello >>$i/README ||
 			exit 1
-- 
2.55.0.827.g48ce2c92dc

