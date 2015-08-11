From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/16] lock_repo_for_gc(): compute the path to "gc.pid" only once
Date: Tue, 11 Aug 2015 13:06:28 -0700
Message-ID: <xmqq4mk5r3nf.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<e34adde5b2cc3adbcd011ee06aeab93b3459a883.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPFoh-0008BY-FB
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbbHKUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:06:31 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33167 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbbHKUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:06:30 -0400
Received: by pabyb7 with SMTP id yb7so136947361pab.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lD25nH9KAMUGdFA8oYR04BRADJ+G2gim7brr1ECaSoY=;
        b=H65LyYw60kmhmM/6DGc2l3TVtXVOCAjMIGnT0AmGWqPzKoxNmOC/bD8chN/b/qnC2H
         8cOO8kSNSPJKt43TbRHOQJJYLu1wPGqBA+Uxh1UPSbe87DtWhl9jd8BecZAilMNLHTFL
         HXaVeuSJsJb1jT5Rf5TKSfY9a3CIjKvX1mKQkg2jqIBSaBPaJRw959NOvmK2s57+3BOS
         +WwlTdciw5Q74s7qLPGuDI4fT6BFkRMJSYM2UXMgIfhB0FqURz8dtn4kymEUJlD7r99V
         DHvnlNiz3Lt9zTWID5BOtU60Li7XnfqTPjnzTwx1mSG3vPb+Po4YVYxORKJi6MJeM7mM
         PTlQ==
X-Received: by 10.68.239.69 with SMTP id vq5mr31487805pbc.111.1439323589899;
        Tue, 11 Aug 2015 13:06:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id hz5sm3681238pbb.39.2015.08.11.13.06.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 13:06:29 -0700 (PDT)
In-Reply-To: <e34adde5b2cc3adbcd011ee06aeab93b3459a883.1439198011.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 10 Aug 2015 11:47:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275717>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/gc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 36fe333..c41354b 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -199,6 +199,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  	uintmax_t pid;
>  	FILE *fp;
>  	int fd;
> +	char *pidfile_path;
>  
>  	if (pidfile)
>  		/* already locked */
> @@ -207,12 +208,13 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  	if (gethostname(my_host, sizeof(my_host)))
>  		strcpy(my_host, "unknown");
>  
> -	fd = hold_lock_file_for_update(&lock, git_path("gc.pid"),
> +	pidfile_path = git_pathdup("gc.pid");
> +	fd = hold_lock_file_for_update(&lock, pidfile_path,
>  				       LOCK_DIE_ON_ERROR);

Looks correct; somehow this reminded me of the other topic from Peff
to reduce use of git_path() ;-)

> -	pidfile = git_pathdup("gc.pid");
> +	pidfile = pidfile_path;
>  	sigchain_push_common(remove_pidfile_on_signal);
>  	atexit(remove_pidfile);

I wonder if you can reduce the atexit() here by registering this as
a tempfile to be cleared?
