From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5528: do not fail with FreeBSD shell
Date: Sun, 8 Mar 2015 13:56:25 -0400
Message-ID: <20150308175624.GA30399@peff.net>
References: <e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 18:56:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUfRJ-0002rc-S1
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 18:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbbCHR43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 13:56:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:58862 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932078AbbCHR42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 13:56:28 -0400
Received: (qmail 5825 invoked by uid 102); 8 Mar 2015 17:56:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Mar 2015 12:56:28 -0500
Received: (qmail 556 invoked by uid 107); 8 Mar 2015 17:56:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Mar 2015 13:56:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Mar 2015 13:56:25 -0400
Content-Disposition: inline
In-Reply-To: <e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265099>

On Sun, Mar 08, 2015 at 08:37:50AM -0700, Kyle J. McKay wrote:

> The FreeBSD shell converts this expression:
> 
>   git ${1:+-c push.default="$1"} push
> 
> to this when "$1" is not empty:
> 
>   git "-c push.default=$1" push
> 
> which causes git to fail.

Hmph, just when I thought I knew about all of the weird shell quirks. :)

I am not convinced this isn't a violation of POSIX (which specifies that
field splitting is done on the results of parameter expansions outside
of double-quotes). But whether it is or not, we have to live with it.

For my own curiosity, what does:

  foo='with space'
  printf "%s\n" ${foo:+first "$foo"}

print? That is, are the double-quotes even doing anything on such a
shell? On bash and dash, it prints:

  first
  with space

which is what I would expect. So does "ash" (0.5.7, packaged for
Debian), which is what I _thought_ FreeBSD's shell was based on. But
clearly there is some divergence.

I guess they are getting eaten by your shell, otherwise we would pass
them along to git in the test script, which would complain.

> ---
>  t/t5528-push-default.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch itself looks obviously correct.

-Peff
