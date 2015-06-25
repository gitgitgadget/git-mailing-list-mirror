From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] refs: replace log_ref_write with create_reflog
Date: Thu, 25 Jun 2015 09:54:22 -0700
Message-ID: <xmqqmvznzq2p.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	<1435173388-8346-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:54:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8AQF-0002Bc-O1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbbFYQyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:54:35 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36556 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbFYQyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:54:24 -0400
Received: by igbiq7 with SMTP id iq7so123111363igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GFYS3GYXBmrCddm39VyNXQxN8k9PGODgEEFfs2sVbMc=;
        b=sJzXCBN3gxtLrfkIA48wjLjP8qTFggEHsD4Zu5YlRSVXfHNnFJMCe4okhRUtD75M5L
         dHUfZVVhWo+EL63a9fHZZF+cEwVuDSI1vXVzP/ZWR7Q/K1UaBWnmZnRek14tdt2B7ISC
         QZlHRm9X3aQN5u7QuxOL/dUbdUZdbnQeZs4AQezJk8hGeiKl8CzbPf3OtZ4JHyy1Ru9b
         XEb/2qlR5QbDRo/tM1qzkDtOsBZeHU/5NLqGnhkPUW6CR1FEYKfh06e8tykW0TFrsiEs
         qRw3QDLpYXniDCWkbS7oVzEdoSdpvUplQiWmrAcCMDRBlp9t8IsxY2KJiLVjQDxhi3pZ
         Qs4A==
X-Received: by 10.107.135.22 with SMTP id j22mr12927687iod.20.1435251264168;
        Thu, 25 Jun 2015 09:54:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id e10sm3665267igy.11.2015.06.25.09.54.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 09:54:23 -0700 (PDT)
In-Reply-To: <1435173388-8346-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Jun 2015 15:16:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272697>

David Turner <dturner@twopensource.com> writes:

> In a moment, we will use this to add reflog creation commands to
> git-reflog.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

The title is misleading, if this is merely renaming.  I first
thought with this change the current callers of log_ref_setup()
would get a different/updated behaviour from the API by calling
something else, but that is not the case.

>  builtin/checkout.c | 2 +-
>  refs.c             | 4 ++--
>  refs.h             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ac4d10a..7549ae2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -629,7 +629,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
>  				temp = log_all_ref_updates;
>  				log_all_ref_updates = 1;
> -				ret = log_ref_setup(ref_name, &log_file, &err);
> +				ret = create_reflog(ref_name, &log_file, &err);
>  				log_all_ref_updates = temp;
>  				strbuf_release(&log_file);
>  				if (ret) {
> diff --git a/refs.c b/refs.c
> index c1a563f..93412ee 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3119,7 +3119,7 @@ static int copy_msg(char *buf, const char *msg)
>  }
>  
>  /* This function will fill in *err and return -1 on failure */
> -int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
> +int create_reflog(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
>  {
>  	int logfd, oflags = O_APPEND | O_WRONLY;
>  	char *logfile;
> @@ -3203,7 +3203,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>  	if (log_all_ref_updates < 0)
>  		log_all_ref_updates = !is_bare_repository();
>  
> -	result = log_ref_setup(refname, sb_log_file, err);
> +	result = create_reflog(refname, sb_log_file, err);
>  
>  	if (result)
>  		return result;
> diff --git a/refs.h b/refs.h
> index eee99f6..d4f75a9 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -233,7 +233,7 @@ int pack_refs(unsigned int flags);
>  /*
>   * Setup reflog before using. Fill in err and return -1 on failure.
>   */
> -int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
> +int create_reflog(const char *refname, struct strbuf *logfile, struct strbuf *err);
>  
>  /** Reads log for the value of ref during at_time. **/
>  extern int read_ref_at(const char *refname, unsigned int flags,
