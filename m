From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Add a script to run test scripts using valgrind.
Date: Tue, 25 Dec 2007 21:29:14 +0100
Message-ID: <20071225212914.c4bb3f87.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 25 21:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7GJN-00044q-TI
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 21:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXLYUXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 15:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbXLYUXE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 15:23:04 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:55016 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbXLYUXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 15:23:03 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id AC3F41AB2C3;
	Tue, 25 Dec 2007 21:22:59 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 6BCDD1AB2CC;
	Tue, 25 Dec 2007 21:22:59 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69236>

This patch adds a Perl script 'run_valgrind.pl' that runs
the test scripts passed as arguments using valgrind.

To use valgrind, we use a shell alias like:

alias git='valgrind <options> git'

and we source a test script in the same system call.

The valgrind logs are then parsed for errors and the errors
found are hashed so that they appear only once at the end.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/run_valgrind.pl |  138 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 138 insertions(+), 0 deletions(-)
 create mode 100755 t/run_valgrind.pl

diff --git a/t/run_valgrind.pl b/t/run_valgrind.pl
new file mode 100755
index 0000000..cb965c9
--- /dev/null
+++ b/t/run_valgrind.pl
@@ -0,0 +1,138 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+# All arguments should be test scripts.
+my @scripts = @ARGV;
+
+my $vg_vers = valgrind_version();
+
+print "Using valgrind version: $vg_vers\n";
+
+my $log_base = '/tmp/vg_log';
+my $log_opt = ($vg_vers < '3.3') ? $log_base : "$log_base.%p";
+my $vg_opts = "--log-file=$log_opt --trace-children=yes";
+my $alias = "alias git='valgrind $vg_opts git'";
+
+# Remove previous log files.
+system("rm -rf $log_base.*");
+
+# Run the scripts using an alias for Git.
+foreach my $file (@scripts) {
+	system("$alias \n . ./$file");
+}
+
+# Error lines from log files.
+my @log_files = glob("$log_base.*");
+my @errs = `grep 'ERROR SUMMARY' $log_base.*`;
+chomp @errs;
+
+print "\nNumber of log files: " . scalar(@log_files) . "\n";
+print "Number of error lines: " . scalar(@errs) . "\n";
+
+my @logs;
+for (@errs) {
+	if (m/^([^:]+):.*ERROR SUMMARY: (\d+) errors/) {
+		push @logs, $1 if ($2 > 0);
+	} else {
+		print STDERR "strange line: $_\n";
+	}
+}
+
+print "\nResulting files with errors:\n\n", join("\n", @logs), "\n\n";
+
+# Parse error files.
+my @info = ();
+for (@logs) {
+	my @new = parse_error_file($_);
+	push @info, @new;
+}
+
+# Get only uniq errors.
+my @uniq = ();
+my %stack = ();
+for (@info) {
+	my $key = stack_info($_, 1);
+	if (exists $stack{$key}) {
+		push @{$stack{$key}}, $_->{file};
+	} else {
+		$stack{$key} = [ $_->{file} ];
+		$_->{file} = $stack{$key};
+		push @uniq, $_;
+	}
+}
+
+# Print uniq errors.
+print "Uniq errors:\n";
+for (@uniq) {
+	print "\n" . stack_info($_);
+	print "Files: " . join(", ", @{$_->{file}}) . "\n";
+}
+
+sub valgrind_version {
+	system("which valgrind > /dev/null 2>&1") == 0
+	  or die "'which valgrind' failed.";
+
+	my $version = `valgrind --version`;
+	chomp $version;
+
+	if ($version =~ m/(\d+)\.(\d+)\.(\d+)/) {
+		return "$1.$2";
+	} else {
+		die "Could not find valgrind version.";
+	}
+}
+
+sub stack_info {
+	$_ = shift;
+	my ($key) = @_;
+
+	my $msg = $_->{msg};
+	$msg =~ s/0x[0-9A-F]+// if ($key);
+
+	my @places = map { $_->[1] } @{$_->{stack}};
+	return "$msg\n" . join("\n", @places) . "\n";
+}
+
+sub clean_line {
+	my ($line) = @_;
+
+	$line =~ s/^==\d+==\s+//;
+
+	return $line;
+}
+
+sub parse_error_file {
+	my ($file) = @_;
+
+	# Slurp file.
+	open(IN, "< $file") or die "Could not open '$file' for reading: $!";
+	my @content = <IN>;
+	chomp @content;
+	close IN;
+
+	# Parse errors in file.
+	my @errs = ();
+	my $stack = 0;
+	my $prev = '';
+	my $cur;
+	for (@content) {
+		if (not $stack and m/    at 0x([0-9A-F]+): (.*)$/) {
+			$stack = 1;
+			$cur = { msg => $prev,
+				 file => $file,
+				 stack => [ [$1, $2] ] };
+		} elsif ($stack) {
+			if (m/    by 0x([0-9A-F]+): (.*)$/) {
+				push @{$cur->{stack}}, [$1, $2];
+			} else {
+				push @errs, $cur;
+				$stack = 0;
+			}
+		}
+		$prev = clean_line($_);
+	}
+
+	return @errs;
+}
-- 
1.5.3.7.2270.g786cf-dirty
