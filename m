From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_octopus_merge_bases(): cleanup redundant variable
Date: Fri, 03 Jan 2014 10:26:43 -0800
Message-ID: <xmqqeh4oncpo.fsf@gitster.dls.corp.google.com>
References: <1388760346-19515-1-git-send-email-einmalfel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: Vasily Makarov <einmalfel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 19:26:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz9SR-0006tV-UH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 19:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbaACS0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 13:26:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbaACS0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 13:26:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE14A5D0FF;
	Fri,  3 Jan 2014 13:26:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OegzcdgWPVhlTBNBHGyU4nrnFZY=; b=aM8EVl
	tZWRrZVCcl4nVbZBK+WvadAmvwtDuwU7WECIwRCPu4AbeTGPWdXH5sqT7pzS+PiC
	w/ysuc86YU7+Bx9EJCatMJOtxDjIM5HrnSk0sfNUq7+IXH/R6JHQAuz9dfOKVTze
	s46dKdB7IhEyKzu4DUBbMVftLXRsM2D9lfUQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4HDldwlwv09usKTHiFWYDV9lTBlq7CU
	sFPcCQElbOuhxEKSrAjyaZupHUICHm442jWTdQ/uG+pra8ECLYwoJsncKmOeOciY
	n3he5TA/9Y+DPw0o9u4lG9VbJTf2KYPax1PTm6uqnBW4cudAhbeAuiLbr8FoAq22
	COE0exyZTro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6F615D0F5;
	Fri,  3 Jan 2014 13:26:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8DEA5D0F0;
	Fri,  3 Jan 2014 13:26:45 -0500 (EST)
In-Reply-To: <1388760346-19515-1-git-send-email-einmalfel@gmail.com> (Vasily
	Makarov's message of "Fri, 3 Jan 2014 18:45:46 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99F6468A-74A4-11E3-BF95-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239923>

Vasily Makarov <einmalfel@gmail.com> writes:

> pptr is needless. Some related code got cleaned as well
>
> Signed-off-by: Vasily Makarov <einmalfel@gmail.com>
> ---
>  commit.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index de16a3c..4a7a192 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -834,26 +834,23 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>  struct commit_list *get_octopus_merge_bases(struct commit_list *in)
>  {
>  	struct commit_list *i, *j, *k, *ret = NULL;
> -	struct commit_list **pptr = &ret;
>  
> -	for (i = in; i; i = i->next) {
> -		if (!ret)
> -			pptr = &commit_list_insert(i->item, pptr)->next;
> -		else {
> -			struct commit_list *new = NULL, *end = NULL;
> -
> -			for (j = ret; j; j = j->next) {
> -				struct commit_list *bases;
> -				bases = get_merge_bases(i->item, j->item, 1);
> -				if (!new)
> -					new = bases;
> -				else
> -					end->next = bases;
> -				for (k = bases; k; k = k->next)
> -					end = k;
> -			}
> -			ret = new;
> +	commit_list_insert(in->item, &ret);

I suspect that the original code would have behaved well (and I also
suspect that it was designed to) even if in==NULL upon entry, but
this version will crash here.  Nothing a simple

	if (!in)
        	return NULL;

upfront cannot fix, though.

And if we add these three lines back, the patch will become 18
insertions with 18 deletions but the result is very much more
readable than the original ;-).

> +
> +	for (i = in->next; i; i = i->next) {
> +		struct commit_list *new = NULL, *end = NULL;
> +
> +		for (j = ret; j; j = j->next) {
> +			struct commit_list *bases;
> +			bases = get_merge_bases(i->item, j->item, 1);
> +			if (!new)
> +				new = bases;
> +			else
> +				end->next = bases;
> +			for (k = bases; k; k = k->next)
> +				end = k;
>  		}
> +		ret = new;
>  	}
>  	return ret;
>  }
