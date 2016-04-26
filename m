From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/21] bisect: use a bottom-up traversal to find relevant weights
Date: Tue, 26 Apr 2016 11:27:23 -0700
Message-ID: <xmqqh9eogr90.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-20-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:27:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7hy-00054Y-80
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbcDZS13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:27:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753172AbcDZS11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:27:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6BA415C11;
	Tue, 26 Apr 2016 14:27:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AtSp6ai7aB5KXKYs6JDA4s/e8Uo=; b=r/MC4a
	b+GIG/5pdG80KlAa4XFI0n3O6f+JIey9Ksj2zjuBLaMSA0PEpTB+XTROYw7vDFo3
	AtwCdvaKrMXKz+vyVrfS4x46svTp2EUi5Fo8Qt0hC7HkGjs2/dNrAnr28721kekk
	MsnTNnjH9rlOxzjKUx/oOUK/kV+sH7Kuu9/IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3RIcchsmN3rVzxTmCtVKEO0a0NSxuFq
	5c1LDttHRnXcZbghY+e2nKizTT3MNtKsA+swoBFYv0Hr673dbjB3OSrZAFawdQUq
	fS/QWcUvYR3kPO48+e9Tn/hgBqX5MGQzPAmjuk/2jnlyWZ40z3RjMYcj+tSRNZiz
	fXbpNrmZMu8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD4F015C10;
	Tue, 26 Apr 2016 14:27:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30A1615C0F;
	Tue, 26 Apr 2016 14:27:25 -0400 (EDT)
In-Reply-To: <1460294354-7031-20-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 861D230A-0BDC-11E6-AF57-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292642>

Stephan Beyer <s-beyer@gmx.net> writes:

>  struct commit_list *find_bisection(struct commit_list *list,
> @@ -470,8 +541,11 @@ struct commit_list *find_bisection(struct commit_list *list,
>  		compute_all_weights(list, weights);
>  		best = best_bisection_sorted(list);
>  	} else {
> +		int i;
>  		compute_relevant_weights(list, weights);
>  		best = best_bisection(list);
> +		for (i = 0; i < on_list; i++) /* cleanup */
> +			free_commit_list(weights[i].children);
>  	}
>  	assert(best);
>  	*reaches = node_data(best->item)->weight;

One thing I forgot to mention is that we now may want to reconsider
what the first loop in this function does.  It used to be that the
purpose of the loop is to "count the number of total and
tree-changing items on the list while reversing the list" as the
comment says.  While it is still necessary to count the items (by
the way, with 16/21 you made these two numbers identical, i.e. there
no longer is a separate 'total' but your 'total' now actually means
the number of tree-changing items), I do not know if the "reverse"
would still be a good fit for the performance characteristic of the
new algorithm.

The list-reversal there was done as an optimization to make sure
that older ones are processed early to avoid looping too much just
to follow the list to find a single-parent commit whose parent's
weight is already known, as the only meaningful optimization in the
original algorithm was the "we can increment one without doing the
costly graph re-traversal for single-strand-of-pearls".  That
optimization may no longer relevant (or it could even be harmful)
as you traverse the graph in reverse.
