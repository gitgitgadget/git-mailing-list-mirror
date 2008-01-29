From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Tue, 29 Jan 2008 08:20:14 +0100
Message-ID: <479ED3AE.5000403@viscovery.net>
References: <47975FE6.4050709@viscovery.net>	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>	<alpine.LSU.1.00.0801272043040.23907@racer.site>	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>	<20080128003404.GA18276@lintop>	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>	<479D805E.3000209@viscovery.net>	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>	<479D9ADE.6010003@viscovery.net>	<alpine.LSU.1.00.0801281210440.23907@racer.site> <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 08:20:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJkm6-0003bs-9f
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 08:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYA2HUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 02:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYA2HUW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 02:20:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7440 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbYA2HUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 02:20:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJklF-0006Es-8W; Tue, 29 Jan 2008 08:20:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E78CC6D9; Tue, 29 Jan 2008 08:20:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71958>

Junio C Hamano schrieb:
> +static int sanitary_path_copy(char *dst, const char *src)
>  {
> -	const char *orig = path;
> +	char *dst0 = dst;
> +
> +	if (*src == '/') {
> +		*dst++ = '/';
> +		while (*src == '/')
> +			src++;
> +	}

Advance notice: In this function, tests of the kind *src == '/' need to be
turned into is_dir_sep(*src) when we port to Windows.

> +		/* copy up to the next '/', and eat all '/' */
> +		while ((c = *src++) != '\0' && c != '/')
> +			*dst++ = c;
>  		if (c == '/') {
> -			path += 2;
> -			continue;
> -		}
> -		if (c != '.')
> +			*dst++ = c;

			*dst++ = '/';

will be needed on Windows to sanitize all is_dir_sep(c) to '/'.

> +			while (c == '/')
> +				c = *src++;
> +			src--;
> +		} else if (!c)
>  			break;
...
> +const char *prefix_path(const char *prefix, int len, const char *path)
> +{
> +	const char *orig = path;
> +	char *sanitized = xmalloc(len + strlen(path) + 1);
> +	if (*orig == '/')

	if (is_absolute_path(*orig))

> +		strcpy(sanitized, path);
> +	else {
> +		if (len)
> +			memcpy(sanitized, prefix, len);
> +		strcpy(sanitized + len, path);		
>  	}
> -	return path;
> +	if (sanitary_path_copy(sanitized, sanitized))
> +		goto error_out;
> +	if (*orig == '/') {

Ditto.

> +		const char *work_tree = get_git_work_tree();
> +		size_t len = strlen(work_tree);
> +		if (strncmp(sanitized, work_tree, len) ||
> +		    (sanitized[len] != '\0' && sanitized[len] != '/')) {
> +		error_out:
> +			error("'%s' is outside repository", orig);
> +			free(sanitized);
> +			return NULL;
> +		}
> +	}
> +	return sanitized;
>  }

I appreciate this new sanitary_copy_path() because I expect that we will
need at least one less #ifdef __MINGW32__/#endif compared to our current
Windows port.

-- Hannes
