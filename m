Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A4C6FA8F
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 00:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjH3Aqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjH3Aqi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 20:46:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDDCC9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 17:46:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 870B8195068;
        Tue, 29 Aug 2023 20:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nMmKRRJ13UJ5sXC8al9YVRGbli3kgWadkLojtF6VmKk=; b=Ip2Y
        B2YTGIsiZXRjhNm87aIlEbtfZgERWQcRH1e7C5a8sKmVOAITQ8a/+Q7PflF5rqMZ
        92Ux6ufv4qObBZkwRT4JKwBfoP3Zor+3BZgYoNxMtUBzDtlI2/691/3k/9qpkAWp
        xVn+tQYnK8K2O+4r+Zs6CbOfHMTBaPRBeJ637qc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D6E8195067;
        Tue, 29 Aug 2023 20:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB65B195063;
        Tue, 29 Aug 2023 20:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] send-email: prompt-dependent exit codes
References: <xmqq5y5msmc0.fsf@gitster.g>
        <20230821170720.577835-1-oswald.buddenhagen@gmx.de>
Date:   Tue, 29 Aug 2023 17:46:32 -0700
Message-ID: <xmqq3501bbmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAE12C42-46CE-11EE-9BFE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Proposed content for RelNotes:
>
>  * "git send-email" now reports interactive cancellation via a distinct
>    non-zero exit status. Callers which do not consider this situation an
>    error need to be adjusted.

If we still want to deliberately break folks with this change, we
should not blame users for becoming accustomed to the traditional
behaviour and pretend as if burdening them to change their scripts
is within our rights.  We should be a lot more apologetic in the
backward compatibility notes than what you wrote in the above.

Having said that, quite honestly, I do not think this new behaviour
deserves to be a new default from the day one, with need for an
apology to existing users by the project.  Given that the users have
lived with the current behaviour practically forever in Git's
timescale and that not changing the default and letting them "live
with" the status quo cannot cause any serious problem, I cannot
stand behind such a default change myself.  It should be a new
feature that is opt-in, just like any other new and useful feature..

By the way, I just noticed that the test will not pass on BSD
derived systems.  Something like this need to be squashed in if we
want to proceed further.

--- >8 --- squash --- >8 ---
Subject: [PATCH] SQUASH???

Sending "wc -l" output to a file and expecting that it has a run of
digits with terminating newline and nothing else is prone to break
on BSD derived systems, including macOS.
---
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64f9c7c154..8323783963 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1198,7 +1198,7 @@ test_confirm_many () {
 		-2 <replies
 	echo $? >exit_sts
 	test_cmp expected_sts exit_sts || return 1
-	ls commandline* 2>/dev/null | wc -l >num_mails
+	echo $(ls commandline* 2>/dev/null | wc -l) >num_mails
 	test_cmp expected_num num_mails || return 1
 }
 
-- 
2.42.0-81-g1a190bc14a

