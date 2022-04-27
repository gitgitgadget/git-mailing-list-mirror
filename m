Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A968C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiD0Px1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Apr 2022 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiD0PxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 11:53:23 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F15418D
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:50:09 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23RFo8nN042158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Apr 2022 11:50:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>, <phillip.wood@dunelm.org.uk>
Cc:     <git@vger.kernel.org>, <philipoakley@iee.email>, <me@ttaylorr.com>,
        <guy.j@maurel.de>, <szeder.dev@gmail.com>,
        <johannes.Schindelin@gmx.de>, <gitster@pobox.com>,
        <derrickstolee@github.com>
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com> <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
In-Reply-To: <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
Subject: RE: [PATCH] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Wed, 27 Apr 2022 11:50:04 -0400
Organization: Nexbridge Inc.
Message-ID: <009d01d85a4e$79cfa570$6d6ef050$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKW87AjxA2cdMBJpUJ6sUXK7KFdYwFanWTqAZPhW0MBIEH92qtmPvKg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 27, 2022 11:39 AM, Carlo Arenas wrote:
>On Wed, Apr 27, 2022 at 2:33 AM Phillip Wood <phillip.wood123@gmail.com>
>wrote:
>> On 27/04/2022 01:05, Carlo Marcelo Arenas Belón wrote:
>> > diff --git a/git-compat-util.h b/git-compat-util.h index
>> > 58fd813bd01..9bb0eb5087a 100644
>> > --- a/git-compat-util.h
>> > +++ b/git-compat-util.h
>> > @@ -437,12 +437,48 @@ static inline int git_offset_1st_component(const char
>*path)
>> >   #endif
>> >
>> >   #ifndef is_path_owned_by_current_user
>> > +
>> > +#ifdef __TANDEM
>> > +#define ROOT_UID 65535
>> > +#else
>> > +#define ROOT_UID 0
>> > +#endif
>> > +
>> > +/*
>> > + * this helper function overrides a ROOT_UID with the one provided
>> > +by
>> > + * an environment variable, do not use unless the original uid is
>> > + * root
>> > + */
>> > +static inline int extract_id_from_env(const char *env, uid_t *id)
>>
>> Do we really want this living in git-compat-util.h?
>
>No; but IMHO the same applies to is_path_owned_by_current_uid(), and as I
>mentioned in my original proposal refactoring this code to do so has been punted
>until later since the objective here was to keep the change as small as possible for
>clean backporting.
>
>My intention with that comment was not only to warn people that might want to
>reuse that helper but to indicate it was just a hack that should be refactored ASAP.
>
>FWIW, I still think that using atoi with a check to skip "" is probably as safe as doing
>all this extra checking as no one has shown yet a system where sizeof(uid_t) >
>sizeof(uint32_t), but agree with Junio that using long instead avoids issues with
>the systems where
>sizeof(uid_t) > sizeof(int) and unless sizeof(int) == sizeof(long)
>(ex: 32-bit Linux) which is then covered by the cast.
>
>> > +{
>> > +     const char *real_uid = getenv(env);
>> > +
>> > +     if (real_uid && *real_uid) {
>> > +             char *error;
>> > +             long extracted_id = strtol(real_uid, &error, 10);
>> > +             if (!*error && LONG_MIN < extracted_id &&
>> > +                             extracted_id < LONG_MAX) {
>>
>> strtol() returns a long so the last two checks are redundant.
>
>The last two checks were to check for underflow or overflow and to make sure
>that the bogus values this function returns in case of those errors are not taken
>into consideration.
>
>>The standard is silent on what happens to error when the value is out
>>of  range.
>
>Which is why instead I was avoiding LONG_{MIN,MAX} which are described[1] as
>the bogus values that will be used in that case Agree with you that we could also
>add a check for >=0 as uid_t is usually unsigned, but it is not warranted to be so,
>and that is I was aiming for the wider possible range so we don't have to worry
>that much and let it be settled to a valid value through the cast.

Somehow, the root user id is a compat issue. Perhaps we need a uid_t getRootUid() in git-compat-util.h, and hide the details of the proc from the interface.

