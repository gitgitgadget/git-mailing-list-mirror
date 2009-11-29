From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFH] Mention of 1.7.0 transition plans in Release Notes to 1.6.6
Date: Sun, 29 Nov 2009 12:24:48 +0900
Message-ID: <20091129122448.6117@nanako3.lavabit.com>
References: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 04:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEaRa-0006am-Gu
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 04:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZK2D1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 22:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbZK2D1B
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 22:27:01 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36028 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbZK2D1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 22:27:00 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id A736511B726;
	Sat, 28 Nov 2009 21:27:06 -0600 (CST)
Received: from 5456.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id PY6TQY67X3WJ; Sat, 28 Nov 2009 21:27:06 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=n1hLEsSnsnGCXDOhBV1jHjZYa9ZOR99AOoJfREO3VOLKoAo7kdWvdIgf/mx2sozAJLYq1G8laDTyoSrX+9ERyOi2BU77e9qIjI+pqC+0AoGG51XMToCUaTyrol/NvDPOId/86J0HR/smde6sucDjB7fFhW35BXLtrUwTo0lW90o=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133987>

Subject: prepare send-email for smoother change of --chain-reply-to default

Give a warning message when send-email uses chain-reply-to to thread the
messages because of the current default, not because the user explicitly
asked to, either from the command line or from the configuration.

This way, by the time 1.7.0 switches the default, everybody will be ready.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Quoting Junio C Hamano <gitster@pobox.com>

 >  - I do not think we have such an anti-procrastination measure for
 >    send-email's --[no-]chain-reply-to change.  We might want to have one
 >    before 1.6.6 ships; namely, if the code decided to use chain-reply-to
 >    behaviour by default because there was no sendemail.chainreplyto (or
 >    sendemail.$identity.chainreplyto) configured, nor --no-chain-reply-to
 >    or --chain-reply-to given from the command line, we issue a big fat
 >    warning just like we warn against unconfigured push.denyCurrentBranch
 >    when allowing pushing to a checked-out branch without being told.

 Like this?

 git-send-email.perl   |   19 +++++++++++++++++--
 t/t9001-send-email.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4f5da4e..2afed76 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -187,9 +187,11 @@ my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
 my (@suppress_cc);
 
+my $not_set_by_user = "true but not set by the user";
+
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
-    "chainreplyto" => [\$chain_reply_to, 1],
+    "chainreplyto" => [\$chain_reply_to, $not_set_by_user],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
@@ -214,6 +216,19 @@ my %config_settings = (
     "from" => \$sender,
 );
 
+# Help users prepare for 1.7.0
+sub chain_reply_to {
+	if (defined $chain_reply_to &&
+	    $chain_reply_to eq $not_set_by_user) {
+		print STDERR
+		    "In git 1.7.0, the default will be changed to --no-chain-reply-to\n" .
+		    "Set sendemail.chainreplyto configuration variable to true if\n" .
+		    "you want to keep --chain-reply-to as your default.\n";
+		$chain_reply_to = 1;
+	}
+	return $chain_reply_to;
+}
+
 # Handle Uncouth Termination
 sub signal_handler {
 
@@ -1157,7 +1172,7 @@ foreach my $t (@files) {
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
-		($chain_reply_to || !defined $reply_to || length($reply_to) == 0)) {
+		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84a7f03..4372774 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -769,4 +769,44 @@ test_expect_success 'threading but no chain-reply-to' '
 	grep "In-Reply-To: " stdout
 '
 
+test_expect_success 'no warning with an explicit --chain-reply-to' '
+	git send-email \
+	--dry-run \
+	--from="Example <nobody@example.com>" \
+	--to=nobody@example.com \
+	--chain-reply-to \
+	outdir/000?-*.patch 2>errors >out &&
+	! grep "no-chain-reply-to" errors
+'
+
+test_expect_success 'no warning with an explicit --no-chain-reply-to' '
+	git send-email \
+	--dry-run \
+	--from="Example <nobody@example.com>" \
+	--to=nobody@example.com \
+	--no-chain-reply-to \
+	outdir/000?-*.patch 2>errors >out &&
+	! grep "no-chain-reply-to" errors
+'
+
+test_expect_success 'no warning with sendemail.chainreplyto = false' '
+	git config sendemail.chainreplyto false &&
+	git send-email \
+	--dry-run \
+	--from="Example <nobody@example.com>" \
+	--to=nobody@example.com \
+	outdir/000?-*.patch 2>errors >out &&
+	! grep "no-chain-reply-to" errors
+'
+
+test_expect_success 'no warning with sendemail.chainreplyto = true' '
+	git config sendemail.chainreplyto true &&
+	git send-email \
+	--dry-run \
+	--from="Example <nobody@example.com>" \
+	--to=nobody@example.com \
+	outdir/000?-*.patch 2>errors >out &&
+	! grep "no-chain-reply-to" errors
+'
+
 test_done


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
