From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] t4200: rerere a merge with two identical conflicts
Date: Mon, 14 Sep 2015 16:57:29 -0700
Message-ID: <1442275050-30497-7-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:57:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbdd9-0006Sk-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbbINX5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:47 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36010 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbINX5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:40 -0400
Received: by padhk3 with SMTP id hk3so157175095pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Av/ZbjaMCcLk8iRmd/OX41n5UHEVVL6lMW9oDw0xLS4=;
        b=lA2uc9VXs6jF3Q4NRDox91GQEKu2kfr2+niOShbnwKNpUYac/4TqnL/ObDF4bHCqb8
         VuJvDyekvAz3sSqcELCJlLCOxbxrrX16eo1Qp9UaYy9wbw9Xn28F1BebDhnaBLGzOHBG
         mNeWLmzln5YekO4aya5YHohchf4TKI4ue1slT6qazHzSWG8w3nrGS64Wk/6pc7bncFSR
         0R+8f5rHiX8QCuOevWQ+OqFuq1WIpTut0Okj66GfLPrMg7k49GlcZVL9E0cQuYX4Y/Ug
         bDCbd/fxOY3/IujFn8TvQf9wRhCk+AKuuHWUllWTKWqtyMdSc6DfG+ooev5EOA9vnLMh
         Cm1w==
X-Received: by 10.69.2.69 with SMTP id bm5mr39818665pbd.41.1442275059895;
        Mon, 14 Sep 2015 16:57:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id je5sm7148868pbd.79.2015.09.14.16.57.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:39 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277883>

When the context of multiple identical conflicts are different, two
seemingly the same conflict resolution cannot be safely applied.

In such a case, at least we should be able to record these two
resolutions separately in the rerere database, and reuse them when
we see the same conflict later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4200-rerere.sh | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 52a8e09..8d52854 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -407,4 +407,78 @@ test_expect_success 'rerere -h' '
 	test_i18ngrep [Uu]sage help
 '
 
+concat_insert () {
+	last=$1
+	shift
+	cat early && printf "%s\n" "$@" && cat late "$last"
+}
+
+test_expect_failure 'multiple identical conflicts' '
+	git reset --hard &&
+
+	test_seq 1 6 >early &&
+	>late &&
+	test_seq 11 15 >short &&
+	test_seq 111 120 >long &&
+	concat_insert short >file1 &&
+	concat_insert long >file2 &&
+	git add file1 file2 &&
+	git commit -m base &&
+	git tag base &&
+	git checkout -b six.1 &&
+	concat_insert short 6.1 >file1 &&
+	concat_insert long 6.1 >file2 &&
+	git add file1 file2 &&
+	git commit -m 6.1 &&
+	git checkout -b six.2 HEAD^ &&
+	concat_insert short 6.2 >file1 &&
+	concat_insert long 6.2 >file2 &&
+	git add file1 file2 &&
+	git commit -m 6.2 &&
+
+	# At this point, six.1 and six.2
+	# - derive from common ancestor that has two files
+	#   1...6 7 11..15 (file1) and 1...6 7 111..120 (file2)
+	# - six.1 replaces these 7s with 6.1
+	# - six.2 replaces these 7s with 6.2
+
+	test_must_fail git merge six.1 &&
+
+	# Check that rerere knows that file1 and file2 have conflicts
+
+	printf "%s\n" file1 file2 >expect &&
+	git ls-files -u | sed -e "s/^.*	//" | sort -u >actual &&
+	test_cmp expect actual &&
+
+	git rerere status | sort >actual &&
+	test_cmp expect actual &&
+
+	# Resolution is to replace 7 with 6.1 and 6.2 (i.e. take both)
+	concat_insert short 6.1 6.2 >file1 &&
+	concat_insert long 6.1 6.2 >file2 &&
+
+	git rerere remaining >actual &&
+	test_cmp expect actual &&
+
+	# We resolved file1 and file2
+	git rerere &&
+	>expect &&
+	git rerere remaining >actual &&
+	test_cmp expect actual &&
+
+	# Now we should be able to resolve them both
+	git reset --hard &&
+	test_must_fail git merge six.1 &&
+	git rerere &&
+
+	>expect &&
+	git rerere remaining >actual &&
+	test_cmp expect actual &&
+
+	concat_insert short 6.1 6.2 >file1.expect &&
+	concat_insert long 6.1 6.2 >file2.expect &&
+	test_cmp file1.expect file1 &&
+	test_cmp file2.expect file2
+'
+
 test_done
-- 
2.6.0-rc2-164-gdcd5d00
