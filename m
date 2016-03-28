From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] path.c enter_repo(): fix unproper strbuf unwrapping
 and memory leakage
Date: Mon, 28 Mar 2016 13:55:28 -0400
Message-ID: <20160328175528.GB20028@sigill.intra.peff.net>
References: <20160325175947.GC10563@sigill.intra.peff.net>
 <1459180570-5521-1-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:55:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akbO4-0005Wh-BU
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 19:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcC1Rzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 13:55:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:39471 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751004AbcC1Rzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 13:55:31 -0400
Received: (qmail 17009 invoked by uid 102); 28 Mar 2016 17:55:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Mar 2016 13:55:30 -0400
Received: (qmail 14852 invoked by uid 107); 28 Mar 2016 17:55:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Mar 2016 13:55:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2016 13:55:28 -0400
Content-Disposition: inline
In-Reply-To: <1459180570-5521-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290052>

On Mon, Mar 28, 2016 at 11:56:10PM +0800, Hui Yiqun wrote:

> According to strbuf.h, strbuf_detach is the sole supported method
> to unwrap a memory buffer from its strbuf shell.
> 
> So we should not return the pointer of strbuf.buf directly.
> 
> What's more, some memory leakages are solved.

There is something else going on here, which makes this case different
than some others. Note that the function returns a const string:

> diff --git a/path.c b/path.c
> index 969b494..b07e5a7 100644
> --- a/path.c
> +++ b/path.c
> @@ -625,6 +625,7 @@ const char *enter_repo(const char *path, int strict)

By convention, that means that the result is not owned by the caller,
and should not be freed. We implement that by:

>  {
>  	static struct strbuf validated_path = STRBUF_INIT;
>  	static struct strbuf used_path = STRBUF_INIT;

...using static variables which persist after the call returns. So this
function retains ownership of the memory, and it remains valid until the
next call to enter_repo().

There's no leak when we return NULL, because the function retains
control of the memory (though it will hold onto it until the end of the
program if nobody calls enter_repo() again). And thus we shouldn't use
strbuf_detach(), which loses that reference to the memory (and since the
callers don't take ownership, it actually _creates_ a leak).

We could release the memory when returning, but I don't think it's a big
deal to do so.

-Peff
