From: Kyle <kiltnaked@gmail.com>
Subject: Re: [PATCH] gc: notice gc processes run by other users
Date: Thu, 2 Jan 2014 16:11:24 -0800
Message-ID: <02BCE0EB-ADA1-48F9-BD00-369FFDB5E372@gmail.com>
References: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 01:11:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VysMS-0005h5-J2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 01:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbaACALb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 19:11:31 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39835 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbaACAL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 19:11:28 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so15147481pbc.1
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 16:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=JHdM+lB3YmB2dOQlHhgTvN/LWDcPKWbCFrG0IGyj0ok=;
        b=Dg+SLvUnPNPz+o1PuA5AMUvybBA3sryp2BKg6yEcW1GjOILaeNL092jsCcZZKpcG41
         uJ8ZGXB0c8223HMtn12w4YPGzqO3iGlNdsSJi9BA6Q5Z6sdDNcmUqc5vwl/coIpE/qji
         Ep81UZQg5EnL64wlcH8mM6wSxD0MPAMTmr9sOqaiYqlbl47xI/7JpXMt9QYEomH2RWak
         jgk283snlAa5dk93/yvUFqThht9vcUJ4CUWYYKbRLx/u46DyDTr9lnV9lyWptojZ/XiI
         VPxRrnz9kAxlo1QQzNrsAB8VpiWcgcw7RtktyJx/zOvxGmZBRdUPlat9stI9xQAt2M97
         PyNw==
X-Received: by 10.66.122.40 with SMTP id lp8mr92674525pab.82.1388707888559;
        Thu, 02 Jan 2014 16:11:28 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yg3sm137058325pab.16.2014.01.02.16.11.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 16:11:27 -0800 (PST)
In-Reply-To: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239897>

On Dec 31, 2013, at 04:07, Kyle J. McKay wrote:
> Since 64a99eb4 git gc refuses to run without the --force option if
> another gc process on the same repository is already running.
>
> However, if the repository is shared and user A runs git gc on the
> repository and while that gc is still running user B runs git gc on
> the same repository the gc process run by user A will not be noticed
> and the gc run by user B will go ahead and run.
>
> The problem is that the kill(pid, 0) test fails with an EPERM error
> since user B is not allowed to signal processes owned by user A
> (unless user B is root).
>
> Update the test to recognize an EPERM error as meaning the process
> exists and another gc should not be run (unless --force is given).

Oops, sorry, forgot sign off, here's my sign off:

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

> ---
>
> I suggest this be included in maint as others may also have expected  
> the
> shared repository, different user gc scenario to be caught by the new
> code when in fact it's not without this patch.
>
> builtin/gc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c14190f8..25f2237c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -222,7 +222,7 @@ static const char *lock_repo_for_gc(int force,  
> pid_t* ret_pid)
> 			time(NULL) - st.st_mtime <= 12 * 3600 &&
> 			fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_host) == 2 &&
> 			/* be gentle to concurrent "gc" on remote hosts */
> -			(strcmp(locking_host, my_host) || !kill(pid, 0));
> +			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno ==  
> EPERM);
> 		if (fp != NULL)
> 			fclose(fp);
> 		if (should_exit) {
> -- 
> 1.8.5.2
>
