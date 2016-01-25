From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 09/11] config: add core.untrackedCache
Date: Mon, 25 Jan 2016 12:47:03 -0800
Message-ID: <xmqqio2hfku0.fsf@gitster.mtv.corp.google.com>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
	<1453649304-18121-10-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:47:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNo2e-00046h-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 21:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934093AbcAYUrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 15:47:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934085AbcAYUrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 15:47:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 816673F349;
	Mon, 25 Jan 2016 15:47:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DbV17awoihU1nTw1v7owmUbRNRg=; b=nfPyNs
	Yktlui+zSHAoZxULLmVEECaAU8G8pOcoGBqOsLoeKsmmqR4SzGTNJeqSleVkqwvf
	FhG4uO9rMk2RTWbIvQ9xJ8p6lyt6zddyKaXgyYYPnL4wKuHZ8TE/jBXT8TKvNZ2J
	+WKRNXgRUX/wYZ4oreByt91FvNalPn9Z33Xv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LiLUnI6f75UYz2liC4n5qXkQTftT9qvz
	1Pa5nbRxs8alyC+9q/a9xyZU4rHmiSQujgH93c0TWo2aGI4FRmkmSWdkUAvbcf8n
	HI3DPBxMOTGe+zaqJ8qPXmSivyAreNzY/JEkQBqbm7vihXSCziwWx39EQjL5X1Mm
	glqdBJJJ5dI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 777BC3F348;
	Mon, 25 Jan 2016 15:47:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D31793F345;
	Mon, 25 Jan 2016 15:47:04 -0500 (EST)
In-Reply-To: <1453649304-18121-10-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Jan 2016 16:28:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAD26FF8-C3A4-11E5-B5E7-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284756>

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 5be7cd1..a04ec8c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1497,10 +1497,23 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>  	return ce;
>  }
>  
> -static void check_ce_order(struct index_state *istate)
> +static void post_read_index_from(struct index_state *istate)
>  {
>  	unsigned int i;
>  
> +	switch (git_config_get_untracked_cache()) {
> +	case -1: /* keep: do nothing */
> +		break;
> +	case 0: /* false */
> +		remove_untracked_cache(istate);
> +		break;
> +	case 1: /* true */
> +		add_untracked_cache(istate);
> +		break;
> +	default: /* unknown value: do nothing */
> +		break;
> +	}
> +
>  	for (i = 1; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i - 1];
>  		struct cache_entry *next_ce = istate->cache[i];

Bad manners.

 * The new code added to an existing function, unless there is a
   good reason, goes to the bottom.  In this case, the verification
   of the ordering of cache entries and tweaking of UC extension are
   two unrelated things that can be independently done, and there is
   no justification why the new code has to come to top.

 * The old function name served as a good documentation of what it
   does.  That is no longer the case.  Each unrelated segment of
   this new function needs to be commented.  Even better, perhaps
   leave the original check_ce_order() as-is, introduce a new
   function tweak_uc_extension(), and make the post_read_index()
   to be just two-liner function:

	static void post_read_index(struct index_state *istate)
        {
        	check_ce_order(istate);
                tweak_uc_extension(istate);
	}

   That way the documentation value of each function that does one
   specific thing and named specific to its task will be kept, and
   there is no need for extra comments.
