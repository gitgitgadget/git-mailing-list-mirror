From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/3] daemon.c: introduce daemon's service
Date: Thu, 31 Aug 2006 15:07:00 +0200
Message-ID: <44F6DEF4.6000609@innova-card.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com> <1157027723594-git-send-email-vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 15:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GImGE-0001D4-JQ
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 15:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHaNHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWHaNHF
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 09:07:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15589 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932196AbWHaNHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 09:07:03 -0400
Received: by nf-out-0910.google.com with SMTP id x30so394085nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 06:07:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Q7FNqvn/AuO1APk1W5Mvb8px2rESYO1ka0islsEs8CDratdUvKU41KHMgj6r1aRCCHEqj5RZMJMsf7M5gZXaPYAnnwh5c0YGr+mK8OFFv4l/2+f9DP9BfkDsU4uLqrxHG1B5tw0Fwx65jLphKtcYUKSxM0lxULA7x3eWFsgTXEA=
Received: by 10.49.10.3 with SMTP id n3mr1327655nfi;
        Thu, 31 Aug 2006 06:07:01 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l38sm1609365nfc.2006.08.31.06.07.00;
        Thu, 31 Aug 2006 06:07:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <1157027723594-git-send-email-vagabon.xyz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26259>

Franck Bui-Huu wrote:
> Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
> ---
>  daemon.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 61 insertions(+), 17 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index 66ec830..ed3a13d 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -232,16 +232,57 @@ static char *path_ok(char *dir)
>  	return NULL;		/* Fallthrough. Deny by default */
>  }
>  
> -static int upload(char *dir)
> +/*
> + * Services we're able to deal with.
> + */
> +static int service_upload_pack(const char *dir, const char *args)
>  {
>  	/* Timeout as string */
>  	char timeout_buf[64];
> +
> +	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
> +
> +	/* git-upload-pack only ever reads stuff, so this is safe */
> +	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
> +	return -1;
> +}
> +
> +/* service options */
> +#define NEED_REPO	(1<<0)
> +
> +struct service_info {
> +	const char *name;
> +	int (*fn)(const char *dir, const char *args);
> +	int options;
> +};
> +
> +static struct service_info services[] = {
> +	{ "git-upload-pack", service_upload_pack, NEED_REPO },
> +};
> +
> +static int run_service(char *cmdline)
> +{
> +	struct service_info *serv;
>  	const char *path;
> +	size_t len;
> +	int i;
>  
> -	loginfo("Request for '%s'", dir);
> +	for (i = 0; i < ARRAY_SIZE(services); i++) {
> +		serv = &services[i];
> +		

OMG, trailing white spaces !

> +		len = strlen(serv->name);
> +		if (strncmp(cmdline, serv->name, len))
> +			continue;
> +		if (cmdline[len] != ' ')
> +			continue;
> +		goto found;
> +	}
> +	return -1;
> +found:
> +	cmdline += len + 1;
> +	path = NULL;
>  
> -	if (!(path = path_ok(dir)))
> -		return -1;
> +	loginfo("Request '%s' for '%s'", serv->name, cmdline);
>  
>  	/*
>  	 * Security on the cheap.
> @@ -253,30 +294,33 @@ static int upload(char *dir)
>  	 * path_ok() uses enter_repo() and does whitelist checking.
>  	 * We only need to make sure the repository is exported.
>  	 */
> +	if (serv->options & NEED_REPO) {
> +		if (!(path = path_ok(cmdline)))
> +			return -1;
>  
> -	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
> -		logerror("'%s': repository not exported.", path);
> -		errno = EACCES;
> -		return -1;
> +		if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
> +			logerror("'%s': repository not exported.", path);
> +			errno = EACCES;
> +			return -1;
> +		}
> +		cmdline += strlen(path) + 1;
>  	}
> -
> +	

ditto

		Franck
