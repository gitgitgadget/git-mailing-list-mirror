From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 03:42:51 -0400
Message-ID: <20111003074250.GB9455@sigill.intra.peff.net>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:42:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAdAv-0002oI-Lm
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab1JCHmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:42:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51455
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab1JCHmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:42:53 -0400
Received: (qmail 24812 invoked by uid 107); 3 Oct 2011 07:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 03:47:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 03:42:51 -0400
Content-Disposition: inline
In-Reply-To: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182634>

On Sat, Oct 01, 2011 at 11:26:55AM +1000, Nguyen Thai Ngoc Duy wrote:

> This protocol has never been designed for pushing. Attempts to push
> over git:// usually result in
> 
>   fatal: The remote end hung up unexpectedly
> 
> That message does not really point out the reason. With this patch, we get
> 
>   error: this protocol does not support pushing
>   error: failed to push some refs to 'git://some-host.com/my/repo'

I thought pushing over git:// _is_ supported. It's just that most
servers don't have it turned on, for the obvious lack-of-authentication
reasons.

See 4b3b1e1 (git-push through git protocol, 2007-01-21), and the
discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/37325

Your patch shuts it off at the client level, so even with it turned on
for the server, the client can never get to it.

I still think push-over-git:// is a bit insane, and especially now with
smart-http, you'd be crazy to run it. And in that sense, I wouldn't mind
seeing it deprecated. But just shutting it off without a deprecation
period seems unnecessarily harsh.

The real problem here seems to be that instead of communicating "no, we
don't support that", git-daemon just hangs up. It would be a much nicer
fix if we could change that. I'm not sure it's possible, though. There's
not much room in the beginning of the room to make that communication in
a way that's backwards compatible.

-Peff
