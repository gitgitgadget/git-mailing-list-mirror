From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Fri, 14 Nov 2014 23:32:29 -0800
Message-ID: <5467018D.7000103@gmail.com>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu> <1416036379-4994-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:32:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpXqW-000461-ST
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbaKOHcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 02:32:33 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35622 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbaKOHcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 02:32:32 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so75059pab.6
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 23:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yYBe3bsrSXDJnWl3oipb1UdsNQweE6iFv0rOvLLu0mI=;
        b=saaCqybsTlb6JdiK6eANt66kRC3N0MIGrTfwtMJ7QHSIZhv18wkQ/lCz8g9c87fDm5
         ZpWwYv6VEHkFNi7FD042TUNTS+6rD+Yj/wuhKxphIf8wKwuYtL2U75Cx0+9K+1/feKDm
         DidX32lx7HfVij6QuWxBbXxaKtOVI75DXQQK2uGJIsNO209fkWGSwmGLGZA2sb+p0s8h
         2kvAijbBEHDy4gw9MwSkIrhHPTEqWJGW4fiOV2k/593QvDK0DSGZPL+LsSX+9gQSeC4k
         abcLPCSmX3EBHtfT6AdjD2B6/bbHvkhlPaJHB7MsEed57r08tnl4mPR/6ui3o1qlS7AT
         RMOg==
X-Received: by 10.66.118.136 with SMTP id km8mr15792321pab.100.1416036751814;
        Fri, 14 Nov 2014 23:32:31 -0800 (PST)
Received: from [192.168.2.7] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id px9sm7714628pbb.84.2014.11.14.23.32.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2014 23:32:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1416036379-4994-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.11.2014 23:26, Michael Haggerty wrote:
> There is no reason for $GIT_DIR/config to be executable, plus this
> change will help clean up repositories affected by the bug that was
> fixed by the previous commit.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  config.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 9e42d38..0942e5f 100644
> --- a/config.c
> +++ b/config.c
> @@ -1653,7 +1653,15 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  			MAP_PRIVATE, in_fd, 0);
>  		close(in_fd);
>  
> -		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
> +		/*
> +		 * We make of the executable bits because (a) it

We make *use* of

> +		 * doesn't make sense to have executable bits set on
> +		 * the config file, and (b) there was a bug in git 2.1
> +		 * which caused the config file to be created with u+x
> +		 * set, so this will help repair repositories created
> +		 * with that version.
> +		 */
> +		if (chmod(lock->filename, st.st_mode & 07666) < 0) {
>  			error("chmod on %s failed: %s",
>  				lock->filename, strerror(errno));
>  			ret = CONFIG_NO_WRITE;
> @@ -1832,7 +1840,7 @@ int git_config_rename_section_in_file(const char *config_filename,
>  
>  	fstat(fileno(config_file), &st);
>  
> -	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
> +	if (chmod(lock->filename, st.st_mode & 07666) < 0) {
>  		ret = error("chmod on %s failed: %s",
>  				lock->filename, strerror(errno));
>  		goto out;
> 
