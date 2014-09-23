From: Jeff King <peff@peff.net>
Subject: Re: [Bug] Query string not being phrased correctly when question
 marks present in config URL.
Date: Tue, 23 Sep 2014 05:06:27 -0400
Message-ID: <20140923090627.GB7644@peff.net>
References: <CAOf__z5DTzchZpnz-DzoOEHnt8RdypV7=RPP1=AzinsskQEg8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven Lawler <steven.lawler777@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWM3T-0004Lc-1k
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 11:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbaIWJGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 05:06:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:50861 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753337AbaIWJGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 05:06:30 -0400
Received: (qmail 8851 invoked by uid 102); 23 Sep 2014 09:06:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 04:06:30 -0500
Received: (qmail 25662 invoked by uid 107); 23 Sep 2014 09:06:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 05:06:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 05:06:27 -0400
Content-Disposition: inline
In-Reply-To: <CAOf__z5DTzchZpnz-DzoOEHnt8RdypV7=RPP1=AzinsskQEg8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257408>

On Tue, Sep 23, 2014 at 04:20:55AM +1000, Steven Lawler wrote:

> Cause:
> [remote "repo"]
>   url = http://example.com/git/example.com?foo=bar
> There is a question mark in the URL of the repo URL.

Is the question mark there because it is separating query parameters
from the path, or is "?foo=bar" part of the literal path? If the latter,
it needs to be percent-escaped.

> Effect (Taken from Apache logs):
> [22/Sep/2014:14:12:07 -0400] "GET
> /git/example.com?foo=bar/info/refs&service=git-receive-pack HTTP/1.1"
> 403 207 "-" "git/1.9.4.msysgit.1"
> 
> Git attempts to correct the issue by making the query string continue
> using ampersands where it would have started the original query
> string.

It has to, because:

  http://example.com/git/example.com?foo=bar?service=git-receive-pack

would not mark the "service" parameter as a separate parameter of the
query-string.  However, from your expected output below, I do not think
that part is the thing you are complaining about:

> Expected outcome:
> The git client should move the ?foo=bar onto the beginning (or end) of
> the query string that it is creating. For example:
> [22/Sep/2014:14:12:07 -0400] "GET
> /git/example.com/info/refs?foo=bar&service=git-receive-pack HTTP/1.1"
> 403 207 "-" "git/1.9.4.msysgit.1"

The difference here is not the ampersand but the placement of
"info/refs".  Let's forget about the "service" parameter for a moment.
Git needs to access the "info/refs" directory of the repo specified by
the URL it is passed. Given:

  http://host/path?key=value

which part of the URL specifies the path to the repository (and that we
could munge to access info/refs)? I do not think there is a well-defined
answer. If "path" is the path to the repo and "key=value" is an
unrelated parameter, you would want:

  http://host/path/info/refs?key=value

which matches your example. But if the key is specifying the repository
path in its value, you would want to append it directly there. For
example,

  http://host/git?path=my-repo.git

should become:

  http://host/git?path=my-repo.git/info/refs

So I think you would need a config option or other mechanism to specify
which form your URL requires.

-Peff
