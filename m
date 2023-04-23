Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3ABC77B73
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 12:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDWM2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDWM2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 08:28:08 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689E1728
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 05:28:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef4d902708so36025586d6.2
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682252887; x=1684844887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1O8CzGZCHV5vKGfF10rVjUovXf/oxdYEKsgBqW2J4k=;
        b=lB2qpW32/IVbwXKmsrkeacxsNI3z9Z14AL5r48zWv1huVQX+UlIdwRxgqDrkfhUZLC
         mRaci/g4EvG5sK7vjsoEVm/6zzDn9MwUH6eP2NY1j8KYUVWLFbQm4OsfapZBh7jyXDh7
         pHqCcihBEyYqYENEcw8oIs0VTfvyvslwpITaaVX/2nxDyXoZoUtJLyt2oP5Wb7Li+Qee
         Jt45cTdAb4sBmyYS14jGc3l0hOYJLXZlpXs/KD2hgRyCYqEqdLgQb20txt0m59Pe96fV
         MM9iiuf/ZPqeWSkyLIlbbblbuZxRzXm0CWr0854n5kxs93M8q0zNf9Ta4gKIWPt1GpFO
         KdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682252887; x=1684844887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1O8CzGZCHV5vKGfF10rVjUovXf/oxdYEKsgBqW2J4k=;
        b=YcSui19nRCqUikMJdXLwEPxqyAu1fYBYzIlFLjxaVF/zSvwWjj+HDgFwWBx65H9ZUc
         +0+nZ4mXZoRIH8qAEIFA95NpzXXmfCQGu+LkBGPHbTsGvszrsBox+gLFaFWJGFasYPq6
         ccHaUHL2ndHD6I+H8B+iUfqAhS4UjwzUnWELO4eV9ZjsPF7f8apzMLSZ6ZKVYyG6AWCd
         hUQIaIw2BmQZVgTcv0T74pD088sc8aPK5ECnXezcNa8RNVZfWSc6grMCZVPWUP16LdS9
         3+QCu5tnuwwVx/tQs9LTid1QqCtUjfLXCdYMQwkNxZHrkdc/QCJDHvS1nn6QgqBFnjJk
         UE/A==
X-Gm-Message-State: AAQBX9fnk+Q+2oIzJD19RR9JEo2zh05p1tiPyt4PcCVXKlwYXbAMh+HE
        zJkAfdueOVkQfdblEYCvXb1xO8UWu+I=
X-Google-Smtp-Source: AKy350bAhNz7mzLbzebc7IJ+fr8tvcBD1ccv3/BsRrH7GUFnhKJgSoGEirUknfVu61BEZ8bo20IE9Q==
X-Received: by 2002:a05:6214:2487:b0:5ef:4565:a441 with SMTP id gi7-20020a056214248700b005ef4565a441mr19116838qvb.13.1682252887000;
        Sun, 23 Apr 2023 05:28:07 -0700 (PDT)
Received: from localhost.localdomain (dsl-141-20.b2b2c.ca. [66.158.141.20])
        by smtp.gmail.com with ESMTPSA id b10-20020a05622a020a00b003e65228ef54sm2827654qtx.86.2023.04.23.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:28:06 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH 1/2] send-email: extract execute_cmd from recipients_cmd
Date:   Sun, 23 Apr 2023 08:27:43 -0400
Message-Id: <20230423122744.4865-2-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactor is to pave the way for the addition of the new
'--header-cmd' option to the send-email command.
---
 git-send-email.perl | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd8cd0d46f..d2febbda1f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2,6 +2,7 @@
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
+# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
 #
 # GPL v2 (See COPYING)
 #
@@ -2006,15 +2007,30 @@ sub process_file {
 	}
 }
 
+# Execute a command (e.g., $x_cmd) and return its output lines as an
+# array.
+sub execute_cmd {
+	my ($prefix, $cmd, $file) = @_;
+	my @lines = ();
+	open my $fh, "-|", "$cmd \Q$file\E"
+		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
+	while (my $line = <$fh>) {
+		last if $line =~ /^$/;
+		push @lines, $line;
+	}
+	close $fh
+	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
+	return @lines;
+}
+
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
 	my ($prefix, $what, $cmd, $file) = @_;
-
+	my @lines = ();
 	my @addresses = ();
-	open my $fh, "-|", "$cmd \Q$file\E"
-	    or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
-	while (my $address = <$fh>) {
+	@lines = execute_cmd($prefix, $cmd, $file);
+	for my $address (@lines) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
@@ -2023,8 +2039,6 @@ sub recipients_cmd {
 		printf(__("(%s) Adding %s: %s from: '%s'\n"),
 		       $prefix, $what, $address, $cmd) unless $quiet;
 		}
-	close $fh
-	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
 	return @addresses;
 }
 
-- 
2.39.2

