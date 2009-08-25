From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression: overwriting untracked files in a fresh repo
Date: Mon, 24 Aug 2009 19:11:43 -0700
Message-ID: <7vk50sve00.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
 <20090824190710.GB25168@coredump.intra.peff.net>
 <7vab1o3ikz.fsf@alter.siamese.dyndns.org>
 <20090825013601.GA3515@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 04:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MflWN-00056a-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 04:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZHYCMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 22:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbZHYCMF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 22:12:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZHYCMF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 22:12:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B68AB365AB;
	Mon, 24 Aug 2009 22:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Uazs40fNZqbJMZ9cL+LAA5uGcA=; b=w0uhYP
	HKOY7Ms5aVVBjq1pBZX198xDiz8HUVh7Cgae6ZnUj4MkZSBOVY1uXwXN6UGQbq9m
	u+5UYifrU3KS7Z4M335KHaijG9fb9g+e2tL3DHQlvT+++FVnOFy/odlD1PVf1i07
	Lqz1jIHcpHyMPB2xO8E3K/tCtpcBoogeL5UaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aXRxIEdd9io2jEP2BBtuzV/+sejYKbRv
	VNL1aUOYM6yqxRyItl5WENzLJScbIzxP9J0d2b1CZo8FUoAoA6dEjzJG6TVGqlpW
	OBxF/F6ncCK7Uzj3GQOmW0vcv2ETTgZAWdkV/X+f5dBSNBZfbGVQDnawitiRh9iO
	plBlAc6uM1A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D100365AA;
	Mon, 24 Aug 2009 22:11:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B5B9365A7; Mon, 24 Aug 2009
 22:11:44 -0400 (EDT)
In-Reply-To: <20090825013601.GA3515@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 24 Aug 2009 21\:36\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A81555BE-911C-11DE-8AC6-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126990>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 8a9a474..1f2f84d 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -402,7 +402,9 @@ static int merge_working_tree(struct checkout_opts *opts,
>  		topts.dir = xcalloc(1, sizeof(*topts.dir));
>  		topts.dir->flags |= DIR_SHOW_IGNORED;
>  		topts.dir->exclude_per_dir = ".gitignore";
> -		tree = parse_tree_indirect(old->commit->object.sha1);
> +		tree = parse_tree_indirect(old->commit ?
> +					   old->commit->object.sha1 :
> +					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
>  		init_tree_desc(&trees[0], tree->buffer, tree->size);
>  		tree = parse_tree_indirect(new->commit->object.sha1);
>  		init_tree_desc(&trees[1], tree->buffer, tree->size);

This looks a lot saner; I like it.  Care to wrap it up with the usual
supporting material?

I think the "You appear to be" can just go, but I do not feel very
strongly either way.
