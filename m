Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17B4EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 23:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGQXL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGQXLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 19:11:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1B10F5
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 16:10:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38FFD190E41;
        Mon, 17 Jul 2023 19:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nAMW93iGVHbZ
        dNBKUCz1v0SNZSSKSJXj74Ckwf8Gjpg=; b=ViU8Io4QjRVgyG+V0aMoR3mR6vyZ
        yxYR9ta3hTS/1+k24PuthVPw9AAkzFICIy3wQ69Yp08z0TSxGfBha1LwlyLHGGYD
        A71hr5OpM2uO6dtp9bgm/F2rx5tJZ5WwIaEg7evDGibqsVUM70lY9CoU/ew7NHAu
        rkezjQmtxunfviY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32221190E40;
        Mon, 17 Jul 2023 19:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D0E1190E3C;
        Mon, 17 Jul 2023 19:10:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
Date:   Mon, 17 Jul 2023 16:10:14 -0700
In-Reply-To: <20230715160730.4046-1-andy.koppe@gmail.com> (Andy Koppe's
        message of "Sat, 15 Jul 2023 17:07:29 +0100")
Message-ID: <xmqqmszudtih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16F7E50A-24F7-11EE-BA4B-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> This lists ref names in the same way as the %d decoration format, but

Please replace "This" with "%(descorate[:<options>]", i.e. a more
concrete form, so that people do not have to go back to the title in
order to understand the body of the proposed log message.

> -'%(describe[:options])':: human-readable name, like
> +'%(describe[:<options>])':: human-readable name, like
> -'%(trailers[:options])':: display the trailers of the body as
> +'%(trailers[:<options>])':: display the trailers of the body as

It is a very good idea to signal that <options> is a placeholder by
enclosing it inside <angle bracket> like this patch wants to do with
%(decorate), and to make sure that other existing ones consistently
follow the same convention.

But the latter, being very small, can be buried in the noise.

It may be a good idea to have small "preliminary clean-up" patches
that do not add anything related to %(decorate) at the beginning of
the series.  [PATCH 1/3] can be %(token[:<options>]) clean-up,
[PATCH 2/3] can be "what is literal formatting code" clarification,
and [PATCH 3/3] can be the rest of this patch, for example.

> +'%(decorate[:<options>])':: ref names with custom decorations.
> +			  The `decorate` string may be followed by a colon
> +			  and zero or more comma-separated options.
> +			  Option values may contain literal formatting codes.
> +			  These must be used for commas (`%x2C`) and closing
> +			  parentheses (`%x29`), due to their role in the option
> +			  syntax.

OK.  I fear that "literal formatting codes" may not be understood by
readers without having any cross references here.  Perhaps something
like the patch attached at the end of this message would help.

> +** 'arrow=3D<value>': Shown between HEAD and the branch it points to, =
if any.
> +		    Defaults to "=C2=A0\->=C2=A0".

It feels a bit strange that this feature is limited only to "HEAD"
and other symbolic refs are not annotated with an arrow, but it is
not the fault of this patch.  We might want to see if it is worth to
extend this to other symbolic refs but not while this patch is being
discussed and polished.

