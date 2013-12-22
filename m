From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/5] safe_create_leading_directories(): fix a mkdir/rmdir
 race
Date: Sun, 22 Dec 2013 22:42:55 +0000
Message-ID: <52B76AEF.70200@ramsay1.demon.co.uk>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu> <1387696451-32224-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 23:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vurjq-0005uL-PU
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 23:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab3LVWnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 17:43:06 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:37863 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755438Ab3LVWnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 17:43:05 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 6E97C400C0A;
	Sun, 22 Dec 2013 22:43:02 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 24DB3400741;
	Sun, 22 Dec 2013 22:43:02 +0000 (GMT)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun, 22 Dec 2013 22:43:01 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387696451-32224-5-git-send-email-mhagger@alum.mit.edu>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239649>

On 22/12/13 07:14, Michael Haggerty wrote:
> It could be that some other process is trying to clean up empty
> directories at the same time that safe_create_leading_directories() is
> attempting to create them.  In this case, it could happen that
> directory "a/b" was present at the end of one iteration of the loop
> (either it was already present or we just created it ourselves), but
> by the time we try to create directory "a/b/c", directory "a/b" has
> been deleted.  In fact, directory "a" might also have been deleted.
> 
> So, if a call to mkdir() fails with ENOENT, then try checking/making
> all directories again from the beginning.  Attempt up to three times
> before giving up.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  sha1_file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index dcfd35a..abcb56b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -108,6 +108,7 @@ int mkdir_in_gitdir(const char *path)
>  int safe_create_leading_directories(char *path)
>  {
>  	char *next_component = path + offset_1st_component(path);
> +	int attempts = 3;
>  	int retval = 0;
>  
>  	while (!retval && next_component) {
> @@ -132,6 +133,16 @@ int safe_create_leading_directories(char *path)
>  			if (errno == EEXIST &&
>  			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
>  				; /* somebody created it since we checked */
> +			} else if (errno == ENOENT && --attempts) {
> +				/*
> +				 * Either mkdir() failed bacause

s/bacause/because/

> +				 * somebody just pruned the containing
> +				 * directory, or stat() failed because
> +				 * the file that was in our way was
> +				 * just removed.  Either way, try
> +				 * again from the beginning:
> +				 */
> +				next_component = path + offset_1st_component(path);
>  			} else {
>  				retval = -1;
>  			}
> 

ATB,
Ramsay Jones
