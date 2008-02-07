From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Thu, 7 Feb 2008 19:02:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802071855550.8543@racer.site>
References: <20080206102608.GA1007@coredump.intra.peff.net> <47A98F07.4000402@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNC3I-0007NR-4f
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 20:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760584AbYBGTDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760446AbYBGTDi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 14:03:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:38997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760594AbYBGTDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 14:03:35 -0500
Received: (qmail invoked by alias); 07 Feb 2008 19:03:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 07 Feb 2008 20:03:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ELnBQaKXEpgAf88SWUx2N+dUOj7iTLVWq9+6W4j
	x3676l0dVaAHqW
X-X-Sender: gene099@racer.site
In-Reply-To: <47A98F07.4000402@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72989>

Hi,

On Wed, 6 Feb 2008, Johannes Sixt wrote:

> Jeff King schrieb:
> > In setup_git_directory_gently, we have a special rule that says "if 
> > GIT_DIR is set but GIT_WORK_TREE is not, then use the current working 
> > directory as the work tree." This is the intended behavior for the 
> > user perspective.
> > 
> > However, setup_git_directory_gently sets GIT_DIR itself, meaning that 
> > further setups (either because we are executing a command via alias, 
> > or in a subprocess) will see the non-existent GIT_WORK_TREE and assume 
> > we fall into the "current working directory is the working tree" 
> > codepath.
> > 
> > Instead, we now use a special value of GIT_WORK_TREE to indicate that 
> > we have already checked for a worktree and that there isn't one, 
> > setting it when we set GIT_DIR and checking for it in the special case 
> > path.
> > 
> > The special value is a blank GIT_WORK_TREE; it could be any value, but 
> > this should not conflict with any user values (and as a bonus, you can 
> > now tell git "I don't have a work tree" with "GIT_WORK_TREE= git", 
> > though I suspect the use case for that is limited).
> 
> Hrm. Unfortunately, on Windows there is no such thing as an empty 
> environment string. setenv(x, "") *removes* the environment variable.

That might be a shortcoming of our implementation of setenv():

-- snip --
cd /git

cat > a1.c << EOF
#include <stdio.h>
#include "compat/setenv.c"
#include "compat/unsetenv.c"

static void p()
{
	const char *abc = getenv("ABC");
	printf("env ABC: %s\n", abc ? abc : "(null)");
}

int main()
{
	p();
	gitsetenv("ABC", "Hello", 1);
	p();
	gitsetenv("ABC", "", 1);
	p();
	gitunsetenv("ABC");
	p();
	return 0;
}
EOF

gcc -DNO_MMAP=1 -I. -Icompat -o a1.exe a1.c

ABC="" ./a1.exe 
-- snap --

This will show

env ABC: 
env ABC: Hello
env ABC: (null)
env ABC: (null)

So it seems that environment variables _can_ be empty.  Just our 
relatively stupid implementation of setenv() does not do it.

Maybe something like compat/unsetenv.c is needed in setenv(), too.

Ciao,
Dscho
