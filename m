From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] refs:  Introduce pseudoref and per-worktree ref concepts
Date: Fri, 24 Jul 2015 12:20:42 -0700
Message-ID: <xmqqio99mkfp.fsf@gitster.dls.corp.google.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	<1437713129-19373-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 21:20:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiWY-0007Ub-7I
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbbGXTUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:20:46 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35672 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbGXTUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:20:45 -0400
Received: by pabkd10 with SMTP id kd10so18675836pab.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TSFVXGIPjx1nMTiV1AT4wYkv8p7J/r9+enLc0w96Pno=;
        b=ZSV2TbHQVkXSUtcH73ttYz16ggtdq0XAHh5ksG9oAoAUE42feY4XeR12DaaFyAzOfa
         OsRMSOSSYS9PuCLGgtud5hUh9Om/6IMJuRb0tXo5R1nb7cioe9VgmRXd06+7wfso44zp
         BXmJzuy68vnmm8xeG68oO/bkiV3/BaB/V/zvOL6n2V8YQGExeuCJ3DV1E1s0AeSYjB3K
         llpCiuOzKXhqRWd7WB0GjZgjQRx3v3hef6reWRHiPtTDIO/HcDlhyGjmUeopBIMmjp+H
         aRm1QuzaNLLFORxEZ3xaVa+Zts4cy/8zF7GqMIWvUOOzapThoLKpPGhv+AnIksLh63tR
         JKxw==
X-Received: by 10.70.88.176 with SMTP id bh16mr34204726pdb.165.1437765644876;
        Fri, 24 Jul 2015 12:20:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id p1sm15971932pdb.3.2015.07.24.12.20.42
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 12:20:43 -0700 (PDT)
In-Reply-To: <1437713129-19373-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 24 Jul 2015 00:45:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274590>

David Turner <dturner@twopensource.com> writes:

> +[[def_pseudoref]]pseudoref::
> +	Files under `$GIT_DIR` whose names are all-caps, and that
> +	contain a line consisting of a <<def_sha1,SHA-1>> followed by
> +	a newline, and optionally some additional data.  `MERGE_HEAD`
> +	and `CHERRY_PICK_HEAD` are examples.  Unlike...

I wonder if you meant to include FETCH_HEAD in this category (I am
not complaining about not having it listed as an example).  If you
did mean to include FETCH_HEAD, then "followed-by a newline" must
be rethought.

Documentation pedant might say that the above definition would throw
HEAD into this category.  s/all-caps,/all-caps (except "HEAD"),/ or
something like that may be needed to prevent them from making useless
noise.

> diff --git a/refs.c b/refs.c
> index 0b96ece..d31ca42 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3857,6 +3857,29 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  	free(transaction);
>  }
>  
> +int is_per_worktree_ref(const char *refname)
> +{
> +	return !strcmp(refname, "HEAD");
> +}
> +
> +static int is_pseudoref(const char *refname)
> +{
> +	const char *c;
> +
> +	if (strchr(refname, '/'))
> +		return 0;
> +
> +	if (is_per_worktree_ref(refname))
> +		return 0;
> +
> +	for (c = refname; *c; ++c) {
> +		if (!isupper(*c) && *c != '-' && *c != '_')
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static struct ref_update *add_update(struct ref_transaction *transaction,
>  				     const char *refname)
>  {
> diff --git a/refs.h b/refs.h
> index e4e46c3..bd5526e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -445,6 +445,8 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
>  
>  extern int ref_is_hidden(const char *);
>  
> +int is_per_worktree_ref(const char *refname);
> +
>  enum expire_reflog_flags {
>  	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
>  	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
