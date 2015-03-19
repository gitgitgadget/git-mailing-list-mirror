From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Thu, 19 Mar 2015 11:53:10 -0700
Message-ID: <xmqqy4msizu1.fsf@gitster.dls.corp.google.com>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 19:53:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYfZG-00029q-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 19:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbbCSSxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 14:53:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751115AbbCSSxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 14:53:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53DCB412A5;
	Thu, 19 Mar 2015 14:53:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V6BfY1q7KrrwHuJGfCMuw40vMTg=; b=KcS1Pj
	LEAoEYZ5dfOedo3a1vhIMJzKV3u3+EKdFBI91S0hKBmRVGahDz6kFEMl6uPTyC1m
	P2owpugmdcXr3CRwKWtDYK0cHJIlxpGPeRXbZntoxSG3omQ0KG355seQaBo1lsjL
	NUeQ4VM0/fyXtAq8TGeX6RToiuLqo/9Sv0FrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eUgNUuJSYq5FDp4WDmC8HkkdL/RuMV1u
	HmUNI15m37Tlf/njOMP4wI2XFMWCMchshq99s7rmLIyYmFPqkhmalHtxj8p25vjT
	o5tQrXtkPEukn/1M0blcabyt9aZem0tPoG72CCvMC0zkyX7vvXuD07pcjO9VUSTP
	B2/XlYnm7ek=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CB7B412A4;
	Thu, 19 Mar 2015 14:53:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5866412A2;
	Thu, 19 Mar 2015 14:53:11 -0400 (EDT)
In-Reply-To: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org> (Trevor
	Saunders's message of "Wed, 18 Mar 2015 08:27:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3113BBA0-CE69-11E4-A33D-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265816>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

> If a user does git checkout HEAD -- path/to/submodule they'd expect the
> submodule to be checked out to the commit that submodule is at in HEAD.

Hmmm.

Is it a good idea to do that unconditionally by hard-coding the
behaviour like this patch does?

Is it a good idea that hard-coded behaviour is "checkout [-f]"?

I think "git submodule update" is the command people use when they
want to "match" the working trees of submodules, and via the
configuration mechanism submodule.*.update, people can choose what
they mean by "match"ing.  Some people want to checkout the commit
specified in the superproject tree by detaching HEAD at it.  Some
people want to integrate by merging or rebasing.

> This is the most brute force possible way of try to do that, and so its
> probably broken in some cases.  However I'm not terribly familiar with
> git's internals and I'm not sure if this is even wanted so I'm starting
> simple.  If people want this to work I can try and do something better.
>
> Signed-off-by: Trevor Saunders <tbsaunde@tbsaunde.org>
> ---
>  entry.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 1eda8e9..2dbf5b9 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -1,6 +1,8 @@
>  #include "cache.h"
> +#include "argv-array.h"
>  #include "blob.h"
>  #include "dir.h"
> +#include "run-command.h"
>  #include "streaming.h"
>  
>  static void create_directories(const char *path, int path_len,
> @@ -277,9 +279,25 @@ int checkout_entry(struct cache_entry *ce,
>  		 * just do the right thing)
>  		 */
>  		if (S_ISDIR(st.st_mode)) {
> -			/* If it is a gitlink, leave it alone! */
> -			if (S_ISGITLINK(ce->ce_mode))
> +			if (S_ISGITLINK(ce->ce_mode)) {
> +				struct argv_array args = ARGV_ARRAY_INIT;
> +				char sha1[41];
> +
> +				argv_array_push(&args, "checkout");
> +
> +				if (state->force)
> +					argv_array_push(&args, "-f");
> +
> +				memcpy(sha1, sha1_to_hex(ce->sha1), 41);
> +				argv_array_push(&args, sha1);
> +				
> +				run_command_v_opt_cd_env(args.argv,
> +					       		 RUN_GIT_CMD, ce->name,
> +							 NULL);
> +				argv_array_clear(&args);
> +
>  				return 0;
> +			}
>  			if (!state->force)
>  				return error("%s is a directory", path.buf);
>  			remove_subtree(&path);
