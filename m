From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/48] merge-recursive: Remember to free generated unique
 path names
Date: Mon, 18 Jul 2011 16:39:00 -0700
Message-ID: <7voc0rcg6j.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-20-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixP3-00033c-36
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab1GRXjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:39:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483Ab1GRXjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4646C41CB;
	Mon, 18 Jul 2011 19:39:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eYGcyPWdVhO9RBI/ZbQQcYh9YMU=; b=TteGaTgHjZU7Cz6pKGvD
	flsX/zVvvzGb9NDHdn54Qmu6OzCrADW2IYx0BUamLIFv0DA+jWgZrQav67LrDCSR
	Gr29F9RKcz+2VAceQdY6VAUo+y/Rem8skAD7qkgrqrK2lbt4QWoKIBq9i/rUcUEU
	f9zE8yhyQprS+lE/whRjAXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=akV8KQ3POyR3XjF89Kp/JNtydA9u3TauQMZ9y0i9TXWe/v
	aipelFL6PkGyx97TVsjuywc/i5sdqMleF6LQmHShsP5hZtYGF5v2xg0RVO+binsr
	hMaCaiTqs3ZOzb0yaPVNgsUJ1BBusfUwFxF0xmae7psdpw6QptW9KT8A21k88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31AE641CA;
	Mon, 18 Jul 2011 19:39:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9EC041C9; Mon, 18 Jul 2011
 19:39:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DB561D2-B197-11E0-8A05-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177420>

Elijah Newren <newren@gmail.com> writes:

> @@ -1433,12 +1434,17 @@ static int process_df_entry(struct merge_options *o,
>  		}
>  	} else if (o_sha && (!a_sha || !b_sha)) {
>  		/* Modify/delete; deleted side may have put a directory in the way */
> -		const char *new_path = path;
> -		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode))
> +		char *new_path;
> +		int free_me = 0;
> +		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
>  			new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
> +			free_me = 1;
> +		}
>  		clean_merge = 0;
> -		handle_delete_modify(o, path, new_path,
> +		handle_delete_modify(o, path, free_me ? new_path : path,
>  				     a_sha, a_mode, b_sha, b_mode);

Here free_me is not about free_me but is used as a substitute for "did I
stuff the path to be used in new_path, or should I use the original path?",
and I find the variable misnamed.  How about doing it this way instead?

	char *renamed = NULL;
        if (lstat(path, &st) ...)
        	renamed = unique_path(...);
	clean_merge = 0;
	handle_delete_modify(o, path, renamed ? renamed : path, ...);

> +		if (free_me)
> +			free(new_path);

and then you can free renamed unconditoinally here.

Other than that looks good to me.

Thanks.
