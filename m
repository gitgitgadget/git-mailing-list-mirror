From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git send-email: allow any rev-list option as an argument.
Date: Fri, 31 Oct 2008 17:52:05 +0100
Message-ID: <1225471925-2750-1-git-send-email-madcoder@debian.org>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 17:54:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxFs-00013c-7t
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYJaQwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYJaQwJ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:52:09 -0400
Received: from pan.madism.org ([88.191.52.104]:48023 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbYJaQwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:52:07 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 362CD3B623;
	Fri, 31 Oct 2008 17:52:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 39D005EE243; Fri, 31 Oct 2008 17:52:05 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.791.g15769.dirty
In-Reply-To: <1225450632-7230-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99604>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  One can consider to squash that on top of
  <1225450632-7230-3-git-send-email-madcoder@debian.org> to be able to pass
  all non path arguments before a possible '--' to git format-patch.

  The downside of this patch is that:

    git send-email -C -C -M origin/next

  will send the content of origin/next if it's an existing file. Of course a
  disambiguation can be:

    git send-email -C -C -M refs/heads/origin/next

  But again if this file also exists, one is basically screwed. I see no
  proper way to fix that, unless to change git-send-email behaviour at once.


  Though I believe this semantics to be better than the one in the previous
  patch, as it's often a good idea to pass -M -C -C to format-patch, which is
  currently impossible. It also allow revision lists to work as expected (wrt
  --all, --not and so on).

  Comments are welcomed.


 Documentation/git-send-email.txt |    2 +-
 git-send-email.perl              |   19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9ee81d5..39d6da9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -8,7 +8,7 @@ git-send-email - Send a collection of patches as emails
 
 SYNOPSIS
 --------
-'git send-email' [options] <file|directory|rev-list>...
+'git send-email' [options] <file|directory|rev-list options>...
 
 
 DESCRIPTION
diff --git a/git-send-email.perl b/git-send-email.perl
index 5c189a7..8667e0b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -25,6 +25,8 @@ use Term::ANSIColor;
 use File::Temp qw/ tempdir /;
 use Git;
 
+Getopt::Long::Configure qw/ pass_through /;
+
 package FakeTerm;
 sub new {
 	my ($class, $reason) = @_;
@@ -39,7 +41,7 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory | rev-list >
+git send-email [options] <file | directory | rev-list options >
 
   Composing:
     --from                  <str>  * Email From:
@@ -383,8 +385,12 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 
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
 		opendir(DH,$f)
 			or die "Failed to opendir $f: $!";
 
@@ -394,11 +400,14 @@ for my $f (@ARGV) {
 	} elsif (-f $f or -p $f) {
 		push @files, $f;
 	} else {
-		my $tempdir = tempdir(CLEANUP => 1);
-		push @files, $repo->command('format-patch', '-o', $tempdir, $f);
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
1.6.0.3.791.g15769.dirty
