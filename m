Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5E8C4332F
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiD0OTT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Apr 2022 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiD0OS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 10:18:58 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C451E5D
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:15:44 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23REFgVc037622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Apr 2022 10:15:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <phillip.wood@dunelm.org.uk>,
        "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        <git@vger.kernel.org>
Cc:     <philipoakley@iee.email>, <me@ttaylorr.com>, <guy.j@maurel.de>,
        <szeder.dev@gmail.com>, <johannes.Schindelin@gmx.de>,
        <gitster@pobox.com>, <derrickstolee@github.com>
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com> <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
In-Reply-To: <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
Subject: RE: [PATCH] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Wed, 27 Apr 2022 10:15:38 -0400
Organization: Nexbridge Inc.
Message-ID: <006e01d85a41$4903f5c0$db0be140$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKW87AjxA2cdMBJpUJ6sUXK7KFdYwFanWTqAZPhW0MB3pyBzatgMbUg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 27, 2022 8:31 AM, Phillip Wood wrote:
>On 27/04/2022 10:33, Phillip Wood wrote:
>> Hi Carlo
>>
>> On 27/04/2022 01:05, Carlo Marcelo Arenas Belón wrote:
>
>> [...]
>>> +{
>>> +    const char *real_uid = getenv(env);
>>> +
>>> +    if (real_uid && *real_uid) {
>>> +        char *error;
>>> +        long extracted_id = strtol(real_uid, &error, 10);
>>> +        if (!*error && LONG_MIN < extracted_id &&
>>> +                extracted_id < LONG_MAX) {
>>
>> strtol() returns a long so the last two checks are redundant. The
>> standard is silent on what happens to error when the value is out of
>> range. The way to check that all the string was consumed without
>> underflow/overflow is
>>
>>      errno = 0;
>>      val = strtol(str, &endp, 10);
>>      if (errno || !*endp)
>
>Sorry that should be "if (errno || *endp)" to check for an error
>
> > [...]
> >     #if sizeof(uid_t) == sizeof(int)
> >         if (extracted_id > INT_MAX)
> >             error(...)
> >     #endif
>
>I think we should probably check if uid_t is a short integer as well as
>
> > +#ifdef __TANDEM
> > +#define ROOT_UID 65535
>
>suggests it may be an unsigned short on NonStop.
>
>Not knowing the size of uid_t or if it is signed or not (as far as I can tell posix just
>says it's an integer) makes the limit checks tricky - maybe we make euid a long (or
>unsigned long) here and it the function below rather than casting it to uid_t and
>possibly truncating it.

It depends on the compile. If LP64 is used - long file pointers, then it is a long (32-bit) or an int (also 32-bit). Not unsigned in either case, but specifying unsigned would be helpful. Nice catch.

> > [...]
>>> +
>>>   static inline int is_path_owned_by_current_uid(const char *path)
>>>   {
>>>       struct stat st;
>>> +    uid_t euid;
>>> +
>>>       if (lstat(path, &st))
>>>           return 0;
>>> -    return st.st_uid == geteuid();
>>> +
>>> +    euid = geteuid();
>>> +    if (euid == ROOT_UID) {
>>> +        /* we might have raised our privileges with sudo */
>>> +        extract_id_from_env("SUDO_UID", &euid);
>
>You are ignoring any errors when parsing the environment variable - that is not a
>good idea in a security check.

