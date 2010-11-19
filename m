From: Jeff King <peff@peff.net>
Subject: Re: pager config for external commands
Date: Fri, 19 Nov 2010 11:00:58 -0500
Message-ID: <20101119160058.GA7967@sigill.intra.peff.net>
References: <AANLkTimtjR0O3K8iGOVVVaFJS2+2wHcHhWf45tFYXjRQ@mail.gmail.com>
 <AANLkTimMSp8XVzoaax2mW-jYP26B+zF2QSJFcy4TUi60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 17:01:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJTOv-0008Q4-Ni
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 17:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab0KSQBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 11:01:06 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54641 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634Ab0KSQBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 11:01:04 -0500
Received: (qmail 24866 invoked by uid 111); 19 Nov 2010 16:01:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 16:01:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 11:00:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimMSp8XVzoaax2mW-jYP26B+zF2QSJFcy4TUi60@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161763>

On Fri, Nov 19, 2010 at 09:26:59AM -0600, Jeffrey Middleton wrote:

> External commands don't appear to support the pager.<cmd> config
> setting. It's implemented for builtins via the call to
> check_pager_config and associated code in run_builtin, but there's
> nothing like that in execv_dashed_external. Is there a reason not to
> implement this for external commands? I can't see one, since the
> --no-pager option does apply to them.

See 4e10738 (Allow per-command pager config, 2008-07-03) for some
discussion.

Basically the problem is that we just call execv("git-<cmd>"). If it
works, then we are running an external, but we no longer have an
opportunity to start the pager. If it doesn't, then we don't necessarily
want to commit our pager choice. We may be running an alias, or we may
simply barf with "no such command".

Later on, we started to use run_command instead of execv, but I don't
think that changes the situation.

I think what we really want to do is split out the "look up in PATH" bit
from run_command, actually find out if we have an external command, and
then commit to running it if it exists. If you're interested in working
on that, I think it would be great.

-Peff
