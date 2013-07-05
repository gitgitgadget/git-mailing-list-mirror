From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v10 4/5] t6006 (rev-list-format): add tests for "%b" and "%s" for the case i18n.commitEncoding is not set
Date: Fri,  5 Jul 2013 16:01:49 +0400
Message-ID: <a17c23d117e9457cdf131068a4aae586bda854e8.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 14:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4iZ-0004To-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab3GEMCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jul 2013 08:02:16 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47563 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab3GEMCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:02:07 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so2000591lbd.15
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=z858TlBOWWaspo2Qmng7wsUxaY/+z11IH7KTR+O8XEc=;
        b=X9dralYxVaejGWacdvkFGluYp3XbOeKiv7fI7At7uxoj73LO8FD67uxxwefIcanWjn
         Zmd1coE9DZACVIbH12AL/lMRkBLK9rXWSlkpjJgT1WQU45uzB/OVUrjtlyrhw2kTlG3s
         wnXgda07I9rSTrnpW+QESMq4YNsWhT+bvaFnfXneQDpt8iPDLKm6riU9F5xq99cb2Jsj
         ToZXZDCW2bpluWQTa+mRIJlWaxNM2osQ76rVdMu7OsbeIqbKHPp4/1FJPJFd6iD9I2N5
         DlXB4R262TjFQ6zsr5Yz8PktxS1syQchzibxSp4I/JkApfxQS3U/3MhWuhrQgPIHrfXv
         mVXQ==
X-Received: by 10.112.198.10 with SMTP id iy10mr5432630lbc.38.1373025726390;
        Fri, 05 Jul 2013 05:02:06 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id x8sm2755354lae.10.2013.07.05.05.02.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.16.gb1f0d63
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com> <cover.1373024281.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229656>

In de6029a (pretty: Add failing tests: --format output should honor
logOutputEncoding, 2013-06-26) 'complex-subject' test was changed.
Revert it back, because that change actually removed tests for "%b" and
"%s" with i18n.commitEncoding set.
Also, add two more tests for mentioned above "%b" and "%s" to test
encoding conversions with no i18n.commitEncoding set.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Suggested-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t6006-rev-list-format.sh | 41 ++++++++++++++++++++++++++++----------=
---
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b32405a..e51d0f0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -218,12 +218,7 @@ test_expect_success 'setup complex body' '
 	git config i18n.commitencoding iso8859-1 &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=3D$(git rev-parse --verify HEAD) &&
-	head3_short=3D$(git rev-parse --short $head3) &&
-	# unset commit encoding config
-	# otherwise %e does not print encoding value
-	# and following test fails
-	git config --unset i18n.commitEncoding
-
+	head3_short=3D$(git rev-parse --short $head3)
 '
=20
 test_format complex-encoding %e <<EOF
@@ -239,21 +234,41 @@ test_format complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
-$changed
+$changed_iso88591
 commit $head1
-$added
+$added_iso88591
 EOF
=20
-test_format complex-body %b <<EOF
-commit $head3
-This commit message is much longer than the others,
-and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+test_expect_success 'prepare expected messages (for test %b)' '
+    cat <<-EOF >expected.utf-8 &&
+	commit $head3
+	This commit message is much longer than the others,
+	and it will be encoded in iso8859-1. We should therefore
+	include an iso8859 character: =C2=A1bueno!
+
+	commit $head2
+	commit $head1
+EOF
+	iconv -f utf-8 -t iso8859-1 expected.utf-8 >expected.iso8859-1
+'
+
+test_format complex-body %b <expected.iso8859-1
=20
+# Git uses i18n.commitEncoding if no i18n.logOutputEncoding set
+# so unset i18n.commitEncoding to test encoding conversion
+git config --unset i18n.commitEncoding
+
+test_format complex-subject-commitencoding-unset %s <<EOF
+commit $head3
+Test printing of complex bodies
 commit $head2
+$changed
 commit $head1
+$added
 EOF
=20
+test_format complex-body-commitencoding-unset %b <expected.utf-8
+
 test_expect_success '%x00 shows NUL' '
 	echo  >expect commit $head3 &&
 	echo >>expect fooQbar &&
--=20
1.8.3.2.16.gb1f0d63
