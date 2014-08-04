From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] pretty.c: make git_pretty_formats_config return -1 on git_config_string failure
Date: Mon, 04 Aug 2014 17:45:44 +0200
Message-ID: <vpqmwbki7h3.fsf@anie.imag.fr>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:46:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEKSn-0005R5-BU
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 17:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbaHDPqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 11:46:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48062 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbaHDPqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 11:46:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74FjhnS004786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 17:45:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74FjiZ3003345;
	Mon, 4 Aug 2014 17:45:44 +0200
In-Reply-To: <1407163275-3006-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 4 Aug 2014 07:41:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 17:45:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74FjhnS004786
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407771943.85404@4fbaMYs57WKGCFqAQD04Kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254742>

Tanay Abhra <tanayabh@gmail.com> writes:

> `git_pretty_formats_config()` continues without checking git_config_string's
> return value which can lead to a SEGFAULT.

Indeed, without the patch:

$ git -c pretty.my= log --pretty=my                        
error: Missing value for 'pretty.my'                         
zsh: segmentation fault  git -c pretty.my= log --pretty=my

> diff --git a/pretty.c b/pretty.c
> index 3a1da6f..72dbf55 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -65,7 +65,9 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
>  
>  	commit_format->name = xstrdup(name);
>  	commit_format->format = CMIT_FMT_USERFORMAT;
> -	git_config_string(&fmt, var, value);
> +	if (git_config_string(&fmt, var, value))
> +		return -1;
> +

Ack-ed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

My first thought reading this was "why not rewrite using non-callback
API?", but this particular call to git_config needs to iterate over
config keys anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
