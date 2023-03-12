Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA94C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCLUJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCLUJa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9304324128
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bk32so8061874oib.10
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bebF08/+RDv/uLWtfqv73JX0ux1QIUq3jA8prI7QtMw=;
        b=ABzagcSnK7OAKrSldoC+LP1TZaiK/XfH35arrjdG5EFwzFXuqBRUJ/q6Sux/NbEZ62
         sYfWMdBHRDJqbCdSwX3D9snxe4Mc7o9T7sNnTdzprQw/t9WT0nmGOgRYFDKmaabTyr3K
         Sg3lGZSrP4L5qkO+gQivXgwA5NRv2kaSAyXCyQDySyjEacZR/cVGL5Izq0BPiUZKRsUs
         Zwl62BjhNIyVGilDvjpEyrskAaDpJVfeYrginhOdPQqxM1QSTJ0KlVquFS+WyAr089h4
         JzKV7fUpcPHs0kItQ5NDfrzlJikTGJlPLdAYU1wf0sje0GIMdEEnJx1xt7SET4tXhsBM
         KtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bebF08/+RDv/uLWtfqv73JX0ux1QIUq3jA8prI7QtMw=;
        b=Drzk+K4bvwYCy7ol1Sz/vIm0qfH8DxB6CbQ+RAlZjzD5uuDFrXlDy2qJiNOlnQDaIo
         B+UapknspGocJYexl5i8mQSkKB5QC64GTLG+jr1nJAkswtVP6zMO9AZtym2P1cMg9t09
         ttvQEos51xTt2XDahKsGg35nBCyxG7I/pheseg9ITkLCL/3GO31kB9zYRiIbWL+ziMNL
         ic6Eu1olHHfW1oLYtq2KWo/X8e7GUC0QWo/YKB0z+TQLZMa2ysANdIzNSyZIGj+Yq/cm
         JBmvAshav8VgcHUK8njdmiOUGNgCZBe4kk1DMqYSgomQm0BVlP/Z1YbPWDaSA1DdPTu4
         rNNw==
X-Gm-Message-State: AO0yUKUf2sq9nmhUdc8f7dse0irtbbbP18Yua7nH4SXXPXfTIr5bu23m
        TR8fFUgUw86C7trIn5WTuFtBHETOPFU=
X-Google-Smtp-Source: AK7set+I3hHaObe57i5a9+t1/vL8tKo4QPbDlsI8n5vO7TK2Q5XXoEZPjhBiU06qUSUGidz2VPwtNQ==
X-Received: by 2002:a05:6808:298a:b0:384:1c31:d10e with SMTP id ex10-20020a056808298a00b003841c31d10emr13997435oib.41.1678651741520;
        Sun, 12 Mar 2023 13:09:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q132-20020acac08a000000b00383b371f2a7sm2368081oif.42.2023.03.12.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:09:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] perf: grep: don't check PRCE twice
Date:   Sun, 12 Mar 2023 14:08:54 -0600
Message-Id: <20230312200856.323688-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230312200856.323688-1-felipe.contreras@gmail.com>
References: <20230312200856.323688-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just set the prereq and let the testing framework check it once.

Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/perf/p4220-log-grep-engines.sh       | 2 +-
 t/perf/p4221-log-grep-engines-fixed.sh | 2 +-
 t/perf/p7820-grep-engines.sh           | 2 +-
 t/perf/p7821-grep-engines-fixed.sh     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/perf/p4220-log-grep-engines.sh b/t/perf/p4220-log-grep-engines.sh
index 03fbfbb85d..2c619a626f 100755
--- a/t/perf/p4220-log-grep-engines.sh
+++ b/t/perf/p4220-log-grep-engines.sh
@@ -30,7 +30,7 @@ do
 			# Poor man's basic -> extended converter.
 			pattern=$(echo $pattern | sed 's/\\//g')
 		fi
-		if test $engine = "perl" && ! test_have_prereq PCRE
+		if test $engine = "perl"
 		then
 			prereq="PCRE"
 		else
diff --git a/t/perf/p4221-log-grep-engines-fixed.sh b/t/perf/p4221-log-grep-engines-fixed.sh
index 0a6d6dfc21..095c5d1765 100755
--- a/t/perf/p4221-log-grep-engines-fixed.sh
+++ b/t/perf/p4221-log-grep-engines-fixed.sh
@@ -20,7 +20,7 @@ for pattern in 'int' 'uncommon' 'æ'
 do
 	for engine in fixed basic extended perl
 	do
-		if test $engine = "perl" && ! test_have_prereq PCRE
+		if test $engine = "perl"
 		then
 			prereq="PCRE"
 		else
diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 9bfb86842a..336424cb00 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -41,7 +41,7 @@ do
 			# Poor man's basic -> extended converter.
 			pattern=$(echo "$pattern" | sed 's/\\//g')
 		fi
-		if test $engine = "perl" && ! test_have_prereq PCRE
+		if test $engine = "perl"
 		then
 			prereq="PCRE"
 		else
diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index 0d75240dae..79b1b9f8b2 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -25,7 +25,7 @@ for pattern in 'int' 'uncommon' 'æ'
 do
 	for engine in fixed basic extended perl
 	do
-		if test $engine = "perl" && ! test_have_prereq PCRE
+		if test $engine = "perl"
 		then
 			prereq="PCRE"
 		else
-- 
2.39.2.13.g1fb56cf030

