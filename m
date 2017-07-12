Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD47C202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 23:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbdGLXoQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:44:16 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36860 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdGLXoP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:44:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so4715565pgy.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=vMsuGaLkXrN71e8GCHCAoeUo359OWhYAQtobLYs1K+U=;
        b=AnKed9yPFHNOAT4hw65oT/D1yPsDvMv7RnrSJ3fyMBcfIu3Bf9jkibnnKuI5DFFLYm
         Jacz1rukROu60rVr2vJr7Ngh9PgdRZ5gN5964oGaFu9f0dksAvRORvf1yjGvDRN3ep0K
         SgasiapLDuzi4oVmAn7uKf+DOqbZu24raxb/HvwipY7e2pmAe0UKyoqcFPZ/0LfK2Jb+
         DZnUhAEWK+cwLCS6ZRmVCrFVhfT5aqm1xjbxoyFyWqxTbt51AA0RyKmV2UGYj1K6IXuz
         zMGW8linxEpr9GQflFJQ59aA+O4hQDHJum3DAY1JkcRm3z/SvD4FvouDdePrHjpvr2gh
         SIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=vMsuGaLkXrN71e8GCHCAoeUo359OWhYAQtobLYs1K+U=;
        b=fzDjOQmr0bK2hU9f4UPsocnNMnfTQ6THXZ4PXqSr9ztxDjAfsOQcurMCkDwmCOqlTy
         bpODFbtqxcvDC6lS7Wyq7S530GBze2gBSqB0p9KrIJI6HjEDqyCCEdXh/RdvtuRK3lZw
         OweMSFXebqZmcNI/XxOv0I0Gf8ezrUoYDlA9oiXZUHiUbbs9ghVOYJV+mySY6fdzZGmi
         PaAqwkLim013xvU8tyjX4C7VOnsgkcEwO0z/ZEY6t2xK1FHNVPjTGCe5uF/RR98dG2iz
         U1FfaPCPsNM8rDKgD37tiVuvir6srF0HGHS8IfXKSrVecYtP6IqIUpqN3YX0XiMWkNsK
         +REw==
X-Gm-Message-State: AIVw110KfO6Pt71C0tc61l/CX9yapXt1P78nvb0mnV8OPfZBhZbaoVEw
        sOehySZPa1i1mg==
X-Received: by 10.84.215.2 with SMTP id k2mr7089416pli.104.1499903054179;
        Wed, 12 Jul 2017 16:44:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id g7sm7487236pfj.29.2017.07.12.16.44.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 16:44:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Reducing redundant build at Travis?
Date:   Wed, 12 Jul 2017 16:44:12 -0700
Message-ID: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I usually try to stay as late as possible to finish all the
integration branches in order before pushing out the result; it is
more efficient to be able to batch things (for humans).  

I however noticed that This often means we would have multiple build
jobs at Travis for branches and builds on Windows often fails
waiting for its response.  Since I tagged the tip of 'maint', and I
wanted to give all the build a fair chance to succeed without other
build jobs starving it of resources, I pushed out 'maint' and the
tag before others, even though I already have all the other
integration branches ready.

Unfortunately, https://travis-ci.org/git/git/builds/ shows that it
does not care if it spawned a job to build the tip of 'maint' and
another for 'v2.13.3' that point at the same thing.

I do not mind this behaviour terribly for Linux builds that never
seem to time out, but it is wasteful.  Here is what I came up with
to skip the build and test on a branch tip that is tagged, but I
suspect this would not actually work (when told to build a tag, I
suspect that it would try to find an exact-match and ends up finding
itself, refusing to do the work).

I also do not quite like the way that I had to add a check like this
for every script: thing in the .travis.yml file (the attached does
not even cover MacOS whose build tends to take a lot longer).  I
suspect that you or others who are better versed with the system may
have better idea to have a single centralized check that avoids a
tip of a branch that is pointed at by a release tag.

Thanks.

 ci/run-linux32-build.sh | 6 ++++++
 ci/run-windows-build.sh | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e30fb2cddc..ffb5c8fdf1 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -6,6 +6,12 @@
 #   run-linux32-build.sh [host-user-id]
 #
 
+if TAG=$(git describe --exact-match HEAD 2>/dev/null)
+then
+	echo "The tip of the branch is exactly at $TAG"
+	exit 0
+fi
+
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
     apt update >/dev/null &&
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index 2d98f6b2f9..74d4819d74 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -12,6 +12,12 @@ test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
 BRANCH=$1
 COMMIT=$2
 
+if TAG=$(git describe --exact-match "$COMMIT" 2>/dev/null)
+then
+	echo "Tip of $BRANCH exactly at $TAG"
+	exit 0
+fi
+
 gfwci () {
 	local CURL_ERROR_CODE HTTP_CODE
 	CONTENT_FILE=$(mktemp -t "git-windows-ci-XXXXXX")
