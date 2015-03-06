From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is empty
Date: Fri,  6 Mar 2015 16:48:08 +0530
Message-ID: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 12:18:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqHK-0006us-7l
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbbCFLSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 06:18:44 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46770 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbbCFLSe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 06:18:34 -0500
Received: by pabli10 with SMTP id li10so50796848pab.13
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TcGcpdkBR8E2SRjMBbB5ADMhYF9P8ZJThYTRmI8Cq2s=;
        b=ukJmOOxbHjQzVN8OyXhy51FiVrUIHOwi82m4G40DBJ0s5Ra9wGQNj8a/dhBU9hgn/d
         R89wMnb/H8h3K6Ox3Yco2ePj8UShXX9cDzD52VeTC0gzJ5p5xX7fu8IiGAtopDXhZUOQ
         JYzC8fhgsl0TqPmhRQGnDskNMmoEaRUO3ZZYR4TfVhHCc+WFYDrhAIMEIVTa6Vk8h1PW
         P+EIXxqI6tRwvOx/y822EKbMLrn7MyZg3tXQ+m0H5OrYVANfC+Y7qQgbq8xNxNK9xHYK
         b1nd7OKnL0+V+Q1Rp1WrlLiNhVlBzCU5a2JyC9HI6vxQ7qJ8lFcyUW6dpr7Ws2migs7/
         X+9w==
X-Received: by 10.68.98.98 with SMTP id eh2mr24740227pbb.112.1425640713864;
        Fri, 06 Mar 2015 03:18:33 -0800 (PST)
Received: from ashley.localdomain ([182.156.10.227])
        by mx.google.com with ESMTPSA id i3sm9293216pbq.49.2015.03.06.03.18.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2015 03:18:33 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264911>

'git -C ""' unhelpfully dies with error "Cannot change to ''",
whereas the shell treats `cd ""' as a no-op. Taking the shell's
behavior as a precedent, teach git to treat `-C ""' as a no-op, as
well.

Test to check the no-op behaviour of "-C <path>" when <path> is
empty, written by Junio C Hamano.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunchine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 git.c            | 10 ++++++----
 t/t0056-git-C.sh | 10 ++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 8c7ee9c..b062e0e 100644
--- a/git.c
+++ b/git.c
@@ -204,10 +204,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for -C.\n" );
 				usage(git_usage_string);
 			}
-			if (chdir((*argv)[1]))
-				die_errno("Cannot change to '%s'", (*argv)[1]);
-			if (envchanged)
-				*envchanged = 1;
+			if (*(*argv)[1]) {
+				if (chdir((*argv)[1]))
+					die_errno("Cannot change to '%s'", (*argv)[1]);
+				if (envchanged)
+					*envchanged = 1;
+			}
 			(*argv)++;
 			(*argc)--;
 		} else {
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 99c0377..2630e75 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -14,6 +14,16 @@ test_expect_success '"git -C <path>" runs git from the directory <path>' '
 	test_cmp expected actual
 '
 
+test_expect_success '"git -C <path>" with an empty <path> is a no-op' '
+	(
+		mkdir -p dir1/subdir &&
+		cd dir1/subdir &&
+		git -C "" rev-parse --show-prefix >actual &&
+		echo subdir/ >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
 	test_create_repo dir1/dir2 &&
 	echo 1 >dir1/dir2/b.txt &&
-- 
2.3.1.167.g7f4ba4b.dirty
