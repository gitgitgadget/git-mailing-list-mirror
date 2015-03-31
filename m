From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote.c: drop "remote" pointer from "struct branch"
Date: Tue, 31 Mar 2015 13:50:05 -0700
Message-ID: <xmqqvbhgq4ci.fsf@gitster.dls.corp.google.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173555.GB18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:50:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd36z-0000HK-LC
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 22:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbbCaUuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 16:50:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752717AbbCaUuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 16:50:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB6ED45CFA;
	Tue, 31 Mar 2015 16:50:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PCUsg2xE9cHeoybypN1qKrLNWWE=; b=WrThhx
	OHdT1RtbgyFflHrIQ0eBxkScA/03PhO6/ztFiowxc9LUYymlhxEGghhudrNrOYc8
	tEMYd5pQish+Qd7E21rGvUKhs9srvAT9dDGizIlijh1ekSdY6NpaxWyQn8pHhQtS
	pjHyeDAyImNA+z5T3ePJi60plW8tgNjtOa5Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chD2UywLq865fT4Wrx+Eehrpvlx8jHI8
	crKAN9eeB9jABDCXmcIcvOnOtds2l/baQZZxEGefPEaxOzIqxHmK5mHNkpgnJ6Zl
	5hPx4iyUVqvGmKowsel/mhNyAuMbQz/jB32bH+8K/XNhEUocnYuxa7Akwd/VQ/N1
	oA/w8qF8AwA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C49FF45CF9;
	Tue, 31 Mar 2015 16:50:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3160A45CF7;
	Tue, 31 Mar 2015 16:50:06 -0400 (EDT)
In-Reply-To: <20150331173555.GB18912@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 13:35:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82F0ACC6-D7E7-11E4-B3F7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266555>

Jeff King <peff@peff.net> writes:

> When we create each branch struct, we fill in the
> "remote_name" field from the config, and then fill in the
> actual "remote" field based on that name. However, it turns
> out that nobody really cares about this field. The only two
> sites that access it are:
>
>   1. git-merge, which uses it to notice when the branch does
>      not have a remote defined. But we can easily replace this
>      with looking at remote_name instead.
>
>   2. remote.c itself, when setting up the @{upstream} merge
>      config. But we don't need to save the "remote" for
>      that; we can just look it up for the duration of the
>      operation.
>
> Getting rid of it drops one potential source of confusion:
> is the value the match for "remote_name", or is it the
> remote we would fetch from when on that branch (i.e., does
> it fall back to "origin")?

I had to read the above three times before I realized that you were
wondering "what is the value of this 'remote' field?  is it what
remote_get() would give us for 'remote_name' and is NULL if
remote_name is not set, or is it never NULL and instead have the
remote for 'origin' if remote_name is not set?"

But perhaps it is just me.

We certainly have duplicated information between the two fields, and
it first looked somewhat unnatural that you kept the name with which
you need to trigger a search for the structure, instead of keeping
the structure, one of whose field is its name already.  Perhaps
there was a valid reason behind this choice, and I am guessing that
it is probably because it will not let you differenciate the case
where the user explicitly said 'origin' and we used 'origin' as a
fallback, if you keep a "remote" field that stores the instance of
the remote structure for 'origin' without keeping "remote_name".

But we shouldn't leave it for readers to guess.

> When we add pushremote_name, this question would get even
> more confusing, as pushremotes have a more complicated
> lookup procedure. It would be nice for the code to be
> consistent between the remote and pushremote, and this takes
> us one step closer.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/merge.c |  2 +-
>  remote.c        | 14 ++++++++------
>  remote.h        |  1 -
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 3b0f8f9..1840317 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -955,7 +955,7 @@ static int setup_with_upstream(const char ***argv)
>  
>  	if (!branch)
>  		die(_("No current branch."));
> -	if (!branch->remote)
> +	if (!branch->remote_name)
>  		die(_("No remote for the current branch."));
>  	if (!branch->merge_nr)
>  		die(_("No default upstream defined for the current branch."));
> diff --git a/remote.c b/remote.c
> index fcd868d..d5fd605 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1633,15 +1633,20 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  
>  static void set_merge(struct branch *ret)
>  {
> +	struct remote *remote;
>  	char *ref;
>  	unsigned char sha1[20];
>  	int i;
>  
> +	if (!ret->remote_name || !ret->merge_nr)
> +		return;
> +	remote = remote_get(ret->remote_name);
> +
>  	ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
>  	for (i = 0; i < ret->merge_nr; i++) {
>  		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
>  		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
> -		if (!remote_find_tracking(ret->remote, ret->merge[i]) ||
> +		if (!remote_find_tracking(remote, ret->merge[i]) ||
>  		    strcmp(ret->remote_name, "."))
>  			continue;
>  		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
> @@ -1661,11 +1666,8 @@ struct branch *branch_get(const char *name)
>  		ret = current_branch;
>  	else
>  		ret = make_branch(name, 0);
> -	if (ret && ret->remote_name) {
> -		ret->remote = remote_get(ret->remote_name);
> -		if (ret->merge_nr)
> -			set_merge(ret);
> -	}
> +	if (ret)
> +	       set_merge(ret);
>  	return ret;
>  }
>  
> diff --git a/remote.h b/remote.h
> index 02d66ce..4bb6672 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -203,7 +203,6 @@ struct branch {
>  	const char *refname;
>  
>  	const char *remote_name;
> -	struct remote *remote;
>  
>  	const char **merge_name;
>  	struct refspec **merge;
