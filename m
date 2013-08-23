From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] t3103: demonstrate dir.c:treat_one_path() core.ignorecase failure
Date: Fri, 23 Aug 2013 00:29:14 -0400
Message-ID: <1377232155-7300-2-git-send-email-sunshine@sunshineco.com>
References: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 06:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCj0U-00072z-At
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 06:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab3HWE3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 00:29:41 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33173 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3HWE3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 00:29:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id u16so136195iet.6
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 21:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zUeaeeIO41oGf24Ib/tM8xfL06U4F2hJV7wuthIy2Vw=;
        b=tN5rwiVWtnBsj+ihwqe2jWj0x9hOFnfM6bMVd70j6hL2l5zT9hNZykjsDNS/tSPPyA
         kbFbd8Of0M88ghHDsHyNbJQI1S0UhyZ0VHy8LB0Wk02pP7UJqVMEBuRPTBDo/v1tvODU
         lsbeFK3ooE2mY0cFHXbaGcOHeX7SD+WqKIRafUIhjdGOk1hVkNZf+xD/WaPIIC4ZFKvi
         I5vsDDWQrxg+sPM0zQ3D/l1vQJ3+rBq6q8gbZ6DAMoco++W6xLgv/MT1Y8UhybbUeEsP
         KSN8GJhR2fK6y+Pk6ahlec25J0196VisDWrBHbV7PzJ8uqlk5WoC5jm1BOHFigHmTeSu
         GaMA==
X-Received: by 10.50.50.104 with SMTP id b8mr262275igo.1.1377232180253;
        Thu, 22 Aug 2013 21:29:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id p5sm1090591igj.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 21:29:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.529.g78818d7
In-Reply-To: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232797>

2eac2a4cc4bdc8d7 (ls-files -k: a directory only can be killed if the
index has a non-directory; 2013-08-15) adds a caller of
directory_exists_in_index(dirname,len) which forgets to satisfy the
undocumented requirement that a '/' must be present at dirname[len]
(despite being past the end-of-string). This oversight leads to
incorrect behavior when core.ignorecase is true. Demonstrate this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3103-ls-tree-misc.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 09dcf04..fd95991 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -4,6 +4,7 @@ test_description='
 Miscellaneous tests for git ls-tree.
 
 	      1. git ls-tree fails in presence of tree damage.
+	      2. git ls-tree acts sanely with core.ignorecase.
 
 '
 
@@ -21,4 +22,18 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+test_expect_failure 'ls-tree directory core.ignorecase' '
+	cat >expect <<-\EOF &&
+	d/e/f
+	EOF
+	mkdir d &&
+	>d/e &&
+	git update-index --add -- d/e &&
+	rm d/e &&
+	mkdir d/e &&
+	>d/e/f &&
+	git -c core.ignorecase=true ls-files -k >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.rc4.529.g78818d7
