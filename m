From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 18/25] lockfile: avoid transitory invalid states
Date: Mon, 7 Apr 2014 15:38:34 -0400
Message-ID: <20140407193834.GD19342@sigill.intra.peff.net>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
 <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu>
 <534242AC.7030908@viscovery.net>
 <53428846.7060104@alum.mit.edu>
 <5342962A.8020608@viscovery.net>
 <5342A451.5020905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFNR-0000VX-UG
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbaDGTih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:38:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:55647 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754044AbaDGTig (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:38:36 -0400
Received: (qmail 15552 invoked by uid 102); 7 Apr 2014 19:38:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Apr 2014 14:38:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Apr 2014 15:38:34 -0400
Content-Disposition: inline
In-Reply-To: <5342A451.5020905@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245895>

On Mon, Apr 07, 2014 at 03:12:49PM +0200, Michael Haggerty wrote:

> > How far *do* you want to go? I'm certainly not opposed to field-test your
> > current changeset (plus and adjustment to use sig_atomic_t) -- overall it
> > is an improvement. And then we will see how it works.
> 
> For now I think I'd just like to get the biggest problems fixed without
> making anything worse.  Given that there might be a GSoC student working
> in this neighborhood, he/she might be able to take up the baton.
> 
> I changed the patch series to use a new "volatile sig_atomic_t active"
> field rather than a bit in a "flags" field.

That seems like a good place to stop for now.

If any code touches the fields, it can unset the "active" flag (even
temporarily), and restore it when the structure is in a known state.

I'm not sure if we can ever reach full safety. If you have an event
loop, the sane thing to do is set an atomic flag in your signal handler
and then handle it on the next iteration of the loop. But all of our
signal handlers are jumped to from arbitrary code, and are just going to
die(). There's nothing to return to, so any useful work we do has to be
done from the handler.

-Peff
