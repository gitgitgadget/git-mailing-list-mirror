Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646D320323
	for <e@80x24.org>; Tue, 14 Mar 2017 06:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750799AbdCNGKe (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 02:10:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64960 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750785AbdCNGKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 02:10:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92B8866FE7;
        Tue, 14 Mar 2017 02:10:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3MkV3GTUF3oW9r5uzdWzos94aJw=; b=iNbkha
        z4+2+vLS3tuvE/uhAi46u+Pfs19Mr2iGzC+o41YqRNp6mRGKPNghtDNUY8Magfu+
        kyHIeu9UGBX5i3vCSMUS9Cwu+7bJhJ5b/gxjTeDPbrKW+mQ19p5C4IRFvx8PtLg5
        LRb5qzZ+TaEUK/FFmPZ9srSDDfH2jr54Tl9WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ouPtXS4uA665bOnIuJfHr5tJp/2Wq8TB
        OhTlPJCxwMPErW4AeJCevaAHVouMaObabPdAwfkUlqvTojhDnrPVZqhNwdToRbmx
        R9EK4q7kwumkqKwAVo5iBKY9e7myTAzqJGrHROILshTW6otgeeWqLH5hMNfgKV6a
        i2qHut5lOko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C5C766FE6;
        Tue, 14 Mar 2017 02:10:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5D5C66FE5;
        Tue, 14 Mar 2017 02:10:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket if a socket
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
        <20170314003246.71586-1-lehmacdj@gmail.com>
        <20170314003246.71586-4-lehmacdj@gmail.com>
        <xmqq8to8lj59.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Mar 2017 23:10:29 -0700
In-Reply-To: <xmqq8to8lj59.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Mar 2017 18:52:18 -0700")
Message-ID: <xmqqo9x4jsmi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED5FC58E-087C-11E7-82B8-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Devin Lehmacher <lehmacdj@gmail.com> writes:
>
>> diff --git a/credential-cache.c b/credential-cache.c
>> index db1343b46..63236adc2 100644
>> --- a/credential-cache.c
>> +++ b/credential-cache.c
>> @@ -83,12 +83,18 @@ static void do_cache(const char *socket, const char *action, int timeout,
>>  	strbuf_release(&buf);
>>  }
>>  
>> +static int is_socket(char *path) {
>> +	struct stat sb;
>> +	int ret = lstat(path, &sb);
>> +	return ret && S_IFSOCK(sb.st_mode);
>> +}
>> +
>>  static char *get_socket_path(void) {
>>  	char *home_socket;
>>  
>>  	home_socket = expand_user_path("~/.git-credential-cache/socket");
>>  	if (home_socket) {
>> -		if (file_exists(home_socket))
>> +		if (is_socket(home_socket))
>
> This should be done as part of 2/3, no?  It does not make sense to
> add 2/3 and then immediately say "oops, the check in 2/3 is wrong,
> and let's update it like so".

Also I think you would want to use S_ISFIFO() and/or S_ISSOCK()
macros (I do not offhand recall which one credential cache daemon
uses), not the S_IFxxx constant.

Perhaps 

   1/3 - add xdg_cache similar to xdg_config

   2/3 - add is_socket()

   3/3 - use xdg_cache location for socket if traditional location
         is not in use

would be a better logical ordering of the patches.

Having said that, I do not think ~/.git-credential-cache/socket is
the right thing to test.  If the ~/.git-credential-cache directory
already exists, it is likely that the user has a set-up that works
well with "socket" inside it, and it is safer to keep using that
location.  

On the other hand, if that directory does not exist, we know it is
safe to use whatever new location---after all, the lack of the
directory tells us that the user has never used the traditional
location successfully ;-)

So is_socket() may not even be needed, in which case this will be a
two-patch series:

   1/2 - add xdg_cache similar to xdg_config
   2/2 - use xdg_cache location if ~/.git-credential-cache/ is not there

