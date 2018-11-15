Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914421F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 09:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeKOTpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 14:45:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:40248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728609AbeKOTpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 14:45:49 -0500
Received: (qmail 10965 invoked by uid 109); 15 Nov 2018 09:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 09:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13866 invoked by uid 111); 15 Nov 2018 09:38:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 04:38:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 04:38:44 -0500
Date:   Thu, 15 Nov 2018 04:38:44 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20181115093844.GA14218@sigill.intra.peff.net>
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
 <20181114122725.18659-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114122725.18659-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 01:27:25PM +0100, SZEDER Gábor wrote:

> The command 'git ls-remote --sort=authordate <remote>' segfaults when
> run outside of a repository, ever since the introduction of its
> '--sort' option in 1fb20dfd8e (ls-remote: create '--sort' option,
> 2018-04-09).
> 
> While in general the 'git ls-remote' command can be run outside of a
> repository just fine, its '--sort=<key>' option with certain keys does
> require access to the referenced objects.  This sorting is implemented
> using the generic ref-filter sorting facility, which already handles
> missing objects gracefully with the appropriate 'missing object
> deadbeef for HEAD' message.  However, being generic means that it
> checks replace refs while trying to retrieve an object, and while
> doing so it accesses the 'git_replace_ref_base' variable, which has
> not been initialized and is still a NULL pointer when outside of a
> repository, thus causing the segfault.
> 
> Make ref-filter more careful upfront while parsing the format string,
> and make it error out when encountering a format atom requiring object
> access when we are not in a repository.  Also add a test to ensure
> that 'git ls-remote --sort' fails gracefully when executed outside of
> a repository.

Thanks for picking up this loose end. I like the general approach here,
but...

> diff --git a/ref-filter.c b/ref-filter.c
> index 0c45ed9d94..a1290659af 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -534,6 +534,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  	if (ARRAY_SIZE(valid_atom) <= i)
>  		return strbuf_addf_ret(err, -1, _("unknown field name: %.*s"),
>  				       (int)(ep-atom), atom);
> +	if (valid_atom[i].source != SOURCE_NONE && !have_git_dir())
> +		return strbuf_addf_ret(err, -1,
> +				       _("not a git repository, but the field '%.*s' requires access to object data"),
> +				       (int)(ep-atom), atom);

Is SOURCE_NONE a complete match for what we want?

I see problems in both directions:

 - sorting by "objectname" works now, but it's marked with SOURCE_OBJ,
   and would be forbidden with your patch.  I'm actually not sure if
   SOURCE_OBJ is accurate; we shouldn't need to access the object to
   show it (and we are probably wasting effort loading the full contents
   for tools like for-each-ref).

   However, that's not the full story. For objectname:short, it _does_ call
   find_unique_abbrev(). So we expect to have an object directory.

 - sorting by "HEAD" hits a BUG(), and would still be allowed with your
   patch.

So I like the idea here that the particular atoms would tell us whether
they're going to need to be in a repository or not, but I think the
annotations have to be cleaned up first.

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 91ee6841c1..32e722db2e 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -302,6 +302,12 @@ test_expect_success 'ls-remote works outside repository' '
>  	nongit git ls-remote dst.git
>  '
>  
> +test_expect_success 'ls-remote --sort fails gracefully outside repository' '
> +	# Use a sort key that requires access to the referenced objects.
> +	nongit test_must_fail git ls-remote --sort=authordate "$TRASH_DIRECTORY" 2>err &&
> +	test_i18ngrep "^fatal: not a git repository, but the field '\''authordate'\'' requires access to object data" err
> +'

Regardless of our solution, we probably want to add an extra test making
sure that something vanilla like:

  nongit git ls-remote --sort=v:refname "$TRASH_DIRECTORY"

continues to work (we do test ls-remote outside a repo already, but not
with a sort specifier).

-Peff
