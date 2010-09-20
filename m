From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/37] t6020: Add a testcase for modify/delete + directory/file conflict
Date: Mon, 20 Sep 2010 02:28:43 -0600
Message-ID: <1284971350-30590-11-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblF-0006R4-UK
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0ITI1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:55 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0ITI1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:52 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5t6T+juwaGVoM+BAj/BKnhfXdHaDZaGETspLKHOh3i0=;
        b=qVGbrN9VfS5wNlycq/OAUvVWy9qPLVyjp5HJBM9USgFw8ApAZ1NkOpF4L2XguYqnyq
         B/fs8hvPW57NajOU+R4jMbvEVPlk0aqHJhbwHr/SDwptsSyC1liQCAipUAObXhruuoi6
         zJRbMNzTPwnejclkyOLl8RMgemqtkKqyKKD7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nifQ8SIuzVqtUIb+pZkkuaNmmXS78j50mQ1IbFNKFXn+Q6JEYRHmEUcFyz1XLMJjUs
         x9ZKPlg2l1t9NW5cqeLzNyDRzlKx6gzAaFmL9UiL+YI9mw/7kBk66ayxLrQo16ImbSb3
         9ZHwZ/YqZOhJ49ppajGA7d+yFyyEWUT4oyZqw=
Received: by 10.142.141.4 with SMTP id o4mr7334614wfd.314.1284971271896;
        Mon, 20 Sep 2010 01:27:51 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156579>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6020-merge-df.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 8662207..bc9db1a 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -50,4 +50,51 @@ test_expect_success 'F/D conflict' '
 	git merge master
 '
 
+test_expect_success 'setup modify/delete + directory/file conflict' '
+	git checkout --orphan modify &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	printf "a\nb\nc\nd\ne\nf\ng\nh\n" >letters &&
+	git add letters &&
+	git commit -m initial &&
+
+	echo i >>letters &&
+	git add letters &&
+	git commit -m modified &&
+
+	git checkout -b delete HEAD^ &&
+	git rm letters &&
+	mkdir letters &&
+	>letters/file &&
+	git add letters &&
+	git commit -m deleted
+'
+
+test_expect_failure 'modify/delete + directory/file conflict' '
+	git checkout delete^0 &&
+	test_must_fail git merge modify &&
+
+	test 3 = $(git ls-files -s | wc -l) &&
+	test 2 = $(git ls-files -u | wc -l) &&
+	test 1 = $(git ls-files -o | wc -l) &&
+
+	test -f letters/file &&
+	test -f letters~modify
+'
+
+test_expect_failure 'modify/delete + directory/file conflict; other way' '
+	git reset --hard &&
+	git clean -f &&
+	git checkout modify^0 &&
+	test_must_fail git merge delete &&
+
+	test 3 = $(git ls-files -s | wc -l) &&
+	test 2 = $(git ls-files -u | wc -l) &&
+	test 1 = $(git ls-files -o | wc -l) &&
+
+	test -f letters/file &&
+	test -f letters~HEAD
+'
+
 test_done
-- 
1.7.3.271.g16009
