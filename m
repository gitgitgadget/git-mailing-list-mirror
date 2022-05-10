Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23397C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 22:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiEJWHO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 10 May 2022 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiEJWHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 18:07:12 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B925F8CA
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:07:10 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24AM71As018875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 May 2022 18:07:01 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Derrick Stolee'" <stolee@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com> <xmqqtu9x6ovh.fsf@gitster.g>
In-Reply-To: <xmqqtu9x6ovh.fsf@gitster.g>
Subject: RE: [PATCH v4 1/7] archive: optionally add "virtual" files
Date:   Tue, 10 May 2022 18:06:56 -0400
Organization: Nexbridge Inc.
Message-ID: <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKQWb69+l7J8EAL2VRwkE+mUiRXFgGWHZmgAWLGzcIBWUdMuauGL0ow
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 10, 2022 5:48 PM, Junio C Hamano wrote:
>"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>writes:
>
>> @@ -514,14 +522,38 @@ static int add_file_cb(const struct option *opt, const
>char *arg, int unset)
>>  	if (!arg)
>>  		return -1;
>>
>> -	path = prefix_filename(args->prefix, arg);
>> -	item = string_list_append_nodup(&args->extra_files, path);
>> -	item->util = info = xmalloc(sizeof(*info));
>> +	info = xmalloc(sizeof(*info));
>>  	info->base = xstrdup_or_null(base);
>> -	if (stat(path, &info->stat))
>> -		die(_("File not found: %s"), path);
>> -	if (!S_ISREG(info->stat.st_mode))
>> -		die(_("Not a regular file: %s"), path);
>> +
>> +	if (!strcmp(opt->long_name, "add-file")) {
>> +		path = prefix_filename(args->prefix, arg);
>> +		if (stat(path, &info->stat))
>> +			die(_("File not found: %s"), path);
>> +		if (!S_ISREG(info->stat.st_mode))
>> +			die(_("Not a regular file: %s"), path);
>> +		info->content = NULL; /* read the file later */
>> +	} else {
>
>This pretends that this new one will stay to be the only other option that uses the
>same callback in the future.  To be more defensive, it should do
>
>	} else if (!strcmp(opt->long_name, "...")) {
>
>and end the if/else if/else cascade with
>
>	} else {
>		BUG("add_file_cb called for unknown option");
>	}
>
>> +		const char *colon = strchr(arg, ':');
>> +		char *p;
>> +
>> +		if (!colon)
>> +			die(_("missing colon: '%s'"), arg);
>> +
>> +		p = xstrndup(arg, colon - arg);
>> +		if (!args->prefix)
>> +			path = p;
>> +		else {
>> +			path = prefix_filename(args->prefix, p);
>> +			free(p);
>> +		}
>> +		memset(&info->stat, 0, sizeof(info->stat));
>> +		info->stat.st_mode = S_IFREG | 0644;
>
>I can sympathize with the desire to omit the mode bits because it may not be
>useful for the immediate purpose of "scalar diagnose"
>where the extracting end won't care what the file's permission bits are, but by
>letting this "mode is hardcoded" thing squat here would later make it more work
>when other people want to add an option that truely lets the caller add a "vitual"
>file, in response to end-user complaints that they cannot use the existing one to
>add an exectuable file, for example.  I do not care too much about the pathname
>limitation that does not allow a colon in it, simply because it is unusual enough, but
>I am not sure about hardcoded permission bits.
>
>If we did "--add-virtual-file=<path>:0644:<contents>" instead from day one, it
>certainly adds a few more lines of logic to this patch, and the calling "scalar
>diagnose" may have to pass a few more bytes, but I suspect that such a change
>would help the project in the longer run.

Would not core.filemode=false somewhat simulate this? The consumer-client would not care/do anything with the mode anyway. Or am I missing something?
--Randall

