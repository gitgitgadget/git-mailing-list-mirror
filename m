Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B27C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D836124F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJDHhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:37:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJDHhe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:37:34 -0400
Received: (qmail 8257 invoked by uid 109); 4 Oct 2021 07:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 07:35:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11861 invoked by uid 111); 4 Oct 2021 07:35:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 03:35:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 03:35:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-name: make ambiguous object output
 translatable
Message-ID: <YVqu0aEBMy3mnYoE@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <patch-2.2-b6136380c28-20211004T013611Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-b6136380c28-20211004T013611Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 03:42:49AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the output of show_ambiguous_object() added in [1] and last
> tweaked in [2] to be more friendly to translators. By being able to
> customize the sprintf formats we're even ready for RTL languages.
> 
> 1. ef9b0370da6 (sha1-name.c: store and use repo in struct
>    disambiguate_state, 2019-04-16)
> 2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
>    then SHA-1, 2018-05-10)

I suspect you meant 1ffa26c461 (get_short_sha1: list ambiguous objects
on error, 2016-09-26) for the first one.

I had to stare at the patch for a while to understand the goal here. I
think this would have been a bit easier to review if "change" in your
first sentence was described a bit more. Perhaps:

  The list of candidates output by show_ambiguous_output() is not marked
  for translation. At the very least we want to allow the text "the
  candidates are" to be translated. But we also format individual
  candidate lines like:

      deadbeef commit 2021-01-01 - Some Commit Message

  by formatting the individual components, then using a printf-format to
  arrange them in the correct order. Even though there's no text here to
  be translated, the order and spacing is determined by the format
  string. Allowing that to be translated helps RTL languages.

I have a few comments on the patch itself. The biggest thing is that it
changes the format to add an extra newline (between "The candidates
are:" and the actual list). I don't have a strong opinion on including
that or not, but it seemed unintentional given the comment on the first
commit (and its lack of mention here).

The rest are mostly observations, not criticisms. You can take them with
the appropriate grain of salt given that I don't do translation work
myself, nor know any RTL languages.

> @@ -366,18 +373,34 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
>  		if (commit) {
>  			struct pretty_print_context pp = {0};
>  			pp.date_mode.type = DATE_SHORT;
> -			format_commit_message(commit, " %ad - %s", &desc, &pp);
> +			format_commit_message(commit, _(" %ad - %s"), &desc, &pp);
>  		}

Is it OK to use non-printf expansions with the gettext code? Presumably
the translated string would have the same set of placeholders in it, but
my understanding is that gettext may sometimes munge the %-placeholders
(e.g., allowing numbered ones for re-ordering). I admit I don't know how
any of that works, but I just wonder if this "%ad" may cause confusion
(or even if not, if it is even possible to re-order it for an RTL
language).

>  	} else if (type == OBJ_TAG) {
>  		struct tag *tag = lookup_tag(ds->repo, oid);
>  		if (!parse_tag(tag) && tag->tag)
> -			strbuf_addf(&desc, " %s", tag->tag);
> +			strbuf_addf(&desc, _(" %s"), tag->tag);
>  	}

I wonder whether " %s" is worthwhile as a translatable string. It does
seem to be unique among strings marked for translation, but there are a
ton of non-translated instances. Would context ever matter here?

My impression is that this kind of translation-lego is frowned upon, and
we might be better off repeating ourselves a bit more. I.e., something
like:

  if (commit) {
	  struct strbuf date = STRBUF_INIT;
	  struct strbuf subject = STRBUF_INIT;
	  format_commit_message(commit, "%ad", &date, &pp);
	  format_commit_message(commit, "%s", &subject, &pp);
	  strbuf_addf(advice, _("  %s commit %s - %s\n"),
		      repo_find_unique_abbrev(...),
		      date.buf, subject.buf);
	  strbuf_release(&date);
	  strbuf_release(&subject);
  } else if (type == OBJ_TAG) {
          ...
	  strbuf_addf(advice, _("  %s tag %s\n"),
	              repo_find_unique_abbrev(...), tag->tag);
  } else {
	  /* TRANSLATORS: the fields are abbreviated oid and type */
          strbuf_addf(advice, _("  %s %s\n"),
	              repo_find_unique_abbrev(...), type_name(type));
  }

Though that last one similarly has a real lack of context.

> -	advise("  %s %s%s",
> -	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
> -	       type_name(type) ? type_name(type) : "unknown type",
> -	       desc.buf);
> +	strbuf_addf(advice,
> +		    /*
> +		     * TRANSLATORS: This is a line of ambiguous object
> +		     * output. E.g.:
> +		     *
> +		     *    "deadbeef commit 2021-01-01 - Some Commit Message\n"
> +		     *    "deadbeef tag Some Tag Message\n"
> +		     *    "deadbeef tree\n"
> +		     *
> +		     * I.e. the first argument is a short OID, the
> +		     * second is the type name of the object, and the
> +		     * third a description of the object, if it's a
> +		     * commit or tag. In that case the " %ad - %s" and
> +		     * " %s" formats above will be used for the third
> +		     * argument.
> +		     */
> +		    _("  %s %s%s\n"),
> +		    repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
> +		    type_name(type) ? type_name(type) : "unknown type",
> +		    desc.buf);

Would you want to translate "unknown type" here, as well? It's probably
not that important in practice, but it seems like a funny omission.

> @@ -488,12 +516,19 @@ static enum get_oid_result get_short_oid(struct repository *r,
>  		if (!ds.ambiguous)
>  			ds.fn = NULL;
>  
> -		advise(_("The candidates are:"));
>  		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
>  		sort_ambiguous_oid_array(r, &collect);
>  
> -		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
> +		if (oid_array_for_each(&collect, show_ambiguous_object, &as))
>  			BUG("show_ambiguous_object shouldn't return non-zero");
> +
> +		/*
> +		 * TRANSLATORS: The argument is the list of ambiguous
> +		 * objects composed in show_ambiguous_object(). See
> +		 * its "TRANSLATORS" comment for details.
> +		 */
> +		advise(_("The candidates are:\n\n%s"), sb.buf);

Here's where the extra newline.

I understand why the earlier ones were changed for RTL languages. But
this one is always line-oriented. Is the point to help bottom-to-top
languages? I can buy that, though it feels like that would be something
that the terminal would deal with (because even with this, you're still
getting the "error:" line printed separately, for example).

I don't think what this is doing is wrong (at first I wondered about the
"hint:" lines, but because advise() looks for embedded newlines, we're
OK). But if the translation doesn't need to reorder things across lines,
this extra format-into-a-strbuf step doesn't seem necessary. We can just
call advise() directly in show_ambiguous_object(), as before.

If it is necessary, then note that you leak "sb" here.

-Peff
