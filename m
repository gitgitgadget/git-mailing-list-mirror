From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 05/13] run-command: factor out return value computation
Date: Mon, 21 Sep 2015 17:38:37 -0700
Message-ID: <xmqqk2rj70fm.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:38:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeBbY-0001qI-SM
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 02:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbbIVAik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 20:38:40 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35769 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbbIVAij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 20:38:39 -0400
Received: by pacfv12 with SMTP id fv12so133655281pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lmwFffnswkPG4wVTCQmTQSRFRBVzm0/8BnyzL8XAX4Q=;
        b=CONCvoEkHjECd9CQ53QsKdXGmjeuY0uzvID9AUbfzWvf/L1JyJHdlk6VqDwO+Eu32M
         aClg8J304PY6tKeNDIHVsGh/jx+gFOBf8NURtB5ITPVIUj5MqlGMVVuv1bqGNQXiNhVX
         L1rqxyManmg5FF9+WQmMYyqZqA/TE1fnOXszPc3XDA+RLXFCaxOZaEkfa9Fc6ZJ2GzNL
         o41sbfI1M0B8AFduVeZMPgSZnP4yjJcoXzlGUP3XMddFOIof6iaKstPa3dIlhP2pvmYO
         zSd5M6sWNqU2q1WdX2r4WuM/yrVAjmEaAcxrOcehkuI2jlBMfVo75KrVYZBEiHMPkav7
         HnCA==
X-Received: by 10.66.248.10 with SMTP id yi10mr28723661pac.6.1442882319189;
        Mon, 21 Sep 2015 17:38:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id bi2sm26782083pbb.45.2015.09.21.17.38.38
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 17:38:38 -0700 (PDT)
In-Reply-To: <1442875159-13027-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278368>

Stefan Beller <sbeller@google.com> writes:

> We will need computing the return value in a later patch without the
> wait.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  run-command.c | 54 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 28e1d55..674e348 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -232,6 +232,35 @@ static inline void set_cloexec(int fd)
>  		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
>  }
>  
> +static int determine_return_value(int wait_status,
> +				  int *result,
> +				  int *error_code,
> +				  const char *argv0)
> +{
> +	if (WIFSIGNALED(wait_status)) {
> +		*result = WTERMSIG(wait_status);
> +		if (*result != SIGINT && *result != SIGQUIT)
> +			error("%s died of signal %d", argv0, *result);
> +		/*
> +		 * This return value is chosen so that code & 0xff
> +		 * mimics the exit code that a POSIX shell would report for
> +		 * a program that died from this signal.
> +		 */

Not a new problem but "from these signals", I think.

> @@ -244,29 +273,10 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>  	if (waiting < 0) {
>  		failed_errno = errno;
>  		error("waitpid for %s failed: %s", argv0, strerror(errno));
> -...
>  	} else {
> -		error("waitpid is confused (%s)", argv0);
> +		if (waiting != pid
> +		   || (determine_return_value(status, &code, &failed_errno, argv0) < 0))

Move "||" to the end of the previous line?

> +			error("waitpid is confused (%s)", argv0);
>  	}
>  
>  	clear_child_for_cleanup(pid);
