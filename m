From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] Teach revision walking machinery to walk multiple
 times sequencially
Date: Mon, 13 Feb 2012 17:33:34 -0800
Message-ID: <7vfwee9p1t.fsf@alter.siamese.dyndns.org>
References: <20120213092541.GA15585@t1405.greatnet.de>
 <20120213092730.GB15585@t1405.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 02:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx7HN-0006nQ-QM
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 02:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab2BNBdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 20:33:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2BNBdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 20:33:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 332F1752B;
	Mon, 13 Feb 2012 20:33:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrHyigPSBDNXGDejQAkmQjfMpQI=; b=BtBEBu
	i/kA14i3jJAQCSL7NRSNa30NjMYtYIS2P8YpLKT2SKPoa1Q34n5CrGeOPsTZl5qI
	KI9z9YbftrLbcq36S1DXOf3ngWva2/p8uCDGXWhXye9h9+nWTtDuDYQBppS9mD1A
	7T7bFHHMPnsPqSMWeFS11x5rAytm14U4lksLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GFSIpRkXSzNq1gKetuf9hqmzmA5QcVXh
	E5kczL4URP2fmud+7aSfCh1JOB1o3CEqV7caDhzoDFRTc1EXgP9bUlVJpUtmCslC
	+zD8L0y1CcRzz/veQrhz7Uj99SM5A29ckxYLdQNQeeC/h3sudv4XDozMpy/KXt1n
	mgeQzw1Q3nQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A559752A;
	Mon, 13 Feb 2012 20:33:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 765827529; Mon, 13 Feb 2012
 20:33:35 -0500 (EST)
In-Reply-To: <20120213092730.GB15585@t1405.greatnet.de> (Heiko Voigt's
 message of "Mon, 13 Feb 2012 10:27:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E98405AC-56AB-11E1-AB2C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190697>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Previously it was not possible to iterate revisions twice using the
> revision walking api. We add a reset_revision_walk() which clears the
> used flags. This allows us to do multiple sequencial revision walks.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

I am kind of surprised that this is already its 5th round.

> diff --git a/object.c b/object.c
> index 6b06297..6291ce9 100644
> --- a/object.c
> +++ b/object.c
> @@ -275,3 +275,14 @@ void object_array_remove_duplicates(struct object_array *array)
>  		array->nr = dst;
>  	}
>  }
> +
> +void clear_object_flags(unsigned flags)
> +{
> +	int i;
> +	struct object *obj;
> +
> +	for (i=0; i < obj_hash_size; i++) {
> +		if ((obj = obj_hash[i]) && obj->flags & flags)
> +			obj->flags &= ~flags;
> +	}
> +}

Minimally,

        void clear_object_flags(unsigned flags)
        {
                int i;

                for (i = 0; i < obj_hash_size; i++) {
                        struct object *obj = obj_hash[i];
                        if (obj && (obj->flags & flags))
                                obj->flags &= ~flags;
                }
        }

I am not sure if the "If there is any bit set we care about, drop them"
buys us anything, though.

> diff --git a/revision.c b/revision.c
> index c97d834..77ce6bd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2061,6 +2061,11 @@ static void set_children(struct rev_info *revs)
>  	}
>  }
>  
> +void reset_revision_walk()

	void reset_revision_walk(void)

> +{
> +	clear_object_flags(SEEN | ADDED | SHOWN);
> +}

But is this really the right API?  After a particular program finishes
using the revision walker, wouldn't it want to clear both the set of these
standard flag bits used by the traversal machinery, as well as whatever
program specific bits it used to mark the objects with?

> diff --git a/revision.h b/revision.h
> index b8e9223..3535733 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -192,6 +192,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
>  ...
> +extern void reset_revision_walk();

Likewise, "extern void reset_revision_walk(void);".

> diff --git a/submodule.c b/submodule.c
> index 9a28060..645ff5d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -404,6 +404,7 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
>  	while ((commit = get_revision(&rev)) && !needs_pushing)
>  		commit_need_pushing(commit, &needs_pushing);
>  
> +	reset_revision_walk();
>  	free(sha1_copy);
>  	strbuf_release(&remotes_arg);
>  
> @@ -741,6 +742,7 @@ static int find_first_merges(struct object_array *result, const char *path,
>  		if (in_merge_bases(b, &commit, 1))
>  			add_object_array(o, NULL, &merges);
>  	}
> +	reset_revision_walk();
>  
>  	/* Now we've got all merges that contain a and b. Prune all
>  	 * merges that contain another found merge and save them in

These two hunk look like a *BUGFIX* to me (certainly it does not look like
this is an addition of any new feature).

What bug does this fix, and how is the current submodule code broken
without this patch?  Can you describe the problem in the log message, and
add a test to demonstrate the existing breakage?
