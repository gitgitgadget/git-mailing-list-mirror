From: Jeff King <peff@peff.net>
Subject: Re: [BUG] redundant error message
Date: Thu, 5 Dec 2013 16:00:00 -0500
Message-ID: <20131205210000.GA19617@sigill.intra.peff.net>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
 <20131205191518.GB19039@sigill.intra.peff.net>
 <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
 <20131205200306.GA13443@sigill.intra.peff.net>
 <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 22:00:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vog1n-0002Wt-CP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 22:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab3LEVAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 16:00:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:51198 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924Ab3LEVAC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 16:00:02 -0500
Received: (qmail 1694 invoked by uid 102); 5 Dec 2013 21:00:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 15:00:02 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 16:00:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238911>

On Thu, Dec 05, 2013 at 12:15:07PM -0800, Junio C Hamano wrote:

> >> Hmph, it looks like it is following the usual "zero-or-more dashed
> >> options, zero-or-more revs and then zero-or-one double-dash and then
> >> zero-or-more paths" rule to parse the thing.  "foobar" is a file and
> >> not a rev, so "--" should not be there, no?
> >> 
> >> Confused why you think it is not right...
> >
> > Because once you say "--", then all ambiguity goes away, no?
> 
> But it is tricky (not from implementation but from semantics point
> of view) to make rev-parse follow that "-- separates revs and paths"
> rule literally.  The primary use of rev-parse is to convert revs in
> extended SHA-1 expressions into concrete object names, so that
> scripts do not have to worry about having to deal with object names
> in a format that is not 40-hexdecimal.  "git rev-parse foobar --"
> that gives
> 
> 	foobar
>         --
> 
> without any error, because 'foobar' cannot be made into an object
> name, would be behaving in a way unexpected by the calling script,
> no?

Yes, I do expect an error. But it should not be "-- after filename". It
should be "foobar is not a revision".

Thinking on it more, though, the problem is purely limited to wrong
error messages. If "foobar" exists as a rev, we do parse it correctly.
If it does not, we are in the wrong code path, but it _must_ be an error
at that point (either because foobar does not exist as a file, or it
does and has "--" after it).

It would be nice to get the error messages right, though. I do not see
any reason why it could not follow the same steps as "git log",
converting revisions (or throwing an error as appropriate) on the left
side of the "--", and passing through the right side untouched.

-Peff
