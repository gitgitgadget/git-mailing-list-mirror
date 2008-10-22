From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] archive: fix setup to work in bare repositories
Date: Wed, 22 Oct 2008 16:46:50 -0400
Message-ID: <20081022204650.GD4585@coredump.intra.peff.net>
References: <gdmp0p$92r$1@ger.gmane.org> <20081022130829.GC2015@riemann.deskinm.fdns.net> <gdnsca$92r$2@ger.gmane.org> <20081022203722.GD2015@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kenneth johansson <ken@kenjo.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:48:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kskcg-0006hj-SH
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYJVUqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbYJVUqy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:46:54 -0400
Received: from peff.net ([208.65.91.99]:1945 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbYJVUqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:46:53 -0400
Received: (qmail 4423 invoked by uid 111); 22 Oct 2008 20:46:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:46:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:46:50 -0400
Content-Disposition: inline
In-Reply-To: <20081022203722.GD2015@riemann.deskinm.fdns.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98910>

On Wed, Oct 22, 2008 at 04:37:22PM -0400, Deskin Miller wrote:

> cmd_archive was calling git_config -> setup_git_env prior to
> write_archive calling setup_git_directory.  In a bare repository, the
> former will set git_dir to be '.git' since the latter has not
> determined that it's operating in a bare repository yet.
> 
> Things are complicated, however, by the fact that git archive --list
> should work from anywhere, not just in git repositories, so that
> argument needs to be checked for before setup_git_directory is called.

Should you perhaps be able to call setup_git_directory_gently(), and
then once you decide that you really do need the setup, call
setup_git_directory()?

You would have to add a "did we already do run" flag to
setup_git_directory_gently(), but I think it is already an error to call
it twice, so you wouldn't be hurting anything by that.

Note also that by moving the setup, you are moving the chdir() that
happens; you may need to prefix paths to any arguments to accomodate
this (I don't think it should matter, since git-archive shouldn't look
at any paths until after it would have done the setup_git_directory()
before, but I didn't check carefully).

-Peff
