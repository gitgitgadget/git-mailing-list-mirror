From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5561: get rid of racy appending to logfile
Date: Wed, 23 Sep 2015 21:45:41 -0400
Message-ID: <20150924014541.GB6442@sigill.intra.peff.net>
References: <20150923232443.GA21755@sigill.intra.peff.net>
 <1443054017-8312-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 03:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZevbY-0002dP-C9
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 03:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbbIXBpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 21:45:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:35501 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932095AbbIXBpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 21:45:43 -0400
Received: (qmail 25709 invoked by uid 102); 24 Sep 2015 01:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Sep 2015 20:45:43 -0500
Received: (qmail 21785 invoked by uid 107); 24 Sep 2015 01:45:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Sep 2015 21:45:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Sep 2015 21:45:41 -0400
Content-Disposition: inline
In-Reply-To: <1443054017-8312-1-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278527>

On Thu, Sep 24, 2015 at 02:20:17AM +0200, Stephan Beyer wrote:

> The definition of log_div() appended information to the web server's
> logfile to make the test more readable. However, it could happen that
> this information is written before the web server writes its log line
> (this consistently happens with a PROFILE=GEN build), and hence the
> test failed.

I don't know if you want to add more detail here or not, but I believe
the race is based on the amount of time between git-http-backend
finishes serving the request, and when the process exits. We run
log_div() as soon as the first is done, but Apache waits for the latter
to flush out the logfile. And PROFILE=GEN lengthens that time.

> To get rid of this behavior, the logfile is not touched at all. This
> commit removes log_div() and its calls. The readability-improving
> information is kept in the test but filtered out before comparing
> it to the actual logfile.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  t/t5560-http-backend-noserver.sh |  4 ----
>  t/t5561-http-backend.sh          |  8 +-------
>  t/t556x_common                   | 12 ------------
>  3 files changed, 1 insertion(+), 23 deletions(-)

This looks good to me.

I'd have written the grep as:

> -cat >exp <<EOF
> +grep -e '^[GP]' >exp <<EOF

grep '^[^#]' >exp <<EOF

to exclude blank lines and comments, but I doubt it matters in practice
(I cannot imagine any line except GET or POST here).

-Peff
