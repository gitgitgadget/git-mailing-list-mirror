Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0183ACA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB9C20753
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgELTXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 15:23:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:44560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgELTXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 15:23:24 -0400
Received: (qmail 30901 invoked by uid 109); 12 May 2020 19:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 May 2020 19:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10229 invoked by uid 111); 12 May 2020 19:23:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2020 15:23:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 May 2020 15:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     George Brown <321.george@gmail.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH] contrib/git-jump: cat output when not a terminal
Message-ID: <20200512192323.GC54565@coredump.intra.peff.net>
References: <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
 <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
 <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
 <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
 <20200511143157.GA1415@coredump.intra.peff.net>
 <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
 <20200511154226.GC1415@coredump.intra.peff.net>
 <xmqqy2pyqv11.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2pyqv11.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 09:46:34AM -0700, Junio C Hamano wrote:

> Lest we all forget...
> 
> -- >8 --
> Subject: git-jump: just show the list with the "--no-editor" option

Thanks for tying this up. It seems to work as advertised. A few nits:

> +edit=yes
> +
> +while	case "$#,$1" in

Tab between "while" and "case"?

> +	0,*) break ;;
> +	*,--no-editor) edit=no ;;
> +	*,--*) usage >&2; exit 1 ;;
> +	*) break ;;
> +	esac
> +do
> +	shift
> +done

I found the use of "case" in the loop conditional a little unusual. I'd
have probably written:

  while test $# -gt 0
  do
	case "$1" in
	--no-editor) edit=no ;;
	--*) usage >&2; exit 1 ;;
	*) break ;;
	esac
	shift
  done

> @@ -75,4 +87,9 @@ tmp=`mktemp -t git-jump.XXXXXX` || exit 1
>  type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
>  "mode_$mode" "$@" >"$tmp"
>  test -s "$tmp" || exit 0
> -open_editor "$tmp"
> +
> +case "$edit" in
> +yes)	open_editor "$tmp" ;;
> +no)	cat "$tmp" ;;
> +esac
> +

"diff --check" complains about the empty line.

It probably doesn't matter much, but we could skip the tempfile entirely
in no-editor mode. I.e.:

  if test "$edit" = "no"
  then
    "mode_$mode" "$@"
  fi

  # otherwise set up trap, mktemp, etc

-Peff
