From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: remove redundant check for merge commit
Date: Fri, 27 Jul 2012 15:30:54 -0700
Message-ID: <7vfw8czvj5.fsf@alter.siamese.dyndns.org>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:31:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sut3o-0007Y2-QK
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab2G0Wa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab2G0Wa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:30:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2851853B;
	Fri, 27 Jul 2012 18:30:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=avJq/suMIujptIQuH9Rk3bWyBEs=; b=KNQiDD
	ebqC0Jz27yTMWfdo53HWGleHMu+GIHWEGYVWB+O1hUX7p1xFmvdxldPt8aIrP43h
	cxL9cTyl9X2FStAvxLjHSVuV4dXl2Jv8UTl39f90U/CSbBgeMqhHeDTw4e9ObK6m
	omrU4eulqY4b2EUDxkDGTEOINuVZbbHiGWnk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKLx5YbaT1XEDHE1KrtX8gZq8zvwruA+
	Sys30BWDg2SMd4N1A2j6FiMY+hCVHqYGuLcgZCWKPMs4lfTvZmOkEA0THN/2YQgc
	m7gcRynXP23dOlex7QEZ7dygQwqeoU15EQvxVLl12tG/2Ra37EcmS/nc3QQnzb4P
	M0S1+lPk2LA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EFA7853A;
	Fri, 27 Jul 2012 18:30:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04CF48539; Fri, 27 Jul 2012
 18:30:55 -0400 (EDT)
In-Reply-To: <1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Fri, 27 Jul 2012 10:21:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB527F72-D83A-11E1-9E44-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202385>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> While walking the revision list in get_patch_ids and cmd_cherry, we
> ignore merges by checking if there is more than one parent. However,
> since the revision walk was initialized with revs.ignore_merges = 1,
> this would never happen. Remove the unnecessary checks.
>
> Also re-initializing rev_info fields to the same values already set in
> init_revisions().
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

I think the in-loop checks were totally redundant.  I suspect that
explicit initialization to revs.ignore_merges outself can be called
belt-and-braces defensive programming to avoid getting surprised by
future changes to what init_revisions() would do, so I do not have
strong preference either way.

> ---
>  builtin/log.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 7a92e3f..8182a18 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -726,10 +726,6 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
>  		die(_("revision walk setup failed"));
>  
>  	while ((commit = get_revision(&check_rev)) != NULL) {
> -		/* ignore merges */
> -		if (commit->parents && commit->parents->next)
> -			continue;
> -
>  		add_commit_patch_id(commit, ids);
>  	}
>  
> @@ -1509,8 +1505,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  
>  	init_revisions(&revs, prefix);
>  	revs.diff = 1;
> -	revs.combine_merges = 0;
> -	revs.ignore_merges = 1;
>  	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
>  
>  	if (add_pending_commit(head, &revs, 0))
> @@ -1534,10 +1528,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  	if (prepare_revision_walk(&revs))
>  		die(_("revision walk setup failed"));
>  	while ((commit = get_revision(&revs)) != NULL) {
> -		/* ignore merges */
> -		if (commit->parents && commit->parents->next)
> -			continue;
> -
>  		commit_list_insert(commit, &list);
>  	}
