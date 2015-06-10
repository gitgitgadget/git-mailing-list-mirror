From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/14] write_shared_index(): use tempfile module
Date: Wed, 10 Jun 2015 10:56:35 -0700
Message-ID: <xmqqegljla5o.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
	<78ffe87f5dd9037ae16a77bf9c40dcfdd9e3b40f.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:56:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kF1-00018F-AT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933051AbbFJR4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:56:39 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33562 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932785AbbFJR4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:56:37 -0400
Received: by iebgx4 with SMTP id gx4so39721813ieb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3rr0jTSaWQTiNjAhvu+LJBi4HwWk+YFyH1U7jUwXrb0=;
        b=KiegaPHdY99IXwVhDzATK7/PjCz9Dnt7QJyMs1pGvLpXz6DvuHdqTSusWm+IwERIT8
         /oxRPvHeEbRXowOUfjOW31I4U2MpAAoRhax6D7zl0FVkU60O/4rIaB6E67FhX/xJU6e5
         U0o/aOvaLj6OmT1Ss9D3Q0cS6z1w5i/pHK00rAKiOY2w9UxFCb1anR3DctySuM1tHiCf
         USu6Guxq5sNE4lN/WPDE9ykZlYerLdMuKteCnLiW5/f3CjViKvMXmHR2DtCCAhwCQtJX
         rNyvOGoKFd8cyH9LriWS0alLsEDkdJjBspKdVzIOvdyuQYqLu6YGPLs3uuliEliIsnJj
         9+Ag==
X-Received: by 10.50.61.161 with SMTP id q1mr6537611igr.12.1433958997062;
        Wed, 10 Jun 2015 10:56:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id d8sm3685498igl.19.2015.06.10.10.56.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 10:56:36 -0700 (PDT)
In-Reply-To: <78ffe87f5dd9037ae16a77bf9c40dcfdd9e3b40f.1433751986.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 8 Jun 2015 11:07:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271335>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  read-cache.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)

Nicely done.

>
> diff --git a/read-cache.c b/read-cache.c
> index 3e49c49..4f7b70f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2137,54 +2137,27 @@ static int write_split_index(struct index_state *istate,
>  	return ret;
>  }
>  
> -static char *temporary_sharedindex;
> -
> -static void remove_temporary_sharedindex(void)
> -{
> -	if (temporary_sharedindex) {
> -		unlink_or_warn(temporary_sharedindex);
> -		free(temporary_sharedindex);
> -		temporary_sharedindex = NULL;
> -	}
> -}
> -
> -static void remove_temporary_sharedindex_on_signal(int signo)
> -{
> -	remove_temporary_sharedindex();
> -	sigchain_pop(signo);
> -	raise(signo);
> -}
> +static struct tempfile temporary_sharedindex;
>  
>  static int write_shared_index(struct index_state *istate,
>  			      struct lock_file *lock, unsigned flags)
>  {
>  	struct split_index *si = istate->split_index;
> -	static int installed_handler;
>  	int fd, ret;
>  
> -	temporary_sharedindex = git_pathdup("sharedindex_XXXXXX");
> -	fd = mkstemp(temporary_sharedindex);
> +	fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
>  	if (fd < 0) {
> -		free(temporary_sharedindex);
> -		temporary_sharedindex = NULL;
>  		hashclr(si->base_sha1);
>  		return do_write_locked_index(istate, lock, flags);
>  	}
> -	if (!installed_handler) {
> -		atexit(remove_temporary_sharedindex);
> -		sigchain_push_common(remove_temporary_sharedindex_on_signal);
> -	}
>  	move_cache_to_base_index(istate);
>  	ret = do_write_index(si->base, fd, 1);
> -	close(fd);
>  	if (ret) {
> -		remove_temporary_sharedindex();
> +		delete_tempfile(&temporary_sharedindex);
>  		return ret;
>  	}
> -	ret = rename(temporary_sharedindex,
> -		     git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
> -	free(temporary_sharedindex);
> -	temporary_sharedindex = NULL;
> +	ret = rename_tempfile(&temporary_sharedindex,
> +			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
>  	if (!ret)
>  		hashcpy(si->base_sha1, si->base->sha1);
>  	return ret;
