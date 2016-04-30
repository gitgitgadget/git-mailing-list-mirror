From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/10] submodule init: redirect stdout to stderr
Date: Fri, 29 Apr 2016 17:40:38 -0700
Message-ID: <1461976845-18228-4-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyG-0006iW-5I
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbcD3AlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:06 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36596 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbcD3AlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:41:04 -0400
Received: by mail-pa0-f42.google.com with SMTP id bt5so51379982pac.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lACD27zKrcEAj8dLUeAnftEi8EZG7pJGEh1g6nCkoj4=;
        b=PK6ZnwZL9D6IWj6s5eJ0F8tX/1n0uFcJdZ851QmGf+e/JkK/rQqwCtoUoHSwHT/wq/
         imsEER9oOlOLjSWJZQz8PKUS0aFEKVThtrOZg3yuQ+1VFFb1YFMvI2k5pra2f2LeyMw9
         EgBUYs/Mw0dbCckZJqyPObYi6N3E+dQ40zc2ru5dczslBTWgh08p6WTT16QmRPqPWFrP
         DUJ2XaEheRNglgsMfF47mtB34zc9845OpNuOWkOsFS4xMnBZViynxpj2DEyq5fqFcrkQ
         SNmCYmAzqY7FznXhlnydc7ooBRbNx3/W4lH29RUy8C75ezhBM5bz3Naq4QSJlJEoSz0B
         r71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lACD27zKrcEAj8dLUeAnftEi8EZG7pJGEh1g6nCkoj4=;
        b=DNpm24ECeHYzI58+LaaQnN6onxpv49D88tpP86hjU0UHRBmWmDiHrg6bgGEbqQFiFq
         BjWqLGn5exuPuOs0gYzkBJurE1Xx1W//z0RVp4zKjJ9uFdp1C4Wgx8giOcmMuy9JhvH6
         XooEMWRJHqh5Oq+eAMqoS/XhKsdZUwKyA2Wz+Lt7NJktZnUWGjxR0gv2w8Vd1V82TD6b
         9mjOgDy4/+7VkJqz2SDt71prHL85wIixqw/++ojAUJUoIbSzH0JltOVns5PlrZKbKZa7
         ayUEMlsgAE4vDB6kONGibRy+8mt3eDj6EeCVLMHVzwtKZklsyE3eFdDehePfCGoLjJ4k
         C83A==
X-Gm-Message-State: AOPr4FXHK2FzR5VLWCkNGoH9UeISXZMXixZoA6f/qAe6g4fgcy4giq3kuSbhLFq/0eltU3Fq
X-Received: by 10.66.138.16 with SMTP id qm16mr33580690pab.28.1461976853612;
        Fri, 29 Apr 2016 17:40:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id e7sm19471737pfa.28.2016.04.29.17.40.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293091>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

We want to init submodules from the helper for `submodule update`
in a later patch and the stdout output of said helper is consumed
by the parts of `submodule update` which are still written in shell.
So we have to be careful which messages are on stdout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c |  3 ++-
 t/t7406-submodule-update.sh | 24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5d05393..7f0941d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -366,7 +366,8 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!quiet)
-			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+			fprintf(stderr,
+				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index fd741f5..5f27879 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -108,24 +108,36 @@ pwd=$(pwd)
 
 cat <<EOF >expect
 Submodule path '../super': checked out '$supersha1'
-Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
-Submodule 'none' ($pwd/none) registered for path '../super/none'
-Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
-Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
 Submodule path '../super/merging': checked out '$mergingsha1'
 Submodule path '../super/none': checked out '$nonesha1'
 Submodule path '../super/rebasing': checked out '$rebasingsha1'
 Submodule path '../super/submodule': checked out '$submodulesha1'
 EOF
 
+cat <<EOF >expect2
+Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
+Submodule 'none' ($pwd/none) registered for path '../super/none'
+Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
+Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
+Cloning into '$pwd/recursivesuper/super/merging'...
+done.
+Cloning into '$pwd/recursivesuper/super/none'...
+done.
+Cloning into '$pwd/recursivesuper/super/rebasing'...
+done.
+Cloning into '$pwd/recursivesuper/super/submodule'...
+done.
+EOF
+
 test_expect_success 'submodule update --init --recursive from subdirectory' '
 	git -C recursivesuper/super reset --hard HEAD^ &&
 	(cd recursivesuper &&
 	 mkdir tmp &&
 	 cd tmp &&
-	 git submodule update --init --recursive ../super >../../actual
+	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
 	) &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_cmp expect2 actual2
 '
 
 apos="'";
-- 
2.8.0.32.g71f8beb.dirty
