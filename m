From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/5] git send-email: interpret unknown files as revision lists
Date: Tue,  4 Nov 2008 17:24:15 +0100
Message-ID: <1225815858-30617-3-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 17:25:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxOiu-0006x8-UT
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 17:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbYKDQY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 11:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbYKDQYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 11:24:25 -0500
Received: from pan.madism.org ([88.191.52.104]:54652 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYKDQYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 11:24:22 -0500
Received: from madism.org (unknown [213.223.38.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4A2C43BFF8;
	Tue,  4 Nov 2008 17:24:21 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 653D842786; Tue,  4 Nov 2008 17:24:18 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.844.gcde3
In-Reply-To: <1225815858-30617-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100090>

Filter out all the arguments git-send-email doesn't like to a
git format-patch command, that dumps its content to a safe directory.

Barf when a file/revision conflict occurs.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-send-email.txt |    2 +-
 git-send-email.perl              |   28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 82f5056..4654d4f 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -8,7 +8,7 @@ git-send-email - Send a collection of patches as emails
 
 SYNOPSIS
 --------
-'git send-email' [options] <file|directory> [... file|directory]
+'git send-email' [options] <file|directory|rev-list options>...
 
 
 DESCRIPTION
diff --git a/git-send-email.perl b/git-send-email.perl
index aaace02..c29868a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -22,8 +22,11 @@ use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
 use Term::ANSIColor;
+use File::Temp qw/ tempdir /;
 use Git;
 
+Getopt::Long::Configure qw/ pass_through /;
+
 package FakeTerm;
 sub new {
 	my ($class, $reason) = @_;
@@ -38,7 +41,7 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory>...
+git send-email [options] <file | directory | rev-list options >
 
   Composing:
     --from                  <str>  * Email From:
@@ -363,10 +366,22 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 
 ($sender) = expand_aliases($sender) if defined $sender;
 
+sub check_file_rev_conflict($) {
+	my $f = shift;
+	if ($repo->command('rev-parse', '--verify', '--quiet', $f)) {
+		die("revision/filename conflict on `$f'");
+	}
+}
+
 # Now that all the defaults are set, process the rest of the command line
 # arguments and collect up the files that need to be processed.
-for my $f (@ARGV) {
-	if (-d $f) {
+my @rev_list_opts;
+while (my $f = pop @ARGV) {
+	if ($f eq "--") {
+		push @rev_list_opts, "--", @ARGV;
+		@ARGV = ();
+	} elsif (-d $f) {
+		check_file_rev_conflict($f);
 		opendir(DH,$f)
 			or die "Failed to opendir $f: $!";
 
@@ -374,12 +389,17 @@ for my $f (@ARGV) {
 				sort readdir(DH);
 		closedir(DH);
 	} elsif (-f $f or -p $f) {
+		check_file_rev_conflict($f);
 		push @files, $f;
 	} else {
-		print STDERR "Skipping $f - not found.\n";
+		push @rev_list_opts, $f;
 	}
 }
 
+if (@rev_list_opts) {
+	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
+}
+
 if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
-- 
1.5.6.5
