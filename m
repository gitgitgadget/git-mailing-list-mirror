From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (MINGW) Resend] Windows: Make OpenSSH properly detect
 tty detachment.
Date: Thu, 06 Nov 2008 08:35:35 +0100
Message-ID: <49129E47.4080209@viscovery.net>
References: <200811022011.13970.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 08:37:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxzQL-0004zP-6O
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 08:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbYKFHfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 02:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYKFHfp
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 02:35:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61541 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYKFHfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 02:35:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KxzP0-0008Pk-Ib; Thu, 06 Nov 2008 08:35:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0FA614E4; Thu,  6 Nov 2008 08:35:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200811022011.13970.angavrilov@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100215>

Alexander Gavrilov schrieb:
> Apparently, CREATE_NO_WINDOW makes the OS tell the process
> that it has a console, but without actually creating the
> window. As a result, when git is started from GUI, ssh
> tries to ask its questions on the invisible console.
> 
> This patch uses DETACHED_PROCESS instead, which clearly
> means that the process should be left without a console.
> The downside is that if the process manually calls
> AllocConsole, the window will appear. A similar thing
> might occur if it calls another console executable.

The latest "What's cooking in git.git" report still doesn't mention this
patch. The reason might be that you mention some scary downsides in this
paragraph. I think you should either not mention the downsides, or
describe further why they do not make a difference in our case:

- We never call AllocConsole(). If some third-party program calls it, then
it gets what it requested. (But, yes, the behavior would indeed be
different from what it used to be.)

- There are two possible circumstances when another console executable is
called:

  * A program that has no console - e.g. git-gui - runs a git process.
Then we are entering the "then" branch, and the new process is started
with DETACH_PROCESS. No new console window appears.

  * A program that already has a console runs a git process. Then we are
entering the "else" branch, and we do not change the process flags nor are
we requesting a new console. No new console window appears.

I'm using this patch since weeks without noticing any downsides.

-- Hannes

> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
> Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> 
> 	This patch appears to have been overlooked, so I	resend
> 	it just in case. It fixes a long standing problem in msysgit.
> 
> 	-- Alexander
> 
>  compat/mingw.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 1e29b88..b6fcf69 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -586,12 +586,16 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
>  		 * would normally create a console window. But
>  		 * since we'll be redirecting std streams, we do
>  		 * not need the console.
> +		 * It is necessary to use DETACHED_PROCESS
> +		 * instead of CREATE_NO_WINDOW to make ssh
> +		 * recognize that it has no console.
>  		 */
> -		flags = CREATE_NO_WINDOW;
> +		flags = DETACHED_PROCESS;
>  	} else {
>  		/* There is already a console. If we specified
> -		 * CREATE_NO_WINDOW here, too, Windows would
> +		 * DETACHED_PROCESS here, too, Windows would
>  		 * disassociate the child from the console.
> +		 * The same is true for CREATE_NO_WINDOW.
>  		 * Go figure!
>  		 */
>  		flags = 0;
