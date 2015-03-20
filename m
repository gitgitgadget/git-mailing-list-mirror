From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/2] test-lib: allow using split index in the test suite
Date: Fri, 20 Mar 2015 22:43:13 +0100
Message-ID: <1426887794-9655-2-git-send-email-t.gummerer@gmail.com>
References: <20150320195943.GB6545@hank>
 <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 22:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4hj-0007Jn-3h
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbCTVn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 17:43:28 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:33988 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbCTVn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 17:43:27 -0400
Received: by wegp1 with SMTP id p1so91793178weg.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+nbliap7KphWB1wKBPTOGgrGR3RTK9tG9Lda1vjWS/o=;
        b=HDSYQO+zOFObumxersWfZKV+FZwKoO4QYckfm8Z6TIqmWr1Yyv0ODLJiFZnWVOQQp2
         +4/v+/6A0ocEnlt/5PgPD1EjUH0AV2fUhpUeoSi7akuGNjNprlStEO/vWryeb7QwtlaW
         M5WvbohjbEWTBDi2+qBiRbZF/MEtwqbG0yGuBlqw2dQq66VoWM/UOT27CVHav3Suk8FW
         +ouDdFoyuO+T6un6aMQVXczm9DSz2T/jRvhRX9nsDDRo+n1wcRci8sxLfQ2MNUqMXdd6
         ujz1M07lG3UpuW4a3ikDh9PH+fee4jeOCCWT//NFJKXt+HCszVDUXiNexyc7LYIs0AtC
         Ku5w==
X-Received: by 10.180.80.9 with SMTP id n9mr8420583wix.34.1426887806525;
        Fri, 20 Mar 2015 14:43:26 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id ew5sm599305wic.14.2015.03.20.14.43.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 14:43:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.264.g0463184.dirty
In-Reply-To: <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265967>

Allow adding a TEST_GIT_TEST_SPLIT_INDEX variable to config.mak to run
the test suite with split index enabled.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile      | 6 ++++++
 t/test-lib.sh | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index 44f1dd1..55e558a 100644
--- a/Makefile
+++ b/Makefile
@@ -339,6 +339,9 @@ all::
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
+# Define TEST_GIT_TEST_SPLIT_INDEX to 1 to run the test suite with split
+# index enabled.
+#
 # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
 # return NULL when it receives a bogus time_t.
 #
@@ -2129,6 +2132,9 @@ endif
 ifdef TEST_GIT_INDEX_VERSION
 	@echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@
 endif
+ifdef TEST_GIT_TEST_SPLIT_INDEX
+	@echo TEST_GIT_TEST_SPLIT_INDEX=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_TEST_SPLIT_INDEX)))'\' >>$@
+endif
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c096778..477f253 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -119,6 +119,12 @@ then
 	export GIT_INDEX_VERSION
 fi
 
+if test -n "${TEST_GIT_TEST_SPLIT_INDEX:+isset}"
+then
+	GIT_TEST_SPLIT_INDEX="$TEST_GIT_TEST_SPLIT_INDEX"
+	export GIT_TEST_SPLIT_INDEX
+fi
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
-- 
2.1.0.264.g0463184.dirty
