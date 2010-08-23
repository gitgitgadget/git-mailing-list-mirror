From: Jeff King <peff@peff.net>
Subject: Re: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Mon, 23 Aug 2010 16:33:04 -0400
Message-ID: <20100823203304.GB4458@coredump.intra.peff.net>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
 <AANLkTi=R6ZdD9GUO6T6uCUkF+KVPbG1FGrieOfeusKct@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 22:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ondhh-0002wY-CV
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab0HWUdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 16:33:08 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964Ab0HWUdH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 16:33:07 -0400
Received: (qmail 13015 invoked by uid 111); 23 Aug 2010 20:33:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Mon, 23 Aug 2010 20:33:06 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Aug 2010 16:33:04 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=R6ZdD9GUO6T6uCUkF+KVPbG1FGrieOfeusKct@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154255>

On Mon, Aug 23, 2010 at 09:02:36PM +0200, Alex Riesen wrote:

> Maybe it is worth fixing, but on a case-by-case basis?
> 
> I mean changing the execv_git_cmd interface (or create a new execv
> function), so that it can get the list of config vars to pass down to
> the callee. A trivial case of its use would be to just pass the
> current config (or, more likely, none).  Or, one could give it its own
> list of config parameters.

I don't think that is enough. We don't necessarily know which config
options will be relevant to exec'd processes. We could be running some
user-defined command that calls a bunch of other git commands. Or a
hook, for that matter.

Which does bring up one interesting boundary. If I run:

  git -c receive.denyDeletes=false git push

what should happen? Obviously with cross-server communication the
environment won't get passed. I am inclined to say that even for local
cases, receive-pack should clear the string. Certainly for the sake of
consistency between local and remote transports, but it may also be a
security issue (in most cases, no, since you would have to be exec'ing
receive-pack directly, and you are clearly already running an arbitrary
command, but I can see somebody perhaps crossing a setuid boundary with
receive-pack).

-Peff
