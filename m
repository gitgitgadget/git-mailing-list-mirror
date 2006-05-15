From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH (resend)] send-email: address expansion for common mailers
Date: Sun, 14 May 2006 19:13:44 -0700
Message-ID: <11476592243181-git-send-email-normalperson@yhbt.net>
References: <20060326024416.GA14234@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 15 04:13:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSam-0000Cq-U4
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWEOCNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWEOCNr
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:13:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:28576 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750807AbWEOCNq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 22:13:46 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id F3D7D7DC005;
	Sun, 14 May 2006 19:13:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 May 2006 19:13:44 -0700
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>,
	Ryan Anderson <ryan@michonline.com>
X-Mailer: git-send-email 1.3.2.g1c9b
In-Reply-To: <20060326024416.GA14234@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20007>

mutt, gnus, pine, mailrc formats should be supported.

Testing and feedback for correctness and completeness of all formats
and support for additional formats would be good.

Nested expansions are also supported.

More than one alias file to be used.

All alias file formats must still of be the same type, though.

Two git repo-config keys are required for this
(as suggested by Ryan Anderson):

    sendemail.aliasesfile = <filename of aliases file>
    sendemail.aliasfiletype = (mutt|gnus|pine|mailrc)

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

Looks like this patch got forgotten a while ago, and I never noticed
because I forgot to set WITH_SEND_EMAIL when doing make install.
Of course, WITH_SEND_EMAIL should no longer be needed...

 git-send-email.perl |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

ff6593287dc500853c1cf05bdb0f32f970f10c9d
diff --git a/git-send-email.perl b/git-send-email.perl
index 703dd1f..d8c4b1f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -89,6 +89,41 @@ sub gitvar_ident {
 my ($author) = gitvar_ident('GIT_AUTHOR_IDENT');
 my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
 
+my %aliases;
+chomp(my @alias_files = `git-repo-config --get-all sendemail.aliasesfile`);
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
+if (@alias_files && defined $parse_alias{$aliasfiletype}) {
+	foreach my $file (@alias_files) {
+		open my $fh, '<', $file or die "opening $file: $!\n";
+		$parse_alias{$aliasfiletype}->($fh);
+		close $fh;
+	}
+}
+
 my $prompting = 0;
 if (!defined $from) {
 	$from = $author || $committer;
@@ -112,6 +147,19 @@ if (!@to) {
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
1.3.2.g1c9b
