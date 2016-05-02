From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule init: redirect stdout to stderr
Date: Mon,  2 May 2016 15:24:04 -0700
Message-ID: <1462227844-10624-4-git-send-email-sbeller@google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue May 03 00:24:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axMGQ-0003oe-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbcEBWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 18:24:20 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33634 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbcEBWYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 18:24:17 -0400
Received: by mail-pa0-f52.google.com with SMTP id xk12so1018686pac.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTytx0Vh4/26P3KgUeR0TlokNHk1ZunPHG8M2hpArG4=;
        b=LjF1QnWhTqN4ZOJnbLwOzVf9G2mRzoRCLK3N3LplzqskFWI4R2jySodWI2sHcS3vCH
         9f4g3P8kw3HETBm0fRtMNv132+AOYPnXTRv6jpWAGTMyrdKy8EqKzC+p+qOVmKEc7CO7
         prkRFUESRe3Vmkb8ihE6VU2QzpWi7uwJQxkNqXXQjbgE1PTtpOEQ1OZBuHN3MyAGCxYS
         Vu8WEjePIoOdWDEQFYOQQRNNf5tzWUbOG24GzoiNlkrMt6nNmoRDY6DzUD8R+Lwb/lCH
         v2Osvi/sIdGpBAOkhhPWC9kRR/fUcsFs3GsBiARb0VanNdInVM4RRlt0TKYuILslQXcA
         Cbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTytx0Vh4/26P3KgUeR0TlokNHk1ZunPHG8M2hpArG4=;
        b=FOyagKVMYqPFrxp9CkCvAlt3ReOUQFG3TB1/iLN0W6nq2xSggR0Ci1IR7OvExs27oS
         mIILZDBJ/DvDAfG8hBbFWrAmt8ah+uKt5xGAQZS9UlaEq6TxJOXSHHmkIB5joLV4q3bv
         dwkioegjdL032hQ/mIx1VSGRxrElhAkm0i7w2S6vEeqadoyYuEbipLH0M4FF8BYPB4o1
         rsC9M0VPDgJaS11RxiCFV7myTnbUWE7fuTEovwcwhZI5mYKWDGcausUjjuByofoar7ML
         3d/Hy6T1CqlJEDDiM5qGPlnsaG8YVnNpU9cgvmA3Tt+QhmTZbkLX+rGJ+2oVIJvoHoGY
         E7Vg==
X-Gm-Message-State: AOPr4FV7DfvfDAJBcyYui5thrfpokMggjDB+ifdJ3qa9hQqEyz0+eSk9dklWr6U58BSLEdKo
X-Received: by 10.66.229.33 with SMTP id sn1mr55430635pac.49.1462227856377;
        Mon, 02 May 2016 15:24:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9831:74f0:67fd:61ba])
        by smtp.gmail.com with ESMTPSA id dr4sm288348pac.11.2016.05.02.15.24.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 15:24:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.37.gb114fff.dirty
In-Reply-To: <1462227844-10624-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293297>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

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
2.8.0.37.gb114fff.dirty
