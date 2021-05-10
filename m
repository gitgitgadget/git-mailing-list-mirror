Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D7C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BCA613CF
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEJHNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 03:13:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56837 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhEJHNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 03:13:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79ABF14161E;
        Mon, 10 May 2021 03:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hr+Mc9Y8QfB7zj3sf780dyhDv/LAhP0h60qO/2
        9hICo=; b=c9vCeoNfZwxMHYMvfEgrblc+hyq1pU17E83/oOibsGEI5rURvNuQhY
        9u+UN0J2CZH/5bGihpMxFVfuy4D3Etqm72xP47SxxIqznDFmRAIO+DqVB8YVcMur
        +/XegRzMs1rkDvFh7HoyTBaCrBmebR1iKmfdBUM7jDump4TveQAFE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7272514161D;
        Mon, 10 May 2021 03:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAC7A14161B;
        Mon, 10 May 2021 03:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git <git@vger.kernel.org>,
        "Derrick Stolee" <dstolee@microsoft.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH] maintenance: fix two memory leaks
References: <20210509221613.474887-1-lenaic@lhuard.fr>
        <67ed4ca6b15a11eba8d80024e87935e7@oschina.cn>
Date:   Mon, 10 May 2021 16:11:59 +0900
In-Reply-To: <67ed4ca6b15a11eba8d80024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Mon, 10 May 2021 14:38:56 +0800")
Message-ID: <xmqqlf8nqczk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 044E06D6-B15F-11EB-82C7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

>>@@ -1999,6 +2000,7 @@ static int update_background_schedule(int enable)
>> die("unknown background scheduler: %s", scheduler);
>>
>> rollback_lock_file(&lk);
>>+	free(lock_path); 
> Based on your change, I think when "hold_lock_file_for_update()<0", we should also free local_path
> Thanks

Meaning something like this?


 builtin/gc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git c/builtin/gc.c w/builtin/gc.c
index 98a803196b..50565c37c7 100644
--- c/builtin/gc.c
+++ w/builtin/gc.c
@@ -1971,8 +1971,10 @@ static int update_background_schedule(int enable)
 		cmd = sep + 1;
 	}
 
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
-		return error(_("another process is scheduling background maintenance"));
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+		result = error(_("another process is scheduling background maintenance"));
+		goto cleanup;
+	}
 
 	if (!strcmp(scheduler, "launchctl"))
 		result = launchctl_update_schedule(enable, get_lock_file_fd(&lk), cmd);
@@ -1984,6 +1986,9 @@ static int update_background_schedule(int enable)
 		die("unknown background scheduler: %s", scheduler);
 
 	rollback_lock_file(&lk);
+
+cleanup:
+	free(lock_path);
 	free(testing);
 	return result;
 }
