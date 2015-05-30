From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH mh/lockfile-retry] lockfile: replace random() by rand()
Date: Sat, 30 May 2015 10:12:57 -0700
Message-ID: <xmqq7frqat0m.fsf@gitster.dls.corp.google.com>
References: <55695770.2040303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 30 19:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YykJv-0004xG-T7
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbbE3RNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:13:01 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32873 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbbE3RM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:12:59 -0400
Received: by igbpi8 with SMTP id pi8so35460499igb.0
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=woHJVARhIrcJwtiapDSh+lWPlSd4j1PwF7PqmPd1aXQ=;
        b=shbfdjZQckPnI36aBcJIJrtISVv9y5W31isk3so8vWs+ID8SDUiNfPRlkfOcUQMex+
         7rHVPVcj1CZr5bR7j/vxGjjnvPjrL4eP1Cnl0sV1VNV7dGJHdAnHY1Hl7BK5u4ltWP3O
         tzUFK2s3Hop8Uy2rEkmGNvIM3bIkDAVqJ9+Pv1tEqnASAyPwzH8opzs0dj99NcCE2U/r
         8Idju4pd2Mtn17pR2J8sp6fo8o3TiFxoXPLr0Ob+pYC9uhIkdsDc1lHatVsmaY7EFLvR
         cxj0FPg6MrtrFRFNnsgU2RY5xYsLt1LdFcmnJcoj3fhUvkcDyr90G5/GmhCh3+NyqhXm
         4YMA==
X-Received: by 10.50.79.232 with SMTP id m8mr3800918igx.6.1433005979059;
        Sat, 30 May 2015 10:12:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id b8sm6691662ioe.23.2015.05.30.10.12.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 30 May 2015 10:12:58 -0700 (PDT)
In-Reply-To: <55695770.2040303@kdbg.org> (Johannes Sixt's message of "Sat, 30
	May 2015 08:23:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270292>

Johannes Sixt <j6t@kdbg.org> writes:

> There you have it: Look the other way for a while, and people start
> using exotic stuff... ;)

Is it exotic to have random/srandom?  Both are in POSIX and 4BSD;
admittedly rand/srand are written down in C89 and later, so they
might be more portable, but I recall the prevailing wisdom is to
favor random over rand for quality of randomness and portability, so
I am wondering if it may be a better approach to keep the code as-is
and do a compat/random.c based on either rand/srand (or use posix
sample implementation [*1*]).


[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/functions/rand.html



>
> This is a build breakage of master on Windows. There are also a few
> new test suite failures. On of them is in t1404#2, indicating that
> a DF conflict takes a different error path. I haven't debugged, yet.
> The lock file retry test fails, too. I'll report back as time permits.
>
>  lockfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 5a93bc7..ee5cb01 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -191,7 +191,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>  		return lock_file(lk, path, flags);
>  
>  	if (!random_initialized) {
> -		srandom((unsigned int)getpid());
> +		srand((unsigned int)getpid());
>  		random_initialized = 1;
>  	}
>  
> @@ -218,7 +218,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>  
>  		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
>  		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
> -		wait_us = (750 + random() % 500) * backoff_ms;
> +		wait_us = (750 + rand() % 500) * backoff_ms;
>  		sleep_microseconds(wait_us);
>  		remaining_us -= wait_us;
