From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] refs: add safe_create_reflog function
Date: Thu, 25 Jun 2015 14:02:26 -0700
Message-ID: <xmqqwpyrwlgd.fsf@gitster.dls.corp.google.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	<1435265110-6414-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:02:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8EI6-0004Fn-CT
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbFYVCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:02:30 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36294 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbFYVC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:02:28 -0400
Received: by igbiq7 with SMTP id iq7so788700igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RhHqlfuSkkZEdgpIOKzOzlZ/vO0w7IT3CGV+0gADCgI=;
        b=S+EWqdJSOafcc7dV3oRjhxT9Wpbp3Vl3dMxwtieg58JOXmgBlz9RD3Pz5aBriLdR2g
         xBRk3OIgKwaTIUK3ao5KyvJunPzbexV+V1PkBt+IBdTfnIjH8mfsC2jI56Bp6OPq0Rv3
         bX4gixPzjYKxvFvYV3lRomgmHAsWMzNESMUvZCmVJDSfLXzMs3eAycFblWpbpx75o7dD
         GbGGZFW5gB9dyOnHrZSk5kyaYf18dhjxIGzzFzpBBCKErlcq3hDUwJhfEhv6Est09sHU
         2Ln1jtFZr2AvYalKRFTFtcSIF3mKfUXlnytvDxof/nil4B0Y/K7XHxSSaBZ0KSWlGjwM
         jwNg==
X-Received: by 10.43.10.194 with SMTP id pb2mr46982701icb.31.1435266148332;
        Thu, 25 Jun 2015 14:02:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id s5sm4081154igh.6.2015.06.25.14.02.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 14:02:27 -0700 (PDT)
In-Reply-To: <1435265110-6414-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 16:45:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272734>

David Turner <dturner@twopensource.com> writes:

> Make log_ref_setup private, and add public safe_create_reflog which
> calls log_ref_setup.
>
> In a moment, we will use safe_create_reflog to add reflog creation
> commands to git-reflog.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c |  4 +---
>  refs.c             | 11 +++++++++++
>  refs.h             |  2 +-
>  3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 93f63d3..b793670 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -621,7 +621,6 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  		if (opts->new_orphan_branch) {
>  			if (opts->new_branch_log && !log_all_ref_updates) {
>  				int temp;
> -				struct strbuf log_file = STRBUF_INIT;
>  				int ret;
>  				const char *ref_name;
>  				struct strbuf err = STRBUF_INIT;
> @@ -629,9 +628,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
>  				temp = log_all_ref_updates;
>  				log_all_ref_updates = 1;
> -				ret = log_ref_setup(ref_name, &log_file, &err);
> +				ret = safe_create_reflog(ref_name, &err);
>  				log_all_ref_updates = temp;
> -				strbuf_release(&log_file);
>  				if (ret) {
>  					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
>  						opts->new_orphan_branch, err.buf);

Yup, much nicer ;-)

> diff --git a/refs.c b/refs.c
> index de7b5ef..7b02c45 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3171,6 +3171,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
>  	return 0;
>  }
>  
> +
> +int safe_create_reflog(const char *refname, struct strbuf *err)
> +{
> +	int ret;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	ret = log_ref_setup(refname, &sb, err);
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
>  static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
>  			    const unsigned char *new_sha1,
>  			    const char *committer, const char *msg)
> diff --git a/refs.h b/refs.h
> index debdefc..2986aac 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -228,7 +228,7 @@ int pack_refs(unsigned int flags);
>  /*
>   * Setup reflog before using. Fill in err and return -1 on failure.
>   */
> -int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
> +int safe_create_reflog(const char *refname, struct strbuf *err);
>  
>  /** Reads log for the value of ref during at_time. **/
>  extern int read_ref_at(const char *refname, unsigned int flags,
