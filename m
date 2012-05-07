From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 2/6] tests: add more bash completion tests
Date: Mon,  7 May 2012 03:23:16 +0200
Message-ID: <1336353800-17323-3-git-send-email-felipe.contreras@gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCft-0004IR-2U
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab2EGBXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 21:23:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43046 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab2EGBXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:33 -0400
Received: by wibhq2 with SMTP id hq2so98201wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4NyptJ/v9nI4x6nBlgBTVsf8ggUK/O4fvfQ+xihu6I4=;
        b=L1nVDBeBmhcZmoGC6iES5Yx8kK4WTKrPmdD2QjHozKwnFXYAzINzp4NkmOt6ja09dg
         2loDqCGuZJu2GF/YHyQFW7br3ja409j0XE9cBX/+zf/GQtnkN7KVQgT0OwGdWaCbdFJP
         SX2t8+7EHvmwZAPciKgBX+k1JdOW5oviV/pROPiyJ5UEtmetyc6q1NBFl1hL8BRnz+jl
         8dG5PHc+S7tJgdFZIT+uOWe7PTMm4UxJ7akBQ28K+zRwflGPjGIrtj8az8k2/xs3ZfZx
         iccdWsxI34365UD3aoCI4mjGr1vJAoB2W6AT3V04lGuw3tcFc5N8fUTQQooS+UGHTVBH
         roqA==
Received: by 10.216.134.155 with SMTP id s27mr5484705wei.80.1336353812281;
        Sun, 06 May 2012 18:23:32 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id n20sm28317891wiw.5.2012.05.06.18.23.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197228>

These tests try to excercise code that deals with 'words' and 'cword'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

 t/t9902-completion.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 331a5b9..bb66848 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -158,6 +158,22 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
 
+setup_repository ()
+{
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	test_tick &&
+	git commit --allow-empty -m "Initial"
+	)
+}
+
+test_expect_success 'prepare' '
+	setup_repository one &&
+	git clone one test &&
+	cd test
+'
+
 test_expect_success 'basic' '
 	run_completion "git \"\"" &&
 	# built-in
@@ -240,4 +256,43 @@ test_expect_success 'general options plus command' '
 	test_completion "git --no-replace-objects check" "checkout "
 '
 
+test_expect_success 'remote or refspec' '
+	test_completion "git fetch o" "origin " &&
+	test_completion "git fetch origin m" "master:master " &&
+	test_completion "git pull o" "origin " &&
+	test_completion "git pull origin m" "master " &&
+	test_completion "git push o" "origin " &&
+	test_completion "git push origin m" "master "
+'
+
+test_expect_success 'subcomands' '
+	test_completion "git bisect st" "start "
+'
+
+test_expect_success 'has double dash' '
+	test_completion "git add -- foo" ""
+'
+
+test_expect_success 'config' '
+	git config --file=foo color.ui auto &&
+	test_completion "git config --file=foo --get c" "color.ui "
+'
+
+test_expect_success 'other' '
+	cat >expected <<-\EOF &&
+	origin/HEAD 
+	origin/master 
+	EOF
+	test_completion "git branch -r o" &&
+	test_completion "git bundle cr" "create " &&
+
+	echo foobar > tags &&
+	test_completion "git grep f" "foobar " &&
+
+	test_completion "git notes --ref m" "master " &&
+
+	git tag v0.1 &&
+	test_completion "git tag -d v" "v0.1 "
+'
+
 test_done
-- 
1.7.10
