From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rollback index if git-commit is interrupted by a
 signal
Date: Thu, 29 May 2008 13:42:06 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291341290.13507@racer.site.net>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 29 14:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1hUG-0005Te-VC
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 14:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYE2MnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 08:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYE2MnR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 08:43:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:45830 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751268AbYE2MnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 08:43:16 -0400
Received: (qmail invoked by alias); 29 May 2008 12:43:15 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp052) with SMTP; 29 May 2008 14:43:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188k7k3XnA8v2bjCQ0uzuIyMSm/xw+WflZ3GfJRUb
	8ZK+bXrfCHZGq5
X-X-Sender: gene099@racer.site.net
In-Reply-To: <E1K1eXC-0005xW-Jd@fencepost.gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83192>

Hi,

On Thu, 29 May 2008, Paolo Bonzini wrote:

> If git-commit is interrupted by a signal, the index.lock file may be 
> left in the repository.  This patch teaches git to break them, and adds 
> a test.
> 
> This will usually happen if you ^Z the editor, and then either close the 
> terminal or kill git.  However, the patch is more defensive and sets up 
> the signal handlers so that the entire creation of the index is 
> protected.
> 
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  builtin-commit.c  |   25 ++++++++++++++-----------
>  t/t7502-commit.sh |   14 ++++++++++++++
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> 	rollback_index_files handles cleanly the case when the lock
> 	had not been established; git-status tests check for this.
> 
> 	The test is a bit tricky.  To find git's PID, I use a separate shell
> 	so that I can "exec" git: git will then inherit the same PID as the
> 	shell, which I get with $$.  Using a subshell does not work because bash
> 	optimizes subshells and does not fork a copy of itself -- this however
> 	means that it will not be able to really honor the "exec" command,
> 	and git will get a different PID!
> 	
> diff --git a/builtin-commit.c b/builtin-commit.c
> index b294c1f..ef8b1f0 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -111,17 +111,8 @@ static struct option builtin_commit_options[] = {
>  
>  static void rollback_index_files(void)
>  {
> -	switch (commit_style) {
> -	case COMMIT_AS_IS:
> -		break; /* nothing to do */
> -	case COMMIT_NORMAL:
> -		rollback_lock_file(&index_lock);
> -		break;
> -	case COMMIT_PARTIAL:
> -		rollback_lock_file(&index_lock);
> -		rollback_lock_file(&false_lock);
> -		break;
> -	}
> +	rollback_lock_file(&index_lock);
> +	rollback_lock_file(&false_lock);
>  }

Your commit message gives _no_ good reason for this change.  As a matter 
of fact, I imagine that this could be a regression.

Ciao,
Dscho
