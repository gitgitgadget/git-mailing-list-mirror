Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03692C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C670022209
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2RYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 12:24:34 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37824 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 12:24:34 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kuIiu-00C0qs-AH; Tue, 29 Dec 2020 10:23:52 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kuIit-00031H-IJ; Tue, 29 Dec 2020 10:23:52 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 34A34500C94;
        Tue, 29 Dec 2020 10:23:51 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kqKESd4sN2BR; Tue, 29 Dec 2020 10:23:51 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id D7F03500484;
        Tue, 29 Dec 2020 10:23:50 -0700 (MST)
Date:   Tue, 29 Dec 2020 10:23:49 -0700
From:   Seth House <seth@eseth.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <20201229172349.GA17517@ellen>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
 <20201228192919.1195211-5-seth@eseth.com>
 <3eb8c8d9-5b56-82ff-21d8-725a6c269f66@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eb8c8d9-5b56-82ff-21d8-725a6c269f66@kdbg.org>
X-XM-SPF: eid=1kuIit-00031H-IJ;;;mid=<20201229172349.GA17517@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH v9 4/5] mergetool: break setup_tool out into separate
 initialization function
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 09:50:44AM +0100, Johannes Sixt wrote:
> Would it be possible to move the call above the
> `mergetool_tmpdir_init` call, so that nothing has to be rewound?

Ah, I see. Good suggestion. Yes, moving that call higher works just
fine. E.g.:

diff --git a/git-mergetool.sh b/git-mergetool.sh
index a44afd3822..36c1920dd6 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -276,6 +276,8 @@ merge_file () {
 		ext=
 	esac
 
+	initialize_merge_tool "$merge_tool" || return
+
 	mergetool_tmpdir_init
 
 	if test "$MERGETOOL_TMPDIR" != "."
@@ -334,8 +336,6 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	initialize_merge_tool "$merge_tool"
-
 	if automerge_enabled && test "$(
 		git config --get --bool "mergetool.$merge_tool.automerge" ||
 		git config --get --bool "mergetool.automerge" ||

Thanks. I'll roll that change into a v10 patch series later today or
tomorrow to give a little more time for any other feedback.

