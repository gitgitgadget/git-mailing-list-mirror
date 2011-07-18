From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/48] merge-recursive: Fix sorting order and directory
 change assumptions
Date: Mon, 18 Jul 2011 16:39:11 -0700
Message-ID: <7vhb6jcg68.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-23-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixPD-00036b-9r
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab1GRXjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:39:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab1GRXjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741A441D0;
	Mon, 18 Jul 2011 19:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=XqyaK2VA5rYUQqCIGZl1FSc8yaY=; b=dU3PeSiINAiof0RaHk0o
	dWxHr/GGKmX1dW8KQoSoh7lUwN6QtdoB4xGC2S60r4KPSS2ui+WPkmNSJNZLHv2m
	Ic1tfzyBHBvrbErYGXXXttLsAzauIfWTNthyma3PSTAw8Vm+uqmB9r6G7l3vflQP
	rFkVHZ8o/ruD1YmKXZw0vww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Qz8UkzqGpLkqa8yInWgrTVt3cbDngA5MkcWyWczq71jVGN
	QdWfh4lGywNuzKJ/p/sRM0jTF/2GDZy3lzAmKfXJ9ITT+NTSaihDvQw1UzLS7yM8
	nbXyM/0UXYwrTQksLDBwDn1t3JPp+v6b1ffndyvfXcKRJ3PpTdqJrNPKZQWqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B77741CE;
	Mon, 18 Jul 2011 19:39:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F315E41CD; Mon, 18 Jul 2011
 19:39:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24677D94-B197-11E0-A788-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177421>

Elijah Newren <newren@gmail.com> writes:

> We cannot assume that directory/file conflicts will appear in sorted
> order; for example, 'letters.txt' comes between 'letters' and
> 'letters/file'.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c   |   31 ++++++++++++++++++++++++++-----
>  t/t6020-merge-df.sh |   26 ++++++++++++++++++--------
>  2 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 4771fb4..ed1fdb2 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -333,6 +333,28 @@ static struct string_list *get_unmerged(void)
>  	return unmerged;
>  }
>  
> +static int string_list_df_name_compare(const void *a, const void *b)
> +{
> +	const struct string_list_item *one = a;
> +	const struct string_list_item *two = b;
> +	/*
> +	 * Here we only care that entries for D/F conflicts are
> +	 * adjacent, in particular with the file of the D/F conflict
> +	 * appearing before files below the corresponding directory.
> +	 * The order of the rest of the list is irrelevant for us.
> +	 *
> +	 * To achieve this, we sort with df_name_compare and provide
> +	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
> +	 * We use the mode S_IFDIR for everything else for simplicity,
> +	 * since in other cases any changes in their order due to
> +	 * sorting cause no problems for us.
> +	 */

I recall there was an issue of this sorting reported earlier...

> diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
> index eec8f4e..27c3d73 100755
> --- a/t/t6020-merge-df.sh
> +++ b/t/t6020-merge-df.sh
> @@ -59,15 +59,19 @@ test_expect_success 'setup modify/delete + directory/file conflict' '
>  	git add letters &&
>  	git commit -m initial &&
>  
> +	# Throw in letters.txt for sorting order fun
> +	# ("letters.txt" sorts between "letters" and "letters/file")
>  	echo i >>letters &&
> -	git add letters &&
> +	echo "version 2" >letters.txt &&
> +	git add letters letters.txt &&

Nice.
