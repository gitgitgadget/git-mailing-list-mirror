From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] submodule foreach: correct path display in recursive submodules
Date: Tue, 29 Mar 2016 15:23:43 -0700
Message-ID: <1459290228-9069-2-git-send-email-sbeller@google.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23T-0002JJ-Gm
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbcC2WX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:23:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33654 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753AbcC2WX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:23:56 -0400
Received: by mail-pa0-f49.google.com with SMTP id zm5so24434275pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HKYomCQzTY9cnAP/AEepTvm7sdUzTNrsBVSQrqTdWgU=;
        b=YqFIms/KnzQuEj8VJzkwwB09APgQ2HDHVGMNh8OrO/9ZgCBuCiufpCaGcvuwa1sp6b
         R7+WHKO4isHSkOO//Tk8D0wFGUGMZAqGGvIUxzu51x6y2JiObtcJyGC+uu7RK6zpLaUO
         hJrqdluW1pkJu47sCiliVaRb/CVvBIw6ndaJ4FAcLoOYH8/I97TuPEzq+mK4Dqde8mcH
         P+z1V+NYd0RN0sawXMJPiLcY7Z1bJtuadUu2BeAz057cf1WN+D48MPZU64rjVYGVUlnq
         6yN35X+k5d/RNYFi5NQJY1VVzzDxgPk2K6BG+f6VpX0bSlpt9wW1aGoFu0SKiZkFoew3
         IOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HKYomCQzTY9cnAP/AEepTvm7sdUzTNrsBVSQrqTdWgU=;
        b=EH1ZqtHl1PI8qEj3anlfiaxcdSnXXlmHeit0aQSAlBN0X6tYVkjeO35a5JgJSljbrZ
         OL9vYfoShjIl6fCO3XjqqHZv1RYzArJOkHi6pvT7RNTd9YG9xFhY+NnsByNSlka5mo5Y
         Pr8nvSSzwD+PURCP5q0p4O7vtYtQHSkLhiYiIL3epg99s6KtbXQnr8UwC/rN74FJ9Kdt
         v0IuDJINREoQvALNiTuxOyXPsDF3opQsKmHg9Y7lzkMQqOxBAF6qtv6DNwhT/KHwApcK
         KsX3I4Ip4Og8mPJpePubKE3eVtZKQM3aA5id0lszXalUSfYUurRXmqpiICRBNBLMlbaP
         ASFg==
X-Gm-Message-State: AD7BkJJLdeoJe5ma8BTbKc3zROleh7F9M1Qlwp+9UzGDnLwt2jXdM3IkrEclJF8MN90U0Pgx
X-Received: by 10.66.123.17 with SMTP id lw17mr7415528pab.108.1459290235737;
        Tue, 29 Mar 2016 15:23:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id k88sm691947pfj.0.2016.03.29.15.23.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:23:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290206>

The new test replicates the previous test with the difference of executing
from a sub directory. By executing from a sub directory all we would
expect all displayed paths to be prefixed by '../'.

Prior to this patch the test would report
    Entering 'nested1/nested2/../nested3'
instead of the expected
    Entering '../nested1/nested2/nested3'

because the prefix is put unconditionally in front and after that a
computed display path with is affected by `wt_prefix`. This is wrong as
any relative path computation would need to be at the front. By emptying
the `wt_prefix` in recursive submodules and adding the information of any
relative path into the `prefix` this is fixed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  3 ++-
 t/t7407-submodule-foreach.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..2838069 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -417,10 +417,11 @@ cmd_foreach()
 			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
 			name=$(git submodule--helper name "$sm_path")
 			(
-				prefix="$prefix$sm_path/"
+				prefix="$(relative_path $prefix$sm_path)/"
 				clear_local_git_env
 				cd "$sm_path" &&
 				sm_path=$(relative_path "$sm_path") &&
+				wt_prefix=
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 7ca10b8..776b349 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -178,6 +178,26 @@ test_expect_success 'test messages from "foreach --recursive"' '
 '
 
 cat > expect <<EOF
+Entering '../nested1'
+Entering '../nested1/nested2'
+Entering '../nested1/nested2/nested3'
+Entering '../nested1/nested2/nested3/submodule'
+Entering '../sub1'
+Entering '../sub2'
+Entering '../sub3'
+EOF
+
+test_expect_success 'test messages from "foreach --recursive" from subdirectory' '
+	(
+		cd clone2 &&
+		mkdir untracked &&
+		cd untracked &&
+		git submodule foreach --recursive >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
+cat > expect <<EOF
 nested1-nested1
 nested2-nested2
 nested3-nested3
-- 
2.8.0.4.g5639dee.dirty
