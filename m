From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] line-log: fix crash when --first-parent is used
Date: Mon, 03 Nov 2014 12:58:42 -0800
Message-ID: <xmqqoasoq9vh.fsf@gitster.dls.corp.google.com>
References: <1414784636-43155-1-git-send-email-tmikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tzvetan Mikov <tmikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOiA-0008WR-5q
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbaKCU6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:58:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752772AbaKCU6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 15:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B08C81BA51;
	Mon,  3 Nov 2014 15:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BsV0F1qwZZF1MG8RTxxMjNaISG4=; b=jR7xY2
	TRDVASmMatIKwSr0sEeeuu/0ddMyAwnpAgmlSXPvx2PBb//irhZkhL4dSxu1VLqM
	SQDsM4nTlUwScC+dKbuDebQfPhaXsd73WJiIsuew6NOMIAgsug6/Orphroolo9Y+
	VHU0fvCO6DUKQS8RPdHh0jCUCtAkT7kGmMjws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhzyXnCF0e1jw9iqFIHm77kZiaRIdQRN
	oWBHopVnXbJx42wanUg0cCzugGEuEBp/FhY7hyQpwrTuv4UqJePiNGnJOUC6UkN7
	DJLdMM7Nj+J7bZ9g92JdOJZQw0AB/3zNhSHKA0uXlsRvdJGIKrhjhRH5wU+J2w9U
	k1bD2fRjHTQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A28C1BA50;
	Mon,  3 Nov 2014 15:58:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4F991BA4F;
	Mon,  3 Nov 2014 15:58:43 -0500 (EST)
In-Reply-To: <1414784636-43155-1-git-send-email-tmikov@gmail.com> (Tzvetan
	Mikov's message of "Fri, 31 Oct 2014 12:43:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32518C3C-639C-11E4-B8FE-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzvetan Mikov <tmikov@gmail.com> writes:

> line-log tries to access all parents of a commit, but only the first
> parent has been loaded if "--first-parent" is specified, resulting
> in a crash.
>
> Limit the number of parents to one if "--first-parent" is specified.
>
> Reported-by: Eric N. Vander Weele <ericvw@gmail.com>
> Signed-off-by: Tzvetan Mikov <tmikov@gmail.com>
> ---

Thomas, how does this one look?

Tzvetan, can we have a test for this one?

Thanks.

>  line-log.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/line-log.c b/line-log.c
> index 1008e72..86e7274 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1141,6 +1141,9 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  	int i;
>  	int nparents = commit_list_count(commit->parents);
>  
> +	if (nparents > 1 && rev->first_parent_only)
> +	    nparents = 1;
> +
>  	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
>  	cand = xmalloc(nparents * sizeof(*cand));
>  	parents = xmalloc(nparents * sizeof(*parents));
