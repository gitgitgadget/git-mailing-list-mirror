Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80731C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7461151
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhJFTHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:07:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:34378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhJFTHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:07:02 -0400
Received: (qmail 26769 invoked by uid 109); 6 Oct 2021 19:05:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Oct 2021 19:05:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32434 invoked by uid 111); 6 Oct 2021 19:05:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 15:05:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 15:05:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] object.[ch]: mark object type names for
 translation
Message-ID: <YV3zZFOJd6blVGXn@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
 <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:01PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Mark the "commit", "tree", "blob" and "tag" types for translation, and
> add an extern "unknown type" string for the OBJ_NONE case.
> 
> It is usually bad practice to translate individual words like this,
> but for e.g. the list list output emitted by the "short object ID dead
> is ambiguous" advice it makes sense.

We already seem to have a translatable string for "commit", but if I
look at say es.po, the translation is "confirmar", which is considering
it a verb. Now my Spanish is pretty rusty, so it's possible this works
as a noun, too. But if I look at other messages, like:

  #: builtin/commit.c:1623
  msgid "override date for commit"
  msgstr "sobrescribe la fecha del commit"

  #: builtin/commit.c:1626
  msgid "reuse message from specified commit"
  msgstr "reusar el mensaje de un commit específico"

then it's clear that "commit" as a noun is translated as "commit". I'm
not sure what facilities (if any) there are in gettext for having the
same string in different contexts.

I do note that this is already a problem. Of the five spots listed:

  #: builtin/commit.c:1625 builtin/commit.c:1626 builtin/commit.c:1632
  #: parse-options.h:329 ref-filter.h:90
  msgid "commit"
  msgstr "confirmar"

They all appear to want is as a noun. So maybe this is just
mis-translated for Spanish. It does feel like an accident in the making,
though.

> A subsequent commit will make that output translatable, and use these
> translation markings to do so. Well, we won't use "commit", but let's
> mark it up anyway for consistency. It'll probably come in handy sooner
> than later to have it already be translated, and it's to much of a
> burden to place on translators if they're translating the other three
> object types anyway.

I do wonder how useful it is to translate these type names in general.
Especially as used in this series, they're really technical terms, and
you are not going to escape the name "git commit" as a command. But I
don't ever use translated Git, so I'm not sure my opinion is all that
meaningful there.

> Aside: I think it would probably make sense to change the "NULL" entry
> for type_name() to be the "unknown type". I've ran into cases where
> type_name() was unconditionally interpolated in e.g. an sprintf()
> format, but let's leave that for #leftoverbits as that would be
> changing the behavior of the type_name() function.

IMHO this would be a bad idea. Even if there is a spot that uses the
result without checking for NULL, I'd much rather have Git segfault than
say, write out an object with a bogus name (as it would in index_mem(),
for example). So you really have to look over every caller, at which
point you may as well adjust the ones that aren't checking for NULL.

Now if you introduced type_name_human(), which auto-translated and
converted NULL to "unknown", then that would be easy to plug in
appropriately as you audited the callers.

>  static const char *object_type_strings[] = {
>  	NULL,		/* OBJ_NONE = 0 */
> -	"commit",	/* OBJ_COMMIT = 1 */
> -	"tree",		/* OBJ_TREE = 2 */
> -	"blob",		/* OBJ_BLOB = 3 */
> -	"tag",		/* OBJ_TAG = 4 */
> +	/*
> +	 * TRANSLATORS: "commit", "tree", "blob" and "tag" are the
> +	 * name of Git's object types. These names are interpolated
> +	 * stand-alone when doing so is unambiguous for translation
> +	 * and doesn't require extra context. E.g. as part of an
> +	 * already-translated string that needs to have a type name
> +	 * quoted verbatim, or the short description of a command-line
> +	 * option expecting a given type.
> +	 */
> +	N_("commit"),	/* OBJ_COMMIT = 1 */
> +	N_("tree"),	/* OBJ_TREE = 2 */
> +	N_("blob"),	/* OBJ_BLOB = 3 */
> +	N_("tag"),	/* OBJ_TAG = 4 */
>  };

This does make me feel slightly uneasy, just because so many parts of
Git rely on these _not_ being translated. But I see in your other
response that N_() really does nothing. So aside from possibly
misleading readers of the code, I think this is probably OK.

-Peff
