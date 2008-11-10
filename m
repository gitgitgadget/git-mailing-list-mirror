From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/4] git send-email: interpret unknown files as revision lists
Date: Tue, 11 Nov 2008 00:54:00 +0100
Message-ID: <1226361242-2516-3-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-2-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgbZ-0003dS-7a
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYKJXyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYKJXyL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:54:11 -0500
Received: from pan.madism.org ([88.191.52.104]:37659 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbYKJXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:54:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 471F63CD89;
	Tue, 11 Nov 2008 00:54:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 027D02A251; Tue, 11 Nov 2008 00:54:02 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4.862.g3e9be
In-Reply-To: <1226361242-2516-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100601>

Filter out all the arguments git-send-email doesn't like to a
git format-patch command, that dumps its content to a safe directory.

Barf when a file/revision conflict occurs, allow it to be overriden
--[no-]format-patch.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-send-email.txt |    8 +++++-
 git-send-email.perl              |   47 +++++++++++++++++++++++++++++++++----
 t/t9001-send-email.sh            |    8 ++++++
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 82f5056..0beaad4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -8,7 +8,7 @@ git-send-email - Send a collection of patches as emails
 
 SYNOPSIS
 --------
-'git send-email' [options] <file|directory> [... file|directory]
+'git send-email' [options] <file|directory|rev-list options>...
 
 
 DESCRIPTION
@@ -183,6 +183,12 @@ Administering
 --[no-]validate::
 	Perform sanity checks on patches.
 	Currently, validation means the following:
+
+--[no-]format-patch::
+	When an argument may be understood either as a reference or as a file name,
+	choose to understand it as a format-patch argument ('--format-patch')
+	or as a file name ('--no-format-patch'). By default, when such a conflict
+	occurs, git send-email will fail.
 +
 --
 		*	Warn of patches that contain lines longer than 998 characters; this
diff --git a/git-send-email.perl b/git-send-email.perl
index aaace02..6f5a613 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -22,8 +22,12 @@ use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
 use Term::ANSIColor;
+use File::Temp qw/ tempdir /;
+use Error qw(:try);
 use Git;
 
+Getopt::Long::Configure qw/ pass_through /;
+
 package FakeTerm;
 sub new {
 	my ($class, $reason) = @_;
@@ -38,7 +42,7 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory>...
+git send-email [options] <file | directory | rev-list options >
 
   Composing:
     --from                  <str>  * Email From:
@@ -73,6 +77,8 @@ git send-email [options] <file | directory>...
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
+    --[no-]format-patch            * understand any non optional arguments as
+                                     `git format-patch` ones.
 
 EOT
 	exit(1);
@@ -146,6 +152,7 @@ if ($@) {
 
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
+my $format_patch;
 my $compose_filename = $repo->repo_path() . "/.gitsendemail.msg.$$";
 
 # Variables with corresponding config settings
@@ -229,6 +236,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
 		    "validate!" => \$validate,
+		    "format-patch!" => \$format_patch,
 	 );
 
 unless ($rc) {
@@ -363,23 +371,52 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 
 ($sender) = expand_aliases($sender) if defined $sender;
 
+# returns 1 if the conflict must be solved using it as a format-patch argument
+sub check_file_rev_conflict($) {
+	my $f = shift;
+	try {
+		$repo->command('rev-parse', '--verify', '--quiet', $f);
+		if (defined($format_patch)) {
+			print "foo\n";
+			return $format_patch;
+		}
+		die(<<EOF);
+File '$f' exists but it could also be the range of commits
+to produce patches for.  Please disambiguate by...
+
+    * Saying "./$f" if you mean a file; or
+    * Giving --format-patch option if you mean a range.
+EOF
+	} catch Git::Error::Command with {
+		return 0;
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
+	} elsif (-d $f and !check_file_rev_conflict($f)) {
 		opendir(DH,$f)
 			or die "Failed to opendir $f: $!";
 
 		push @files, grep { -f $_ } map { +$f . "/" . $_ }
 				sort readdir(DH);
 		closedir(DH);
-	} elsif (-f $f or -p $f) {
+	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
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
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 561ae7d..b4bddd1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -292,4 +292,12 @@ test_expect_success '--compose adds MIME for utf8 subject' '
 	grep "^Subject: =?utf-8?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
 '
 
+test_expect_success 'detects ambiguous reference/file conflict' '
+	echo master > master &&
+	git add master &&
+	git commit -m"add master" &&
+	test_must_fail git send-email --dry-run master > errors &&
+	grep disambiguate errors
+'
+
 test_done
-- 
1.6.0.4.859.g7ecd.dirty
