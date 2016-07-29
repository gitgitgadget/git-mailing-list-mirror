Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8F81F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbcG2SPr (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:15:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753409AbcG2SPo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:15:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D4A2F403;
	Fri, 29 Jul 2016 14:15:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rbO/9oql6S0JYNIYttF4yJddNK0=; b=MtOu5V
	VG4NXpbwwresSY9f48Jwm0udyezDuRhPYMof14Eto5IAyLz5pFC727vxIeEMpu1v
	ng6+ZmlKQPIsHlWxo8iCLP37UkGf90cvGdoRDyRUKTMp7xhU2f9/i5wBEc806rHl
	/dLM2i692zjUIUomhVf/4GbC4LNSkT46x8RWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJGl8at5ciRYmKWZfOISY6/spwojX6Yd
	i+qXpj3cIFsdxWjD2Tjjj8wBbPih//KrOq0hdnJjzkbZwzbfSFuY49pkYR5grT+V
	Nl6vSTB5BCptBhg3zJzEhJ7lG9GTWFLIcynXZd+wLSECBkXms520flTiabRgKKyC
	cxfVoQZ0oW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A600B2F402;
	Fri, 29 Jul 2016 14:15:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27E572F401;
	Fri, 29 Jul 2016 14:15:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
	<CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
	<20160729002902.GD9646@sigill.intra.peff.net>
	<CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
	<20160729155012.GA29773@sigill.intra.peff.net>
	<xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
	<20160729180517.GA14953@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 11:15:39 -0700
In-Reply-To: <20160729180517.GA14953@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 14:05:18 -0400")
Message-ID: <xmqqeg6cnwdw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75E678BC-55B8-11E6-8BDE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Linus suggested resetting the timestamp after making the commit, to
> clear the way for the next commit. But if we reset any cached value
> _before_ making the commit, this has a few advantages:

I guess our mails crossed ;-).

> It does feel a little backwards to cache by default, and then try to
> catch all the places that want to reset. Another way of thinking about
> it would be to almost _never_ cache, but let a few callsites like (the
> commit object creation) explicitly ask for a stable timestamp between
> the author and committer.

... and the reflog?

I would say that the approach taken by this version is perfectly
sensible, if we don't look at it as a "cache" and instead look at it
as a "snapshot" of the clock for the duration of the operation.
"reset" is like "now we are starting another operation, so grab a
snapshot please".

The changes to both tagging and committing look sensible.  Thanks.

> -- >8 --
> Subject: reset cached ident date before creating objects
>
> When we compute the date to put in author/committer lines of
> commits, or tagger lines of tags, we get the current date
> once and then cache it for the rest of the program.  This is
> a good thing in some cases, like "git commit", because it
> means we do not racily assign different times to the
> author/committer fields of a single commit object.
>
> But as more programs start to make many commits in a single
> process (e.g., the recently builtin "git am"), it means that
> you'll get long strings of commits with identical committer
> timestamps (whereas before, we invoked "git commit" many
> times and got true timestamps).
>
> This patch addresses it by letting callers reset the cached
> time, which means they'll get a fresh time on their next
> call to git_committer_info() or git_author_info().  We do so
> automatically before filling in the ident fields of commit
> and tag objects. That retains the property that committers
> and authors in a single object will match, but means that
> separate objects we create should always get their own
> fresh timestamps.
>
> There's no automated test, because it would be inherently
> racy (it depends on whether the program takes multiple
> seconds to run). But you can see the effect with something
> like:
>
>   # make a fake 100-patch series; use --first-parent
>   # so that we pretend merges are just more patches
>   top=$(git rev-parse HEAD)
>   bottom=$(git rev-list --first-parent -100 HEAD | tail -n 1)
>   git log --format=email --reverse --first-parent \
>           --binary -m -p $bottom..$top >patch
>
>   # now apply it; this presumably takes multiple seconds
>   git checkout --detach $bottom
>   git am <patch
>
>   # now count the number of distinct committer times;
>   # prior to this patch, there would only be one, but
>   # now we'd typically see several.
>   git log --format=%ct $bottom.. | sort -u
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/tag.c | 1 +
>  cache.h       | 1 +
>  commit.c      | 1 +
>  ident.c       | 5 +++++
>  4 files changed, 8 insertions(+)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 50e4ae5..3025e7f 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -225,6 +225,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>  	if (type <= OBJ_NONE)
>  	    die(_("bad object type."));
>  
> +	reset_ident_date();
>  	header_len = snprintf(header_buf, sizeof(header_buf),
>  			  "object %s\n"
>  			  "type %s\n"
> diff --git a/cache.h b/cache.h
> index b5f76a4..31e65f9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1269,6 +1269,7 @@ extern const char *ident_default_email(void);
>  extern const char *git_editor(void);
>  extern const char *git_pager(int stdout_is_tty);
>  extern int git_ident_config(const char *, const char *, void *);
> +extern void reset_ident_date(void);
>  
>  struct ident_split {
>  	const char *name_begin;
> diff --git a/commit.c b/commit.c
> index 71a360d..7ddbffe 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1548,6 +1548,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	}
>  
>  	/* Person/date information */
> +	reset_ident_date();
>  	if (!author)
>  		author = git_author_info(IDENT_STRICT);
>  	strbuf_addf(&buffer, "author %s\n", author);
> diff --git a/ident.c b/ident.c
> index 139c528..e20a772 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -184,6 +184,11 @@ static const char *ident_default_date(void)
>  	return git_default_date.buf;
>  }
>  
> +void reset_ident_date(void)
> +{
> +	strbuf_reset(&git_default_date);
> +}
> +
>  static int crud(unsigned char c)
>  {
>  	return  c <= 32  ||
