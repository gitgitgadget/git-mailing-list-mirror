From: larsxschneider@gmail.com
Subject: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Sun, 24 Jan 2016 13:22:50 +0100
Message-ID: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, jehan@orb.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 13:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNJhi-0003Ch-3C
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 13:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbcAXMW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 07:22:56 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34867 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcAXMWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 07:22:54 -0500
Received: by mail-wm0-f43.google.com with SMTP id r129so34018787wmr.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pzFP0+AalvLo4jSEZqvBoKs23941SqW/s0DWvcJXBKM=;
        b=E8pDM6jyGVoR0cBBQU+Yz2sjfHFWrJAV7qQqcoCVAEyZ2iI0bU7Edkt9acuXB1/qOM
         Q/FUO8ZBtT36pVwK3ZA75lv5fFyGkHhfZDtULBnWyR/hb83mP7RKZLkxbi2U8clGy4I0
         tACF84BM2xHctYjn2fSVFdAYSOgOn3uiwTDdBasrh6B8dCG0MYhirVl3MXv0KVCTR3so
         cFCtMkocgAa0O9jXlkagyNl7q4nbwx0RTLcBNRQCvReoguVTV/5qlyiRUlou2EKg/geU
         0yQh5qrGl0mtDSeK0dRZde9sBOg7MzwXhsK52WxdCOc8cJ8v30xn2nuDElUY3uSM1a8t
         NZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pzFP0+AalvLo4jSEZqvBoKs23941SqW/s0DWvcJXBKM=;
        b=kgp14bjDKg66MvuKQdtWxeOprhU2eAoPmhqVEOzmsrTqfPn8xCdmcjgxLOB4co6ql6
         TjK0Mzp9VYsUdhDMyPeTQUfz7dL8k5ELkO/8QCycJyNjV/uWsPxbPlhc2HP/ljmlfZEe
         o9+ZcHXusEQst950OH1Q5SOlqq8m3Lh4XHhCaiXjEWDhYNHoZr98inETdTWGO5smTRTX
         9YJYmPz1DIk2RXFd/EAwShK3aflWjVpShS3LQIQ0PKfFSIulqIHpQGH9veZFAw+dX+3y
         GHjL53bF9Kf0OgbU3BLmp7qpASD/23NouhJz7t99bFYyNfT8zgwq9IhO+wSi5Z8JXeGs
         pzxA==
X-Gm-Message-State: AG10YORe4zCEgFfutg8x+6EZx1CIS71kExujc47pKEHgz/6YwHO1KjMEL34/5L/tuUr0YA==
X-Received: by 10.28.53.193 with SMTP id c184mr12648965wma.4.1453638173018;
        Sun, 24 Jan 2016 04:22:53 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB4D5E.dip0.t-ipconnect.de. [93.219.77.94])
        by smtp.gmail.com with ESMTPSA id ha9sm14329520wjc.3.2016.01.24.04.22.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 04:22:52 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284646>

From: Lars Schneider <larsxschneider@gmail.com>

A clean/smudge filter can be disabled if set to an empty string. However,
Git will try to run the empty string as command which results in a error
message per processed file.

Teach Git to consider an empty clean/smudge filter as legitimately disabled
and do not print an error message.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c             |  4 ++--
 t/t0021-conversion.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 814e814..58af965 100644
--- a/convert.c
+++ b/convert.c
@@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	struct conv_attrs ca;

 	convert_attrs(&ca, path);
-	if (ca.drv) {
+	if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {
 		filter = ca.drv->clean;
 		required = ca.drv->required;
 	}
@@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	struct conv_attrs ca;

 	convert_attrs(&ca, path);
-	if (ca.drv) {
+	if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {
 		filter = ca.drv->smudge;
 		required = ca.drv->required;
 	}
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 718efa0..56e385c 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -252,4 +252,18 @@ test_expect_success "filter: smudge empty file" '
 	test_cmp expected filtered-empty-in-repo
 '

+test_expect_success 'disable filter with empty override' '
+	git config filter.disable.smudge false &&
+	git config filter.disable.clean false &&
+
+	echo "*.disable filter=disable" >.gitattributes &&
+
+	echo test >test.disable &&
+	git -c filter.disable.clean= add test.disable 2>err &&
+	! test -s err &&
+	rm -f test.disable &&
+	git -c filter.disable.smudge= checkout -- test.disable 2>err &&
+	! test -s err
+'
+
 test_done
--
2.5.1
