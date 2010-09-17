From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCH 2/2] t7500: add tests of commit --fixup/--squash
Date: Thu, 16 Sep 2010 19:39:56 -0600
Message-ID: <1284687596-236-3-git-send-email-patnotz@gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 03:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwPwN-0002Ua-QY
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 03:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab0IQBkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 21:40:17 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:57488 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0IQBkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 21:40:15 -0400
X-WSS-ID: 0L8VBB2-0C-0WH-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 11B745486CC
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 19:40:13 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 16 Sep 2010 19:40:01 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8H1dpRX017624 for
 <git@vger.kernel.org>; Thu, 16 Sep 2010 19:39:52 -0600
Received: from sacv8030ib.sandia.gov (134.253.116.6) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 16 Sep 2010 19:39:59 -0600
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1284687596-236-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.17.12722
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1800_1899 0,
 BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0,
 DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20100917014005; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34433932433646352E303231443A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAJsKIgAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 608C197B29K4137522-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156370>

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 t/t7500-commit.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index aa9c577..cd21f67 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -215,4 +215,43 @@ test_expect_success 'Commit a message with --allow-empty-message' '
 	commit_msg_is "hello there"
 '
 
+commit_for_rebase_autosquash_setup() {
+	echo "first content for testing commit messages for rebase --autosquash" >>foo &&
+	git add foo &&
+	cat >log <<EOF
+target message subject line
+
+target message body line 1
+target message body line 2
+EOF
+	git commit -F log &&
+	echo "second content for testing commit messages for rebase --autosquash" >>foo &&
+	git add foo &&
+	git commit -m "intermediate commit" &&
+	echo "third content for testing commit messages for rebase --autosquash" >>foo &&
+	git add foo
+}
+
+test_expect_success 'commit --fixup provides correct one-line commit message' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~1 &&
+	commit_msg_is "fixup! target message subject line"
+'
+test_expect_success 'commit --squash provides correct one-line commit message' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 &&
+	commit_msg_is "squash! target message subject line"
+'
+
+test_expect_success 'multiple commit message options must fail' '
+	echo changes >>foo &&
+	echo "message" >log &&
+	git add foo &&
+	test_must_fail git commit --fixup HEAD~1 --squash HEAD~1 &&
+	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
+	test_must_fail git commit --fixup HEAD~1 -F log &&
+	test_must_fail git commit --squash HEAD~1 -C HEAD~2 &&
+	test_must_fail git commit --squash HEAD~1 -c HEAD~2
+'
+
 test_done
-- 
1.7.2.3
