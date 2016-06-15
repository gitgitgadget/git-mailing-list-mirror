From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 04:17:25 -0400
Message-ID: <11227978451100@foobar.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ryan@michonline.com
X-From: git-owner@vger.kernel.org Sun Jul 31 10:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz91r-00013d-GU
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 10:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbVGaISW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 04:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGaIRb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 04:17:31 -0400
Received: from mail.autoweb.net ([198.172.237.26]:3817 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261840AbVGaIR1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 04:17:27 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dz90g-0005mG-9C; Sun, 31 Jul 2005 04:17:26 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dz9AL-0004my-00; Sun, 31 Jul 2005 04:27:25 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1Dz90f-0006XV-Dv; Sun, 31 Jul 2005 04:17:25 -0400
In-Reply-To: 
X-Mailer: git-send-email-script
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is based off of GregKH's script, send-lots-of-email.pl, and strives to do
all the nice things a good subsystem maintainer does when forwarding a patch or
50 upstream:

	All the prior handlers of the patch, as determined by the
	Signed-off-by: lines, and/or the author of the commit, are cc:ed on the
	email.

	All emails are sent as a reply to the previous email, making it easy to
	skip a collection of emails that are uninteresting.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Makefile              |    2 
 git-send-email-script |  265 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 266 insertions(+), 1 deletions(-)
 create mode 100755 git-send-email-script

55d4b5b7a11448d60eb00b5a7081954663842b06
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script
+	git-request-pull-script git-send-email-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-send-email-script b/git-send-email-script
new file mode 100755
--- /dev/null
+++ b/git-send-email-script
@@ -0,0 +1,265 @@
+#!/usr/bin/perl -w
+# horrible hack of a script to send off a large number of email messages, one after
+# each other, all chained together.  This is useful for large numbers of patches.
+#
+# Use at your own risk!!!!
+#
+# greg kroah-hartman Jan 8, 2002
+# <greg@kroah.com>
+#
+# GPL v2 (See COPYING)
+# 
+# Ported to support git "mbox" format files by Ryan Anderson <ryan@michonline.com>
+#
+# Sends emails to the email listed on the command line.
+# 
+# updated to give a valid subject and CC the owner of the patch - Jan 2005
+# first line of the message is who to CC, 
+# and second line is the subject of the message.
+# 
+
+use strict;
+use warnings;
+use Term::ReadLine;
+use Mail::Sendmail;
+use Getopt::Long;
+use Data::Dumper;
+use Email::Valid;
+
+# Variables we fill in automatically, or via prompting:
+my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from);
+
+# Example of them
+# modify these options each time you run the script
+#$to = 'torvalds@osdl.org,git@vger.kernel.org';
+#$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
+#$initial_subject = "[PATCH] Deb package build fixes";
+#@files = (qw(
+#0001-Make-debian-rules-executable-and-correct-the-spelling-of-rsync-in.txt
+#0002-Debian-packages-should-include-the-binaries.txt
+#0003-The-deb-package-building-needs-these-two-new-files-to-work-correctly.txt
+#));
+
+# change this to your email address.
+#$from = "Ryan Anderson <ryan\@michonline.com>";
+
+my $term = new Term::ReadLine 'git-send-email';
+
+# Begin by accumulating all the variables (defined above), that we will end up
+# needing, first, from the command line:
+
+my $rc = GetOptions("from=s" => \$from,
+                    "in-reply-to=s" => \$initial_reply_to,
+		    "subject=s" => \$initial_subject,
+		    "to=s" => \@to,
+	 );
+
+# Now, let's fill any that aren't set in with defaults:
+
+open(GITVAR,"-|","git-var","-l")
+	or die "Failed to open pipe from git-var: $!";
+
+my ($author,$committer);
+while(<GITVAR>) {
+	chomp;
+	my ($var,$data) = split /=/,$_,2;
+	my @fields = split /\s+/, $data;
+
+	my $ident = join(" ", @fields[0...(@fields-3)]);
+
+	if ($var eq 'GIT_AUTHOR_IDENT') {
+		$author = $ident;
+	} elsif ($var eq 'GIT_COMMITTER_IDENT') {
+		$committer = $ident;
+	}
+}
+close(GITVAR);
+
+
+if (!defined $from) {
+	$from = $author || $committer;
+	1 while (!defined ($_ = $term->readline("Who should the emails appear to be from? ", 
+				$from)));
+	$from = $_;
+	print "Emails will be sent from: ", $from, "\n";
+}
+
+if (!@to) {
+	1 while (!defined ($_ = $term->readline("Who should the emails be sent to? ", 
+				"")));
+	my $to = $_;
+	push @to, split /,/, $to;
+}
+
+if (!defined $initial_subject) {
+	1 while (!defined ($_ = 
+		$term->readline("What subject should the emails start with? ", 
+			$initial_subject)));
+	$initial_subject = $_;
+}
+
+if (!defined $initial_reply_to) {
+	1 while (!defined ($_ = 
+		$term->readline("Message-ID to be used as In-Reply-To? ", 
+			$initial_reply_to)));
+	$initial_reply_to = $_;
+}
+
+# Now that all the defaults are set, process the rest of the command line
+# arguments and collect up the files that need to be processed.
+for my $f (@ARGV) {
+	if (-d $f) {
+		opendir(DH,$f)
+			or die "Failed to opendir $f: $!";
+
+		push @files, map { +$f . "/" . $_ } grep !/^\.{1,2}$/,
+			sort readdir(DH);
+	} elsif (-f $f) {
+		push @files, $f;
+
+	} else {
+		print STDERR "Skipping $f - not found.\n";
+	}
+}
+
+if (@files) {
+	print $_,"\n" for @files;
+} else {
+	print <<EOT;
+git-send-email-script [options] <file | directory> [... file | directory ]
+Options:
+   --from         Specify the "From:" line of the email to be sent.
+   --to	          Specify the primary "To:" line of the email.
+   --subject      Specify the initial "Subject:" line.
+   --in-reply-to  Specify the first "In-Reply-To:" header line.
+
+Error: Please specify a file or a directory on the command line.
+EOT
+	exit(1);
+}
+
+# Variables we set as part of the loop over files
+our ($message_id, $cc, %mail, $subject, $reply_to, $message);
+
+
+# Usually don't need to change anything below here.
+
+# we make a "fake" message id by taking the current number
+# of seconds since the beginning of Unix time and tacking on
+# a random number to the end, in case we are called quicker than
+# 1 second since the last time we were called.
+sub make_message_id
+{
+	my $date = `date "+\%s"`;
+	chomp($date);
+	my $pseudo_rand = int (rand(4200));
+	$message_id = "<$date$pseudo_rand\@foobar.com>";
+	print "new message id = $message_id\n";
+}
+
+
+
+$cc = "";
+
+sub send_message
+{
+	my %to;
+	$to{lc(Email::Valid->address($_))}++ for (@to);
+
+	my $to = join(",", keys %to);
+
+	%mail = (	To	=>	$to,
+			From	=>	$from,
+			CC	=>	$cc,
+			Subject	=>	$subject,
+			Message	=>	$message,
+			'Reply-to'	=>	$from,
+			'In-Reply-To'	=>	$reply_to,
+			'Message-ID'	=>	$message_id,
+			'X-Mailer'	=>	"git-send-email-script",
+		);
+
+	$mail{smtp} = 'localhost';
+
+	#print Data::Dumper->Dump([\%mail],[qw(*mail)]);
+
+	sendmail(%mail) or die $Mail::Sendmail::error;
+
+	print "OK. Log says:\n", $Mail::Sendmail::log;
+	print "\n\n"
+}
+
+
+$reply_to = $initial_reply_to;
+make_message_id();
+$subject = $initial_subject;
+
+foreach my $t (@files) {
+	my $F = $t;
+	open(F,"<",$t) or die "can't open file $t";
+
+	@cc = ();
+	my $found_mbox = 0;
+	my $header_done = 0;
+	$message = "";
+	while(<F>) {
+		if (!$header_done) {
+			$found_mbox = 1, next if (/^From /);
+			chomp;
+
+			if ($found_mbox) {
+				if (/^Subject:\s+(.*)$/) {
+					$subject = $1;
+
+				} elsif (/^(Cc|From):\s+(.*)$/) {
+					printf("(mbox) Adding cc: %s from line '%s'\n",
+						$2, $_);
+					push @cc, $2;
+				}
+
+			} else {
+				# In the traditional
+				# "send lots of email" format,
+				# line 1 = cc
+				# line 2 = subject
+				# So let's support that, too.
+				if (@cc == 0) {
+					printf("(non-mbox) Adding cc: %s from line '%s'\n",
+						$_, $_);
+
+					push @cc, $_;
+
+				} elsif (!defined $subject) {
+					$subject = $_;
+				}
+			}
+			
+			# A whitespace line will terminate the headers
+			if (m/^\s*$/) {
+				$header_done = 1;
+			}
+		} else {
+			$message .=  $_;
+			if (/^Signed-off-by: (.*)$/i) {
+				my $c = $1;
+				chomp $c;
+				push @cc, $c;
+				printf("(sob) Adding cc: %s from line '%s'\n",
+					$c, $_);
+			}
+		}
+	}
+	close F;
+
+	my %clean_ccs;
+	$clean_ccs{lc(Email::Valid->address($_))}++ for @cc;
+
+	$cc = join(",", keys %clean_ccs);
+
+	send_message();
+
+	# set up for the next message
+	$reply_to = $message_id;
+	make_message_id();
+#	$subject = "Re: ".$initial_subject;
+}
