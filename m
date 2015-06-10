From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/19] pull: implement pulling into an unborn branch
Date: Tue, 09 Jun 2015 18:31:51 -0700
Message-ID: <xmqqoakouz5k.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-14-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 03:32:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Us3-00080x-39
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 03:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbbFJBby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 21:31:54 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37974 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbbFJBbx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 21:31:53 -0400
Received: by igblz2 with SMTP id lz2so23434139igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Mf4eogLumiH5UtNyYyDcAp7AbFRFqbg+6A150Syp4II=;
        b=TQ22H+bu5Bw5wSyblHxuZRVO9+SPU5D7osGK6NrW0A2xaAAkCu54IXqJsKACV5fPq4
         fMJiYlIwmg8TVk5mlRKmC3PM+4Uacimu4dTgQFtjBWB28jhD66yj2+fe8g1l1sQ9NJg1
         ztbHY48dsvjnEVhoRcS3+viWFaLXrN7ZHO2akJ5VO6y8F+VrsAUudbBchYRKuFIHlpYL
         pF4FMy8phTC2x5YpqF1hGnA/mB+9TuDahahuLK0CVumC0bHAZZ/hN82vOiOtaGRUkU84
         /DiRea37jpc00cmt5ScbFts6bILVTUDSbx3Rl/LqWFJKyYmx8kBx4lQl3psKF4ZGfUk4
         tdYA==
X-Received: by 10.50.73.198 with SMTP id n6mr24126052igv.32.1433899912822;
        Tue, 09 Jun 2015 18:31:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id jd4sm2389895igb.15.2015.06.09.18.31.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 18:31:52 -0700 (PDT)
In-Reply-To: <1433314143-4478-14-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 3 Jun 2015 14:48:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271250>

Paul Tan <pyokagan@gmail.com> writes:

>  /**
> + * "Pulls into void" by branching off merge_head.
> + */
> +static int pull_into_void(unsigned char merge_head[GIT_SHA1_RAWSZ],
> +		unsigned char curr_head[GIT_SHA1_RAWSZ])
> +{

It is not wrong per-se, but is rather unusual (and misleading) to
specify the array-ness and array-size of parameters.  Our codebase
tends to prefer spelling it like so instead:

	static int pull_into_void(unsigned char *merge_head,
			          unsigned char *curr_head)
	{

> +	/*
> +	 * Two-way merge: we claim the index is based on an empty tree,

s/claim/treat/ perhaps?

> +	 * and try to fast-forward to HEAD. This ensures we will not lose
> +	 * index/worktree changes that the user already made on the unborn
> +	 * branch.
> +	 */
> +	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head, 0))
> +		return 1;
> +
> +	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
>   * Runs git-merge, returning its exit status.
>   */
>  static int run_merge(void)
> @@ -475,5 +497,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (!merge_heads.nr)
>  		die_no_merge_candidates(repo, refspecs);
>  
> -	return run_merge();
> +	if (is_null_sha1(orig_head)) {
> +		if (merge_heads.nr > 1)
> +			die(_("Cannot merge multiple branches into empty head."));
> +		return pull_into_void(*merge_heads.sha1, curr_head);
> +	} else
> +		return run_merge();
>  }

Sensible.
