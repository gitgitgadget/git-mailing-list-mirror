From: Jeff King <peff@peff.net>
Subject: Re: Running commands in wrong environment
Date: Fri, 4 Dec 2009 05:44:41 -0500
Message-ID: <20091204104441.GD27495@coredump.intra.peff.net>
References: <D6F784B72498304C93A8A4691967698E8EE2C44FE5@REX2.intranet.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Marinescu Paul dan <pauldan.marinescu@epfl.ch>
X-From: git-owner@vger.kernel.org Fri Dec 04 11:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGVeg-0006P5-Cf
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 11:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbZLDKoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 05:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbZLDKoh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 05:44:37 -0500
Received: from peff.net ([208.65.91.99]:46473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbZLDKog (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 05:44:36 -0500
Received: (qmail 18788 invoked by uid 107); 4 Dec 2009 10:49:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 04 Dec 2009 05:49:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2009 05:44:41 -0500
Content-Disposition: inline
In-Reply-To: <D6F784B72498304C93A8A4691967698E8EE2C44FE5@REX2.intranet.epfl.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134507>

On Thu, Dec 03, 2009 at 08:19:05PM +0100, Marinescu Paul dan wrote:

> git's start_command (run_command.c) executes a command (e.g. hook) but
> does not verify that it has properly set up the environment. It seems
> that in the unlikely case where putenv (run_command.c:117) fails, the
> command may have undesirable effects e.g. GIT_INDEX_FILE should have
> been set (interactive pre-commit hooks) but the default index will be
> used instead. It would be safer not to run the command but just exit
> in that case.--

Hmm. It is simple enough to patch the one use of putenv, but there are
34 other calls to setenv, which has the same problem. I am tempted to
ignore it, as it is extremely unlikely for this ever to happen, and
adding error checking everywhere reduces the code readability.

But the consequences, as you mention, could include data loss, which
argues for being on the safe side. In that case, we would probably want
an "xsetenv" to die() if we fail to avoid cluttering the code
everywhere.

I dunno. If we're going to do it, it is probably maint-worthy. Junio?

-Peff
