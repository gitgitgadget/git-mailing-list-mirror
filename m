From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] unpack-trees: don't update files with CE_WT_REMOVE set
Date: Sat, 18 Jul 2015 14:20:11 -0700
Message-ID: <xmqqpp3pyxh0.fsf@gitster.dls.corp.google.com>
References: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
	<1437167967-5933-1-git-send-email-dturner@twopensource.com>
	<20150718083719.GA19676@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Anatole Shaw <git-devel@omni.poc.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 23:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGZWv-0001Vn-5M
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 23:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbbGRVUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 17:20:14 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36773 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbGRVUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 17:20:13 -0400
Received: by pachj5 with SMTP id hj5so79942550pac.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rcT80E87UN+FCWVlgYO5AVJ5GpcFYdgD0aveUMSymjk=;
        b=v4c30YWW/x7R26fLKpYBFtnfPjQn0AThSbRuOMYCs2N/VRlHedlUYWOo7Ueyfq7scY
         giPf/RCHdvm8q6pJdzpKXbNDbQm3/4C2J5ApPzlvTRv3hMY8L7bhRFb6L8Kky2+Xakrf
         /5/qNI6B1oIh13ZHWOc7IQNmgni/14RRHJPyFXcaw2V8Scp2D/pyTyW/IMO64/b+u6wS
         Vl/wbWrgy20M7CCkMzp3x80je01fasDcbN7ZufwxlmVxUxfT3wgKIYBtyVTbhcae1V24
         HVB8Hh/BJWcqzU2PPDEJlWMIjyeYyxXRaG+d/7sZV9PnbCjD8y80RoRlYeyV/uTvU5Qy
         Bc1g==
X-Received: by 10.66.63.9 with SMTP id c9mr42487335pas.40.1437254413188;
        Sat, 18 Jul 2015 14:20:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c060:7851:3fd2:bcfb])
        by smtp.gmail.com with ESMTPSA id fc3sm15263032pab.16.2015.07.18.14.20.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 Jul 2015 14:20:12 -0700 (PDT)
In-Reply-To: <20150718083719.GA19676@lanh> (Duy Nguyen's message of "Sat, 18
	Jul 2015 15:37:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274179>

Duy Nguyen <pclouds@gmail.com> writes:

> Thank you both for catching this. Just a small suggestion. Perhaps we
> should do this instead. apply_sparse_checkout() is the function where
> all "action" manipulation (add, delete, update files..) for sparse
> checkout occurs and it should not ask to delete and update both at the
> same time.

Sounds good.  The first hunk may merely be a noise, but the second
one is the true bugfix for the issue observed, I think.

>
> -- 8< --
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 2927660..d6cf849 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -224,6 +224,9 @@ static int check_updates(struct unpack_trees_options *o)
>  		struct cache_entry *ce = index->cache[i];
>  
>  		if (ce->ce_flags & CE_UPDATE) {
> +			if (ce->ce_flags & CE_WT_REMOVE)
> +				die("BUG: both update and delete flags are set on %s",
> +				    ce->name);
>  			display_progress(progress, ++cnt);
>  			ce->ce_flags &= ~CE_UPDATE;
>  			if (o->update && !o->dry_run) {
> @@ -293,6 +296,7 @@ static int apply_sparse_checkout(struct index_state *istate,
>  		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
>  			return -1;
>  		ce->ce_flags |= CE_WT_REMOVE;
> +		ce->ce_flags &= ~CE_UPDATE;
>  	}
>  	if (was_skip_worktree && !ce_skip_worktree(ce)) {
>  		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
> -- 8< --
>
> --
> Duy
