From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/2] Convert git-send-email to use Git.pm
Date: Sat, 24 Jun 2006 16:34:23 +0200
Message-ID: <20060624143423.13849.8400.stgit@machine.or.cz>
References: <20060624143421.13849.21667.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 16:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu9DT-0002lz-PU
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 16:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbWFXOe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 10:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbWFXOe0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 10:34:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31203 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752247AbWFXOeZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 10:34:25 -0400
Received: (qmail 13869 invoked from network); 24 Jun 2006 16:34:23 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 16:34:23 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624143421.13849.21667.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22520>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-send-email.perl |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c5d9e73..e794e44 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -21,6 +21,7 @@ use warnings;
 use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
+use Git;
 
 # most mail servers generate the Date: header, but not all...
 $ENV{LC_ALL} = 'C';
@@ -46,6 +47,8 @@ my $smtp_server;
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
 
+my $repo = Git->repository();
+
 my $term = new Term::ReadLine 'git-send-email';
 
 # Begin by accumulating all the variables (defined above), that we will end up
@@ -81,23 +84,9 @@ foreach my $entry (@bcclist) {
 
 # Now, let's fill any that aren't set in with defaults:
 
-sub gitvar {
-    my ($var) = @_;
-    my $fh;
-    my $pid = open($fh, '-|');
-    die "$!" unless defined $pid;
-    if (!$pid) {
-	exec('git-var', $var) or die "$!";
-    }
-    my ($val) = <$fh>;
-    close $fh or die "$!";
-    chomp($val);
-    return $val;
-}
-
 sub gitvar_ident {
     my ($name) = @_;
-    my $val = gitvar($name);
+    my $val = $repo->command('var', $name);
     my @field = split(/\s+/, $val);
     return join(' ', @field[0...(@field-3)]);
 }
@@ -106,8 +95,8 @@ my ($author) = gitvar_ident('GIT_AUTHOR_
 my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
 
 my %aliases;
-chomp(my @alias_files = `git-repo-config --get-all sendemail.aliasesfile`);
-chomp(my $aliasfiletype = `git-repo-config sendemail.aliasfiletype`);
+my @alias_files = $repo->config('sendemail.aliasesfile');
+my $aliasfiletype = $repo->config('sendemail.aliasfiletype');
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
@@ -132,7 +121,7 @@ my %parse_alias = (
 		}}}
 );
 
-if (@alias_files && defined $parse_alias{$aliasfiletype}) {
+if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	foreach my $file (@alias_files) {
 		open my $fh, '<', $file or die "opening $file: $!\n";
 		$parse_alias{$aliasfiletype}->($fh);
@@ -374,10 +363,7 @@ sub send_message
 	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime($time++));
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
-	    $gitversion = `git --version`;
-	    chomp $gitversion;
-	    # keep only what's after the last space
-	    $gitversion =~ s/^.* //;
+	    $gitversion = Git::version();
 	}
 
 	my $header = "From: $from
