From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: use help_unknown_ref instead of die
Date: Wed, 01 May 2013 11:36:09 -0700
Message-ID: <7vip325yzq.fsf@alter.siamese.dyndns.org>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
	<1367407327-5216-3-git-send-email-vikrant.varma94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbt3-0001tw-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab3EASgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:36:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455Ab3EASgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:36:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CBFA1B7E9;
	Wed,  1 May 2013 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lhPlQul2aWxoR1MmJmdvX2eyfrY=; b=HQlueZgR4vo+mBAuLu+N
	r6wKvq0o0+VlKzqCNVNMW7hh8laDr5AHdQoFze2vy31eMFr6ViBogqD48MKhBpD9
	eWdA8PX9U/89px7mIrJLg8bSmqb15bRv8ckdMuVofyC29aDm7iKp7VKk6hrZkVfj
	Vfv6+FtDYPjh9GwIHOlW1Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lu5nMjWLkO9Sp6Fo7pcXY/dMelEXmZahwaQ9Gyq/QXoBmv
	c6XQ9Z9V8ITCBnt/BEMii4LH1hNp1HCM/W05UY5XHn9nU8TD/myXv70a4Mjmwsya
	PwgAagVp1zHOa6EK9eVLjJhHtlWE3whqRyNVq9OwEdR/bOpUYTZWNoE+g2SZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 444821B7E8;
	Wed,  1 May 2013 18:36:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2F7C1B7E6;
	Wed,  1 May 2013 18:36:10 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEA2D24E-B28D-11E2-9963-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223116>

Vikrant Varma <vikrant.varma94@gmail.com> writes:

> The previous patch added help_unknown_ref to print a more helpful error 
> message when trying to merge a branch that doesn't exist, by printing a 
> list of remote branches the user might have meant. Use it.
>
> Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>
> ---
>  builtin/merge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 3e2daa3..0f1f39b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1053,8 +1053,8 @@ static struct commit_list *collect_parents(struct commit *head_commit,
>  		remotes = &commit_list_insert(head_commit, remotes)->next;
>  	for (i = 0; i < argc; i++) {
>  		struct commit *commit = get_merge_parent(argv[i]);
> -		if (!commit)
> -			die(_("%s - not something we can merge"), argv[i]);
> +		if (!commit) 
> +		        help_unknown_ref(argv[i]);		        

This calling site may become something like:

	if (!commit) {
        	char *suggestion;
                suggestion = guess_misspelled_ref(argv[i]);
                die(suggestion == NULL
                    ? _("%s - not something we can merge")
                    : _("%s - not something we can merge\n"
                        "Perhaps you meant one of these?\n"
                        "%s"), argv[i], suggestion);
	}

if you really want to keep "not something we can merge" at the top.

I however suspect that this might be easier for the reader.

	if (!commit) {
        	struct string_list *suggestion;
                suggestion = guess_misspelled_ref(argv[i]);
                if (suggestion)
			print_string_list(suggestion,
                                      	_("Perhaps you meant one of these?"));
               	die(_("%s - not something we can merge"), argv[i]);
	}

Note that print_string_list() needs to be enhanced so that the
caller can tell it not to show the .util field if you go in this
direction.

>  		remotes = &commit_list_insert(commit, remotes)->next;
>  	}
>  	*remotes = NULL;

Thanks.
