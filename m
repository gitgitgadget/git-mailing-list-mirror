From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] revision.c: Make --full-history consider more merges
Date: Mon, 06 May 2013 13:45:26 -0700
Message-ID: <7vtxmfq1ll.fsf@alter.siamese.dyndns.org>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
	<1367767977-14513-6-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 06 22:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZSI2-00028P-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 22:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab3EFUph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 16:45:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab3EFUpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 16:45:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CC3C1CB1B;
	Mon,  6 May 2013 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CZ4OaB0M5KnMHSkpn+fCsuZ8yKg=; b=O+vtup
	0uu0yBNxafaF61l4h5KSZ1XS8T+nok6qUheO20OGsm7dwfQjw8VrtgVW1WqmP9B5
	d23AB0eZhl8xi8sc1b4TjXovEZBQngQpS+u79uusDjaNBNpB66piN+w4uO3C7xBJ
	tR7scETvl6nuGtwfuz9V/+OiUklli0bkkmWVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b/F0wIsuuY6kzlf0toIf4QorjE4B24Aw
	AyMKwq3QsKUDiuNeHfSHXQoVBemGA7vvxgOIrkXtcqYV//9xwRK8JKOo0SoZpTme
	Gb3GyWvF5RBZOQNR5PFO4LBNbfb8Mldbd06N5QQXcdMCFlCSSi8fUasys7XLs71O
	lB+1itlAog0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C521CB1A;
	Mon,  6 May 2013 20:45:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBD2E1CB12;
	Mon,  6 May 2013 20:45:34 +0000 (UTC)
In-Reply-To: <1367767977-14513-6-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Sun, 5 May 2013 18:32:53 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6817752-B68D-11E2-B49A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223503>

Kevin Bracey <kevin@bracey.fi> writes:

> diff --git a/revision.c b/revision.c
> index a67b615..c88ded8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -429,10 +429,100 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
>  	return retval >= 0 && (tree_difference == REV_TREE_SAME);
>  }
>  
> +struct treesame_state {
> +	unsigned int nparents;
> +	unsigned char treesame[FLEX_ARRAY];
> +};

I have been wondering if we want to do one-bit (not one-byte) per
parent but no biggie ;-)

> @@ -1971,6 +2083,70 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
>  	return st;
>  }
>  
> +static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
> +{
> +...
> +		po=po->next;

	po = po->next;

> +	}

This seems to be identical (modulo tests) from the previous round,
which I found a reasonable thing to do.
