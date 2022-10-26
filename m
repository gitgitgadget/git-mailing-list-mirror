Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A6C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 08:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiJZIcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZIcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 04:32:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D819E52DF5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 01:32:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 96BA02204E
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666773133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VWiTVkUqpZthvabh2Pnh84yHxgYetgFpchI+U/SJ0CU=;
        b=pYoz3RyEHEPY/cCLhQ4aomu3AE7FUUm+Gu+ItsPOgjFlWKdJAM0cfAMW43wrpdTFv5s3o9
        nQCI2gBtOtcRoOZuJMlXQbIPIgQS+9cImsFzQurr2kn/Rv1fhrwAbVSOBnuAPOlICttRHx
        up7Tci+lSoUkNPyN7udStz8RzRXdlRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666773133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VWiTVkUqpZthvabh2Pnh84yHxgYetgFpchI+U/SJ0CU=;
        b=8FlE3gOGpQx19XYvUEvHrJbaeWwJQOdnUmqa48SlTI3tKTgz2KSjQjAiy4QaCNe6tecY9v
        ZNKwFBhB9VzSQYCw==
Received: from naga.suse.cz (unknown [10.100.224.114])
        by relay2.suse.de (Postfix) with ESMTP id 747FB2C142;
        Wed, 26 Oct 2022 08:32:13 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     git@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] apply: Allow creating files with git patches
Date:   Wed, 26 Oct 2022 10:32:04 +0200
Message-Id: <20221026083204.21333-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git 2.38.0 it is not possible to create a file with apply when the diff
looks like git diff.

It either complains that the source file is not /dev/null or that it is
not the same as the destination.

something.patch
No author found in something.patch
---
Sometext

Author: A. U. Thor <au@thor.com>
gitdiff_verify_name: line: b/somefile.c
@@ -0,0 +1,379 @@
+/*
...
, isnull: 0, *name: somefile.c, side: 1, another: (null)
error: git apply: bad git-diff - inconsistent new filename on line 80

something.patch
No author found in something.patch
---
Sometext

Author: A. U. Thor <au@thor.com>
gitdiff_verify_name: line: a/somefile.c
+++ b/somefile.c
@@ -0,0 +1,379 @@
+/*
...
, isnull: 1, *name: (null), side: 0
error: git apply: bad git-diff - expected /dev/null on line 80

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 2b7cd930ef..9dd01da271 100644
--- a/apply.c
+++ b/apply.c
@@ -928,7 +928,7 @@ static int gitdiff_verify_name(struct gitdiff_data *state,
 			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 				     *name, state->linenr);
 		another = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
-		if (!another || strcmp(another, *name)) {
+		if (another && strcmp(another, *name)) {
 			free(another);
 			return error((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-- 
2.38.0

