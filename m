From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Sun, 10 Jul 2011 22:47:08 +0200
Message-ID: <4E1A0FCC.7080308@kdbg.org>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com> <alpine.DEB.1.00.1107091935210.1985@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@gmail.com>, gitster@pobox.com,
	msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 10 22:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qg0uO-0007Ir-Ru
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jul 2011 22:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab1GJUrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 16:47:14 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:31408 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753752Ab1GJUrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 16:47:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6D9A4A7EB0;
	Sun, 10 Jul 2011 22:47:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4922519F3CF;
	Sun, 10 Jul 2011 22:47:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <alpine.DEB.1.00.1107091935210.1985@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176827>

Am 09.07.2011 19:38, schrieb Johannes Schindelin:
> 
> At least on Windows, chdir() does not update PWD.

Very strange wording. chdir() should not update PWD even on POSIX.

> Unfortunately, stat()
> does not fill any ino or dev fields anymore, so get_pwd_cwd() is not
> able to tell.
> 
> But there is a telltale: both ino and dev are 0 when they are not filled
> correctly, so let's be extra cautious.
> 
> This happens to fix a bug in "get-receive-pack working_directory/" when
> the GIT_DIR would not be set correctly due to absolute_path(".")
> returning the wrong value.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	On Fri, 8 Jul 2011, Pat Thoyts wrote:
> 
> 	> ! t5516-fetch-push      (60 receive.denyCurrentBranch = updateInstead)
> 
> 	This patch fixes that.
> 
> 	Hannes, I have no idea whether you meant 10c4c881 to fix anything 
> 	on Windows.

I think this fix worked for me because when git is called from CMD, PWD
is not in the enviornment and the if (pwd && ...) branch is never taken.

> 
>  abspath.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/abspath.c b/abspath.c
> index 01858eb..37287f8 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -102,7 +102,8 @@ static const char *get_pwd_cwd(void)
>  	pwd = getenv("PWD");
>  	if (pwd && strcmp(pwd, cwd)) {
>  		stat(cwd, &cwd_stat);
> -		if (!stat(pwd, &pwd_stat) &&
> +		if ((cwd_stat.st_dev || cwd_stat.st_ino) &&
> +		    !stat(pwd, &pwd_stat) &&
>  		    pwd_stat.st_dev == cwd_stat.st_dev &&
>  		    pwd_stat.st_ino == cwd_stat.st_ino) {
>  			strlcpy(cwd, pwd, PATH_MAX);

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
