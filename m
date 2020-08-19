Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBFEC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461612245C
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="LA7+19kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHSUv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:51:27 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:34673 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSUvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 16:51:25 -0400
Date:   Wed, 19 Aug 2020 20:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1597870281;
        bh=3v/dV7PVN3/OFTvsQkkLcdP7vmqA0oZV5YpG8bz5jNI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=LA7+19kHPMIDCMjh+WjM6ctuLNH23imTBcmxHLtrY0abdPDzhUcAyR97YPCZTopqL
         +VhOEmDU7ndJUBB50rCmT91aKxIbNaRdotMAfzu1bC9Zzxd9s2JAyMwwlF0JmBWEzC
         H/YDQahZJzwrw9anY9zjmqOBCqj4T2vfvyrk0CW4=
To:     Junio C Hamano <gitster@pobox.com>
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     git@vger.kernel.org
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [RFC PATCH 1/2] parse-options: add --git-completion-helper-all
Message-ID: <a51ff9bb-47df-63ce-0b7f-508e064f4e3f@rtzoeller.com>
In-Reply-To: <xmqqeeo2togj.fsf@gitster.c.googlers.com>
References: <20200819175047.692962-1-rtzoeller@rtzoeller.com> <20200819175047.692962-2-rtzoeller@rtzoeller.com> <xmqqeeo2togj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/20 2:39 PM, Junio C Hamano wrote:
>=20
> Ryan Zoeller <rtzoeller@rtzoeller.com> writes:
>=20
>> --git-completion-helper excludes hidden options, such as --allow-empty
>> for git commit. This is typically helpful, but occasionally we want
>> auto-completion for obscure flags.
>=20
> Hits from "git grep -B2 OPT_NOCOMPLETE" tells me that these are
> mostly unsafe options.  Those who accept the risk by saying
> "complete all" should be allowed to see them.
>=20
> The same with OPT_HIDDEN (including OPT_HIDDEN_<TYPE>) gives us a
> mixed bag.  Many are unsafe, some are uncommon and the rest are
> discouraged, or old synonym to some other option that does get
> completed.  I am not sure if letting them be completed is an overall
> win or makes the output from "git cmd --<TAB><TAB>" too noisy.

If options marked OPT_HIDDEN are considered too internal to
meaningfully expose, I'm happy to hide them. I defaulted to
"show everything", and backing off from that is easy enough.

>=20
>> --git-completion-helper-all returns
>> all options, even if they are marked as hidden or nocomplete.
>=20
> If it is "occasinally", why is the removal of OPT_HIDDEN in
> show_negated_gitcomp() unconditional?

It shouldn't have been. I visually clumped the calls to it
as being inside the for loop, and assumed they were being skipped
over as part of the continue.

>=20
>> Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
>> ---
>>   parse-options.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/parse-options.c b/parse-options.c
>> index c57618d537..cc7239e1c6 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -535,8 +535,9 @@ static void show_negated_gitcomp(const struct option=
 *opts, int nr_noopts)
>>
>>   =09=09if (!opts->long_name)
>>   =09=09=09continue;
>> -=09=09if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
>> -=09=09=09continue;
>> +=09=09/* Don't check PARSE_OPT_HIDDEN or PARSE_OPT_NOCOMPLETE,
>> +=09=09 * we expect the caller to handle these appropriately.
>> +=09=09 */
>=20
> =09/*
> =09 * Style: our multi-line comments should begin with
> =09 * slash-asterisk alone on its own line, and end with
> =09 * asterisk-slash also on its own line, like this.
> =09 */
>=20
> We do not run around and fix existing style violations that would
> only raise the patch noise, but we try not to introduce new
> violators.

Will fix.

>=20
> I am not sure what the new comment says is justifiable.  The only
> caller of show_negated_gitcomp() is in show_gitcomp() where the
> function looped over the options and showed the options normally,
> honoring these two flags, but then the original list of options
> are passed to this function without filtering any option element
> on the list that are marked with these bits, so "the caller"
> apparently is not interested in handling the elements with these
> bits when making the decision to show "--no-<option>" form itself;
> it farms it out to show_negated_gitcomp() and expects the function
> to do "the right thing".  Am I misleading the code?
>=20
>=20

You're not misreading it; I apparently neglected to test the completion
for '--no-' options with '--git-completion-helper', only
'--git-completion-helper-all'. I'll apply the same show_all logic
to this function.

>>   =09=09if (opts->flags & PARSE_OPT_NONEG)
>>   =09=09=09continue;
>>
>> @@ -572,7 +573,7 @@ static void show_negated_gitcomp(const struct option=
 *opts, int nr_noopts)
>>   =09}
>>   }
>>
>> -static int show_gitcomp(const struct option *opts)
>> +static int show_gitcomp(const struct option *opts, int show_all)
>>   {
>>   =09const struct option *original_opts =3D opts;
>>   =09int nr_noopts =3D 0;
>> @@ -582,7 +583,8 @@ static int show_gitcomp(const struct option *opts)
>>
>>   =09=09if (!opts->long_name)
>>   =09=09=09continue;
>> -=09=09if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
>> +=09=09if (!show_all &&
>> +=09=09=09(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE)))
>>   =09=09=09continue;
>>
>>   =09=09switch (opts->type) {
>> @@ -723,9 +725,13 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>>   =09=09if (internal_help && ctx->total =3D=3D 1 && !strcmp(arg + 1, "h"=
))
>>   =09=09=09goto show_usage;
>>
>> -=09=09/* lone --git-completion-helper is asked by git-completion.bash *=
/
>> +=09=09/* lone --git-completion-helper and --git-completion-helper-all
>> +=09=09 * are asked by git-completion.bash
>> +=09=09 */
>=20
> Ditto.
>=20

Will fix.

>>   =09=09if (ctx->total =3D=3D 1 && !strcmp(arg + 1, "-git-completion-hel=
per"))
>> -=09=09=09return show_gitcomp(options);
>> +=09=09=09return show_gitcomp(options, 0);
>> +=09=09if (ctx->total =3D=3D 1 && !strcmp(arg + 1, "-git-completion-help=
er-all"))
>> +=09=09=09return show_gitcomp(options, 1);
>=20
> This is not your fault, but the micro-optimization to avoid
> comparison between *arg (which already is known to be "-") and "-"
> is not worth the reduced readability.
>=20
> =09=09if (ctx->total =3D=3D 1 && !strcmp(arg, "--git-completion-helper"))
> =09=09=09return show_gitcomp(options, 0);
> =09=09if (ctx->total =3D=3D 1 && !strcmp(arg, "--git-completion-helper-al=
l"))
> =09=09=09return show_gitcomp(options, 1);
>=20
> would be much clearer for readers to know what is going on.
>=20

I completely agree, and will clean these up.

> With an extra "const char *rest" variable in the same scope as
> "const char *arg",
>=20
> =09=09if (ctx->total =3D=3D 1 &&
> =09=09    !skip_prefix(arg, "--git-completion-helper", &rest) &&
> =09=09    (!*rest || !strcmp(rest, "-all")))
> =09=09=09return show_gitcomp(options, *rest);
>=20
> would further avoid repetitions, but some folks may find it a bit
> too dense.  I dunno.

I'm inclined to be repetitive in order to keep
'--git-completion-helper-all' intact, e.g. for grepping.

>=20
>>
>>   =09=09if (arg[1] !=3D '-') {
>>   =09=09=09ctx->opt =3D arg + 1;

