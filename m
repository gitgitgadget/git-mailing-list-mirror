From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 16:55:33 -0400
Message-ID: <20140423205533.GA20582@sigill.intra.peff.net>
References: <20140416141519.GA9684@camelia.ucw.cz>
 <20140416154653.GB4691@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
 <20140417213238.GA14792@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
 <20140417215817.GA822@sigill.intra.peff.net>
 <20140423075325.GA7268@camelia.ucw.cz>
 <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
 <20140423191628.GA20596@sigill.intra.peff.net>
 <xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stepan Kasal <kasal@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4Cr-0005ui-35
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbaDWUzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:55:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:37054 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422633AbaDWUzf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:55:35 -0400
Received: (qmail 31354 invoked by uid 102); 23 Apr 2014 20:55:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 15:55:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 16:55:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246893>

On Wed, Apr 23, 2014 at 01:48:05PM -0700, Junio C Hamano wrote:

> > I don't think so. The point is that we _must_ use bash here, not any
> > POSIX shell.
> 
> Sorry, but I do not understand.  Isn't what you want "any POSIX
> shell with 'ulimit -s 64' supported"?

Sure, that would be fine, but the original patch which started this
thread claimed that bash was required. I had assumed that to be true,
but it seems like it's not:

>     $ dash -c 'ulimit -s && ulimit -s 64 && ulimit -s'
>     8192
>     64

If we are just using the same shell we are already running, then why
invoke it by name in the first place? IOW, why not:

  run_with_limited_stack () {
	(ulimit -s 64 && "$@")
  }

-Peff
