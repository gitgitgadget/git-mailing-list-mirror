From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/6] submodule foreach: correct path display in recursive submodules
Date: Tue, 29 Mar 2016 18:27:41 -0700
Message-ID: <1459301266-12403-2-git-send-email-sbeller@google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:27:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4vO-00047S-OL
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbcC3B1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:27:55 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35746 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344AbcC3B1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:53 -0400
Received: by mail-pa0-f54.google.com with SMTP id td3so27045716pab.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+S9KuFT1NrXrnD+bvO7TS2swp72kf2lFH31pL3a7Mh0=;
        b=FuN+DG6Y6+j+U5yIi3NQOE//f742l83JE0U7cM/DjZUdoPyOHIzXijL/+dmDyICcIM
         HsKojGnI6BzPwW50r1UYB5Y9VrdibkGdBIK4SSgEGu7Q48cqPOP/uqGcLUZJsAlI4gCv
         8m+nAfpooWIR+Q+9OCPhELC78Te90Z8rBhuYNV5SI2VyrHi5KjIuHYSwhpo8t3BmSLTg
         70BkJG0hjus1qQut6WnI6kMcWZDLQ9ovEfMFFyDZgi4kq8ugpBNs41LRH4BS28yxdYqY
         P1hjiDQCVBy2AO/oJsYiqTyWlSlqii9xSHDj7GbPdnZMlGZCFfb8yIuF+SqgwkLgEoqc
         SjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+S9KuFT1NrXrnD+bvO7TS2swp72kf2lFH31pL3a7Mh0=;
        b=l/9IMRYlgAsu+bSzfzZCYr9VGgF8lL9ZwsII0jP7c5tnoCinoAgB/cqp6rfHfTnrJv
         O8JupFhG9u+GKwdLCht8umdGDiOrBF4coC8+KkyoI50nw/sFwxiiSureqddNad05MEcF
         D6IzolIugZwd+VQspBNygD09Gybze+kkzmdTIpM3j9CQerShX7LZBO+8sEW9a54a4BLi
         394KRmYuoMAGR12nORfx+uFmlDvT5S5db/y5ZCznh2Ym6vrWytEJLAwDzO7opdXdRSin
         FmRFo9ECUINTi/MKNz1QBuYYTKkO0R9Sts9je+k2ph4vmSmbP+t3yRBVY3dCz3LoJ+eU
         fbEg==
X-Gm-Message-State: AD7BkJKkYUYfsNge5DZhHjOmb3CkzgZtLQKqLY8Vaek/Al8H3kyS08dXnmWP476r4kI3azU7
X-Received: by 10.66.164.39 with SMTP id yn7mr8419910pab.107.1459301272438;
        Tue, 29 Mar 2016 18:27:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id n74sm1132562pfa.45.2016.03.29.18.27.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459301266-12403-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290251>

The `prefix` was put in front of the display path unconditionally.
This is wrong as any relative path computation would need to be at
the front, so include the prefix into the display path.

The new test replicates the previous test with the difference of executing
from a sub directory. By executing from a sub directory all we would
expect all displayed paths to be prefixed by '../'.

Prior to this patch the test would report
    Entering 'nested1/nested2/../nested3'
instead of the expected
    Entering '../nested1/nested2/nested3'

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    * reworded commit message
    * when writing the commit message I discovered a new way to fix the bug
      (fix the computation of the displaypath instead of its parameters
       wt_prefix and prefix.)
    
      The result is the same, but I am not yet sure if I like it more.

 git-submodule.sh             |  6 +++---
 t/t7407-submodule-foreach.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..b3f248c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -413,8 +413,8 @@ cmd_foreach()
 		die_if_unmatched "$mode"
 		if test -e "$sm_path"/.git
 		then
-			displaypath=$(relative_path "$sm_path")
-			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
+			displaypath=$(relative_path "$prefix$sm_path")
+			say "$(eval_gettext "Entering '\$displaypath'")"
 			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
@@ -434,7 +434,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$prefix\$displaypath'; script returned non-zero status.")"
+			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
 		fi
 	done
 }
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
2.8.0.2.gb331331
