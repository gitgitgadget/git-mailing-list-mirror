From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/15] submodule init: redirect stdout to stderr
Date: Tue, 26 Apr 2016 13:50:24 -0700
Message-ID: <1461703833-10350-7-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wk-0006WI-51
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbcDZUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:54 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33286 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcDZUux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:53 -0400
Received: by mail-pf0-f181.google.com with SMTP id 206so11460288pfu.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vT7PbsaKiJNY0l9y5zHDLC1Vrdn4D7lvYStpA6o7eXI=;
        b=hGnDFAigcgx4IJwfDD9ull8d4iHg8dWeSlgMheI4wyBzosEuBkCf30kRpXnAbBX4MS
         zxZXWVEW46FU4JnqRmWPvthHSpWHxWF1LzJXAS1U+48OWJdojf4qQ2zyA2FlmcfqZd/s
         Q6syj5AEaxFw3U63T0T7ovOEB0EXn7qbeVgk5Mbw/AK7OF8BCQCETrcpaH3LUtUwoc5z
         LxMlSLdm952O0RZptiL9jYipejc7rQm1CMdmvMYB1iq79E8ub1SkBZaBWEUQTZ/0ALIb
         nlyCiTo0LmyX94xLDYEML3zRtLfA3ahGV8WHBqMZit9QAgu/5l/gpIL+jf6xVehSUoe5
         YZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vT7PbsaKiJNY0l9y5zHDLC1Vrdn4D7lvYStpA6o7eXI=;
        b=bOifG7/Vm10U2JHF+gUu5BTk3M6Hb8a+mNEQbBgdhMqahP1VWlny4zdiY4apeCvPpl
         VP21SJXk+QSikGs3PhXX7hYyoBwxvUki/Uc+Fd6592P/5pt2QPS71fZMk+dFMMVcAVOY
         xcO+DOgxmhfOp3iQao4S00typDboB3owZi9rehZpXaFE9yYu3mABMGEHBZ/s/cISxBjZ
         cRqYhA/83CV7c+dkqT84WPWYPNFFgcuCODCfl4UybICRDlF87Y3pdyISnWy/Xeu/dnHO
         PQOF8PG7mUpEtt7iq4VNZ4STl5UUS93GNm6+YahFf0z5nTi2v3Y3tgMbnBKbTj0oHy0w
         kVWw==
X-Gm-Message-State: AOPr4FWjm0aiyLIcWS1uZMTqdzc2S4lvWVUEo+KAB62XKvIO2Lw7/nx3z3HZ98jpycttV5fe
X-Received: by 10.98.52.195 with SMTP id b186mr6600392pfa.9.1461703852385;
        Tue, 26 Apr 2016 13:50:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id 71sm487651pfy.32.2016.04.26.13.50.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292667>

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
index 23d7224..7b9a4d7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -362,7 +362,8 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
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
2.8.0.41.g8d9aeb3
