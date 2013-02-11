From: Jeff King <peff@peff.net>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 12:19:57 -0500
Message-ID: <20130211171957.GG16402@sigill.intra.peff.net>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
 <7v7gmeok2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4x3I-0005Q2-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130Ab3BKRUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:20:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44382 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838Ab3BKRT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:19:59 -0500
Received: (qmail 24157 invoked by uid 107); 11 Feb 2013 17:21:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:21:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:19:57 -0500
Content-Disposition: inline
In-Reply-To: <7v7gmeok2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216062>

On Mon, Feb 11, 2013 at 09:07:53AM -0800, Junio C Hamano wrote:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > However, since git only looks at one byte at the time for
> > short-options, it ends up reporting a partial UTF-8 sequence
> > in such cases, leading to corruption of the output.
> 
> Isn't it a workable, easier and more robust alternative to punt and
> use the entire ctx.argv[0] as unrecognized?

Yes, but it regresses the usability:

  [before]
  $ git foobar -qrxs
  unknown switch: x

  [after]
  $ git foobar -qrxs
  unknown switch: -qrxs

One is much more informative than the other, and you are punishing the
common ascii case for the extremely uncommon case of utf-8. Maybe:

  if (isascii(*ctx.opt))
          error("unknown option `%c'", *ctx.opt);
  else
          error("unknown multi-byte short option in string: `%s'", ctx.argv[0]);

which only kicks in in the uncommon case (and extends the error message
to make it more clear why we are showing the whole string).

-Peff
