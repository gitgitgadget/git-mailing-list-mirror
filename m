From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC] autocrlf: Make it work also for un-normalized
 repositories
Date: Mon, 10 May 2010 23:43:21 +0400
Message-ID: <20100510194321.GG14069@dpotapov.dyndns.org>
References: <20100510171119.GA17875@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon May 10 21:43:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBYt2-0004HM-7c
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 21:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab0EJTn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 15:43:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:62065 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204Ab0EJTnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 15:43:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so929799fgg.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fshJbgPLPFdsRt1Ni5OWaFZ6fq4goP/sF9iOea1sigg=;
        b=nN435AuS06FA5gnk8zii/cNUqlr0MTtMAvxG0onspHkAqDvXQYFa51VkKgTm9a8q0P
         7fP84vpXA8JlxSrEzh2lI2zNSjWmlg2QNfROfcMvwfXvQTCVBlnmgoYViHKEvBkbAo8k
         otV8WCkIiBROOR1hnQjfZorq9diDu0qmF1CQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CDQFkRt7Vinq95VzTPfghW+UpojRk467NeXdifFwWE8kugfY2c0Iuih6PvaM3TXq2D
         rtNOtLmItV16Qp6PE4NBXD5tczrIdP/KMv3a+nDezDqkHX9XWxriuV0d6OWmU3cmOM8v
         6rKo2w3yqUIGjFMNImWyQIrvJyIraOMWNraVw=
Received: by 10.223.22.145 with SMTP id n17mr4955795fab.23.1273520603751;
        Mon, 10 May 2010 12:43:23 -0700 (PDT)
Received: from localhost (ppp85-140-167-246.pppoe.mtu-net.ru [85.140.167.246])
        by mx.google.com with ESMTPS id g10sm22914334fai.12.2010.05.10.12.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 12:43:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100510171119.GA17875@pvv.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146848>

On Mon, May 10, 2010 at 07:11:19PM +0200, Finn Arne Gangstad wrote:

> 
> Stealing the problem from Eyvind's initial mail (paraphrased and
> summarized a bit):
> 
> 1. Setting autocrlf globally is a pain since autocrlf does not work well
>    with CRLF in the repo
> 2. Setting it in individual repos is hard since you do it "too late"
>    (the clone will get it wrong)
> 3. If someone checks in a file with CRLF later, you get into problems again
> 4. If a repository once has contained CRLF, you can't tell autocrlf
>    at which commit everything is sane again
> 5. autocrlf does needless work if you know that all your users want
>    the same EOL style.
> 
> I belive that this patch makes autocrlf a safe (and good) default
> setting for Windows, and this solves problems 1-4.

It does not really solve #2, because you will have the wrong ending for
files that must be LF, such as shell scripts, and then these scripts
fail with some weird error...

> 
> I implemented it by looking for CR charactes in the index, and
> aborting any conversion attempt if this is found.

Does it have any measurable impact on the check-in when a lot of files
are committed? 

> 
> Note that ALL the tests still pass unmodified. This is a bit
> surprising perhaps, but think it is an indication that no one ever
> intented autocrlf to do what it does to files containing CRs.

Well, tests do not cover many corner cases... So, no surprise here...

> @@ -147,6 +184,10 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>                        return 0;
>        }
>
> +       /* If the file in the index has any CR in it, do not convert. */
> +       if (has_cr_in_index(path))
> +               return 0;
> +

Why do you disable crlf conversion not only for "guess" case but also
for those files that have the "crlf" attribute? Moreover, you do that
silently without even a warning to the user. IMHO, it is incompatible
change. In fact, it can seen as regression, because by specifying the
correct attribute for that file, I could fix the ending of this file.
Now, this is impossible.

>  
>  	/* Optimization: No CR? Nothing to convert, regardless. */
> @@ -202,6 +243,10 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
>  	if (stats.lf == stats.crlf)
>  		return 0;
>  
> +	/* Are there ANY lines at all with CRLF? If so, ignore */
> +	if (stats.crlf > 0)
> +		return 0;
> +
>  	if (action == CRLF_GUESS) {
>  		/* If we have any bare CR characters, we're not going to touch it */
>  		if (stats.cr != stats.crlf)

This chunk does not make sense. Can you explain what did you try to
achieve here for guess and non-guess cases?

IMHO, we should conservative in our changes. So, to change behavior of
autocrlf only where "crlf" is not set explicitly. Or, at least, produce
some warning about discrepancy between what the user has _explicitly_
told to do and what git does. I really dislike that any tool silently
ignores users explicit instructions, because it thinks it knows better
than a human. It is plainly wrong.


Dmitry
