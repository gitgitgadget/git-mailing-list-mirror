Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7521C1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbdL1TKp (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:10:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62586 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751074AbdL1TKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:10:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D7BCA630;
        Thu, 28 Dec 2017 14:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94/hMohCmVEvmVjam5DOf4CyU6E=; b=kl/M+8
        nVNSW3q/Ap51ALLoJyxitZc+gRCHj4vBQp3eECvhDFQw0Ih8e547FTDL0QABI/BY
        0/JFY+NdV0REYMlAikF9MfUk91w53RddPB8gmCJ1cQF3k1GX6GHDhIS7Wd2w2f9i
        0yGvcUvniHHCIkhNGw7I15wO2wOUdtVWQE3U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vblrLP7r6NDpUON0LXXYGNSqAY1ovVey
        a3icmd38fBXi1SeMza4bThfxJpI+ZOFYVslNv3uRhBEdmLJ5ckBOa+d4JODHFZKO
        HvgU26KddyY/Max2Su2ZK3TGAPyrbZOuulQZvYU6kfVfuw7+PaxNVEJDFQHUZPCC
        nE3Yqbef7Rc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 100DDCA62F;
        Thu, 28 Dec 2017 14:10:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81F66CA62E;
        Thu, 28 Dec 2017 14:10:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] dir.c: avoid stat() in valid_cached_dir()
References: <20171228002807.22388-1-pclouds@gmail.com>
        <xmqqd12yllkz.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 28 Dec 2017 11:10:42 -0800
In-Reply-To: <xmqqd12yllkz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 28 Dec 2017 11:05:32 -0800")
Message-ID: <xmqq608qllcd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD3D2F52-EC02-11E7-A318-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  [1] https://public-inbox.org/git/CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com/
>>
>>  dir.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 7c4b45e30e..edcb7bb462 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1809,7 +1809,7 @@ static int valid_cached_dir(struct dir_struct *dir,
>>  	 */
>>  	refresh_fsmonitor(istate);
>>  	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
>> -		if (stat(path->len ? path->buf : ".", &st)) {
>> +		if (lstat(path->len ? path->buf : ".", &st)) {

Hmph, I have to wonder if this is sufficient, though.  When you got
"a/b/c" in path->buf, is it sufficient to avoid mistaking 'c' that
is (eh, rather, "has unexpectedly turned into") a symbolic link to a
directory as a true directory?  Wouldn't we have to be equally careful
about "a" and "a/b" as well?

>>  			invalidate_directory(dir->untracked, untracked);
>>  			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
>>  			return 0;
