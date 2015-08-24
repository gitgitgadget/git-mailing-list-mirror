From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] am: terminate state files with a newline
Date: Mon, 24 Aug 2015 01:13:44 -0400
Message-ID: <20150824051344.GA12490@sigill.intra.peff.net>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
 <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
 <20150823055053.GA15849@yoshi.chippynet.com>
 <xmqqy4h16d1f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tan <pyokagan@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 07:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTk4u-0002fb-1P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 07:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbbHXFNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 01:13:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:48873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750802AbbHXFNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 01:13:47 -0400
Received: (qmail 1081 invoked by uid 102); 24 Aug 2015 05:13:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 00:13:47 -0500
Received: (qmail 20043 invoked by uid 107); 24 Aug 2015 05:13:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 01:13:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 01:13:44 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4h16d1f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276431>

On Sun, Aug 23, 2015 at 12:05:32PM -0700, Junio C Hamano wrote:

> > -	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f");
> > +	write_file(am_path(state, "threeway"), 1, "%s\n", state->threeway ? "t" : "f");
> 
> Stepping back a bit, after realizing that "write_file()" is a
> short-hand for "I have all information necessary to produce the full
> contents of a file, now go ahead and create and write that and
> close", I have to wonder what caller even wants to create a file
> with an incomplete line at the end.

FWIW, I had a similar thought when reading the original thread. I also
noted that all of the callers here pass "1" for the "fatal" parameter,
and that they are either bools or single strings. I wonder if:

  void write_state_bool(struct am_state *state, const char *name, int v)
  {
	write_file(am_path(state, name), 1, "%s\n", v ? "t" : "f");
  }

would make the call-sites even easier to read (and of course the "\n"
would be dropped here if it does migrate up to write_file()).

> @@ -634,6 +641,9 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
>  	va_start(params, fmt);
>  	strbuf_vaddf(&sb, fmt, params);
>  	va_end(params);
> +	if (sb.len)
> +		strbuf_complete_line(&sb);
> +

I think the "if" here is redundant; strbuf_complete_line already handles
it.

-Peff
