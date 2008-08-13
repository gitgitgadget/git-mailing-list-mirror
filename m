From: Jeff King <peff@peff.net>
Subject: Re: git -p does not detect a bare repository
Date: Wed, 13 Aug 2008 12:51:36 -0400
Message-ID: <20080813165135.GA19490@sigill.intra.peff.net>
References: <48A2E6D9.5000609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJaV-0006S2-Lw
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYHMQvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYHMQvk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:51:40 -0400
Received: from peff.net ([208.65.91.99]:1663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbYHMQvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:51:39 -0400
Received: (qmail 4268 invoked by uid 111); 13 Aug 2008 16:51:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 13 Aug 2008 12:51:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Aug 2008 12:51:36 -0400
Content-Disposition: inline
In-Reply-To: <48A2E6D9.5000609@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92242>

On Wed, Aug 13, 2008 at 03:51:21PM +0200, Johannes Sixt wrote:

> If $PWD is a bare repository, is it expected behavior that
> 
>   $ git diff-tree master^ master
> 
> works as expected, but
> 
>   $ git -p diff-tree master^ master
> 
> errors out:
> 
>   fatal: ambiguous argument 'master^': unknown revision or path blabla...

Yep. This has been broken for some time, too. I bisected it down to
cad3a205 from last year, which is in v1.5.3.

It's yet another incarnation of the same bug we keep seeing (which I
suppose is why you cc'd me). Anytime you look at the config before
running setup_git_directory, it screws up the GIT_DIR calculation for
bare repositories. AFAIK it's a bad interaction between the lazy setup
in setup_git_env and the magic in setup_git_directory.

I'm sure there is a "right" solution but I haven't had time to figure it
out yet. In this case, we are looking at the config to get the value of
core.pager. As a workaround, you could try doing that lookup in the
forked pager child (however, I don't think that would work on platforms
where run_command doesn't use fork).

-Peff
