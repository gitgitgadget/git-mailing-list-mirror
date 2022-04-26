Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3CC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352664AbiDZP7l convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Apr 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352697AbiDZP7k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:59:40 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301432EF7
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:56:30 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23QFuHaW069600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Apr 2022 11:56:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Philip Oakley'" <philipoakley@iee.email>,
        "'Guy Maurel'" <guy.j@maurel.de>, <git@vger.kernel.org>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de> <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g> <xmqqk0bf1i12.fsf@gitster.g> <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan> <xmqqy1zty8dc.fsf@gitster.g> <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan> <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan> <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
Subject: RE: a problem with git describe
Date:   Tue, 26 Apr 2022 11:56:13 -0400
Organization: Nexbridge Inc.
Message-ID: <049e01d85986$2afeeff0$80fccfd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK4mmgVyMbsMsncoPpRmOV7thnz0gIpBz4DAVjzvuQChl/x0wI/p+SmAvZ44vYC2MLZQAEp7E0BAf0zfgWqt+PMcA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 26, 2022 11:44 AM, Johannes Schindelin wrote:
>On Mon, 25 Apr 2022, Carlo Marcelo Arenas Belón wrote:
>
>> On Mon, Apr 25, 2022 at 12:02:45AM -0700, Carlo Marcelo Arenas Belón wrote:
>> > On Sun, Apr 24, 2022 at 11:39:27PM -0700, Junio C Hamano wrote:
>> > > Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
>> > >
>> > > > At that point, though you might as well excempt root from this
>> > > > check
>> > >
>> > > But "root" or any higher-valued account is what needs this kind of
>> > > protection the most, no?
>> >
>> > correct, and I didn't meant to excempt root from the protection, but
>> > from the check that requires that the config file ownership matches.
>> >
>> > if the config file is owned by root, we already lost, regardless of
>> > what uid git is running as.
>>
>> apologies for my confusing english, hopefully this C is clearer
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h index
>> 58fd813bd01..6a385be7d1d 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -440,9 +440,19 @@ static inline int git_offset_1st_component(const
>> char *path)  static inline int is_path_owned_by_current_uid(const char
>> *path)  {
>>  	struct stat st;
>> +	uid_t euid;
>> +
>>  	if (lstat(path, &st))
>>  		return 0;
>> -	return st.st_uid == geteuid();
>> +
>> +	euid = geteuid();
>> +	if (!euid && st.st_uid && isatty(0)) {
>> +		struct stat ttyst;
>> +		if (!stat(ttyname(0), &ttyst))
>> +			euid = ttyst.st_uid;
>> +	}
>> +
>> +	return st.st_uid == euid;
>>  }
>>
>>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
>>
>> it uses stdin instead not to fall in the issue that was raised by
>> Gábor, but I am affraid that it might need to check all stdnandles for
>> a valid tty to be safe, and it looking even more complex.
>
>Maybe a better idea for the `sudo` scenario would be to make use of `SUDO_UID`
>(assuming that no adversary can gain control over the user's environment
>variables)?

Please do not assume that the user id 0 represents root. It does not on all systems. This change will cause breakages. We would need a specific comparison in compat.c with platform-specific values.
For example:

#if defined __TANDEM
#define ROOT_UID 65535
#define ROOT_GID 255
#endif

--Randall

