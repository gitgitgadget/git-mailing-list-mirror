Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761831FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 08:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbcLII6y (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 03:58:54 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36481 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbcLII6y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 03:58:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id x23so1708218pgx.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jG9xnSUTDZuE/mcVvnDV9h6hAirSeg4XdVc+7R15zws=;
        b=DkZicGQwUzomSuE9d/zlWv3rUMWobHQN9YPWxKDdvgfnP1FeruoKOzW1sN5vKU9KIa
         hhBkYMG0q245JJ3PW/8/g8f0rbL10/Bg7ZxYWIeFicagPwbsI1NIydwzS26Ri40sHhut
         0jyDUHmZxMNJhByfP53X0Igwhp4hdq7+lyaC+OdK3aCEvSO+Kz7KkoBJveOAVvHkrX37
         JVYQe4gylvkg5xOtWmGx/iilkvWUSNTPfkdusSNWMrNNfUeReFHN8JiUH3y7Ogr7CAwL
         Le+wOCD5KBD6CwBWoIP8KKMABIUaTiKOPj15eiuix+yiak2h48E8Mzn6pEysUdOslzHK
         XbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jG9xnSUTDZuE/mcVvnDV9h6hAirSeg4XdVc+7R15zws=;
        b=dyXxfqfRREv0KZ/hAjzLn5mmZaMWYHYVYHdC9k7k5DvufqVJjB9EgLSLp2mrCXsKf1
         DSwMPRUiQ/rlm/W8KItUW/0Vm8EJVRL7Pyzllqwc5kZJmp5RyW43f914Lr2+bdUj42zl
         VOKcgh2feKKC1v52F4H0oOspsU6hetMMDkcFtIvOOHJi/j1+dj2FBh2/01wVrx2nIhTZ
         W9H4VBMS02S3kjtx4XTmqU65QH3bLIulCgVK/zkOSoJ343TQ5Rc6Jp+OrqkhDsIgK8mT
         PRG/trHT99w9bGNwF4gkxHJPYPY2tQIxkjv9JcSeyyFLsUsOfJUfz1+ojKmVMd4pVg6D
         sr7w==
X-Gm-Message-State: AKaTC03RHEkWfhUpiAcWDYQP5C0iL46w2xpN6cmk273DPLbEzYY9prYW/TLniLMYW7LxHQ==
X-Received: by 10.99.65.65 with SMTP id o62mr141997739pga.73.1481273933454;
        Fri, 09 Dec 2016 00:58:53 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id o26sm55587687pfk.91.2016.12.09.00.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 00:58:51 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 1/3] difftool: sanitize $workdir as early as possible
Date:   Fri,  9 Dec 2016 00:58:46 -0800
Message-Id: <20161209085848.10929-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.26.gb65c994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The double-slash fixup on the $workdir variable was being
performed just-in-time to avoid double-slashes in symlink
targets, but the rest of the code was silently using paths with
embedded "//" in them.

A recent user-reported error message contained double-slashes.
Eliminate the issue by sanitizing inputs as soon as they arrive.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 959822d5f3..17c336321f 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -224,9 +224,7 @@ EOF
 	delete($ENV{GIT_INDEX_FILE});
 
 	# Changes in the working tree need special treatment since they are
-	# not part of the index. Remove any trailing slash from $workdir
-	# before starting to avoid double slashes in symlink targets.
-	$workdir =~ s|/$||;
+	# not part of the index.
 	for my $file (@working_tree) {
 		my $dir = dirname($file);
 		unless (-d "$rdir/$dir") {
@@ -389,6 +387,7 @@ sub dir_diff
 	my $repo = Git->repository();
 	my $repo_path = $repo->repo_path();
 	my $workdir = $repo->wc_path();
+	$workdir =~ s|/$||; # Avoid double slashes in symlink targets
 	my ($a, $b, $tmpdir, @worktree) = setup_dir_diff($workdir, $symlinks);
 
 	if (defined($extcmd)) {
-- 
2.11.0.26.gb65c994

