From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue, 04 Mar 2014 13:05:59 -0800
Message-ID: <xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:06:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKwXx-0003VD-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 22:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577AbaCDVGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 16:06:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755636AbaCDVGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 16:06:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6AC871ECF;
	Tue,  4 Mar 2014 16:06:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bYUKfTjnec6MCaX8AHqZ8id+Ph0=; b=mVagPB
	NJEq2rNSMN94pjytwYbvO71YyBWWsPPR0TqqnlPrrTx8asQSpAep4kKUmr/b+4b9
	h4KYo/fW2e/29vYma7rcn9KRskKduYHL+x0X0YYxtVIe048XZC7RwHUkb6hdhJOW
	BACIS1Syo1mQ5z2v6tRkqGmLQav2plG8fcaFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avLY3zn1vtIQSb1f6qzAEZanEuus11MS
	dnKwzNh76w9kha1OfUgF3zzkeNjnwB7osvNCQuxQxFSVoISs/GmS6xNDdFFlBnXg
	SG6SLNwB8WqfPKk8rRgWaG6qjI68y+dbIG0nZ0y4uGQJ4XD1WP4a3rme5tbVKEKT
	Chhb0beibV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F21B71ECD;
	Tue,  4 Mar 2014 16:06:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6868771EA5;
	Tue,  4 Mar 2014 16:06:01 -0500 (EST)
In-Reply-To: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 4 Mar 2014 09:31:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA5DD412-A3E0-11E3-A320-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243390>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>  	while (*path) {
> -		const char *slash;
>  		struct cache_tree_sub *sub;
> +		const char *slash = strchr(path, '/');
>  
> -		slash = strchr(path, '/');
>  		if (!slash)
>  			slash = path + strlen(path);

Isn't the above a strchrnul()?

Combining a freestanding decl with intializer assignment to lose one
line is sort of cheating on the line count, but replacing the three
lines with a single strchrnul() would be a real code reduction ;-)

> -		/* between path and slash is the name of the
> -		 * subtree to look for.
> +		/*
> +		 * Between path and slash is the name of the subtree
> +		 * to look for.
>  		 */
>  		sub = find_subtree(it, path, slash - path, 0);
>  		if (!sub)
>  			return NULL;
>  		it = sub->cache_tree;
> -		if (slash)
> -			while (*slash && *slash == '/')
> -				slash++;
> -		if (!slash || !*slash)
> -			return it; /* prefix ended with slashes */
>  		path = slash;
> +		while (*path == '/')
> +			path++;
>  	}
>  	return it;
>  }
