From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 7/8] t5523-push-upstream: test progress messages
Date: Sun, 17 Oct 2010 02:37:02 +0800
Message-ID: <1287254223-4496-8-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
 <1287254223-4496-6-git-send-email-rctay89@gmail.com>
 <1287254223-4496-7-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bdw-0002rt-FB
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab0JPSht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42381 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab0JPShs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:48 -0400
Received: by mail-pv0-f174.google.com with SMTP id 18so130001pva.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gLgjgkhXwlBj7ZKj8mah5VB1bbIfYqLxxK545jpys4E=;
        b=mtgndAjVxkAu+KNUETiRltGUDi2Um1oW1L0uJgwSnt0BULbmxbbaOBVfljhK20wyDR
         RXwa86+aYjHAb3xXVEUJTmGfbU2aDwf/gdGg+cqcNJ6n8m7/MmAipOrKt1/v3IThHGoz
         0T8mKg1TkhDDldkpDf22SoS9UWJ5QOEC23mj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cjpB5bUD+x1D+4p9hzqzq4gn93M1xM+VqJ4hjUSx2QPL1V/zmhI0euT35JiKbU+RO7
         N1AJ7U+mawzTGL/9cedNFjgcOFEOMwdhGS4MbcJsjqc+mVWfEGN8zJHxx9gX2vwuhq01
         +oHYjrvntpUYRNc/2uWadIr3GJIV5uBU5nBw0=
Received: by 10.142.161.12 with SMTP id j12mr1842012wfe.201.1287254268769;
        Sat, 16 Oct 2010 11:37:48 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-7-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159176>

Reported-by: Chase Brammer <cbrammer@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Squashed in Jeff's additional tests, as well as added (missing) TTY
  pre-requisites pointed out by Johnathan.

 t/t5523-push-upstream.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 5a18533..f43d760 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -2,6 +2,7 @@
 
 test_description='push with --set-upstream'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 ensure_fresh_upstream() {
 	rm -rf parent && git init --bare parent
@@ -70,4 +71,41 @@ test_expect_success 'push -u HEAD' '
 	check_config headbranch upstream refs/heads/headbranch
 '
 
+test_expect_success TTY 'progress messages go to tty' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u upstream master >out 2>err &&
+	grep "Writing objects" err
+'
+
+test_expect_failure 'progress messages do not go to non-tty' '
+	ensure_fresh_upstream &&
+
+	# skip progress messages, since stderr is non-tty
+	git push -u upstream master >out 2>err &&
+	! grep "Writing objects" err
+'
+
+test_expect_failure 'progress messages go to non-tty (forced)' '
+	ensure_fresh_upstream &&
+
+	# force progress messages to stderr, even though it is non-tty
+	git push -u --progress upstream master >out 2>err &&
+	grep "Writing objects" err
+'
+
+test_expect_success TTY 'push -q suppresses progress' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u -q upstream master >out 2>err &&
+	! grep "Writing objects" err
+'
+
+test_expect_failure TTY 'push --no-progress suppresses progress' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u --no-progress upstream master >out 2>err &&
+	! grep "Writing objects" err
+'
+
 test_done
-- 
1.7.2.2.513.ge1ef3
