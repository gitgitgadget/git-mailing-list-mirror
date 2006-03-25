From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/4] send-email: add support for mutt aliases files
Date: Sat, 25 Mar 2006 02:43:31 -0800
Message-ID: <11432834111445-git-send-email-normalperson@yhbt.net>
References: <11432834101430-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Ryan Anderson <ryan@michonline.com>,
	Greg KH <greg@kroah.com>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 25 11:44:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN6Fw-00016M-LT
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 11:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWCYKoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 05:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCYKoC
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 05:44:02 -0500
Received: from hand.yhbt.net ([66.150.188.102]:20616 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751164AbWCYKn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 05:43:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5A0477DC023;
	Sat, 25 Mar 2006 02:43:58 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
In-Reply-To: <11432834101430-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17975>

I got rid of the Email::Valid dependency since writing
RFC-correct email addresses is probably not a problem for most
users.

In my experience, misspelled usernames are a much bigger
problem.  I am prone to doing things like leaving out the 'k' in
Junio's email address and other things that Email::Valid can't
catch.

Since I use mutt and the aliases file is pretty simple, I've
added basic support for mutt alias files.

To setup git-send-email to use a mutt aliases file for a repo,
do this:

  git-repo-config sendemail.muttaliases <mutt_alias_file_path>

More email clients/address book formats can easily be supported
in the future.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

8bc65d178dd755ecd1f3c038b975b9bbe58c1015
diff --git a/git-send-email.perl b/git-send-email.perl
index 73bba19..207b1fb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -89,6 +89,15 @@ sub gitvar_ident {
 my ($author) = gitvar_ident('GIT_AUTHOR_IDENT');
 my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
 
+my %aliases;
+if (my $mutt_aliases = `git-repo-config sendemail.muttaliases`) {
+    chomp $mutt_aliases;
+    open my $ma, '<', $mutt_aliases or die "opening $mutt_aliases: $!\n";
+    while (<$ma>) { if (/^alias\s+(\S+)\s+(.*)/) { $aliases{$1} = $2 } }
+    close $ma;
+}
+# aliases for more mail clients can be supported here:
+
 my $prompting = 0;
 if (!defined $from) {
 	$from = $author || $committer;
@@ -112,6 +121,9 @@ if (!@to) {
 	$prompting++;
 }
 
+@to = map { $aliases{$_} || $_ } @to;
+@initial_cc = map { $aliases{$_} || $_ } @initial_cc;
+
 if (!defined $initial_subject && $compose) {
 	do {
 		$_ = $term->readline("What subject should the emails start with? ",
-- 
1.2.4.gb622a
