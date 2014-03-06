From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strchrnul() in place of strchr() and strlen()
Date: Thu, 06 Mar 2014 12:54:29 -0800
Message-ID: <xmqqzjl3vyii.fsf@gitster.dls.corp.google.com>
References: <BLU0-SMTP1988500CEC43BD4C57254AB91890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rohit Mani <rohit.mani@outlook.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfJP-0001LW-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbaCFUyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 15:54:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaCFUye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:54:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39FC271F15;
	Thu,  6 Mar 2014 15:54:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mv9FOiSZ9z6nxvGAOo605luE9zw=; b=X6h8Ll
	mWc/zkDw0N+kTiWP74j/MqLx687iBGAtTfK9qwtEJh4gZkUMvq2t1aXmo68PZrYl
	G2zXVOlwYeqc/I+QSkNJ31ao2pIuZ0Fud6WY8US7rh+rLNClKuE/eQsRMO2PRUMV
	vdtrrEtOE6VRBN4HFYDcqQnzaYYEUjY2PnNRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uO+20Oh1789VRTm12QtVTRG+76uyM1Ym
	3Ech9X1nrZUcv/L675+bH07E4i4YJI7910rraHuqZLrl9gsQS1kudPy2etETVLuA
	dTngB6b8IBAx0q8Sd+VtpzC0cXf7yNJ02jQdO0GG7Oa35NK4qhlkVFCaGSnyU9od
	iT04aWOGRFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287DB71F13;
	Thu,  6 Mar 2014 15:54:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CAE171F12;
	Thu,  6 Mar 2014 15:54:33 -0500 (EST)
In-Reply-To: <BLU0-SMTP1988500CEC43BD4C57254AB91890@phx.gbl> (Rohit Mani's
	message of "Wed, 5 Mar 2014 11:29:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85010244-A571-11E3-B05E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243550>

Rohit Mani <rohit.mani@outlook.com> writes:

> Avoid scanning strings twice, once with strchr() and then with
> strlen(), by using strchrnul(). Update the conditional expressions
> involving the return value of strchrnul() with a check for '\0'.
>
> Signed-off-by: Rohit Mani <rohit.mani@outlook.com>
> ---

Nicely done.  I am not sure if you need to say the "update the
conditional...", which is a logical consequence of such a conversion
and goes without saying, though.

>  cache-tree.c     |   16 +++++++---------

This part may overlap with other topics in flight, but I expect the
conflict resolution would be trivial.

> diff --git a/cache-tree.c b/cache-tree.c
> index 0bbec43..21a13cf 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -121,11 +121,11 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
>  
>  	if (!it)
>  		return;
> -	slash = strchr(path, '/');
> +	slash = strchrnul(path, '/');
>  	it->entry_count = -1;
> -	if (!slash) {
> +	if (*slash == '\0') {

Let's just say

	if (!*slash)

instead; it is more idiomatic (I won't repeat this for other hunks).

>  		int pos;
> -		namelen = strlen(path);
> +		namelen = slash - path;

After this "if (!*slash)", we compute "namelen = slash-path".
Perhaps we can lose this assignment and the other one by hoisting it
up before "if (!*slash)"?

> @@ -564,10 +562,10 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
> +		if (*slash == '\0' || !*slash)

Huh?  "The byte pointed at by 'slash' is NUL, or it is NUL"???

Other than that, looks good to me.

Thanks.