> diff --git a/log-tree.c b/log-tree.c
> index f4b22a60cc..4b46884ef6 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -301,27 +301,34 @@ static void show_name(struct strbuf *sb, const st=
ruct name_decoration *decoratio
> =20
>  /*
>   * The caller makes sure there is no funny color before calling.
> - * format_decorations_extended makes sure the same after return.
> + * format_decorations ensures the same after return.
>   */
> -void format_decorations_extended(struct strbuf *sb,
> +void format_decorations(struct strbuf *sb,
>  			const struct commit *commit,
>  			int use_color,
> -			const char *prefix,
> -			const char *separator,
> -			const char *suffix)
> +			const struct decoration_options *opts)

Hmph, presumably the idea is to collect these parameters in a struct
and pass it around, which would be easier to extend, and then teach
the hardcoded default to the callee, instead of the macro.  OK.

It may have made the change easier to review if such a change that
can cleanly separable into a single step into a single preliminary
clean-up patch before we start adding the customization, but let's
read on to see if I can keep everything in my head---I'll complain
at the end if I can't ;-).

>  {
> -	const struct name_decoration *decoration;
> -	const struct name_decoration *current_and_HEAD;
> -	const char *color_commit =3D
> -		diff_get_color(use_color, DIFF_COMMIT);
> -	const char *color_reset =3D
> -		decorate_get_color(use_color, DECORATION_NONE);

Getting rid of the computation of the initialization value from the
above decl block, ...


> +	const char *color_commit, *color_reset;
> +	const char *prefix, *suffix, *separator, *arrow, *tag;
> +
> +	const struct name_decoration *current_and_HEAD;

... like this, so we will return early without wasting extra cycles
whose result we will not use, is a very good idea.  But then, ...

> +	const struct name_decoration *decoration =3D
> +		get_name_decoration(&commit->object);
> =20
> -	decoration =3D get_name_decoration(&commit->object);
>  	if (!decoration)
>  		return;

... I think the original is easier to follow than the updated form
for the "decoration" variable, simply because the declaration part
will become absolutely free, and it becomes easier to see that the
computation of "decoration" is the very first thing the cycles are
spent on.

> +	color_commit =3D diff_get_color(use_color, DIFF_COMMIT);
> +	color_reset =3D decorate_get_color(use_color, DECORATION_NONE);
> +
> +	prefix =3D (opts && opts->prefix) ? opts->prefix : " (";
> +	suffix =3D (opts && opts->suffix) ? opts->suffix : ")";
> +	separator =3D (opts && opts->separator) ? opts->separator : ", ";

Knowing these hardcoded values were the responsibility of the
format_decorations() C preprocessor macro; now it is written here.
It is a moral no-op change from the caller's point of view.

> +	arrow =3D (opts && opts->arrow) ? opts->arrow : " -> ";
> +	tag =3D (opts && opts->tag) ? opts->tag : "tag: ";

These two are new.  That is one thing why I wondered above if it is
a good idea to separate the "refactor to introduce
decoration_options structure that has three members and replace
three parameters to this function with it, so that we can get rid of
the format_decorations() macro" into a single preliminary step.
Then the reviewers can go on, after being convinced that such a
moral no-op refactoring is correct, to review the next step that
would presumably add these two members to the option struct and make
these customizable.

>  	current_and_HEAD =3D current_pointed_by_HEAD(decoration);
> +
>  	while (decoration) {
>  		/*
>  		 * When both current and HEAD are there, only

Unrelated noise.

> @@ -329,20 +336,29 @@ void format_decorations_extended(struct strbuf *s=
b,
>  		 * appeared, skipping the entry for current.
>  		 */
>  		if (decoration !=3D current_and_HEAD) {
> -			strbuf_addstr(sb, color_commit);
> -			strbuf_addstr(sb, prefix);
> -			strbuf_addstr(sb, color_reset);
> -			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
> -			if (decoration->type =3D=3D DECORATION_REF_TAG)
> -				strbuf_addstr(sb, "tag: ");
> +			const char *color =3D
> +				decorate_get_color(use_color, decoration->type);
> =20
> +			if (*prefix) {
> +				strbuf_addstr(sb, color_commit);
> +				strbuf_addstr(sb, prefix);
> +				strbuf_addstr(sb, color_reset);
> +			}
> +
> +			if (*tag && decoration->type =3D=3D DECORATION_REF_TAG) {
> +				strbuf_addstr(sb, color);
> +				strbuf_addstr(sb, tag);
> +				strbuf_addstr(sb, color_reset);
> +			}
> +			strbuf_addstr(sb, color);
>  			show_name(sb, decoration);

Again, this mixes adding new things (i.e. customizeable "tag:"
string, and "->" we see below) and improving existing things
(i.e. "<color><reset>" that is presumably pointless when prefix is
an empty string is shown as an empty string).  Ideally, the step to
move the three existing parameters to three members of the new
struct should be done first WITHOUT the empty-string improvement,
then another step should do the empty-string improvement (at which
time, presumably existing test script may have to be adjusted), and
then new features to costumize "tag:" and "->" should be added on
top.

> -			if (current_and_HEAD &&
> +			if (*arrow && current_and_HEAD &&
>  			    decoration->type =3D=3D DECORATION_REF_HEAD) {

Because arrow is never allowed to be NULL, remove the above change,
and ...

> -				strbuf_addstr(sb, " -> ");
> +				strbuf_addstr(sb, arrow);

... let the program crash to catch a future bug at runtime.

> @@ -351,9 +367,12 @@ void format_decorations_extended(struct strbuf *sb=
,
>  		}
>  		decoration =3D decoration->next;
>  	}
> -	strbuf_addstr(sb, color_commit);
> -	strbuf_addstr(sb, suffix);
> -	strbuf_addstr(sb, color_reset);
> +
> +	if (*suffix) {
> +		strbuf_addstr(sb, color_commit);
> +		strbuf_addstr(sb, suffix);
> +		strbuf_addstr(sb, color_reset);
> +	}

Ditto about "improving the <color><reset> empty sequence is a
separate change from making various fields customizable".

I'll stop here. After skimming the changes to the test, I think this
single patch should be split into separate steps.  Perhaps the split
should go like this:

 * documentation clean-up %(token[:options]) -> %(token[:<options>])
   plus clarification of what a "literal formatting code" is.

 * introduction of "struct decoration_option",
   removing the format_decorations() macro,
   renaming format_decorations_extended() to format_decorations(),
   replacing the three parameters with a single struct pointer.

 * improving <color><reset> string when the meat of the string is
   empty.  This step will be the FIRST step that changes the
   externally visible behaviour, and presumably will have adjustment
   to existing tests.

 * making "tag:" and "->" customizable, if values are passed in the
   struct.  This step does not have UI changes, and the existing
   tests should serve as a safety net to catch mistakes in this
   step.

 * read the %(describe[:<option>]) and fill "struct describe_option".
   This will be accompanied by additional tests for the new feature.

Thanks.

---------------------- >8 ----------------------
Subject: pretty-formats: define "literal formatting code"

The description for %(trailer) option already uses this term without
having definition anywhere in the document, and we are about to add
another one %(decorate) that uses it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git c/Documentation/pretty-formats.txt w/Documentation/pretty-form=
ats.txt
index c08aba15af..b7a3a150ae 100644
--- c/Documentation/pretty-formats.txt
+++ w/Documentation/pretty-formats.txt
@@ -122,7 +122,9 @@ The placeholders are:
 - Placeholders that expand to a single literal character:
 '%n':: newline
 '%%':: a raw '%'
-'%x00':: print a byte from a hex code
+'%x00':: '%x' followed by two hexadecimal digits is replaced with a
+	byte with the hexdecimal digits' value (we will call this
+	"literal formatting code" in the rest of this document).
=20
 - Placeholders that affect formatting of later placeholders:
 '%Cred':: switch color to red


