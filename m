From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-tree: fix "same file added in subdir"
Date: Wed, 27 Mar 2013 15:42:40 -0700
Message-ID: <7vk3osjwgv.fsf@alter.siamese.dyndns.org>
References: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:43:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKz3o-0004tq-G3
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab3C0Wmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:42:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab3C0Wmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:42:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB943A35F;
	Wed, 27 Mar 2013 18:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yD0Yy8SUmJaHX3L4ZO63tJN8f1g=; b=Xmaix2
	BhIO0c8lFXf6EhneNTh2Zgu4hkbN+3JC1aU+6DLc1dsk0OA5HxxHsP+mj4LyoRa9
	E0+ilqo+bZrqiq4dqYp9Oj+hRskoZPoIrlu0A8ONDKaK6C/6y/JpNiGhIB44otR9
	1bmUP9bKD3q0jrybPvHUOhGHKprBmR39Svkm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMVdkTqslb4wvd1FjPHURI3gO5OoaUTe
	9S0y1lR0GiQNVb1KUd2X8L3BWzaw+a6qYt/CnA+kui2jVhpkOGM4ATZhjyN/sX1W
	XTH7uhW3PqZaATAhgm95c4ZrwpVb3XWqY0b22rXROGV3/YeK5MoOCHhsjNVvJO2d
	h7wBiE2cWIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E105EA35E;
	Wed, 27 Mar 2013 18:42:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34A09A35C; Wed, 27 Mar 2013
 18:42:42 -0400 (EDT)
In-Reply-To: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
 (John Keeping's message of "Wed, 27 Mar 2013 21:34:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2A0E09A-972F-11E2-B81E-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219344>

John Keeping <john@keeping.me.uk> writes:

> When the same file is added with identical content at the top level,
> git-merge-tree prints "added in both" with the details.  But if the file
> is added in an existing subdirectory, threeway_callback() bails out early
> because the two trees have been modified identically.
>
> In order to detect this, we need to fall through and recurse into the
> subtree in this case.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

The rationale the above description gives is internally consistent,
but it is rather sad to see this optimization go.  The primary
motivation behind this program, which does not use the usual
unpack-trees machinery, is to allow us to cull the identical result
at a shallow level of the traversal when the both sides changed (not
added) a file deep in a subdirectory hierarchy.

The patch makes me wonder if we should go the other way around,
resolving the "both added identically" case at the top cleanly
without complaint.

>  builtin/merge-tree.c  |  9 +++++++--
>  t/t4300-merge-tree.sh | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index e0d0b7d..ca97fbd 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -298,12 +298,17 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
>  {
>  	/* Same in both? */
>  	if (same_entry(entry+1, entry+2)) {
> -		if (entry[0].sha1) {
> +		if (entry[0].sha1 && !S_ISDIR(entry[0].mode)) {
>  			/* Modified identically */
>  			resolve(info, NULL, entry+1);
>  			return mask;
>  		}
> -		/* "Both added the same" is left unresolved */
> +		/*
> +		 * "Both added the same" is left unresolved.  We also leave
> +		 * "Both directories modified identically" unresolved in
> +		 * order to catch changes where the same file (with the same
> +		 * content) has been added to both directories.
> +		 */
>  	}
>  
>  	if (same_entry(entry+0, entry+1)) {
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index d0b2a45..be0737e 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -298,4 +298,21 @@ test_expect_success 'turn tree to file' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'add identical files to subdir' '
> +	cat >expected <<\EXPECTED &&
> +added in both
> +  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/ONE
> +  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/ONE
> +EXPECTED
> +
> +	git reset --hard initial &&
> +	mkdir sub &&
> +	test_commit "sub-initial" "sub/initial" "initial" &&
> +	test_commit "sub-add-a-b-same-A" "sub/ONE" "AAA" &&
> +	git reset --hard sub-initial &&
> +	test_commit "sub-add-a-b-same-B" "sub/ONE" "AAA" &&
> +	git merge-tree sub-initial sub-add-a-b-same-A sub-add-a-b-same-B >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
