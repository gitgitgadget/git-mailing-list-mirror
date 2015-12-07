From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] revision.c: fix possible null pointer access
Date: Mon, 07 Dec 2015 12:31:11 -0800
Message-ID: <xmqqegeym25s.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
	<1449329244-4585-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62RK-0001nK-SJ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbbLGUbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:31:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932690AbbLGUbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:31:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B6CE32117;
	Mon,  7 Dec 2015 15:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GmAIkVQMT4XvmXvJ7XnZiLw0UFA=; b=ObA8HJ
	5nfuo5y4MUpTSznRpVCCXgXknq+Iz4s+RG7XjmX9M0eOh20GCPrR0wvk1M+ByJvV
	Ot8aB/tNgZdB+a21MH/Npcx3Or8Y+A4XDGMBp78QhRgGbRmYVaqFlrXrHlDQKbJA
	xHWLwtTe7VEg/WTDhZGziIZbcBdroztXM6TF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnmrOO90FpDp66ek82tBw7RKHg2A4koM
	4paFffg0KTSScnjbAAWa5A1ONybaNW4OdfSyGX54OVjgiihbts1KPcV1yuUYAumD
	alwPJHyQGAJtjpDoM48Fo3ApDaMc0E38+PTsNVYZPH+HV0vPcg7EksXFQRzePd9N
	sn0YSQf9c2I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6419F32116;
	Mon,  7 Dec 2015 15:31:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A04AD32113;
	Mon,  7 Dec 2015 15:31:12 -0500 (EST)
In-Reply-To: <1449329244-4585-1-git-send-email-stefan.naewe@gmail.com> (Stefan
	Naewe's message of "Sat, 5 Dec 2015 16:27:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74F9CCEC-9D21-11E5-88D7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282117>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> mark_tree_uninteresting dereferences a tree pointer before checking
> if the pointer is valid. Fix that by doing the check first.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---

I still have a problem with "dereferences", as "dereference" is
about computing an address and accessing memory based on the result,
and only the first half is happening here.  I can live with "The
function does a pointer arithmetic on 'tree' before it makes sure
that 'tree' is not NULL", but in any case, let's queue this as-is
for now and wait for a while to see if others can come up with a
more appropriate phrases.

Thanks.

>  revision.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 0fbb684..8c569cc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -135,10 +135,12 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
>  
>  void mark_tree_uninteresting(struct tree *tree)
>  {
> -	struct object *obj = &tree->object;
> +	struct object *obj;
>  
>  	if (!tree)
>  		return;
> +
> +	obj = &tree->object;
>  	if (obj->flags & UNINTERESTING)
>  		return;
>  	obj->flags |= UNINTERESTING;
