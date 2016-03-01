From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command
 line
Date: Mon, 29 Feb 2016 20:36:16 -0500
Message-ID: <20160301013616.GA18301@sigill.intra.peff.net>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
 <CA+P7+xrr61wO0XrhXCEbSLPbSo7HxxzDWnq=6K14fvyo7RfscA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:36:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZEk-0003b6-4I
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 02:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbcCABgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 20:36:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:52125 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750760AbcCABgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 20:36:24 -0500
Received: (qmail 24991 invoked by uid 102); 1 Mar 2016 01:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 20:36:18 -0500
Received: (qmail 3210 invoked by uid 107); 1 Mar 2016 01:36:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 20:36:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 20:36:16 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xrr61wO0XrhXCEbSLPbSo7HxxzDWnq=6K14fvyo7RfscA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287981>

On Mon, Feb 29, 2016 at 03:44:51PM -0800, Jacob Keller wrote:

> On Mon, Feb 29, 2016 at 3:39 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> >>
> >> +test_expect_success 'cmdline credential config passes into submodules' '
> >> +       git init super &&
> >> +       set_askpass user@host pass@host &&
> >
> > I wonder why we use pass@host as a password, it seems confusing to me.
> > p@ssword would have worked if we wanted to test a password containing an @,
> > pass@host doesn't quite fit my mental model of how passwords work.
> > No need to change anything, better be consistent with the rest of the tests.
> >
> 
> I am not sure, but I don't think it particularly matters what we use.
> Most of this is pretty much copied as suggested by Peff.

Yes, this dates back to 3cf8fe1 (t5550: test HTTP authentication and
userinfo decoding, 2010-11-14), and the point is just to have an "@" in
each field. And then because that's the only username defined in the
apache setup, it's the one all the tests use. :)

I also have found it off-putting, because it looks like "host" is
supposed to be meaningful. Perhaps the original author had a case where
their web authentication involved a hostname (which seems plausible for
a hosting site which covers multiple domains).

It might be nice to fix that, either by using something like "us@r" and
"p@ssword", or possibly by just introducing a new, easier to read
alternative to lib-httpd/passwd and using it, as most sites are not
testing URL parsing (though I suppose that using the @-filled ones
consistently means we _do_ test the other code paths more thoroughly).

But either way, I don't think it should be part of this series, which
has already expanded well beyond its original 1-patch goal.

> > Why set set_askpass a second time here?
> 
> Interesingly, it fails unless I add this line with:
> [...]
> I really don't understand why adding the extra askpass setting fixes
> this? Possibly because the query and expect files are appended to? Or
> something else subtle going on?

Right. The askpass test-helper logs the queries it gets, and
expect_askpass makes sure that we got the right set of queries. It has
to append to the query-log because it may be invoked multiple times
(e.g., once for the username, once for the password). So we have to
clear the query log, and that is one of the things that set_askpass does
(the other, obviously, is writing the user/pass values for askpass to
feed back to git). Perhaps it should have been called init_askpass or
something, but I don't think it's worth changing now.

You could get away with just:

  >"$TRASH_DIRECTORY/askpass-query"

but IMHO it is less obscure to just call set_askpass a second time.

-Peff
