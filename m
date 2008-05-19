From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Mon, 19 May 2008 09:55:04 +0200
Message-ID: <48313258.5010208@viscovery.net>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com> <alpine.DEB.1.00.0805160012310.30431@racer> <482D2F9D.4080809@viscovery.net> <alpine.DEB.1.00.0805161118160.30431@racer> <482D66DC.30602@viscovery.net> <482DC7B6.1080406@facebook.com> <alpine.DEB.1.00.0805170117000.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Reiss <dreiss@facebook.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 19 09:56:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy0Dy-0005Yg-RO
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 09:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYESHzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 03:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbYESHzL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 03:55:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:65146 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYESHzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 03:55:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jy0D2-0004M1-FB; Mon, 19 May 2008 09:55:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3A32069F; Mon, 19 May 2008 09:55:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0805170117000.30431@racer>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82419>

Johannes Schindelin schrieb:
> Hi,
> 
> On Fri, 16 May 2008, David Reiss wrote:
> 
>> Sorry I missed this before.  As you said, in Johannes's version the 
>> ceiling directories are the last directories we look in, whereas in my 
>> implementation, they are the first directories we do not look in.  I 
>> made this choice because it makes more sense for me to set my ceiling to 
>> "/home", rather than "/home/dreiss", so it will work even if I am in 
>> another user's homedir.
>>
>> There is also a difference in how they handle the case where the cwd is 
>> a ceiling directory, but I think it is worth sorting out the first issue 
>> first.
> 
> Please do not top-post.
> 
> This is the interdiff to the last squashed patch:
> 
> -- snip --
> diff --git a/setup.c b/setup.c
> index cece3e4..2f7a17a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -441,6 +441,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 */
>  	offset = len = strlen(cwd);
>  	for (;;) {
> +		if (offset <= min_offset)
> +			goto non_git;
>  		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
>  		if (gitfile_dir) {
>  			if (set_git_dir(gitfile_dir))
> @@ -460,6 +462,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		chdir("..");
>  		do {
>  			if (offset <= min_offset) {
> +non_git:
>  				if (nongit_ok) {
>  					if (chdir(cwd))
>  						die("Cannot come back to cwd");

Hmm... If the implementation needs a 'goto', then I have the strong
suspicion that there's already something wrong at the concept level.

I actually like the previous version better because of its clearer semantics:

- The current directory is always checked.
- GIT_CEILING_DIRECTORIES are checked. Consequently, setting the variable
to the empty string is equivalent to not setting it at all.

(but it means that David can't have what he wants, i.e. he must set
GIT_CEILING_DIRECTORIES=/home/dreiss.)

This implementation:

- Never checks the root directory, even if it is the current directory.
- Otherwise always checks the current directory, even if it is mentioned
in GIT_CEILING_DIRECTORIES.

[That said, I'm not in strong support of this feature in general - I'm
just caring because *if* it goes in, it will have conflicts with the mingw
branch.]

-- Hannes
