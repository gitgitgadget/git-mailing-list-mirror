From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/12] git submodule update: Handle unmerged submodules in C
Date: Tue, 20 Oct 2015 14:11:27 -0700
Message-ID: <xmqqlhax6y9s.fsf@gitster.mtv.corp.google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoeBx-0001Pv-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 23:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbbJTVLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 17:11:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33362 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbbJTVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 17:11:29 -0400
Received: by pabrc13 with SMTP id rc13so31907549pab.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QoKdwdiMfiH2fFbNTFTyL+N2Gyj7dTBYtwvq3dJW4e0=;
        b=KXwUATD6+hMgfQ5hEXg3MwoY870Fq4LZKqqiztvnxMCJoarvvThqZX5NCOB0kSFqrB
         oHN1qBzUgjcAgwAv6FSjU9KfIxjCBzpymTKFPwTlZ2OG+57hq7nde02LAuz/l1kNx+6w
         SHf93os2i0TXDAa0XZvAtjLGVfW2Zb5d8G3MRpD0VamGHw1AEmGJIjjWY5fJKOUEY1h7
         x5CEVAjVJWdK3ctb1pfoiftnr8wrpQqJfP5YzZ5YxMqkry8ykmoM63SJF8FKxjsFW8lN
         BAzRr4g+sIJaOrlsE2e0XsUSqy6CoXsqAmeNTWyt5jRRNBffgoCXz0s7WUPZ97ph1GVH
         0vNQ==
X-Received: by 10.68.105.193 with SMTP id go1mr6090270pbb.59.1445375488429;
        Tue, 20 Oct 2015 14:11:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id yp5sm3699573pac.38.2015.10.20.14.11.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 14:11:27 -0700 (PDT)
In-Reply-To: <1444960333-16003-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 15 Oct 2015 18:52:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279940>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 15 +++++++++++----
>  git-submodule.sh            |  6 +-----
>  2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 47dc9cb..f81f37a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -284,11 +284,18 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
>  	for (i = 0; i < list.nr; i++) {
>  		const struct cache_entry *ce = list.entries[i];
>  
> -		if (ce_stage(ce))
> -			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
> -		else
> -			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
> +		char *env_prefix = getenv("prefix");

This somehow makes me feel dirty.  Do we really export such an
environment variable that is named overly generically to communicate
with our own helpers?

I can see why you need to be able to prefix leading paths (i.e. you
would need to prefix path to the enclosing submodule to a path to
obtain the "global view" from the very top-level superproject while
recursing into nested submodules), but still...

> +		if (ce_stage(ce)) {
> +			if (env_prefix)
> +				fprintf(stderr, "Skipping unmerged submodule %s/%s",
> +					env_prefix, ce->name);
> +			else
> +				fprintf(stderr, "Skipping unmerged submodule %s",
> +					ce->name);
> +			continue;
> +		}
>  
> +		printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
>  		utf8_fprintf(stdout, "%s\n", ce->name);
>  	}
>  	return 0;
> diff --git a/git-submodule.sh b/git-submodule.sh
> index d2d80e2..0754ecd 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -661,11 +661,7 @@ cmd_update()
>  	while read mode sha1 stage sm_path
>  	do
>  		die_if_unmatched "$mode"
> -		if test "$stage" = U
> -		then
> -			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
> -			continue
> -		fi
> +
>  		name=$(git submodule--helper name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
>  		if ! test -z "$update"
