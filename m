From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Fri, 25 Jan 2013 17:24:11 -0500
Message-ID: <20130125222411.GD23626@sigill.intra.peff.net>
References: <cover.1359126360.git.Alex.Crezoff@gmail.com>
 <4de442db9fd0896f78166e6038b6ea35ed5ab266.1359126360.git.Alex.Crezoff@gmail.com>
 <20130125174700.GA3700@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrhL-0005tg-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3AYWYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:24:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51105 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116Ab3AYWYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:24:13 -0500
Received: (qmail 17143 invoked by uid 107); 25 Jan 2013 22:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Jan 2013 17:25:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2013 17:24:11 -0500
Content-Disposition: inline
In-Reply-To: <20130125174700.GA3700@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214592>

On Fri, Jan 25, 2013 at 06:47:00PM +0100, Krzysztof Mazur wrote:

> On Fri, Jan 25, 2013 at 07:28:54PM +0400, Alexey Shumkin wrote:
> > "git format-patch --attach/--inline" generates multi-part messages.
> > Every part of such messages can contain non-ASCII characters with its own
> > "Content-Type" and "Content-Transfer-Encoding" headers.
> > But git-send-mail script interprets a patch-file as one-part message
> > and does not recognize multi-part messages.
> > So already quoted printable email subject may be encoded as quoted printable
> > again. Due to this bug email subject looks corrupted in email clients.
> 
> I don't think that the problem with the Subject is multi-part message
> specific. The real problem with the Subject is probably that
> is_rfc2047_quoted() does not detect that the Subject is already quoted.

I have not even looked at this problem at all, but seeing this function
name:

> >  sub body_or_subject_has_nonascii {

Makes me think something is very wrong. The subject line should not have
anything to do whatsoever with a content-type or
content-transfer-encoding header. It should either be rfc2047 encoded or
not, and the encoding used does not have to correspond to what is used
elsewhere in the message. rfc2047 is very clear that other MIME headers
are not necessary to interpret encoded words in headers.

So this loop:

	foreach my $f (@files) {
	        next unless (body_or_subject_has_nonascii($f)
	                     && !file_declares_8bit_cte($f));
	        $broken_encoding{$f} = 1;
	}

does not seem right at all. Only the body depends on the 8bit CTE.

-Peff
