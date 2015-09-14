From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 13:17:36 -0400
Message-ID: <20150914171736.GA1548@sigill.intra.peff.net>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
 <1442012994-20374-3-git-send-email-sbeller@google.com>
 <xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:17:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXNw-0001HD-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbbINRRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:17:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:58845 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753857AbbINRRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:17:39 -0400
Received: (qmail 31455 invoked by uid 102); 14 Sep 2015 17:17:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 12:17:39 -0500
Received: (qmail 30447 invoked by uid 107); 14 Sep 2015 17:17:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 13:17:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2015 13:17:36 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277845>

On Mon, Sep 14, 2015 at 09:46:58AM -0700, Stefan Beller wrote:

> I tried implementing a buffering solution for both stdout and stderr,
> but that doesn't really workout well if you consider interleaved output
> on the pipes as we cannot accurately replay that later on. To do that
> we would need to store the timing information of the channels, at least
> the relative order of it like:
> 
>   (stdout, First comes text to stdout),
>   (stderr, interrupted by text in stderr)
>   (stdout, but stdout doesn't bother, blasting more text)
>   (stderr, continues to interrupt)
> 
> obtaining the information is inherently racy, as all we can do is
> polling/reading from both stdout/err as fast as possible but without
> proper synchronization mechanisms we cannot be sure.

I don't think you need exact timing information.  This is no different
than running the commands themselves, with stdout and stderr writing to
a pty that your terminal emulator will then read() from. If the program
produces intermingled stdout/stderr that clogs up the terminal, that is
its problem.

The only difference is that we're going to save it and later replay it
all very quickly.  So I think it would be sufficient just to retain the
original order.

> I will add documentation explaining why the async output case
> will only deal with one channel. I chose stderr as that's already
> available and needed in this use case.

I suspect you could just set child->stdout_to_stderr in this case, and
then you get your ordering for free. But probably in the general case
people would want to run inspection commands that produce a useful
stdout.

To handle multiple channels, I think you could just do a linked list of
buffers rather than a single strbuf. Like:

  struct io_chunk {
	int channel;
	char *buf;
	size_t len;
	struct io_chunk *next;
  };

and just keep appending chunks to the list (and to dump them, just walk
the list, writing each to the appropriate channel descriptor).

-Peff
