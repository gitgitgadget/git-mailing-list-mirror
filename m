From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Thu, 4 Dec 2014 04:04:06 -0500
Message-ID: <20141204090406.GA27455@peff.net>
References: <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141203210031.GA6631@peff.net>
 <20141203213858.GC6527@google.com>
 <20141204075920.GA27142@peff.net>
 <CAGZ79kby-RdwzgXWvVgD42uiEis7SCnuAdSjO2EL03uN4s=LgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:04:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwSKe-0005fP-D6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 10:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbaLDJEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 04:04:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:48236 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751785AbaLDJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 04:04:09 -0500
Received: (qmail 22599 invoked by uid 102); 4 Dec 2014 09:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 03:04:09 -0600
Received: (qmail 4747 invoked by uid 107); 4 Dec 2014 09:04:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 04:04:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 04:04:06 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kby-RdwzgXWvVgD42uiEis7SCnuAdSjO2EL03uN4s=LgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260747>

On Thu, Dec 04, 2014 at 12:36:46AM -0800, Stefan Beller wrote:

> > Your solution adds a strbuf. That helps with context and stomping, but
> > loses readability and adds allocation.
> 
> > If we changed the strbuf to a fixed-size buffer, that would help the
> > allocation issue. Some messages might be truncated, but it seems
> > unlikely in practice. It still loses readability, though.
> 
> > What about a struct that has an errno-like value _and_ a fixed-size
> > buffer? I'm thinking something like:
> 
> What do you mean by the allocation being an issue?

I mean that the caller has to take care of releasing the memory. This
adds boilerplate to the caller, and is a potential source of leaks.

> We're only populating the error buffer in the error case, so you're
> not talking about performance/speed I'd assume?

No, I don't care about performance here. Only code maintainability.

> As error handling breaks in the least expected ways, I'd rather go
> with well tested string buffer codes there?

We'd still be building on snprintf. And with a known-size buffer, we can
wrap the formatting so that the callers don't even have to care (see the
mkerror example I posted).

-Peff
