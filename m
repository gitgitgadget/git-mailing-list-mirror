From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sat, 8 Nov 2014 03:30:41 -0500
Message-ID: <20141108083040.GA15833@peff.net>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 09:30:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn1Q7-0007Ha-9W
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 09:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbaKHIap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 03:30:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:37867 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753341AbaKHIao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 03:30:44 -0500
Received: (qmail 29378 invoked by uid 102); 8 Nov 2014 08:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 02:30:44 -0600
Received: (qmail 1045 invoked by uid 107); 8 Nov 2014 08:30:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 03:30:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 03:30:41 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 11:35:59PM -0800, Junio C Hamano wrote:

> I think that has direct linkage; what you have in mind I think is
> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234935

Thanks for that link.

I did spend a few hours on this topic earlier today, and got very
confused trying to figure out what the deletion behavior _should_ be,
and whether I was breaking it.  For some reason I had zero recollection
of a conversation from last year that I was obviously a major part of. I
think I am getting old. :)

The end of that thread concludes that a diff-based approach is not going
to work, because we need to update the working tree even for files not
mentioned by the diff. I do not think that is a show-stopper, though.
It just means that we need to load the new index as one step (done now
with read_tree_recursive, but ideally using diff), and then walk over
the whole resulting index applying our pathspec again (instead of
relying on CE_UPDATE flags).

This turns out not to be a big deal, because the existing code is
already doing most of that second pathspec application anyway. It does
it because read_tree_recursive is not smart enough to update the "seen"
bits for the pathspec. But now we would have another reason to do it
this way. :)

So just to be clear, the behavior we want is that:

  echo foo >some-new-path
  git add some-new-path
  git checkout HEAD -- .

will delete some-new-path (whereas the current code turns it into an
untracked file). What should:

  git checkout HEAD -- some-new-path

do in that case? With the current code, it actually barfs, complaining
that nothing matched some-new-path (because it is not part of HEAD, and
therefore we don't consider it at all), and aborts the whole operation.
I think we would want to delete some-new-path in that case, too.

-Peff
