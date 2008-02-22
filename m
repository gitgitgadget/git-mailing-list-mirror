From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: fix In-Reply-To regression
Date: Thu, 21 Feb 2008 19:16:04 -0500
Message-ID: <1203639364-91817-1-git-send-email-jaysoffian@gmail.com>
References: <76718490802211351n1f0a6c36nb84902a624ee2120@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, Len Brown <lenb@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 01:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSLbE-0003gS-IG
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 01:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765406AbYBVAQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 19:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760515AbYBVAQM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 19:16:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:55898 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760706AbYBVAQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 19:16:10 -0500
Received: by wx-out-0506.google.com with SMTP id h31so204354wxd.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 16:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=kJk/qZ0YJZ+4/PICoBtW7pXVHHxqwETh1onEeBVZD0I=;
        b=ESzlxRhsLXpGL4apAllhfCQZrtqhybKXvBmuJhd/MSLDAHoPaKr6xedjIWAK62aW/te3JoZh1soMi2PeIL4tqUcxs7r9FvBhn+ixWYkcRtWI20w5/5AxWL1ytUaW/4jEk+dd2YLL6eqvcjh1Snlgh0OGnei81viT5BBLoCrUlj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=tWZFD/VYpyguYXwdRXQTG9Xzoq8hMkJ6qsaZkhcplVNs267T/V204BttZBDGW2WJgkJjRlLaSgBPtbi03oV5OwNNsNLdyhsLzUMgY2DMfOpBPJBov07qxyM3WChXKS3xDDZPUvl591QLCBSl/kRHy1Y982T4ZdchutAy1pg2zqI=
Received: by 10.100.107.7 with SMTP id f7mr21444457anc.35.1203639367898;
        Thu, 21 Feb 2008 16:16:07 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c4sm1145453anc.29.2008.02.21.16.16.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Feb 2008 16:16:07 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.236.g77b4.dirty
In-Reply-To: <76718490802211351n1f0a6c36nb84902a624ee2120@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74685>

Fix a regression introduced by

1ca3d6e (send-email: squelch warning due to comparing undefined $_ to "")

where if the user was prompted for an initial In-Reply-To and didn't
provide one, messages would be sent out with an invalid In-Reply-To of
"<>"

Also add test cases for the regression and the fix. A small modification
was needed to allow send-email to take its replies from stdin if the
environment variable GIT_SEND_EMAIL_NOTTY is set.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---

An issue cropped up with testing the regression: it only occured if
initial_reply_to was "", and the only way to do that is to respond to
the Initial-Reply-To prompt with "\n". But send-email uses readline,
which insists on /dev/tty.

So, I initially simulated the breakage by using --initial-reply-to=" ",
but this isn't quite the same thing. However, it turns out this can also
cause an invalid In-Reply-To, which wasn't fixed by Junio's suggestion
of checking that initial_reply_to ne "". So I did a slightly different
fix that handles initial_reply_to eq  " ".

Anyway, back to testing the original problem. I didn't want to use
expect or Expect.pm, so I made a small change to send-email where if
GIT_SEND_EMAIL_NOTTY is set, it will read from stdin instead of
/dev/tty.

But, I wonder if in the future we'll want to enhance the testing
framework to be able to do expect-type stuff?

j.

 git-send-email.perl   |    9 ++++++---
 t/t9001-send-email.sh |   21 +++++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ccb87a2..29b1105 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -170,7 +170,9 @@ my $envelope_sender;
 
 my $repo = Git->repository();
 my $term = eval {
-	new Term::ReadLine 'git-send-email';
+	$ENV{"GIT_SEND_EMAIL_NOTTY"}
+		? new Term::ReadLine 'git-send-email', \*STDIN, \*STDOUT
+		: new Term::ReadLine 'git-send-email';
 };
 if ($@) {
 	$term = new FakeTerm "$@: going non-interactive";
@@ -476,8 +478,9 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = $_;
 }
 if (defined $initial_reply_to) {
-	$initial_reply_to =~ s/^\s*<?/</;
-	$initial_reply_to =~ s/>?\s*$/>/;
+	$initial_reply_to =~ s/^\s*<?//;
+	$initial_reply_to =~ s/>?\s*$//;
+	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
 if (!defined $smtp_server) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 08f7c3d..1422e9f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -108,4 +108,25 @@ test_expect_success 'allow long lines with --no-validate' '
 		2>errors
 '
 
+test_expect_failure 'Invalid In-Reply-To' '
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--in-reply-to=" " \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches
+		2>errors
+	! grep "^In-Reply-To: < *>" msgtxt
+'
+
+test_expect_success 'Valid In-Reply-To when prompting' '
+	(echo "From Example <from@example.com>"
+	 echo "To Example <to@example.com>"
+	 echo ""
+	) | env GIT_SEND_EMAIL_NOTTY=1 git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches 2>errors &&
+	! grep "^In-Reply-To: < *>" msgtxt
+'
+
 test_done
-- 
1.5.4.2.236.g77b4.dirty
