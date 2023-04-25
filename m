Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A1BC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjDYSwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjDYSvj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:51:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262A49D8
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:51:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-5eefa0a5561so59806166d6.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448624; x=1685040624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAct69PiTDSb12l0VGXuEjtP4Zgiclim1I0CkY8RaMc=;
        b=rrRd1Dq+aZnGk4YAWWOP7xxsH7vljJdtsKfJdVWdlVhpr8y1NDVky8vJIV0G+5KssR
         EgpKeApFtPGU+GCU/7DCn683DEJ/55B4ilRaY2yDYRMoNG9EZYUKRz+5QM+koC3WuInv
         SajAz9MyPEtMPMryB97XGK8MEOG774R2c5WEm9msnSDdify2/afOyyFKa/2g+MI4+bIE
         MYeQH3dyGeoF4JV+wOAsG4bBKL0a/wVQhRVxEJucqOuBfF9n1VacuaCI3j6PVzCYlm3B
         45Dew1W2fhI71h+981Z7oihUsrzjwmyZvsD3L1tOnMSD0ITW+yKTWBlbsgmHWGEXiiH+
         QIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448624; x=1685040624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAct69PiTDSb12l0VGXuEjtP4Zgiclim1I0CkY8RaMc=;
        b=T+N7rCcu1v5R/EseWabG4IZTX5GeIC0X51ACbqBqSx+eRdk1TTZo7IpN/z3eoJlaN4
         vw7AA8TJCKLRuHZFJaZp95tleM30j2Gqt745HJA2SS6um3Y1Ww3HR0boZ1VtvQqfj+qZ
         aWUAzZusoSgsSaHhc2tCU+I1DEqParMgU2dPmuuu67P5W9y8syaOGk6YXCsxRPQ9izyk
         7hPNBuO0PU2otDqIkWVHVMx9oZVYvFHGSYdM27D7e4Em1qacJSiRdnVbLvhHTDplypUo
         kquuxPm8o42EnTJ8Vp06avoznVDM8HL470DVZnzxealeudhFvdjmEDVamRMY2+CBajR3
         zz2w==
X-Gm-Message-State: AAQBX9f6DS0DlJq1ZgIqp+Ge5W8pbK4+EJ87SZRCrvduTUrXqYf1x0VG
        wDcMSegTOWDdWQhwZVdrZqBm2eFzESo=
X-Google-Smtp-Source: AKy350Yotta6sBETchuHPPHQDfDOXwFbxuP88RtQzzBBbyq8ITo4jAEAK87ChwOtMr/gRkf+HimL4w==
X-Received: by 2002:a05:6214:242a:b0:5f1:5f73:aecd with SMTP id gy10-20020a056214242a00b005f15f73aecdmr37489803qvb.17.1682448624474;
        Tue, 25 Apr 2023 11:50:24 -0700 (PDT)
Received: from localhost.localdomain ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf44b000000b005fd79831ac7sm4050080qvm.84.2023.04.25.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:50:24 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH v3 3/3] send-email: detect empty blank lines in command output
Date:   Tue, 25 Apr 2023 14:50:13 -0400
Message-Id: <20230425185013.14351-4-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425185013.14351-1-maxim.cournoyer@gmail.com>
References: <xmqqcz3s3oz7.fsf@gitster.g>
 <20230425185013.14351-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The email format does not allow blank lines in headers; detect such
input and report it as malformed and add a test for it.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---
 git-send-email.perl   | 12 ++++++++++--
 t/t9001-send-email.sh | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 666b37adc9..5adcbbeb49 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2008,14 +2008,22 @@ sub process_file {
 	}
 }
 
-# Execute a command and return its output lines as an array.
+# Execute a command and return its output lines as an array.  Blank
+# lines which do not appear at the end of the output are reported as
+# errors.
 sub execute_cmd {
 	my ($prefix, $cmd, $file) = @_;
 	my @lines = ();
+	my $seen_blank_line = 0;
 	open my $fh, "-|", "$cmd \Q$file\E"
 		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
 	while (my $line = <$fh>) {
-		last if $line =~ /^$/;
+		die sprintf(__("(%s) Malformed output from '%s'"), $prefix, $cmd)
+		    if $seen_blank_line;
+		if ($line =~ /^$/) {
+			$seen_blank_line = $line =~ /^$/;
+			next;
+		}
 		push @lines, $line;
 	}
 	close $fh
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 230f436f23..6701dd8848 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -445,6 +445,23 @@ FoldedField: This is a tale
 	grep "^FoldedField: This is a tale best told using multiple lines.$" msgtxt1
 '
 
+# Blank lines in the middle of the output of a command are invalid.
+test_expect_success $PREREQ 'malform output reported on blank lines in command output' '
+	clean_fake_sendmail &&
+	cp $patches headercmd.patch &&
+	write_script headercmd-malformed-output <<-\EOF &&
+	echo "X-Debbugs-CC: someone@example.com
+
+SomeOtherField: someone-else@example.com"
+	EOF
+	! git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--header-cmd=./headercmd-malformed-output \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		headercmd.patch
+'
+
 test_expect_success $PREREQ 'reject long lines' '
 	z8=zzzzzzzz &&
 	z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
-- 
2.39.2

