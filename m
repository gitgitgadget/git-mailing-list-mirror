From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-tree.c: remove dead code
Date: Tue, 12 Aug 2014 15:24:42 -0700
Message-ID: <xmqqmwb94a8l.fsf@gitster.dls.corp.google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
	<1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, barkalow@iabervon.org,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 00:24:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHKUy-0007NY-S6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 00:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaHLWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 18:24:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61867 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbaHLWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 18:24:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEA7631F72;
	Tue, 12 Aug 2014 18:24:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TSCYiwtsEOgdP4+2sWI2ovVgfIo=; b=GgxApl
	mbHKMK7Lkr/ZiU3QzFlkBZ09jUxI2vfp1wON1KdwHupb0s+3wSF8vyaCTGE+QQQx
	Opr3i6wSIhK8dH0WK+sOvAdYQplxdvhAYQjlSi19Y+ibaLApC+jTZnr5VbIIFGZg
	CBoipqLz7APUdBdOsU7Qu2+bJXanzTSIgMVaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQlYRWcwqsF4AcZn2+0oKTjxspnfx6oa
	ZngsaqvKj/WX/Z//q9ylH4XdfENYBldc9bggbRBfR8ZdrjUFR62VeF5NXr00RCIF
	ov8rvY/JkP+x3UzRMO7lSJ6lv1XZ9gbVQF3Jhpdsc7cP+ilMe+WZiZ7XBTWiKW7R
	g/Zvo9+Ozc0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B47FA31F71;
	Tue, 12 Aug 2014 18:24:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A212731F69;
	Tue, 12 Aug 2014 18:24:43 -0400 (EDT)
In-Reply-To: <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Tue, 12 Aug 2014 23:15:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 758B6C8E-226F-11E4-93D1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255173>

Stefan Beller <stefanbeller@gmail.com> writes:

> In line 1763 of unpack-tree.c we have a condition on the current tree
> 	if (current) {
> 		...
> Within this block of code we can assume current to be non NULL, hence
> the code after the statement in line 1796:
> 	if (current)
> 		return ...
>
> cannot be reached.
>
> current/newtree/oldtree are used in the
> call to reject_merge() *only* for their path aka ce->name, and they
> all point at the same name (there is no rename funkies here); hence
> "all other failures" code path should just rely on current always
> being present.
>
> All referenced lines have been introduced in the same commit
> 076b0adc (2006-07-30, read-tree: move merge functions to the library),
> which was just moving the code around.
> The outer condition on the current tree (now in line 1763) was introduced
> in c859600954df4c292e, June 2005, [PATCH] read-tree: save more user hassles during fast-forward.
> The inner condition on the current tree was introduced in
> ee6566e8d70da682ac4926d, Sept. 2005, [PATCH] Rewrite read-tree
>
> This issue was found by coverity, Id:290002
>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> ---
>  unpack-trees.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> Did I understand you right, when changing to this one?

Something like that.  I've already pushed out the original with a
tentative "SQUASH???" on top for today's integration; I'll try to
remember replacing them with this version.

Thanks.

>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index c6aa8fb..42ee84e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1789,15 +1789,11 @@ int twoway_merge(const struct cache_entry * const *src,
>  			/* 20 or 21 */
>  			return merged_entry(newtree, current, o);
>  		}
> +		else if (o->gently) {
> +			return  -1 ;
> +		}
>  		else {
> -			/* all other failures */
> -			if (oldtree)
> -				return o->gently ? -1 : reject_merge(oldtree, o);
> -			if (current)
> -				return o->gently ? -1 : reject_merge(current, o);
> -			if (newtree)
> -				return o->gently ? -1 : reject_merge(newtree, o);
> -			return -1;
> +			reject_merge(current, o);
>  		}
>  	}
>  	else if (newtree) {
