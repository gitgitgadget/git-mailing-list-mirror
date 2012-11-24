From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] send-email: avoid questions when user has an ident
Date: Sat, 24 Nov 2012 12:16:19 +0100
Message-ID: <1353755779-32548-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 12:16:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcDj8-0001p4-06
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 12:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab2KXLQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 06:16:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64394 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab2KXLQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 06:16:33 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4106114bkw.19
        for <git@vger.kernel.org>; Sat, 24 Nov 2012 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rC0H4TIll0BIX5nkepmWIMs7KN/SL0TJ53uJXP2Ek4I=;
        b=YbIUoAeGcKLijhSTBKpa3jPyWTBaEuHUekE484nkgS4128xLrgYhfK1JMzSrutaCjD
         YyCo9vnaa0J9ZOJv0pHvmTDHwIL4dpg8N1FwzRoKYnhsqDHgnAzYCcIP0TocnA1Qyngd
         dtTMLMKhzTpSfuibrHDLCu6GsNJCLb8NJTLsLSBNO5QsGIVwwi98kxZ8FrCCHeS5DNwq
         LvsICanHz6fISe55r0ob0ZbjsVcQ5+kxxgGG7qDseDBil0gFTFoQ699wf0t9rD+n4D28
         OKGgTWu882cTqd5r7oC86O6AZoxs12O+GKGE6xbetz3GrlA4skE28PsWB9SMllpNka/r
         a+Vg==
Received: by 10.204.130.210 with SMTP id u18mr1848800bks.129.1353755791339;
        Sat, 24 Nov 2012 03:16:31 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id t11sm5669226bkv.11.2012.11.24.03.16.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Nov 2012 03:16:30 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210319>

Currently we keep getting questions even when the user has properly
configured his full name and password:

  Who should the emails appear to be from?
  [Felipe Contreras <felipe.contreras@gmail.com>]

And once a question pops up, other questions are turned on. This is
annoying.

The reason it's safe to avoid this question is because currently the
script fails completely when the author (or committer) is not correct,
so we won't even be reaching this point in the code.

The scenarios, and the current situation:

1) No information at all, no fully qualified domain name

  fatal: empty ident name (for <felipec@nysa.(none)>) not allowed

2) Only full name

  fatal: unable to auto-detect email address (got 'felipec@nysa.(none)')

3) Full name + fqdm

  Who should the emails appear to be from?
  [Felipe Contreras <felipec@nysa.felipec.org>]

4) Full name + EMAIL

  Who should the emails appear to be from?
  [Felipe Contreras <felipe.contreras@gmail.com>]

5) User configured
6) GIT_COMMITTER
7) GIT_AUTHOR

All these are the same as 4)

After this patch:

1) 2) won't change: git send-email would still die

4) 5) 6) 7) will change: git send-email won't ask the user

This is good, that's what we would expect, because the identity is
explicit.

3) will change: git send-email won't ask the user

This is bad, because we will try with an address such as
'felipec@nysa.felipec.org', which is most likely not what the user
wants, but the user will get warned by default (confirm=auto), and if
not, most likely the sending won't work, which the user would readily
note and fix.

The worst possible scenario is that such mail address does work, and the
user sends an email from that address unintentionally, when in fact the
user expected to correct that address in the prompt. This is a very,
very, very unlikely scenario, with many dependencies:

1) No configured user.name/user.email
2) No specified $EMAIL
3) No configured sendemail.from
4) No specified --from argument
5) A fully qualified domain name
6) A full name in the geckos field
7) A sendmail configuration that allows sending from this domain name
8) confirm=never, or
8.1) confirm configuration not hitting, or
8.2) Getting the error, not being aware of it
9) The user expecting to correct this address in the prompt

In a more likely scenario where 7) is not the case (can't send from
nysa.felipec.org), the user will simply see the mail was not sent
properly, and fix the problem.

The much more likely scenario though, is where 5) is not the case
(nysa.(none)), and git send-email will fail right away like it does now.

So the likelihood of this affecting anybody seriously is very very slim,
and the chances of this affecting somebody slightly are still very
small. The vast majority, if not all, of git users won't be affected
negatively, and a lot will benefit from this.

Tests-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Changes since v2:

 * Merge the relevant tests by Jeff King (the rest of the tests might be
   useful, but they belong in a separate patch series)

 git-send-email.perl   | 7 +------
 t/t9001-send-email.sh | 5 ++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..503e551 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,16 +748,11 @@ if (!$force) {
 	}
 }
 
-my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
-	$sender = ask("Who should the emails appear to be from? [$sender] ",
-	              default => $sender,
-		      valid_re => qr/\@.*\./, confirm_only => 1);
-	print "Emails will be sent from: ", $sender, "\n";
-	$prompting++;
 }
 
+my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
 	my $to = ask("Who should the emails be sent to (if any)? ",
 		     default => "",
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0351228..f77f68e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -191,14 +191,13 @@ test_expect_success $PREREQ 'Show all headers' '
 
 test_expect_success $PREREQ 'Prompting works' '
 	clean_fake_sendmail &&
-	(echo "Example <from@example.com>"
-	 echo "to@example.com"
+	(echo "to@example.com"
 	 echo ""
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
-		grep "^From: Example <from@example.com>\$" msgtxt1 &&
+		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
 		grep "^To: to@example.com\$" msgtxt1
 '
 
-- 
1.8.0
