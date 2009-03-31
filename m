From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/4] send-email: ask_default should apply to all emails, not just the first
Date: Tue, 31 Mar 2009 12:22:12 -0400
Message-ID: <77c8a8123cb66821775b03fa0f3d2744de82b79b.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
 <e439cc23328dc25d153baed21f6ad7d90106eb03.1238516122.git.jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 18:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loglf-0007sD-8B
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760950AbZCaQXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760694AbZCaQXE
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:23:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:46070 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760394AbZCaQXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:23:02 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3180189qwh.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=iqHMtAZ1qY12W/CwGvZQyfanD7yrYXSTmemxMFF9Srs=;
        b=GodOKBCYQTpz4MhryWboOrHlZ2qQQXcFswSHzhEP1if/VsLPEYc3ydOM5rVoEMi7CC
         xmTO0hSQTNrjiN1YdEXDCNTJUGQFG8JhSYk4B8/EY5E70gncuDPjthslq/wXI/iANt5+
         7BO7JKVMRsbKFg0sBicVpRvh5ZYRJoYiCHhmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fd9aDWOKirAOeTr78wnCV/e6OVFvV0aIYmrm0W0vw2BTRpxfZhw1TQdwWOm995CrFk
         o4zsZOqnWga/tHYjgdJU/TrQLOUEMmnNL1bQY0p1+BvzVA7M4f+zLdCdmlPcIhoLxceT
         GzJ5PLntDw7opkvuK02YXfzwEGqdiNl6m+WDs=
Received: by 10.224.89.14 with SMTP id c14mr6150481qam.374.1238516580729;
        Tue, 31 Mar 2009 09:23:00 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm296825qwh.39.2009.03.31.09.23.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:23:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.427.g15408
In-Reply-To: <e439cc23328dc25d153baed21f6ad7d90106eb03.1238516122.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115278>

Commit 6e18251 made the "Send this email?" prompt assume yes if confirm
= "inform" when it was unable to get a valid response. However, the
"yes" assumption only worked correctly for the first email. This commit
fixes the issue and confirms the fix my modifying the existing test for
the prompt to send multiple emails.

Reported by Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl   |    3 +--
 t/t9001-send-email.sh |    4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d790660..fc153f9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -687,7 +687,7 @@ if ($compose && $compose > 0) {
 
 # Variables we set as part of the loop over files
 our ($message_id, %mail, $subject, $reply_to, $references, $message,
-	$needs_confirm, $message_num);
+	$needs_confirm, $message_num, $ask_default);
 
 sub extract_valid_address {
 	my $address = shift;
@@ -845,7 +845,6 @@ X-Mailer: git-send-email $gitversion
 
 	if ($needs_confirm && !$dry_run) {
 		print "\n$header\n";
-		my $ask_default;
 		if ($needs_confirm eq "inform") {
 			$confirm_unconfigured = 0; # squelch this message for the rest of this run
 			$ask_default = "y"; # assume yes on EOF since user hasn't explicitly asked for confirmation
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b4de98c..195ff8b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -462,12 +462,14 @@ test_expect_success 'confirm by default (due to --compose)' '
 test_expect_success 'confirm detects EOF (inform assumes y)' '
 	CONFIRM=$(git config --get sendemail.confirm) &&
 	git config --unset sendemail.confirm &&
+	rm -fr outdir &&
+	git format-patch -2 -o outdir &&
 	GIT_SEND_EMAIL_NOTTY=1 \
 		git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
-			$patches < /dev/null
+			outdir/*.patch < /dev/null
 	ret="$?"
 	git config sendemail.confirm ${CONFIRM:-never}
 	test $ret = "0"
-- 
1.6.2.1.427.g15408
