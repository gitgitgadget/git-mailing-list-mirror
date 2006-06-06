From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [REGRESSION] Interrupted clone/fetch leaves .lock files around
Date: Tue, 6 Jun 2006 21:02:55 +0200
Message-ID: <20060606190255.GB15521@diku.dk>
References: <20060606185148.GA15521@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 06 21:03:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FngpT-0002fs-Nk
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 21:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWFFTC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWFFTC7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 15:02:59 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:48836 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750974AbWFFTC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 15:02:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4A535770077
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 21:02:57 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27640-12 for <git@vger.kernel.org>; Tue,  6 Jun 2006 21:02:55 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id CD98E770072
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 21:02:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 6F2CC6DF823
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 20:59:36 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B56C062611; Tue,  6 Jun 2006 21:02:55 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060606185148.GA15521@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21396>

Jonas Fonseca <fonseca@diku.dk> wrote Tue, Jun 06, 2006:
> Below is my feeble attempt at a (tested) fix.

Ok, so maybe I didn't test it so well, other than continuously
interrupting the fetch. ;)
 
> diff --git a/fetch.c b/fetch.c
> index e040ef9..861dc60 100644
> --- a/fetch.c
> +++ b/fetch.c
> @@ -214,9 +216,19 @@ static int mark_complete(const char *pat
>  	return 0;
>  }
>  
> +static struct ref_lock *lock = NULL;
> +
> +static void remove_lockfile_on_signal(int signo)
> +{
> +	if (lock)
> +		unlock_ref(lock);
> +	lock = NULL;
> +	signal(SIGINT, SIG_DFL);
> +	raise(signo);
> +}
> +
>  int pull(char *target)
>  {
> -	struct ref_lock *lock = NULL;
>  	unsigned char sha1[20];
>  	char *msg;
>  	int ret;
...
> @@ -261,6 +263,10 @@ int pull(char *target)
>  		if (msg)
>  			free(msg);
>  		return ret;
> +	} else {
> +		return 0;
>  	}
> -	return 0;
> +
> +	remove_lockfile_on_signal(0);

This will end up calling raise().

> +	return -1;
>  }

-- 
Jonas Fonseca
