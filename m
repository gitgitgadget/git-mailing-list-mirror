Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EDC433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiDYPOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbiDYPOl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 11:14:41 -0400
Received: from hosting01.xaranet.de (hosting01.xaranet.de [192.162.85.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F9884EE8
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 08:11:35 -0700 (PDT)
Received: from [192.168.178.20] (p54a37379.dip0.t-ipconnect.de [84.163.115.121])
        by hosting01.xaranet.de (Postfix) with ESMTPSA id 976BEA361B;
        Mon, 25 Apr 2022 17:11:33 +0200 (CEST)
Authentication-Results: hosting01.xaranet.de;
        spf=pass (sender IP is 84.163.115.121) smtp.mailfrom=guy.j@maurel.de smtp.helo=[192.168.178.20]
Received-SPF: pass (hosting01.xaranet.de: connection is authenticated)
Message-ID: <02adbd7f-d806-1400-1f9c-a37a64b63981@maurel.de>
Date:   Mon, 25 Apr 2022 17:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: a problem with git describe
Content-Language: de-DE
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g> <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
 <xmqqy1zty8dc.fsf@gitster.g> <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
 <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan>
From:   Guy Maurel <guy.j@maurel.de>
In-Reply-To: <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <165089949403.23773.13152797680790549763@hosting01.xaranet.de>
X-PPP-Vhost: maurel.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

It might be important for your debugging work.
I introduce a new file /root/.gitconfig
-rw-r--r--  1 root root   57 Apr 25 17:03 .gitconfig
with
[safe]
         directory = /home/guy/Software/uncrustify

And the call works pretty well:
uncrustify/build $ sudo ~/Software/Git/2.36.0/tar-gz/git-2.36.0/git-describe
uncrustify-0.74.0-315-ga3466c92

Thanks for helping!
guy
Am 25.04.22 um 10:40 schrieb Carlo Marcelo Arenas Belón:
> On Mon, Apr 25, 2022 at 12:02:45AM -0700, Carlo Marcelo Arenas Belón wrote:
>> On Sun, Apr 24, 2022 at 11:39:27PM -0700, Junio C Hamano wrote:
>>> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
>>>
>>>> At that point, though you might as well excempt root from this check
>>>
>>> But "root" or any higher-valued account is what needs this kind of
>>> protection the most, no?
>>
>> correct, and I didn't meant to excempt root from the protection, but
>> from the check that requires that the config file ownership matches.
>>
>> if the config file is owned by root, we already lost, regardless of what
>> uid git is running as.
> 
> apologies for my confusing english, hopefully this C is clearer
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58fd813bd01..6a385be7d1d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -440,9 +440,19 @@ static inline int git_offset_1st_component(const char *path)
>   static inline int is_path_owned_by_current_uid(const char *path)
>   {
>   	struct stat st;
> +	uid_t euid;
> +
>   	if (lstat(path, &st))
>   		return 0;
> -	return st.st_uid == geteuid();
> +
> +	euid = geteuid();
> +	if (!euid && st.st_uid && isatty(0)) {
> +		struct stat ttyst;
> +		if (!stat(ttyname(0), &ttyst))
> +			euid = ttyst.st_uid;
> +	}
> +
> +	return st.st_uid == euid;
>   }
>   
>   #define is_path_owned_by_current_user is_path_owned_by_current_uid
> 
> it uses stdin instead not to fall in the issue that was raised by
> Gábor, but I am affraid that it might need to check all stdnandles for
> a valid tty to be safe, and it looking even more complex.
> 
> Carlo

-- 
Guy Maurel
Sebastian-Fischer-Weg 13
89077 Ulm
