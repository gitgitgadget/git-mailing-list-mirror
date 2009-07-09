From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command line
Date: Thu, 09 Jul 2009 10:37:41 +0200
Message-ID: <200907091037.41329.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907081801.36901.johan@herland.net>
 <81b0412b0907090101x7c8aa182o36687d67be3c5fb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOp8Z-00009V-Ox
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbZGIIhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbZGIIhp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:37:45 -0400
Received: from mx.getmail.no ([84.208.15.66]:55652 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751459AbZGIIho (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:37:44 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI0063OAMU3G40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 10:37:42 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI00LBUAMTMA50@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 10:37:42 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.9.82422
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <81b0412b0907090101x7c8aa182o36687d67be3c5fb0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122944>

On Thursday 09 July 2009, Alex Riesen wrote:
> On Wed, Jul 8, 2009 at 18:01, Johan Herland<johan@herland.net> wrote:
> > On Wednesday 08 July 2009, Johannes Sixt wrote:
> >> ... don't you get this error message with errno set to EPIPE?
> >> Previously, there was no error message.
> >
> > Indeed, you are correct. I guess the following should be added to the
> > patch:
> >
> >        if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) <
> > 0 || write_in_full(revlist.in, "\n", 1) < 0) {
> > -               error("failed write to rev-list");
> > -               err = errno;
> > +               if (errno != EPIPE) {
> > +                       error("failed write to rev-list");
> > +                       err = errno;
>
> You'll loose errno this way: error() does not save it.

Not sure what you mean here. Should I move "err = errno;" outside the 
innermost "if"?

>From my POV, if errno != EPIPE, we save it into err, and return that 
(overridden by finish_command()'s return value, if non-zero). If errno == 
EPIPE, we're not interested in saving it, because we expect finish_command() 
to return non-zero in any case.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
