From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Thu, 11 Jul 2013 15:53:58 -0700
Message-ID: <7vsizkpv21.fsf@alter.siamese.dyndns.org>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPka-0001Wf-De
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab3GKWyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:54:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab3GKWyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:54:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A6AE301B4;
	Thu, 11 Jul 2013 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syUNVY1W1oe64tfAK7sZuiy2zco=; b=b0hGAa
	iJkDCpoRgxXBpQq40TpqGRINNAnyp42bj0haHrenlTTYMkEGtVePLtNFe7b1aMsz
	pDcBuOxeq02AibNgyL35/uW5jNhV9ThGpAX53zRwiuXqvm5n5ETeSG7GMtLtZPh/
	rD3mB4UfwGI7R1v7O0YRB2znY1YZgwU4LzoDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MsjyPbdwUGug4YqbeIU/G9Y0g1BSXN/I
	aY8Tk22uCmrhhROCKujchJgFyN9lpcgLCn3QEI+gRJntqnY/+1uMTwKtLqNG5DIE
	xnu9+ykw3wV6hk5wQXsrcH5M+ZV70ErJF7Y/OjZT+DLJcsaDISJ7AYhYEWUESR/q
	TkxLsB1KGP8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2354F301B1;
	Thu, 11 Jul 2013 22:54:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E59E301A3;
	Thu, 11 Jul 2013 22:53:59 +0000 (UTC)
In-Reply-To: <20130711220127.GK10217@login.drsnuggles.stderr.nl> (Matthijs
	Kooijman's message of "Fri, 12 Jul 2013 00:01:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C671FA0E-EA7C-11E2-AF8A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230149>

Matthijs Kooijman <matthijs@stdin.nl> writes:

[administrivia: you seem to have mail-followup-to that points at you
and the list; is that really needed???]

> This happens when a client issues a fetch with a depth bigger or equal
> to the number of commits the server is ahead of the client.

Do you mean "smaller" (not "bigger")?

> diff --git a/upload-pack.c b/upload-pack.c
> index 59f43d1..5885f33 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -122,6 +122,14 @@ static int do_rev_list(int in, int out, void *user_data)
>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");
>  	mark_edges_uninteresting(revs.commits, &revs, show_edge);
> +	/* In case we create a new shallow root, make sure that all
> +	 * we don't send over objects that the client already has just
> +	 * because their "have" revisions are no longer reachable from
> +	 * the shallow root. */
> +	for (i = 0; i < have_obj.nr; i++) {
> +		struct commit *commit = (struct commit *)have_obj.objects[i].item;
> +		mark_tree_uninteresting(commit->tree);
> +	}

Hmph.

In your discussion (including the comment), you talk about "shallow
root" (I think that is the same as what we call "shallow boundary"),
but in this added block, there is nothing that checks CLIENT_SHALLOW
or SHALLOW flags to special case that.

Is it a good idea to unconditionally do this for all "have"
revisions?

Also there is another loop that iterates over "have" revisions just
above the precontext.  I wonder if this added code belongs in that
loop.
