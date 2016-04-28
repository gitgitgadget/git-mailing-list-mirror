From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Thu, 28 Apr 2016 13:44:24 -0400
Message-ID: <20160428174423.GA32486@sigill.intra.peff.net>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
 <20160428115748.37177-2-gitter.spiros@gmail.com>
 <CAGZ79kYe-WsAJj3xkr9YkHZbHqQ9rhKV80+K0Bx3SZsB85+tHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:44:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpzO-0004gr-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbcD1Ro2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:44:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:58606 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752560AbcD1Ro1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:44:27 -0400
Received: (qmail 5634 invoked by uid 102); 28 Apr 2016 17:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 13:44:26 -0400
Received: (qmail 12574 invoked by uid 107); 28 Apr 2016 17:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 13:44:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 13:44:24 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYe-WsAJj3xkr9YkHZbHqQ9rhKV80+K0Bx3SZsB85+tHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292929>

On Thu, Apr 28, 2016 at 10:26:06AM -0700, Stefan Beller wrote:

> > +'GIT_TRACE_CURL'::
> > +       Enables a curl full trace dump of all incoming and outgoing data,
> > +       including descriptive information, of the git transport protocol.
> > +       This is similar to doing curl --trace-ascii on the command line.
> > +       This option overrides setting the GIT_CURL_VERBOSE environment
> > +       variable.
> 
> How does it overwrite the GIT_CURL_VERBOSE variable?

You can't use both, as they are both triggered using the CURLOPT_VERBOSE
option of curl. The main difference is that with GIT_CURL_VERBOSE, we
rely on curl to print the information to stderr. With GIT_CURL_TRACE, we
do the printing ourselves (so we can tweak the output format, send it to
places other than stderr, etc).

> After a quick `grep -r GIT_CURL_VERBOSE`, I notice 2 things:
> 
> * apparently GIT_CURL_VERBOSE is used as a boolean,
>   so I presume we assume True for GIT_CURL_VERBOSE, but
>   extend it?

It's not a boolean. If the variable exists at all, we turn on verbose
output (so I guess you can consider it a boolean, but we do not parse
its contents as boolean; GIT_CURL_VERBOSE=false does not do what you
might think).

> * GIT_CURL_VERBOSE is not documented at all. (It is mentioned in
>   the release notes for 2.3.0, not sure if that counts as documentation)
>   As you know the area, care to send a documentation patch for
>   GIT_CURL_VERBOSE?

I think there is no need for GIT_CURL_VERBOSE once we have
GIT_TRACE_CURL. The latter is more flexible and matches the GIT_TRACE_*
interface we use elsewhere.

So I think we should consider GIT_CURL_VERBOSE deprecated (though I do
not mind keeping it for old-timers since it is literally one line of
code).

-Peff
