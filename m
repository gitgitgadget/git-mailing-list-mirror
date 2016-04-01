From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix http-backend reading till EOF, ignoring
 CONTENT_LENGTH, violating rfc3875 -- WAS: Problem with git-http-backend.exe
 as iis cgi
Date: Fri, 1 Apr 2016 19:55:32 -0400
Message-ID: <20160401235532.GA27941@sigill.intra.peff.net>
References: <F0F5A56A22F20D4CB4A03BB8D6658797E261A3D6@SERVER2011.CS-SOFTWARE.local>
 <20160329201349.GB9527@sigill.intra.peff.net>
 <F0F5A56A22F20D4CB4A03BB8D6658797E261AF97@SERVER2011.CS-SOFTWARE.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
X-From: git-owner@vger.kernel.org Sat Apr 02 01:55:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am8ui-0006hc-1E
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 01:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbcDAXzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 19:55:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:42854 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754824AbcDAXzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 19:55:35 -0400
Received: (qmail 8618 invoked by uid 102); 1 Apr 2016 23:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 19:55:35 -0400
Received: (qmail 32655 invoked by uid 107); 1 Apr 2016 23:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 19:55:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 19:55:32 -0400
Content-Disposition: inline
In-Reply-To: <F0F5A56A22F20D4CB4A03BB8D6658797E261AF97@SERVER2011.CS-SOFTWARE.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290589>

On Wed, Mar 30, 2016 at 09:08:56AM +0000, Florian Manschwetus wrote:

> After additional analysis it turned out, that in the case you
> mentioned, at least IIS, sets CONTENT_LENGTH to -1 resulting in the
> current behavior of git-http-backend being sufficient in this
> situation.
> Therefore I refactored the code again a bit, to match up the behavior
> I currently fake by using some bash magic...

OK, so I'd agree it makes sense to catch "-1", and read to EOF in that
case (or if CONTENT_LENGTH is NULL).

> From ccd6c88e39a850b253979b785463719cdc0fa1e2 Mon Sep 17 00:00:00 2001
> From: manschwetus <manschwetus@cs-software-gmbh.de>
> Date: Tue, 29 Mar 2016 12:16:21 +0200
> Subject: [PATCH 1/2] Fix http-backend reading till EOF, ignoring
>  CONTENT_LENGTH, violating rfc3875

Please send one patch per email, and these header bits should be the
header of your email.

Though we also generally revise and re-send patches, rather than
presenting one patch that has problems and then tacking fixes on top.
I'll ignore the problems in this patch 1, as it looks like it's just the
original one repeated.

> From 4b2aac3dfd4954098190745a9e4fa17f254cd6a1 Mon Sep 17 00:00:00 2001
> From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> Date: Wed, 30 Mar 2016 10:54:21 +0200
> Subject: [PATCH 2/2] restored old behavior as read_request_eof(...) and moved
>  new variant to read_request_fix_len(...) and introduced read_request(...) as
>  wrapper, which decides based on value retrieved from CONTENT_LENGTH which
>  variant to use

Please use a short subject for your commit message, followed by a blank
line and then a more explanatory body. Also, don't just describe _what_
is happening (we can see that from the diff), but _why_. You can find
more similar tips in SubmittingPatches.

> +/**
> + * wrapper function, whcih determines based on CONTENT_LENGTH value,
> + * to
> + * - use old behaviour of read_request, to read until EOF
> + * => read_request_eof(...)
> + * - just read CONTENT_LENGTH-bytes, when provided
> + * => read_request_fix_len(...)
> + */
> +static ssize_t read_request(int fd, unsigned char **out)
> +{
> +        /* get request size */
> +        size_t req_len = git_env_ulong("CONTENT_LENGTH",
> +                                           -1);
> +        if (req_len < 0){
> +          read_request_eof(fd, out);
> +        } else {
> +          read_request_fix_len(fd, req_len, out);
> +        }
> +}

I don't think "if (req_len < 0)" can ever trigger, because size_t is an
unsigned type (and I do not recall what kind of integer overflow
validation we do in git_env_ulong, but I suspect it may complain about
"-1"). You may have to parse the variable manually rather than using
git_env_ulong (i.e., pick out the NULL and "-1" cases, and then feed the
rest to git_parse_ulong()).

Also, a few style nits. We usually omit braces for one-line
conditionals, and please make sure there is whitespace between the
closing parenthesis and the opening brace. There's some discussing in
CodingGuidelines.

-Peff
