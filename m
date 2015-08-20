From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] trailer: ignore first line of message
Date: Thu, 20 Aug 2015 23:59:15 +0200
Message-ID: <1440107955-26892-1-git-send-email-chriscool@tuxfamily.org>
References: <CAP8UFD0YcBdAfMJxc2bQD_zTp+kPk2L2sQfWYzTDn+trFk+DMA@mail.gmail.com>
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 23:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSXsF-0006EA-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 23:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbbHTV7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 17:59:47 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34636 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbHTV7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 17:59:47 -0400
Received: by paom9 with SMTP id m9so3221657pao.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcP+9fagyO/ecojC8e92eAbPLW6BCUpvYAP0BtIrV1w=;
        b=pPpFskrvcok1VB3lkis9IxO/TLhSG5HQe2E7kNVP3972PF17817fYUNpgYZToSn4Yi
         yTSjCsOvuLt3J0xLPyBJYOWSVTmWr6HxZLL2vL0du5FWm2K+VrnKo2Kk9bqOTzET0aEC
         lp+dey8gVk3+HJB0MlQmAt/gONaPrOxV2dxW/g33rCXkHscsNsw8AIERKlTTuLoPIVQu
         0eTEF7qN1GT1+jw+Ox1t91dHwknKvzPltnxrO7kXWD1dgoWj//f45Eeb3CSHq6DeBiEf
         5bYl6/do5ztkhRM5QTFpuk5UIaW5BVfj11xTyJQRBmTWjmIcWqrs18HLqcy8Ye56uzJg
         xzmQ==
X-Received: by 10.66.161.232 with SMTP id xv8mr10457305pab.137.1440107986595;
        Thu, 20 Aug 2015 14:59:46 -0700 (PDT)
Received: from localhost.localdomain (67-131-47-154.dia.static.qwest.net. [67.131.47.154])
        by smtp.gmail.com with ESMTPSA id ob4sm5416745pbb.40.2015.08.20.14.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Aug 2015 14:59:45 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.5.0.400.gff86faf.dirty
In-Reply-To: <CAP8UFD0YcBdAfMJxc2bQD_zTp+kPk2L2sQfWYzTDn+trFk+DMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276267>

When looking for the start of the trailers in the message
we are passed, we should ignore the first line of the message.

The reason is that if we are passed a patch or commit message
then the first line should be the patch title.
If we are passed only trailers we can expect that they start
with an empty line that can be ignored too.

This way we can properly process commit messages that have
only one line with something that looks like a trailer, for
example like "area of code: change we made".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 15 ++++++++++++++-
 trailer.c                     |  3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index bd0ab46..f7ebc5e 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -93,12 +93,25 @@ test_expect_success 'with config option on the command line' '
 		Acked-by: Johan
 		Reviewed-by: Peff
 	EOF
-	echo "Acked-by: Johan" |
+	{ echo; echo "Acked-by: Johan"; } |
 	git -c "trailer.Acked-by.ifexists=addifdifferent" interpret-trailers \
 		--trailer "Reviewed-by: Peff" --trailer "Acked-by: Johan" >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success 'with message that contains only a title' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	echo "area: change" |
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 4b14a56..af80b8e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -740,8 +740,9 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	/*
 	 * Get the start of the trailers by looking starting from the end
 	 * for a line with only spaces before lines with one separator.
+	 * The start cannot be the first line.
 	 */
-	for (start = count - 1; start >= 0; start--) {
+	for (start = count - 1; start >= 1; start--) {
 		if (lines[start]->buf[0] == comment_line_char)
 			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
-- 
2.5.0.400.gff86faf.dirty
