From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3] trailer: support multiline title
Date: Sun, 30 Aug 2015 21:14:40 +0200
Message-ID: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:16:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW85g-0004t1-J7
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 21:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbbH3TQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 15:16:29 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36365 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbbH3TQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 15:16:28 -0400
Received: by wicfv10 with SMTP id fv10so45562052wic.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LOVMK/W2lPVfFEjdaXp/lauP3uBqi/YmwJZES+8wUHs=;
        b=hQMOMA3Q4POe2xgY2QnMG/Z5gjB3HByxPFDX12TnV1EC39wFnsfoxjl8haK48rP4t6
         r6j3zkoqLWYGYx4pi1iOEuSXALEGXvD/CP9OfbYIeWTU0izqC4pJ+iVP2G5dyY9PEjYa
         fMOKQHwrzDgOdgKhbBDDXgc//xdeQlSeNlRGlUyAM0BfX4yk1Oi88HmmZFEJsDY84H8a
         xWdyfIOyAt7Oud+FrGUTQbleF3cDBpMRaKfXN2SfzppVguugDzpJ3X/fvXBDA61XhHTk
         vcjsfTFPlBFxFZiqRGzltpj1SsmHupNYVhVB/pO9AUsDyMULotjNFmFzxAiqbsglLFjT
         1eZw==
X-Received: by 10.180.105.74 with SMTP id gk10mr15010251wib.92.1440962187479;
        Sun, 30 Aug 2015 12:16:27 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id l17sm3628342wjr.18.2015.08.30.12.16.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2015 12:16:26 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.5.0.402.gcabd5e3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276832>

We currently ignore the first line passed to `git interpret-trailers`,
when looking for the beginning of the trailers.

Unfortunately this does not work well when a commit is created with a
line break in the title, using for example the following command:

git commit -m 'place of
code: change we made'

That's why instead of ignoring only the first line, it is better to
ignore the first paragraph.
---
 t/t7513-interpret-trailers.sh | 14 ++++++++++++++
 trailer.c                     | 15 +++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 9577b4e..56efe88 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -112,6 +112,20 @@ test_expect_success 'with only a title in the message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with multiline title in the message' '
+	cat >expected <<-\EOF &&
+		place of
+		code: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "%s\n%s\n" "place of" "code: change" |
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index b808868..6f3416f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -735,15 +735,22 @@ static int find_patch_start(struct strbuf **lines, int count)
  */
 static int find_trailer_start(struct strbuf **lines, int count)
 {
-	int start, only_spaces = 1;
+	int start, end_of_title, only_spaces = 1;
+
+	/* The first paragraph is the title and cannot be trailers */
+	for (start = 0; start < count; start++) {
+		if (lines[start]->buf[0] == comment_line_char)
+			continue;
+		if (contains_only_spaces(lines[start]->buf))
+			break;
+	}
+	end_of_title = start;
 
 	/*
 	 * Get the start of the trailers by looking starting from the end
 	 * for a line with only spaces before lines with one separator.
-	 * The first line must not be analyzed as the others as it
-	 * should be either the message title or a blank line.
 	 */
-	for (start = count - 1; start >= 1; start--) {
+	for (start = count - 1; start >= end_of_title; start--) {
 		if (lines[start]->buf[0] == comment_line_char)
 			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
-- 
2.5.0.402.gcabd5e3.dirty
