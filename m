From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Wed, 28 Dec 2011 13:40:00 -0500
Message-ID: <20111228184000.GA18780@sigill.intra.peff.net>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
 <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 19:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfyQ5-00081k-QI
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 19:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab1L1SkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 13:40:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53739
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab1L1SkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 13:40:03 -0500
Received: (qmail 4333 invoked by uid 107); 28 Dec 2011 18:46:50 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Dec 2011 13:46:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2011 13:40:00 -0500
Content-Disposition: inline
In-Reply-To: <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187752>

On Tue, Dec 27, 2011 at 01:52:35PM -0800, Junio C Hamano wrote:

> And if the answer to that tongue-in-cheek question is no, what is the
> reason why the users will not find the messages disturbing, while loathing
> the auto-gc?
> 
> I suspect that is because auto-gc takes long time, making the user wait,
> compared to the new message that may be noisy but quick.  Perhaps the real
> cure for the disease is not to add the message but to make an auto-gc less
> painful, no?
> 
> What are the things we could do to make auto-gc less painful?
>
> Are we doing something that is not necessary in auto-gc that takes time
> but that we can live without doing?

I don't personally find gc all that painful (though maybe that is
because I tend to gc myself and rarely hit the auto-gc), but I have
noticed that git-prune takes by far the most time to run. If you are
just doing an incremental pack, you might be packing only a few thousand
objects and not touching old history at all (and with many cores, the
delta compression flies by). But prune requires running "git rev-list
--objects --all", which takes something like 45 seconds for linux-2.6 on
my fast-ish laptop (and about 23 seconds for git.git).

We could perhaps cut out pruning in the auto-gc case unless there are a
lot of objects left over after the packing phase. It's not worth doing a
full prune to clean up a dozen objects[1]. It probably is if you have a
thousand objects left after packing.

-Peff

[1] Actually, it's not just having objects. You may have just exploded
    unreachable objects from a pack, but they are still younger than the
    2 week expiration period. Therefore trying to prune them is
    pointless, because even if they are unreachable, you won't delete
    them. So you really want to say "how many actual candidate objects
    do we have for pruning?"
