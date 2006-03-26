From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: address expansion for common mailers
Date: Sat, 25 Mar 2006 17:10:06 -0800
Message-ID: <11433354063582-git-send-email-normalperson@yhbt.net>
References: <20060325235017.GN26071@mythryan2.michonline.com>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Ryan Anderson <ryan@michonline.com>, git <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 26 03:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJmA-00026y-QY
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWCZBKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWCZBKe
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:10:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34958 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751172AbWCZBKe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 20:10:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C21692DC033;
	Sat, 25 Mar 2006 17:10:33 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
In-Reply-To: <20060325235017.GN26071@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18014>

mutt, gnus, pine, mailrc formats should be supported.

Testing and feedback for correctness and completeness of all formats
and support for additional formats would be good.

Nested expansions are also supported.

Two git repo-config keys are required for this
(as suggested by Ryan Anderson):

	sendemail.aliasesfile = <filename of aliases file>
	sendemail.aliasfiletype = (mutt|gnus|pine|mailrc)

I was initially working on auto-detection, but mailrc and mutt formats
tend to throw each other off (they're alike, but handle multiple
addresses per-alias differently).

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

aea3aaf9571ab639c67608f62771e73104842294
diff --git a/git-send-email.perl b/git-send-email.perl
index 7cbf11d..208c119 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -89,6 +89,39 @@ sub gitvar_ident {
 my ($author) = gitvar_ident('GIT_AUTHOR_IDENT');
 my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
 
+my %aliases;
+chomp(my $aliases_file = `git-repo-config sendemail.aliasesfile`);
+chomp(my $aliasfiletype = `git-repo-config sendemail.aliasfiletype`);
+my %parse_alias = (
+	# multiline formats can be supported in the future
+	mutt => sub { my $fh = shift; while (<$fh>) {
+		if (/^alias\s+(\S+)\s+(.*)$/) {
+			my ($alias, $addr) = ($1, $2);
+			$addr =~ s/#.*$//; # mutt allows # comments
+			 # commas delimit multiple addresses
+			$aliases{$alias} = [ split(/\s*,\s*/, $addr) ];
+		}}},
+	mailrc => sub { my $fh = shift; while (<$fh>) {
+		if (/^alias\s+(\S+)\s+(.*)$/) {
+			# spaces delimit multiple addresses
+			$aliases{$1} = [ split(/\s+/, $2) ];
+		}}},
+	pine => sub { my $fh = shift; while (<$fh>) {
+		if (/^(\S+)\s+(.*)$/) {
+			$aliases{$1} = [ split(/\s*,\s*/, $2) ];
+		}}},
+	gnus => sub { my $fh = shift; while (<$fh>) {
+		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
+			$aliases{$1} = [ $2 ];
+		}}}
+);
+
+if ($aliases_file && defined $parse_alias{$aliasfiletype}) {
+	open my $fh, '<', $aliases_file or die "opening $aliases_file: $!\n";
+	$parse_alias{$aliasfiletype}->($fh);
+	close $fh;
+}
+
 my $prompting = 0;
 if (!defined $from) {
 	$from = $author || $committer;
@@ -112,6 +145,19 @@ if (!@to) {
 	$prompting++;
 }
 
+sub expand_aliases {
+	my @cur = @_;
+	my @last;
+	do {
+		@last = @cur;
+		@cur = map { $aliases{$_} ? @{$aliases{$_}} : $_ } @last;
+	} while (join(',',@cur) ne join(',',@last));
+	return @cur;
+}
+
+@to = expand_aliases(@to);
+@initial_cc = expand_aliases(@initial_cc);
+
 if (!defined $initial_subject && $compose) {
 	do {
 		$_ = $term->readline("What subject should the emails start with? ",
-- 
1.2.4.gb622a
