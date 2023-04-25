Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF587C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjDYQ1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjDYQ1w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:27:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575333C0A
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:27:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-74adf6adac6so612295585a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682440070; x=1685032070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExOD1zuQlVMzcH2TB4SpjSglrq8X0SSSdYI+5SJaUHU=;
        b=mByY+VMR4UTSzibEcVKY2K2WQIsUhGv4HKNY5Qx6LQNIN+uND92z4GGs06ny6MLpIR
         BvKupHEzsLHK5XDxcbIaFzWx1K0lgLZ7tRLzBFD2MZODP1edF533jZ6eiET3xeDcAh6D
         MsSh3p8EC3V/mtCB6buuMjyvKWjYVISynYGYJrpTUliyFZMMHZa3vQHkmKhU1+8eln2G
         ir2l+484gX+Lm8JY08AXYS/0bT7WFDrs/htQN6L4pNfgUwFlgvk7wGO1EjO+WoNT/Opx
         0Zc14KtEd7b4JIOSqbCnSEZ6qxRQpccbrXxmy4eBlzE/vkA81+HlApJV2w+k5EQugPF4
         lDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440070; x=1685032070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExOD1zuQlVMzcH2TB4SpjSglrq8X0SSSdYI+5SJaUHU=;
        b=BjfcbaogGUesk6o6oSGoetbBsPlL24wIar1wNyCLPqAmO9MyXfQZSPUworynXSAzJG
         gToEw2+h6cbEh5Os4hYJJRtj/lQJz6Vq4yo+uwUx3aHK7IFpx0Ug5ViiWH+KUbOD7DMo
         WpwoMsgol6T3SxfWNm+6VsbDGsFJCfvdkaenVXQ07P50kOMDALfBJgafCfsf65WsNooD
         01d1Rfj0Og5hPjgIsNNaRw2d+sxazhEM96JXqCDBRwfhFwOSenpGGnQXbQYUF+boRBSB
         yjuhrqqP6dl+0ZYAd1q6rDBuNRj+lPAv0MOdQEwkyvuEdcHEzMlkom1fVizdALRA7j6v
         gWog==
X-Gm-Message-State: AAQBX9c2EBMAMpGS2MMkUBnVOY54MxcHGJqapRMAQD8xYeELsk29zpSU
        Zw9k479wjYzV4yztUacafB3B6osTrMo=
X-Google-Smtp-Source: AKy350buJ9ll5+HMiGlZR9ZdVKXIIjmOD6trkN7elLX2lzehxYdYDpIdcQ+34Vpl/9BbyEqxK/7JCA==
X-Received: by 2002:a05:622a:13ce:b0:3ef:4c4b:7e1e with SMTP id p14-20020a05622a13ce00b003ef4c4b7e1emr32391005qtk.29.1682440069914;
        Tue, 25 Apr 2023 09:27:49 -0700 (PDT)
Received: from localhost.localdomain ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id m13-20020ac807cd000000b003ef311b39d7sm4535544qth.96.2023.04.25.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:27:49 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH v2 1/2] send-email: extract execute_cmd from recipients_cmd
Date:   Tue, 25 Apr 2023 12:26:32 -0400
Message-Id: <20230425162631.13684-2-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425162631.13684-1-maxim.cournoyer@gmail.com>
References: <xmqqh6t57x0y.fsf@gitster.g>
 <20230425162631.13684-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactor is to pave the way for the addition of the new
'--header-cmd' option to the send-email command.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---
 git-send-email.perl | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd8cd0d46f..b8d77ad214 100755
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
@@ -2006,15 +2007,29 @@ sub process_file {
 	}
 }
 
+# Execute a command and return its output lines as an array.
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
@@ -2023,8 +2038,6 @@ sub recipients_cmd {
 		printf(__("(%s) Adding %s: %s from: '%s'\n"),
 		       $prefix, $what, $address, $cmd) unless $quiet;
 		}
-	close $fh
-	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
 	return @addresses;
 }
 
-- 
2.39.2

