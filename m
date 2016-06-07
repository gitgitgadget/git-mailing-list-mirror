From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:08:56 -0400
Message-ID: <20160607210856.GA6807@sigill.intra.peff.net>
References: <20160607195608.16643-1-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Tue Jun 07 23:09:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOFK-00043K-O1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbcFGVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:09:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:50789 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755210AbcFGVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:08:59 -0400
Received: (qmail 8275 invoked by uid 102); 7 Jun 2016 21:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:08:58 -0400
Received: (qmail 1553 invoked by uid 107); 7 Jun 2016 21:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:09:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 17:08:56 -0400
Content-Disposition: inline
In-Reply-To: <20160607195608.16643-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296724>

On Tue, Jun 07, 2016 at 03:56:08PM -0400, santiago@nyu.edu wrote:

> diff --git a/tag.c b/tag.c
> index d1dcd18..591b31e 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -55,6 +55,14 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
>  
>  	ret = run_gpg_verify(buf, size, flags);
>  
> +	if (flags & TAG_VERIFY_NAME) {
> +		struct tag tag_info;
> +		ret += parse_tag_buffer(&tag_info, buf, size);
> +		if strncmp(tag_info.tag, name_to_report, size)
> +			ret += error("tag name doesn't match tag header!(%s)",
> +					tag_info.tag);
> +	}

Er, is this C? :)

I think the general idea of an option to check the tag-name is a good
one. But there are some corner cases to think about:

  1. What name are we comparing against? Presumably it comes from the
     name the user gave us that resolved to the tag object. We would
     want to shorten "refs/tags/v1.4" to just "v1.4", I would think.

     Would a user ever want to pass a different tagname?

  2. What do we do for non-annotated tags? Is it always a failure?

-Peff
