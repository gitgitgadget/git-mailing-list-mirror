Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D919DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiCJBde (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiCJBdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:33:33 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D8D5F
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:32:33 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6DD117A48F;
        Wed,  9 Mar 2022 20:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TgoeNeDODJLap6PdWgjd/l+OmTPIIAYN+WHsYy
        RNs5g=; b=WrT5JRKu6cva2V9zHTbint/IhzTlwdvWO3BL0Pcdplh/7mJS9Vb+vx
        iX8kb/MGXh2ZMyJjG9SVPx+91pG8OitTtj9qOmlcCeiSK/qenmi1eMIbwV3KR1rL
        8eEYaH9OKHQKD5EXf1ZET6YvJuJF1QxPBEwZXSi1FUkDeowKsSttk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF64B17A48E;
        Wed,  9 Mar 2022 20:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E06B17A48C;
        Wed,  9 Mar 2022 20:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] name-rev: use generation numbers if available
References: <20220310000550.2368737-1-jacob.e.keller@intel.com>
        <xmqqilsmir41.fsf@gitster.g>
Date:   Wed, 09 Mar 2022 17:32:29 -0800
In-Reply-To: <xmqqilsmir41.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        09 Mar 2022 16:33:02 -0800")
Message-ID: <xmqqa6dyiocy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3ABC438-A011-11EC-8450-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
>> +	test_config -C non-monotonic core.commitGraph false &&
>
> Don't you mean "true" here?
>
>> +	(
>> +		cd non-monotonic &&
>> +
>> +		echo "main~3 tags/D~2" >expect &&
>> +		git name-rev --tags main~3 >actual &&
>> +
>> +		test_cmp expect actual
>> +	)
>> +'

And I am not sure if there is anybody _writing_ the graph file in
the first place, so perhaps squash this in?

 t/t6120-describe.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 0b18f73779..9a35e783a7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -503,10 +503,12 @@ test_expect_success 'non-monotonic commit dates setup' '
 '
 
 test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
-	test_config -C non-monotonic core.commitGraph false &&
+	test_config -C non-monotonic core.commitGraph true &&
 	(
 		cd non-monotonic &&
 
+		git commit-graph write --reachable &&
+
 		echo "main~3 tags/D~2" >expect &&
 		git name-rev --tags main~3 >actual &&
 
-- 
2.35.1-744-g1f8f0331bc

