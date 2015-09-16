From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 05:45:17 -0400
Message-ID: <20150916094517.GA13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <55F8643D.6040800@ramsayjones.plus.com>
 <20150915184211.GA31939@sigill.intra.peff.net>
 <CAGZ79kb5qWnOnJGY8JR3Z9UqT2xp390A6-LvNudBk=e3N2W41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:45:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9HP-0002ZU-59
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 11:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbbIPJp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 05:45:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:59827 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbbIPJp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 05:45:26 -0400
Received: (qmail 13006 invoked by uid 102); 16 Sep 2015 09:45:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 04:45:26 -0500
Received: (qmail 16366 invoked by uid 107); 16 Sep 2015 09:45:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:45:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 05:45:17 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kb5qWnOnJGY8JR3Z9UqT2xp390A6-LvNudBk=e3N2W41Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278011>

On Tue, Sep 15, 2015 at 01:38:42PM -0700, Stefan Beller wrote:

> Some off topic thoughts:
> 
> Having an "assert" behavior is not a good user experience though
> and should be fixed. To fix it we need stack traces. And the git
> version. And telling the user to send it to the mailing list.

Yes, any assert (or die("BUG")) should generally result in a code change
to make it never happen again.

I have been tempted to replace our die("BUG") calls with a BUG() macro,
so that we can do more fancy things (even if it is just adding
__FILE__:__LINE__ and a message to contact the list).

> I wonder if we want to include a trace where possible (i.e.
> when compiled with gcc or other precompiler conditions)
> into these assertive behaviors.

That would be nice. I took a look at this back in April:

  http://thread.gmane.org/gmane.comp.version-control.git/267643/focus=267755

but I think I convinced myself that we are better off relying on people
running gdb. If we do anything, it should be to make doing so easier.

> I'd guess we have an assertive behavior if die("BUG:...") is called,
> so maybe we can just check inside of die if we want to print
> a stack trace additionally ?

I guess we could look for starts_with(fmt, "BUG: ") in die(). I think it
would be a bit less gross to convert those calls to a BUG() macro (we
can't get accurate __LINE__ information without it, though in practice
the die messages are usually unique enough to be helpful).

I think a core file is even more useful than a backtrace. Having BUG()
call abort() would be even more useful, I think.

-Peff
