From: Jeff King <peff@peff.net>
Subject: Re: t7610-mergetool.sh test failure
Date: Fri, 27 May 2016 14:24:44 -0400
Message-ID: <20160527182444.GA1871@sigill.intra.peff.net>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net>
 <20160526015114.GA12851@sigill.intra.peff.net>
 <20160527044027.GA26143@gmail.com>
 <20160527050054.GA25774@sigill.intra.peff.net>
 <xmqqshx4row8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 20:24:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6MRI-0000jD-0F
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 20:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbcE0SYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 14:24:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:45344 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751307AbcE0SYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 14:24:47 -0400
Received: (qmail 6231 invoked by uid 102); 27 May 2016 18:24:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 14:24:46 -0400
Received: (qmail 31020 invoked by uid 107); 27 May 2016 18:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 14:24:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2016 14:24:44 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshx4row8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295781>

On Thu, May 26, 2016 at 11:33:27PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The only one I can think of is that if something leaves cruft in
> > $TMPDIR, it could affect later tests that want to `git add`
> > indiscriminately.
> 
> Or "git ls-files -u", "git clean", etc.  I'd mostly worry about a
> failed test in which a program dies without a chance to clean up
> after itself, and letting the cruft affecting the next test.

Yeah, exactly. OTOH, that could be considered a feature. If one of our
programs is leaving cruft in $TMPDIR, that is probably a bug that should
be fixed.

We wouldn't notice in most cases though (it would depend on some later
test actually caring about the cruft). So your "leave cruft in the
source directory but outside the trash directory" would be better there.
I'd worry slightly that it would cause problems when running tests in
parallel, though. Normal /tmp usage is OK with a global namespace (they
choose unique names), but sometimes things might use /tmp with a
well-known name as a rendezvous point (e.g, for sockets). But I guess
such cases are already broken for running in parallel, since /tmp is a
global namespace.

> I just checked my /tmp, and I see a lot of directories whose name
> look like mktemp generated one, with a single socket 's' in them.  I
> wouldn't be surprised if they turn out to be from our tests that
> expect failure, killing a daemon that does not properly clean after
> itself.  People probably would not notice if they are in /tmp, and
> if we moved TMPDIR to the trash, we still wouldn't (because running
> tests successfully without "-d" option will remove the trash
> directory at the end), but if it were dropped somewhere in the
> source tree, we have a better chance of noticing it.

Hmm. I'm not sure what would create a socket in git except the
credential-cache stuff, and that does not write into /tmp (there was a
GSoC-related series in March to move this, but I don't think it ever
even made it to pu). Maybe the new watchman stuff?

If you have inotify-tools, you can "inotifywait -m /tmp" and run "make
test", but it's quite noisy, as apparently a lot of tested commands use
tempfiles internally. Which perhaps shows that maybe some people would
see a performance regression if we moved from /tmp to a slower
filesystem (e.g., especially people whose git clone is on NFS or
something).

-Peff
