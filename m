From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] dir: remove dead code
Date: Sun, 08 Sep 2013 14:30:50 +0200
Message-ID: <522C6DFA.10204@web.de>
References: <1378620563-32709-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 14:31:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIe93-0003Hs-6l
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 14:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab3IHMbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 08:31:08 -0400
Received: from mout.web.de ([212.227.15.3]:62695 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3IHMbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 08:31:06 -0400
Received: from [192.168.2.102] ([79.253.173.109]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MV4tp-1VSivC3429-00YSSr for <git@vger.kernel.org>;
 Sun, 08 Sep 2013 14:31:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1378620563-32709-1-git-send-email-artagnon@gmail.com>
X-Provags-ID: V03:K0:X8SgylBHDgxfUY6JNRvFInzKVdV+SafvQM9s+S2fV3QL+ZfEXo/
 DntEW8BJ+hegsq0mVDVfa5PoeBrfkRsAe8Sw3l6xoZ8ecAFkWvTbO6w7t5zEEl42WNRxwyE
 aZmqj9Cbl2sNKFsmimCEDtb1Pn33MvYcEeClkI+igp7C8npI1PacLzUyH3oEDOJFDGre7Mz
 wsrXw/2wX1+kkkli4TRkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234238>

Am 08.09.2013 08:09, schrieb Ramkumar Ramachandra:
> Remove dead code around remove_dir_recursively().

This basically reverts ae2f203e (clean: preserve nested git worktree in 
subdirectories).  t7300 still seems to pass, though.  I wonder why.

>
> Signed-off-by: Ramkumar Ramachandra<artagnon@gmail.com>
> ---
>   dir.c | 21 ++++-----------------
>   1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 910bfcd..2b31241 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1464,11 +1464,11 @@ int is_empty_dir(const char *path)
>   	return ret;
>   }
>
> -static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
> +int remove_dir_recursively(struct strbuf *path, int flag)
>   {
>   	DIR *dir;
>   	struct dirent *e;
> -	int ret = 0, original_len = path->len, len, kept_down = 0;
> +	int ret = 0, original_len = path->len, len;
>   	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
>   	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
>   	unsigned char submodule_head[20];
> @@ -1476,8 +1476,6 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>   	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
>   	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
>   		/* Do not descend and nuke a nested git work tree. */
> -		if (kept_up)
> -			*kept_up = 1;
>   		return 0;
>   	}
>
> @@ -1504,7 +1502,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>   		if (lstat(path->buf, &st))
>   			; /* fall thru */
>   		else if (S_ISDIR(st.st_mode)) {
> -			if (!remove_dir_recurse(path, flag, &kept_down))
> +			if (!remove_dir_recursively(path, flag))

kept_down could have been set to 1 here...

>   				continue; /* happy */
>   		} else if (!only_empty && !unlink(path->buf))
>   			continue; /* happy, too */
> @@ -1516,22 +1514,11 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>   	closedir(dir);
>
>   	strbuf_setlen(path, original_len);
> -	if (!ret && !keep_toplevel && !kept_down)
> +	if (!ret && !keep_toplevel)
>   		ret = rmdir(path->buf);

... and would have prevented the rmdir() call here.

Is the removed code really dead?  And if not, why does t7300 still pass?

> -	else if (kept_up)
> -		/*
> -		 * report the uplevel that it is not an error that we
> -		 * did not rmdir() our directory.
> -		 */
> -		*kept_up = !ret;
>   	return ret;
>   }
>
> -int remove_dir_recursively(struct strbuf *path, int flag)
> -{
> -	return remove_dir_recurse(path, flag, NULL);
> -}
> -
>   void setup_standard_excludes(struct dir_struct *dir)
>   {
>   	const char *path;
> -- 1.8.4.100.gde18f6d.dirty
>
