From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] t3700 (add): add two tests for testing add with submodules
Date: Tue,  9 Apr 2013 14:51:36 +0530
Message-ID: <1365499297-8667-2-git-send-email-artagnon@gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 11:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPUjO-0003jf-AK
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 11:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184Ab3DIJUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 05:20:22 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:48132 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936465Ab3DIJUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 05:20:19 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so162030pbc.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/tHjDrR1RTh0BOUUAkVwy5SPLTR2wp9Q7IITlZP9avk=;
        b=vS03bOM5B6onkjt3n33eEk/glD65HD1BCno9Q1S8KPU3jlNPnL2TJXNuypPc0D4nRH
         J66Ve9Ujai51XWP0iWxS80XL9AQNUvwNcQX9kXwvAxNxrZXt/HUFX0YQcno92khR+urd
         1/XSiyi5kXP+gZOj78gwAaEIcTU5ffWXs1tzIKmHQaudDsi+2I6ceQ8OBvOKHiTDE0i9
         ZUEWz22k23QcJ1JLWmi/Ql+z+WvmjSujECvAZaW5SqsI4WrzUnuUN7Jmaf3AOB7qYS3/
         sy1djaVvEwe+fFKDvBzVNPpE87Rvxj7DQ9bRywlM8iVkfJEqoaH83EA+HYRHUA21Et4s
         w+JA==
X-Received: by 10.68.180.194 with SMTP id dq2mr1480810pbc.175.1365499218994;
        Tue, 09 Apr 2013 02:20:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id mm9sm1484714pbc.43.2013.04.09.02.20.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 02:20:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.347.gdd82260.dirty
In-Reply-To: <1365499297-8667-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220557>

The first test "git add should not go past gitlink boundaries" checks
that paths within a submodule added with 'git submodule add' cannot be
added to the index.  It passes because of treat_gitlink() in
builtin/add.c.

The second test "git add should not go past git repository boundaries"
checks that paths within a git repository in the worktree (not yet
added with 'git submodule add') cannot be added to the index.  It
fails because there is no existing code to check this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3700-add.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 874b3a6..1ad2331 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -310,4 +310,36 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success 'git add should not go past gitlink boundaries' '
+	rm -rf submodule_dir &&
+	mkdir submodule_dir &&
+	(
+		cd submodule_dir &&
+		git init &&
+		git config remote.origin.url "quux" &&
+		cat >foo <<-\EOF &&
+		Some content
+		EOF
+		git add foo &&
+		git commit -a -m "Add foo"
+	) &&
+	git submodule add ./submodule_dir &&
+	test_must_fail git add submodule_dir/foo
+'
+
+test_expect_failure 'git add should not go past git repository boundaries' '
+	rm -rf submodule_dir &&
+	mkdir submodule_dir &&
+	(
+		cd submodule_dir &&
+		git init &&
+		cat >foo <<-\EOF &&
+		Some content
+		EOF
+		git add foo &&
+		git commit -a -m "Add foo"
+	) &&
+	test_must_fail git add submodule_dir/foo
+'
+
 test_done
-- 
1.8.2.1.347.gdd82260.dirty
