Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E309D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 05:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeHMHvs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 03:51:48 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:46103 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbeHMHvs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Aug 2018 03:51:48 -0400
Received: from mxback16j.mail.yandex.net (mxback16j.mail.yandex.net [IPv6:2a02:6b8:0:1619::92])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 27877185EEC
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 08:11:10 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback16j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NYB6qH4NfF-BAV49nRK;
        Mon, 13 Aug 2018 08:11:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1534137070;
        bh=OF7ZcV9FvEjAKa5/bREagWHIaligpBREvrpDTeBv0KM=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=KoCs0/R2eW1/zbcRzBY5M+Y+fbD2lDdqe5l3/ysd52q/yCInu9rCqGQuX41LUJTIb
         nwP2EDu1NCZZ0tSJd0s0JnlL/aUrols4xaztHAFs8qQOjjldezn9L66tcaAF/xZ8Pm
         vHk9wb3Xw2HuOEfK+gdHbnH3LkXhC4A6SOUaU49U=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id v5WgjwzSlm-B9sKhIMG;
        Mon, 13 Aug 2018 08:11:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1534137069;
        bh=OF7ZcV9FvEjAKa5/bREagWHIaligpBREvrpDTeBv0KM=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=j5qQSG5frrBrzq9y04e2G8bVoM/SUJTTFHtAdmemxVWqz477Ypeu+vGoyoLJvgzO5
         AzDpQmSiShT5jbqULEb7+85u8BQM4rPeXYHgtT3ME4ylRYCHsGAUm/PpdYDNu1v7IX
         HU6iYsNuti/+yRrzJ46mKymdg1SzbX7ADVwUSZj0=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@ya.ru
From:   Nicholas Guriev <guriev-ns@ya.ru>
To:     Git List <git@vger.kernel.org>
Cc:     Nicholas Guriev <guriev-ns@ya.ru>
Subject: [PATCH] mergetool: don't suggest to continue after last file
Date:   Mon, 13 Aug 2018 08:09:29 +0300
Message-Id: <20180813050929.5531-1-guriev-ns@ya.ru>
X-Mailer: git-send-email 2.18.0.547.g1d89318.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This eliminates an unnecessary prompt to continue after failed merger.
The patch uses positional parameters to count files in the list. If only
one iteration is remained, the prompt_after_failed_merge function is not
called.

Signed-off-by: Nicholas Guriev <guriev-ns@ya.ru>
---
 git-mergetool.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index c062e3d..d07c7f3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -491,14 +491,16 @@ main () {
 	printf "%s\n" "$files"
 
 	rc=0
-	for i in $files
+	set -- $files
+	while test $# -ne 0
 	do
 		printf "\n"
-		if ! merge_file "$i"
+		if ! merge_file "$1"
 		then
 			rc=1
-			prompt_after_failed_merge || exit 1
+			test $# -ne 1 && prompt_after_failed_merge || exit 1
 		fi
+		shift
 	done
 
 	exit $rc
-- 
2.7.4

