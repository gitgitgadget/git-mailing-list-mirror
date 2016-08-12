Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08B31F859
	for <e@80x24.org>; Fri, 12 Aug 2016 18:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbcHLSyw (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 14:54:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751512AbcHLSyv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 14:54:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8D303407E;
	Fri, 12 Aug 2016 14:49:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YG81r6avzz1x4dVvphr3rGomJDM=; b=hjBWIz
	srKIQXBKzAav2hA4SBNKGozVYe/HS2xLEClLVmnJLqFftkDSTW2aR0vz4lfLMyCr
	4pr+s64iqp80TdtuOW5Zl2vJ80T/yBUAyTVO4yaMytUzFx+pM1SeYMN7WaepskWg
	n1ewuCuC2R6O/xfbqC3lefHJs+eRWsfdVLmxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=joK9EYHMuGk9+lG4s58JC9j5VKSeE9n9
	4o7xZhnsyHLIS/+7eiknaFL6Z+TGGjw2s/ioJXsfcOeOZCUTji/x1x725/jGG66i
	xy1DSjSdsk/yGFXGy+LqX/RPKjTLy5I5HVqkZFeVC9Havs6MbKmzCgLpLyachX2R
	wCRLk9nsOZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D00353407D;
	Fri, 12 Aug 2016 14:49:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CAC03407C;
	Fri, 12 Aug 2016 14:49:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v12 11/13] bisect--helper: `bisect_next_check` & bisect_voc shell function in C
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
	<010201567675ae68-15d79b9a-83fc-44ee-8607-07c2d0191c59-000000@eu-west-1.amazonses.com>
	<xmqq1t1tyi0z.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 12 Aug 2016 11:49:28 -0700
In-Reply-To: <xmqq1t1tyi0z.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 12 Aug 2016 11:11:08 -0700")
Message-ID: <xmqqpopdx1on.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 808DC878-60BD-11E6-82B6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_next_check(const struct bisect_terms *terms,
>> +			     const char *current_term)
>> +{
>> + ....
>> +		fprintf(stderr, N_("Warning: bisecting only with a %s commit\n"),
>> +			terms->term_bad.buf);
>
> Hmph, is this N_() and not _()?

I recall you saying that you are not familiar with i18n.  As it is a
good skill to have outside the context of this project, let's do a
quick primer. GSoC is a learning experience ;-).

There is a runtime function "gettext()" that takes a string, which
is typically a printf format string, and gives another string.  You
feed your message in the original language, meant to be used in the
C locale, and the function gives it translated into the end-user's
language, specified by environment variables like $LC_MESSAGES.

Since it is too cumbersome to write gettext() all the time, _()
exists as a short-hand for it.  So running this

	printf(_("Hello, world\n"));

would look up "Hello world\n" in database for the end-user's
language, and shows the translated message instead.

By scanning the source text, you can extract these constant strings
passed to gettext() or _().  This is done by the i18n coordinator
with the "msgmerge" program.  By doing so, we learn "Hello, world\n"
must be translated, and then ask i18n team to translate it to their
language.  The result is what we have in the l10n database.  They
are in po/*.po files in our source tree.

Sometimes, the message you want to be translated may be in a
variable, e.g.

        void greeting(const char *message)
        {
                printf(_(message));
        }

        int main(int ac, char **av)
        {
                int i;
                const char *message[] = {
                        "Hello, world\n",
                        "Goodbye, everybody\n",
                };
                for (i = 0; i < ARRAY_SIZE(message); i++)
                        greeting(message[i]);
        }

And scanning the source would not find "Hello, world\n" or "Goodby,
everybody\n" must be translated.  We do not want to do this:

                ...
                const char *message[] = {
*BAD*                   _("Hello, world\n"),
*BAD*                   _("Goodbye, everybody\n"),
                };
                ...

because we do *NOT* want to call gettext() there (we call the
function at runtime inside greeting() instead).  We use N_()
to mark such messages, like so:

                ...
                const char *message[] = {
*GOOD*                  N_("Hello, world\n"),
*GOOD*                  N_("Goodbye, everybody\n"),
                };
                ...

The N_() macro is a no-op at runtime.  It just is there so that
"msgmerge" can notice that the constant string there is something
that needs to be thrown into the l10n database.

As a concrete example:

> @@ -24,6 +25,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
>  	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>  	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
> +	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
>  	NULL
>  };

this is such a use of N_().  You want to keep untranslated message
in the git_bisect_helper_usage[] array, to be given to gettext(), or
more likely its short-hand _(), when these usage strings are used,
and make sure these strings will be in the l10n database so that
translators will give you translations to them to be used at
runtime.

> +		/*
> +		 * have bad (or new) but not good (or old). We could bisect
> +		 * although this is less optimum.
> +		 */
> +		fprintf(stderr, N_("Warning: bisecting only with a %s commit\n"),
> +			terms->term_bad.buf);

This one wants to call gettext() function to give fprintf() the
translated warning message.  It should be _().

> +		/*
> +		 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +		 * translation. The program will only accept English input
> +		 * at this point.
> +		 */
> +		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);

Just like this one.
