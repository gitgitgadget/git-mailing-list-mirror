From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] reset: update cache-tree data when appropriate
Date: Tue, 06 Dec 2011 15:13:28 -0800
Message-ID: <7v62hte1k7.fsf@alter.siamese.dyndns.org>
References: <cover.1323191497.git.trast@student.ethz.ch>
 <1385c10084ae41ae4543ef3ccaa1d6c8182b2204.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 07 00:13:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY4Ce-0007KK-DH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 00:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab1LFXNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 18:13:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab1LFXNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 18:13:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE4550FA;
	Tue,  6 Dec 2011 18:13:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wNA+BW2CPhZV5N71rr7dTnu5bbU=; b=W6EW06
	c5MDdkG2tc/d6YyRLHK+yBO5o9gROw+tP1ZzWwq3VIB3ijG50cH/ywSB2tudGPg8
	Vj+zsYed3RPrIOTFS5q6/Swecj5FYchmZyvLvxuFI5ov85gCJ3lAKqFJg7+EUAoU
	mkFdPBah6EHjJj8uzE4LVrot8HINRF9wudcHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJBYjiTKMo/WtUtZuu5J9cDfauXv5IiQ
	+UzNSpjPOw4RAicE3jStpCB0GycqPF5BqWc8Zh2Ijmg8q+lDVOMVjZK6bzM6u5Ez
	83U2SJTBfMFwToPhJuFYgZegDSFhRQ97xpYLqe89EoLLAPRtLzidD58tIli4itvC
	Sp2SnCwSlJQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54C2250F9;
	Tue,  6 Dec 2011 18:13:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB60F50F8; Tue,  6 Dec 2011
 18:13:29 -0500 (EST)
In-Reply-To: <1385c10084ae41ae4543ef3ccaa1d6c8182b2204.1323191497.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 6 Dec 2011 18:43:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E47E24-205F-11E1-95C0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186404>

Thomas Rast <trast@student.ethz.ch> writes:

> In the case of --mixed and --hard, we throw away the old index and
> rebuild everything from the tree argument (or HEAD).  So we have an
> opportunity here to fill in the cache-tree data, just as read-tree
> did.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  builtin/reset.c       |    7 +++++++
>  t/t0090-cache-tree.sh |    4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 811e8e2..8c2c1d5 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -43,6 +43,7 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
>  	int nr = 1;
>  	int newfd;
>  	struct tree_desc desc[2];
> +	struct tree *tree;
>  	struct unpack_trees_options opts;
>  	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>  
> @@ -84,6 +85,12 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
>  		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
>  	if (unpack_trees(nr, desc, &opts))
>  		return -1;
> +
> +	if (reset_type == MIXED || reset_type == HARD) {
> +		tree = parse_tree_indirect(sha1);
> +		prime_cache_tree(&active_cache_tree, tree);
> +	}

The basic idea that MIXED or HARD should result in a cache-tree that match
the tree we just read is sound, but how expensive is prime_cache_tree()? I
think it reads the same tree once again. Admittedly, the data needed to
reconstruct the tree is likely to be hot in core, but it may be necessary
to measure before deciding if this is a good change.
