Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CF820229
	for <e@80x24.org>; Sat, 22 Oct 2016 03:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756002AbcJVD04 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 23:26:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:32769 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755988AbcJVD0z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 23:26:55 -0400
Received: (qmail 7493 invoked by uid 109); 22 Oct 2016 03:26:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 03:26:55 +0000
Received: (qmail 9148 invoked by uid 111); 22 Oct 2016 03:27:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 23:27:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 23:26:53 -0400
Date:   Fri, 21 Oct 2016 23:26:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Luke Shumaker <lukeshu@sbcglobal.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] daemon, path.c: fix a bug with ~ in repo paths
Message-ID: <20161022032652.nfdj6mcy6mi6anx5@sigill.intra.peff.net>
References: <20161018150629.23205-1-lukeshu@sbcglobal.net>
 <xmqqvawppote.fsf@gitster.mtv.corp.google.com>
 <87pomxildc.wl-lukeshu@sbcglobal.net>
 <CACsJy8AzWqJ_9JQ_BGnAB3E3GrGSTS40z8umbtO6mQJukWOooQ@mail.gmail.com>
 <xmqqlgxhd77u.fsf@gitster.mtv.corp.google.com>
 <xmqqvawlblxi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvawlblxi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 11:23:53AM -0700, Junio C Hamano wrote:

> A request to "git://<site>/<string>", depending on <string>, results
> in "directory" given to path_ok() in a bit different forms.  Namely,
> connect.c::parse_connect_url() gives
> 
>     URL				directory
>     git://site/nouser.git	/nouser.git
>     git://site/~nouser.git	~nouser.git
> 
> by special casing "~user" syntax (in other words, a pathname that
> begins with a tilde _is_ special cased, and tilde is not considered
> a normal character that can be in a pathname).  Note the lack of
> leading slash in the second one.
> 
> Because that is how the shipped clients work, the daemon needs a bit
> of adjustment, because interpolation and base-path prefix codepaths
> wants to accept only paths that begin with a slash, and relies on
> the slash when interpolating it in the template or concatenating it
> to the base (e.g. roughly "sprintf(buf, "%s%s", base_path, dir)").
> 
> I came up with the following as a less invasive patch.  There no
> longer is the ase where "user-path not allowed" error is given,
> as treating tilde as just a normal pathname character even when it
> appears at the beginning is the whole point of this change.

Thanks for explaining this. It is rather gross, but I think your
less-invasive patch is the best we could do given the client behavior.
And it's more what I would have expected based on the original problem
description.

> As I said already, I am not sure if this is a good change, though.

I also am on the fence. I'm not sure I understand a compelling reason to
have a non-interpolated "~" in the repo path name. Sure, it's a
limitation, but why does anybody care?

> @@ -170,11 +171,11 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
>  		return NULL;
>  	}
>  
> +	if (!user_path && *dir == '~') {
> +		snprintf(tilde_path, PATH_MAX, "/%s", dir);
> +		dir = tilde_path;
> +	}

I know you are following existing convention in this function to use an
unchecked snprintf(), but it makes me wonder what kind of mischief a
client could get up to by silently truncating via snprintf. This
function is, after all, supposed to be checking the quality of the
incoming path.

xsnprintf() is probably too blunt a hammer, but:

  if (snprintf(rpath, PATH_MAX, ...) >= PATH_MAX) {
	logerror("path too long");
	return NULL;
  }

in various places may be appropriate.

-Peff
