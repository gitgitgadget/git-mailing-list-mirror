From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remove unnecessary parameter from get_patch_ids()
Date: Fri, 27 Jul 2012 15:44:46 -0700
Message-ID: <7v1ujwzuw1.fsf@alter.siamese.dyndns.org>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1343409699-27199-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutHC-0008GR-FK
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab2G0Wot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:44:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab2G0Wos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:44:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2908888;
	Fri, 27 Jul 2012 18:44:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2upxqO9M5VrwJ56bgA+oXCTlesE=; b=kGUUpx8+2g+YRw2UB23x
	d99jVWcbOOeTGfK2Qgjyd0/SXZYNujUYBNxWOf3NW86b1pJWQuFiVfhfC+fCNLEH
	7Ik2FGvlpKuEprcQPK7QT2UNDrdjRUrI25LSI/fsv8htQiYrXNFq3w/UDkEhgDGz
	O2vhpsaHGL3AAwJvX0rJhbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jCry9Ea5MwWOaVHoKYHQZ0Zm2DQ6nzKy4g+CsQQMspbQ0N
	6OVdJY/+xY2Yse95SzwpP+ERCB5AmowcE/OOhwJ9D2wv4jVlzs3RDubcl78Oc+xV
	HHWre43jQgjwCMYByezxhXAEOz9Q/LACUa/7A2fQqcoNxGONo5E02Sgcon+Ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49CAC8887;
	Fri, 27 Jul 2012 18:44:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CEB78886; Fri, 27 Jul 2012
 18:44:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAF83084-D83C-11E1-BA0B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202387>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> get_patch_ids() takes an already initialized rev_info and a
> prefix. The prefix is used when initalizing a second rev_info. Since
> the initialized rev_info already has a prefix and it seems the prefix
> doesn't change, we can used the prefix from the initialized rev_info
> to initialize the second rev_info.

s/it seems the prefix doesn't change/the prefix never changes/;

> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

I think this change shouldn't change the behaviour and is good.

Just FYI, during the revision traversal, prefix affects two things
in the current code:

 (1) it is used as the basename for prune data that determine which
     parts of the tree structure to pay attention to (e.g. "cd t &&
     git log .").

 (2) it is used as the basename for diff output when revs->diffopt
     is used (e.g. "cd t && git log -p").

And check_rev is used with neither.  It does not want to prune any
part of the tree nor it wants to filter with fancier options like
grep/pickaxe (i.e. it does not use setup_revisions()).

In that sense it probably does not even matter if you did not pass
rev->prefix down to check_rev, and instead gave NULL to it, but that
only holds true in the current codebase, so I think what your patch
does is the right thing to do.

Thanks.

>  builtin/log.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index ecc2793..7a92e3f 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -696,7 +696,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
>  	return 0;
>  }
>  
> -static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const char *prefix)
> +static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
>  {
>  	struct rev_info check_rev;
>  	struct commit *commit;
> @@ -717,7 +717,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
>  	init_patch_ids(ids);
>  
>  	/* given a range a..b get all patch ids for b..a */
> -	init_revisions(&check_rev, prefix);
> +	init_revisions(&check_rev, rev->prefix);
>  	o1->flags ^= UNINTERESTING;
>  	o2->flags ^= UNINTERESTING;
>  	add_pending_object(&check_rev, o1, "o1");
> @@ -1306,7 +1306,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
>  				return 0;
>  		}
> -		get_patch_ids(&rev, &ids, prefix);
> +		get_patch_ids(&rev, &ids);
>  	}
>  
>  	if (!use_stdout)
> @@ -1525,7 +1525,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  			return 0;
>  	}
>  
> -	get_patch_ids(&revs, &ids, prefix);
> +	get_patch_ids(&revs, &ids);
>  
>  	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
>  		die(_("Unknown commit %s"), limit);
