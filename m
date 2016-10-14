Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E905209A9
	for <e@80x24.org>; Fri, 14 Oct 2016 01:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbcJNByP (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 21:54:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52278 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbcJNByN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 21:54:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8D9212169F;
        Fri, 14 Oct 2016 01:46:27 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Mathieu Arnold <mat@FreeBSD.org>
Cc:     =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH 1/2] git-svn: reduce scope of input record separator change
Date:   Fri, 14 Oct 2016 01:46:22 +0000
Message-Id: <20161014014623.15223-2-e@80x24.org>
In-Reply-To: <20161014014623.15223-1-e@80x24.org>
References: <20161014014623.15223-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reducing the scope of where we change the record separator ($/)
avoids bugs in calls which rely on the input record separator
further down, such as the 'chomp' usage in command_oneline.

This is necessary for a future change to git-svn, but exists in
Git.pm since it seems useful for gitweb and our other Perl
scripts, too.

Signed-off-by: Eric Wong <e@80x24.org>
---
 git-svn.perl            |  4 ++--
 perl/Git.pm             | 16 +++++++++++++++-
 perl/Git/SVN/Editor.pm  | 12 +++++-------
 perl/Git/SVN/Fetcher.pm | 15 +++++----------
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4d41d22..6d1a142 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -44,6 +44,7 @@ use Git qw(
 	command_close_pipe
 	command_bidi_pipe
 	command_close_bidi_pipe
+	get_record
 );
 
 BEGIN {
@@ -1880,10 +1881,9 @@ sub get_commit_entry {
 	{
 		require Encode;
 		# SVN requires messages to be UTF-8 when entering the repo
-		local $/;
 		open $log_fh, '<', $commit_msg or croak $!;
 		binmode $log_fh;
-		chomp($log_entry{log} = <$log_fh>);
+		chomp($log_entry{log} = get_record($log_fh, undef));
 
 		my $enc = Git::config('i18n.commitencoding') || 'UTF-8';
 		my $msg = $log_entry{log};
diff --git a/perl/Git.pm b/perl/Git.pm
index ce7e4e8..d2c5a8d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -59,7 +59,7 @@ require Exporter;
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
                 remote_refs prompt
-                get_tz_offset
+                get_tz_offset get_record
                 credential credential_read credential_write
                 temp_acquire temp_is_locked temp_release temp_reset temp_path);
 
@@ -538,6 +538,20 @@ sub get_tz_offset {
 	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
 }
 
+=item get_record ( FILEHANDLE, INPUT_RECORD_SEPARATOR )
+
+Read one record from FILEHANDLE delimited by INPUT_RECORD_SEPARATOR,
+removing any trailing INPUT_RECORD_SEPARATOR.
+
+=cut
+
+sub get_record {
+	my ($fh, $rs) = @_;
+	local $/ = $rs;
+	my $rec = <$fh>;
+	chomp $rec if defined $rs;
+	$rec;
+}
 
 =item prompt ( PROMPT , ISPASSWORD  )
 
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 4c4199a..0df16ed 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -7,7 +7,9 @@ use SVN::Delta;
 use Carp qw/croak/;
 use Git qw/command command_oneline command_noisy command_output_pipe
            command_input_pipe command_close_pipe
-           command_bidi_pipe command_close_bidi_pipe/;
+           command_bidi_pipe command_close_bidi_pipe
+           get_record/;
+
 BEGIN {
 	@ISA = qw(SVN::Delta::Editor);
 }
@@ -57,11 +59,9 @@ sub generate_diff {
 	push @diff_tree, "-l$_rename_limit" if defined $_rename_limit;
 	push @diff_tree, $tree_a, $tree_b;
 	my ($diff_fh, $ctx) = command_output_pipe(@diff_tree);
-	local $/ = "\0";
 	my $state = 'meta';
 	my @mods;
-	while (<$diff_fh>) {
-		chomp $_; # this gets rid of the trailing "\0"
+	while (defined($_ = get_record($diff_fh, "\0"))) {
 		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
 					($::sha1)\s($::sha1)\s
 					([MTCRAD])\d*$/xo) {
@@ -173,9 +173,7 @@ sub rmdirs {
 
 	my ($fh, $ctx) = command_output_pipe(qw/ls-tree --name-only -r -z/,
 	                                     $self->{tree_b});
-	local $/ = "\0";
-	while (<$fh>) {
-		chomp;
+	while (defined($_ = get_record($fh, "\0"))) {
 		my @dn = split m#/#, $_;
 		while (pop @dn) {
 			delete $rm->{join '/', @dn};
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index d8c21ad..64e900a 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -9,7 +9,8 @@ use Carp qw/croak/;
 use File::Basename qw/dirname/;
 use Git qw/command command_oneline command_noisy command_output_pipe
            command_input_pipe command_close_pipe
-           command_bidi_pipe command_close_bidi_pipe/;
+           command_bidi_pipe command_close_bidi_pipe
+           get_record/;
 BEGIN {
 	@ISA = qw(SVN::Delta::Editor);
 }
@@ -86,11 +87,9 @@ sub _mark_empty_symlinks {
 	my $printed_warning;
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
-	local $/ = "\0";
 	my $pfx = defined($switch_path) ? $switch_path : $git_svn->path;
 	$pfx .= '/' if length($pfx);
-	while (<$ls>) {
-		chomp;
+	while (defined($_ = get_record($ls, "\0"))) {
 		s/\A100644 blob $empty_blob\t//o or next;
 		unless ($printed_warning) {
 			print STDERR "Scanning for empty symlinks, ",
@@ -179,9 +178,7 @@ sub delete_entry {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
 		                                     -r --name-only -z/,
 				                     $tree);
-		local $/ = "\0";
-		while (<$ls>) {
-			chomp;
+		while (defined($_ = get_record($ls, "\0"))) {
 			my $rmpath = "$gpath/$_";
 			$self->{gii}->remove($rmpath);
 			print "\tD\t$rmpath\n" unless $::_q;
@@ -247,9 +244,7 @@ sub add_directory {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
 		                                     -r --name-only -z/,
 				                     $self->{c});
-		local $/ = "\0";
-		while (<$ls>) {
-			chomp;
+		while (defined($_ = get_record($ls, "\0"))) {
 			$self->{gii}->remove($_);
 			print "\tD\t$_\n" unless $::_q;
 			push @deleted_gpath, $gpath;
-- 
EW

