From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/2] trailer: support multiline title
Date: Wed, 26 Aug 2015 04:51:01 +0200
Message-ID: <1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 04:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUQpk-0004Ii-1j
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 04:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863AbbHZCw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 22:52:59 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34334 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbHZCw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 22:52:58 -0400
Received: by pabzx8 with SMTP id zx8so53495131pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z+HL0AweL06MIgBPgVJ6S4SOnBtlW3TYhkxhPxqPRps=;
        b=qJrhSYwa8rYg61qnMjm1HVJ6y2wDaWak8oKD28R5avPA8vi/2XXjJuixHtfL4WJhs+
         eBkOoGF37euEh4QaAAaXIpJT24hNkmKgjJ7n2C1en3LMcyV/1XM7yBziBwF47ud0mAWp
         B7JaOhgey8V+iSbQAiOEqtVaeKMVAy1xuRvxFzAoFvdcP3YvZFSoH1wlmXcfM2k1wGee
         XlL0LXv+krVEQ+5/HIzgbKDZnymn8fLVl/pXgFGg4Cx+QvYxjPKpseiB2ZMxOUgi7xWA
         qzv6/3EDkrj0EfJIgTdoCWYm01kAusZDpe+K2Z2vX7cl8ZoIJ9JHOpof/JyC8xtS7c54
         CeNg==
X-Received: by 10.69.2.69 with SMTP id bm5mr63137045pbd.41.1440557578054;
        Tue, 25 Aug 2015 19:52:58 -0700 (PDT)
Received: from sahnlpt0215.Home (174-31-129-28.tukw.qwest.net. [174.31.129.28])
        by smtp.gmail.com with ESMTPSA id kv10sm22671617pbc.2.2015.08.25.19.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Aug 2015 19:52:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.5.0.401.g009ef9b.dirty
In-Reply-To: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276593>

We currently ignore the first line passed to `git interpret-trailers`,
when looking for the beginning of the trailers.

Unfortunately this does not work well when a commit is created with a
line break in the title, using for example the following command:

git commit -m 'place of
code: change we made'

In this special case, it is best to look at the first line and if it
does not contain only spaces, consider that the second line is not a
trailer.
---
 t/t7513-interpret-trailers.sh | 14 ++++++++++++++
 trailer.c                     |  8 +++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index b808868..9a54449 100644
--- a/trailer.c
+++ b/trailer.c
@@ -759,7 +759,13 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		return count;
 	}
 
-	return only_spaces ? count : 0;
+	if (only_spaces)
+		return count;
+
+	if (contains_only_spaces(lines[0]->buf))
+		return 1;
+
+	return count;
 }
 
 /* Get the index of the end of the trailers */
-- 
2.5.0.401.g009ef9b.dirty
