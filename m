From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/8] update-ref: test handling large transactions properly
Date: Sun, 10 May 2015 04:45:30 +0200
Message-ID: <1431225937-10456-2-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 04:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHFs-0001a1-3b
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 04:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbbEJCpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 22:45:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50554 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbbEJCpx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 22:45:53 -0400
X-AuditID: 1207440c-f79376d00000680a-6b-554ec65e4737
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 99.26.26634.E56CE455; Sat,  9 May 2015 22:45:50 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxZ015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:49 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqBt3zC/UYNpDHYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd0bnlJqCPu6KI9c2MzUwLuPsYuTkkBAwkXi0byMThC0mceHeejYQW0jg
	MqPEx70mXYxcQPZxJolNl3ezgCTYBHQlFvU0AzVwcIgIeEm0zSwGqWEW6GWUeLT4FSNIjbCA
	r8TfzbPA6lkEVCV27/kHNpRXwEXi9cL5zBDL5CTOH/8JZnMKuErcPjOXGWKxi0Tj0iaWCYy8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBBjPDsZv62QOMQpwMCrx
	8M7Y4hcqxJpYVlyZe4hRkoNJSZTXZiFQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvyfVAOd6U
	xMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO+FI0CNgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aC4iC8GRgZIigdor81RkL3FBYm5QFGI1lOMilLivHwgCQGQ
	REZpHtxYWNp4xSgO9KUwbyBIFQ8w5cB1vwIazAQ0+G+xD8jgkkSElFQD40LbY2t6ZFWj0jQu
	+l777fDAeWG5uH1BY6lH60HHxYIubnMP3XRiUpB93BV0UkdKe/2LyS9XP3TuOV7KvW6J+MTI
	mZs6lmhtnyN2hV1mdeOJLT3fvql8XrZRadqu5usxe6am2AvLbn2WJ/ru9NEQ28Yf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268716>

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7b4707b..47d2fe9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -973,4 +973,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 32 && "$@")
+}
+
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "create refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	git rev-parse --verify -q refs/heads/33
+)
+'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "delete refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	test_must_fail git rev-parse --verify -q refs/heads/33
+)
+'
+
 test_done
-- 
2.1.4
