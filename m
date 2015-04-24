From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Fri, 24 Apr 2015 13:19:54 -0400
Message-ID: <20150424171953.GA30592@peff.net>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
 <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
 <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:20:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlhGk-0000fa-8g
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbbDXRT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 13:19:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:49708 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754202AbbDXRT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 13:19:57 -0400
Received: (qmail 24621 invoked by uid 102); 24 Apr 2015 17:19:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 12:19:56 -0500
Received: (qmail 17272 invoked by uid 107); 24 Apr 2015 17:20:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 13:20:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2015 13:19:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267744>

On Fri, Apr 24, 2015 at 09:16:28AM -0700, Stefan Beller wrote:

> I think it's a mistake to s/Could/could/g for all errors in the code base
> as it reduces the information provided in the error messages.
> Just 3 days ago ("Regular Rebase Failure"). I used different
> capitalization to get a better understanding where the error may be.
> 
> So if we throw away that information, we should add new information
> to make the spot of the error easily findable in the source.
> That's why I proposed the idea of the version,filename,linenumber
> as that is one of the strongest signals (most information in a short
> amount of text) I can imagine.

I do like that idea, and I think you could base it on the trace_printf
implementation. Note that it requires variadic macros, but I think
that's OK. Just like trace_printf, we can do the macro implementation
when we support that feature, and people on older systems just won't get
the extra file/line data.

I also assume we would not show this information by default, but only
with GIT_TRACE_ERRORS or something like that.

I would love it if we could also get a stack trace for warnings and
errors. Very often the line number of the error() call is not nearly as
interesting as the line number of the _caller_. But doing that portably
is rather hard. Maybe a better option would be to make it easier to
convince git to dump core at the right moments (e.g., dump core when we
hit die() rather than calling exit). And then you can run gdb on the
core file, which gives you a backtrace and much more.

-Peff
