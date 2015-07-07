From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 05/12] t4150: am --resolved fails if index has no changes
Date: Tue,  7 Jul 2015 22:08:27 +0800
Message-ID: <1436278114-28057-6-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYl-0005gv-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602AbbGGOJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:07 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36277 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbbGGOJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:05 -0400
Received: by pddu5 with SMTP id u5so39058988pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fjHds5n3WtpNYewitKMMAMqJdSZSLYYxHNBkqrK7Ykw=;
        b=txCWNId2tnYroknb6Co1wu1o9Wb1T/f2Z6MrStHlZerC2OyNolYL9Kz6WxY10P2dOP
         npR8OEg//4ic/l3lO9Q2VnJbWIcfMWg90cg8bVMWbvYowR4/h/9gIhDXv6lTkf3QlnW8
         S79BKk1Q/Dh++fFJF/B95fewYV9Qa2NvBY9C/A0fKYjjAJgXwXuRl3EJbhTpiz+i8lMw
         X7esOEuIjQLapHaSR6EAL6XHXnl2HZn4itAAfu3l50W5l72IdqL7ZUzPKeITCi9nkc1H
         XiIecutflVlEjs18sdIyJOZzYaDQevAHbrfP54VDQPFbKg1AZxSFF2uk7nJm2pyfOWDO
         0Xdw==
X-Received: by 10.66.222.103 with SMTP id ql7mr9228789pac.144.1436278142756;
        Tue, 07 Jul 2015 07:09:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.08.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273512>

Since 6d28644 (git-am: do not allow empty commits by mistake.,
2006-02-23), git-am --resolved will check to see if the index has any
changes to prevent the user from creating an empty commit by mistake.

Add a test for this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index c350967..430ae71 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -425,6 +425,18 @@ test_expect_success 'am --resolved works' '
 	test_cmp expected another
 '
 
+test_expect_success 'am --resolved fails if index has no changes' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout lorem2^^ &&
+	test_must_fail git am lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev lorem2^^ HEAD &&
+	test_must_fail git am --resolved &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev lorem2^^ HEAD
+'
+
 test_expect_success 'am takes patches from a Pine mailbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.76.gf60a929
