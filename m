From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] send-email: Don't leak To: headers between patches
Date: Mon,  4 Oct 2010 00:05:24 -0700
Message-ID: <1286175924-15761-1-git-send-email-bebarino@gmail.com>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joe Perches <joe@perches.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2f7G-0008Rq-3G
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0JDHFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:05:36 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49909 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab0JDHFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:05:35 -0400
Received: by qwh6 with SMTP id 6so2938150qwh.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Dum+/ff7EjwWrNrHAjTERhikAKCRAIv3b0yzQi1gCaw=;
        b=u0Ma6Tm6VoTjz/Y7xkdkDTh1IxSU/czSqfp7tllmsYAVzzke0e9n+q1SvoNuMip+U1
         mOpp+ReUcuydmHTZNbL9u+bttC5rWhD0R13yuABP4Hv+22wEZL0TVvrAzeLDYGdnJlMj
         yfltt00YNgn1Z6xMpaynBszxFA1sYK56+dEVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nZMnYCD7K4dzta/jGOlwyrWc44l7ntDnqmnjCcKn3q6PStcnEUOcZ7wIWv/5mNoGsS
         ohlIq5ewpL5tYwyMcR5qJpkmdMOOKPDm3CyiFQQoAaejR3xbyG6YmTnMKFIftJW8jIDF
         jNgwQANNPOjY3FPyw99GFNN69H9y1e/KtYXz4=
Received: by 10.224.104.4 with SMTP id m4mr6594326qao.76.1286175931421;
        Mon, 04 Oct 2010 00:05:31 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id r36sm5135614qcs.27.2010.10.04.00.05.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 00:05:30 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 04 Oct 2010 00:05:24 -0700
X-Mailer: git-send-email 1.7.3.17.g34f71
In-Reply-To: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157993>

If the first patch in a series has a To: header in the file and the
second patch in the series doesn't the address from the first patch will
be part of the To: addresses in the second patch. Fix this by treating the
to list like the cc list. Have an initial to list come from the command
line, user input and config options. Then build up a to list from each
patch and concatenate the two together before sending the patch. Finally,
reset the list after sending each patch so the To: headers from a patch
don't get used for the next one.

Reported-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

On 10/03/2010 10:37 PM, Viresh KUMAR wrote:
> While sending multiple patches with a single git-send-email command,
> To: field is not cleared after every mail. This patch clears To: field
> after every patch sent.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Tested-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  git-send-email.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 1ccfb80..cf17704 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1150,6 +1150,7 @@ foreach my $t (@files) {
>  	my $author_encoding;
>  	my $has_content_type;
>  	my $body_encoding;
> +	@to = ();
>  	@cc = ();
>  	@xh = ();
>  	my $input_format = undef;

Ah, I didn't think about this at all. Your patch doesn't look right though.
Consider a user adding a --to argument on the command line. The first patch
will be sent to the right place but the second one will be sent to nobody.
Right?

How about this instead? Based on sb/send-email-use-to-from-input. Junio,
looks like this would also fix a similar situation with the to_cmd in
next.

 git-send-email.perl   |   18 ++++++++++--------
 t/t9001-send-email.sh |   15 +++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d6028ec..7f9eacd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -138,7 +138,7 @@ sub unique_email_list(@);
 sub cleanup_compose_files();
 
 # Variables we fill in automatically, or via prompting:
-my (@to,$no_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
+my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
@@ -213,7 +213,7 @@ my %config_settings = (
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
 	"smtpdomain" => \$smtp_domain,
-    "to" => \@to,
+    "to" => \@initial_to,
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
@@ -271,7 +271,7 @@ $SIG{INT}  = \&signal_handler;
 my $rc = GetOptions("sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
-		    "to=s" => \@to,
+		    "to=s" => \@initial_to,
 		    "no-to" => \$no_to,
 		    "cc=s" => \@initial_cc,
 		    "no-cc" => \$no_cc,
@@ -409,7 +409,7 @@ my ($repoauthor, $repocommitter);
 
 # Verify the user input
 
-foreach my $entry (@to) {
+foreach my $entry (@initial_to) {
 	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
 }
 
@@ -711,9 +711,9 @@ if (!defined $sender) {
 	$prompting++;
 }
 
-if (!@to) {
+if (!@initial_to) {
 	my $to = ask("Who should the emails be sent to? ");
-	push @to, parse_address_line($to) if defined $to; # sanitized/validated later
+	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
 	$prompting++;
 }
 
@@ -731,8 +731,8 @@ sub expand_one_alias {
 	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
 }
 
-@to = expand_aliases(@to);
-@to = (map { sanitize_address($_) } @to);
+@initial_to = expand_aliases(@initial_to);
+@initial_to = (map { sanitize_address($_) } @initial_to);
 @initial_cc = expand_aliases(@initial_cc);
 @bcclist = expand_aliases(@bcclist);
 
@@ -1136,6 +1136,7 @@ foreach my $t (@files) {
 	my $author_encoding;
 	my $has_content_type;
 	my $body_encoding;
+	@to = ();
 	@cc = ();
 	@xh = ();
 	my $input_format = undef;
@@ -1300,6 +1301,7 @@ foreach my $t (@files) {
 		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
 	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
 
+	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
 
 	my $message_was_sent = send_message();
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 294e31f..13d8d1a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -971,6 +971,21 @@ test_expect_success $PREREQ 'patches To headers are appended to' '
 	grep "RCPT TO:<nobody@example.com>" stdout
 '
 
+test_expect_success $PREREQ 'To headers from files reset each patch' '
+	patch1=`git format-patch -1 --to="bodies@example.com"` &&
+	patch2=`git format-patch -1 --to="other@example.com" HEAD~` &&
+	test_when_finished "rm $patch1 && rm $patch2" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to="nobody@example.com" \
+		--smtp-server relay.example.com \
+		$patch1 $patch2 >stdout &&
+	test $(grep -c "RCPT TO:<bodies@example.com>" stdout) = 1 &&
+	test $(grep -c "RCPT TO:<nobody@example.com>" stdout) = 2 &&
+	test $(grep -c "RCPT TO:<other@example.com>" stdout) = 1
+'
+
 test_expect_success $PREREQ 'setup expect' '
 cat >email-using-8bit <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-- 
1.7.3.1.50.g1e633
