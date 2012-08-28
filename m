From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] (BROKEN) get_merge_bases_many(): walk from many tips
 in parallel
Date: Mon, 27 Aug 2012 18:25:02 -0700
Message-ID: <7vipc3q041.fsf@alter.siamese.dyndns.org>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
 <1346109123-12357-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 03:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6AZ7-0004pL-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 03:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab2H1BZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 21:25:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2H1BZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 21:25:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8885C9346;
	Mon, 27 Aug 2012 21:25:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UH/1UVMGXK/2g7hFMZPYtImJ8XM=; b=U1raCk
	ZHE1nnvMvesXb8dJEJYZ+ac2nD7f6F2fzAfSdAH55eqmzmE7sNCp9K3cOM6acn1G
	5Cxfcb6PLzSz1zPQpTO7/Sylf7Z1uLtqPJN+sLol3qms8cFicCODDh1VB8n1rxOB
	aQjcM5vTC9hwH1pyT+NaKlTRpcGyT53pgAnuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uk8CBcHjvkyopILyLdaohCxZl8NG5SPW
	bJ43TWrmrtvUPHVnIEUM9eyaystKkbJiIHAs/SiUN3d9GhUatGBKoJA+fntJ5uLC
	dgGOM4X3nkvA0JvjYADiqqIvxgoWGSKIrCW45YYrI7x/Jf8uSYb+qu8tg42vtOez
	ySTf0obz3NU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 765DA9345;
	Mon, 27 Aug 2012 21:25:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE7FB9344; Mon, 27 Aug 2012
 21:25:03 -0400 (EDT)
In-Reply-To: <1346109123-12357-6-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Mon, 27 Aug 2012 16:12:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 318E83CA-F0AF-11E1-8053-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204394>

Junio C Hamano <gitster@pobox.com> writes:

>  	for (i = 0; i < cnt; i++) {
> -		if (rslt[i])
> +		/*
> +		 * Is rslt[i] an ancestor of any of the others?
> +		 * then it is not interesting to us.
> +		 */
> +		for (j = 0; j < i; j++)
> +			others[j] = rslt[j];
> +		for (j = 1 + 1; j < cnt; j++)

s/1 + 1/i + 1/;

With that, all tests seem to pass ;-)

> +			others[j - 1] = rslt[j];
> +		list = merge_bases_many(rslt[i], cnt - 1, others);
> +		clear_commit_marks(rslt[i], all_flags);
> +		for (j = 0; j < cnt - 1; j++)
> +			clear_commit_marks(others[j], all_flags);
> +		while (list) {
> +			if (rslt[i] == list->item)
> +				break;
> +			list = list->next;
> +		}
> +		if (!list)
>  			commit_list_insert_by_date(rslt[i], &result);
> +		free_commit_list(list);
>  	}
>  	free(rslt);
> +	free(others);
>  	return result;
>  }
