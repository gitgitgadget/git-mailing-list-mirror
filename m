From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues
	with --graph
Date: Mon, 7 Apr 2008 09:17:29 -0400
Message-ID: <20080407131728.GA20319@sigill.intra.peff.net>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net> <1207555281-9362-1-git-send-email-adam@adamsimpkins.net> <1207555281-9362-2-git-send-email-adam@adamsimpkins.net> <7vod8mqdlw.fsf@gitster.siamese.dyndns.org> <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JirEn-0004B4-63
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 15:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYDGNRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 09:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYDGNRc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 09:17:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3403 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbYDGNRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 09:17:32 -0400
Received: (qmail 9692 invoked by uid 111); 7 Apr 2008 13:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 07 Apr 2008 09:17:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Apr 2008 09:17:29 -0400
Content-Disposition: inline
In-Reply-To: <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78973>

On Mon, Apr 07, 2008 at 01:52:40AM -0700, Junio C Hamano wrote:

> Some alternatives to specify terminator semantics I considered are:
> [...]
> The first one is what I suggested in the message, but it feels somewhat
> hacky.  I suspect that the second one would catch 99% of the cases, but it
> is DWIM and it is known that DWIM can go wrong.  I favor design along
> the lines of (3) or (4), which I think would be much cleaner.

How about:

  (5) There is no automagic terminator or separator for user formats. %n
      translates to a newline. %N translates to a newline, unless this
      is the final record, in which case it translates to the empty
      string.

So:
    # oneline
    git log --pretty=format:'%h %s%n'
    # multiline
    git log --pretty=format:'%h%nSubject: %s%n%N'

The main drawback is that dropping the automatic separator breaks
existing uses. We could work around this by automatically appending '%n'
if there is no use of "%n" or "%N", but I think that DWIM won't work for
formats which want a non-newline record separator. So maybe a %x/%X
string to mean "separator / terminator" instead of building on newline.
If one doesn't exist, we append "%x" to the format (to give oneline
semantics).

-Peff
