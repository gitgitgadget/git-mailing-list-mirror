From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/2] trailer: ignore first line of message
Date: Wed, 26 Aug 2015 04:51:00 +0200
Message-ID: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 04:52:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUQpS-00043g-FW
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 04:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbbHZCwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 22:52:42 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34011 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbHZCwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 22:52:41 -0400
Received: by pabzx8 with SMTP id zx8so53487815pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 19:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XLZuXLKgV0y6X+M9wXKekRhbTdTaM0fgB0w7RYL91ZE=;
        b=Ry8TGA8v6KZLLuhfsIzk6sSaTQgXrA/WMjE59ton9dtAXqkEprZtFSCe78dv4nS2iR
         L1KBsqQI1J1nFi9lake0AbIsMwm8DOPloGbG4QlSbccsIpogpEU1maBm4YFTwxwI1Ayo
         HHutpzcDJaBwrH7n6GSf8PQ8ubereWKy+WvoY8O533GvGArPPwRYuikKF5sxLVWDF9k3
         u4rdB/yX63MWHPp03VcJWjeGWXfg3FGO1zLwZr4sUlZsGloabfSh2pMZ7Uticp0cw6Cp
         DhfZG3iy7Ebq3yFT04sKvdxznVW1LSutLoETUpm3PmglXizFSEMRQEiAKKxPGcxA+SuE
         1A+Q==
X-Received: by 10.68.136.234 with SMTP id qd10mr64534022pbb.162.1440557560902;
        Tue, 25 Aug 2015 19:52:40 -0700 (PDT)
Received: from sahnlpt0215.Home (174-31-129-28.tukw.qwest.net. [174.31.129.28])
        by smtp.gmail.com with ESMTPSA id kv10sm22671617pbc.2.2015.08.25.19.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Aug 2015 19:52:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.5.0.401.g009ef9b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276592>

When looking for the start of the trailers in the message
we are passed, we should ignore the first line of the message.

The reason is that if we are passed a patch or commit message
then the first line should be the patch title.
If we are passed only trailers we can expect that they start
with an empty line that can be ignored too.

This way we can properly process commit messages that have
only one line with something that looks like a trailer, for
example like "area of code: change we made".
---
 t/t7513-interpret-trailers.sh | 15 ++++++++++++++-
 trailer.c                     |  4 +++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index bd0ab46..9577b4e 100755
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
 
+test_expect_success 'with only a title in the message' '
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
index 4b14a56..b808868 100644
--- a/trailer.c
+++ b/trailer.c
@@ -740,8 +740,10 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	/*
 	 * Get the start of the trailers by looking starting from the end
 	 * for a line with only spaces before lines with one separator.
+	 * The first line must not be analyzed as the others as it
+	 * should be either the message title or a blank line.
 	 */
-	for (start = count - 1; start >= 0; start--) {
+	for (start = count - 1; start >= 1; start--) {
 		if (lines[start]->buf[0] == comment_line_char)
 			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
-- 
2.5.0.401.g009ef9b.dirty
