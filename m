Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B377E207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758495AbdDSC5f (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:57:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752077AbdDSC5e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:57:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40D7182326;
        Tue, 18 Apr 2017 22:57:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q9ofnkh+pSpAbRkNwsL8dAWb3U4=; b=jG7uGw
        KB8RZV+TUUfM7Z8jg5BVDL7LJwxY+cHKTaXl2lvQt6K8Snyh5+JFidxU2z6c5s8F
        jQlXNc/qtzkC0hP7g0x+jN8k5W9hLAGyzmlF4fQ5w7K1z4asdeNxcmfEWBFdjfgC
        XA13M2E4SiqMojiZmnI8TzqOAUm7aVNjaaxVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HKmPqdHGBOzdI4wqBDfb1jfN3ptr+ScG
        ik4bFQJI5gvnGJt238xEnDJ/yrzxKigkwBJ5xmDdW99E4BsAigh+/9/j9GB5bsj2
        Z9vQdCIyefF8kCmdNXB74R5GhfZsS64CUtnYTwEJ0mwuIuUMythNNS0YmnNqWbxx
        aTEqktBfEtw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3975782325;
        Tue, 18 Apr 2017 22:57:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EFDF82324;
        Tue, 18 Apr 2017 22:57:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        l.s.r@web.de
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for gethostname(2)
References: <20170418215743.18406-1-dturner@twosigma.com>
        <20170418215743.18406-2-dturner@twosigma.com>
        <20170419012824.GA28740@aiede.svl.corp.google.com>
Date:   Tue, 18 Apr 2017 19:57:31 -0700
In-Reply-To: <20170419012824.GA28740@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 18 Apr 2017 18:28:24 -0700")
Message-ID: <xmqqzifdayuc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF0C0BA4-24AB-11E7-841A-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -274,7 +278,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>>  			 * running.
>>  			 */
>>  			time(NULL) - st.st_mtime <= 12 * 3600 &&
>> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
>> +			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&
>
> I hoped this could be simplified since HOST_NAME_MAX is a numeric literal,
> using the double-expansion trick:
>
> #define STR_(s) # s
> #define STR(s) STR_(s)
>
> 			fscanf(fp, "%" SCNuMAX " %" STR(HOST_NAME_MAX) "c",
> 			       &pid, locking_host);
>
> Unfortunately, I don't think there's anything stopping a platform from
> defining
>
> 	#define HOST_NAME_MAX 0x100
>
> which would break that.

Yes, that was exactly why I went to the xstrfmt() route when I sent
mine yesterday ;-).

> So this run-time calculation appears to be necessary.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  
