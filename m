From: Jeff King <peff@peff.net>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 21:57:38 -0400
Message-ID: <20120821015738.GA20271@sigill.intra.peff.net>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 03:57:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3dj1-0007DJ-2R
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 03:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab2HUB5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 21:57:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43219 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017Ab2HUB5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 21:57:41 -0400
Received: (qmail 25079 invoked by uid 107); 21 Aug 2012 01:57:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Aug 2012 21:57:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2012 21:57:38 -0400
Content-Disposition: inline
In-Reply-To: <7v628dght9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203916>

On Mon, Aug 20, 2012 at 06:22:26PM -0700, Junio C Hamano wrote:

> > "git config --system receive.denynonfastforwards true" is not honored.
> >  At all.  (And I checked there was nothing overriding it).
> >
> > "--global" does work (is honored).
> >
> > Tested on 1.7.11
> 
> Thanks, and interesting.
> 
> Does anybody recall if this is something we did on purpose?  After
> eyeballing the callchain starting from cmd_receive_pack() down to
> receive_pack_config(), nothing obvious jumps at me.

No, I do not think it was on purpose. And it would be very hard to do
so, anyway; config callbacks are not given any information about the
source of the config variable, and cannot distinguish between repo,
global, and system-level config variables.

> Could this be caused by a chrooted environment not having
> /etc/gitconfig (now I am just speculating)?

That seems far more likely to me. Another possibility is that the file
is not readable by the user running receive-pack.

> A quick "strace -f -o /tmp/tr git push ../neigh" seems to indicate
> that at least access() is called on "/etc/gitconfig" as I expect,
> which makes me think that near the beginning of git_config_early(),
> we would read from /etc/gitconfig if the file existed (I do not
> install any distro "git", so there is no /etc/gitconfig on my box).

I just did a few quick tests both across local repos and across an ssh
session. receive.denynonfastforwards worked just fine in my
/etc/gitconfig in both cases. So the likely cause would be that git
cannot access that file for some reason (chroot or permissions).

-Peff
