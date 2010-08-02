From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: ensure sent messages are not empty
Date: Mon, 02 Aug 2010 15:00:35 -0700
Message-ID: <7vk4o8k73w.fsf@alter.siamese.dyndns.org>
References: <1280780927-29006-1-git-send-email-kpfleming@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kevin P. Fleming" <kpfleming@digium.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og33x-0003T7-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab0HBWAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 18:00:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab0HBWAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:00:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CFABC9322;
	Mon,  2 Aug 2010 18:00:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6yc9NncUvWWLPqg4qY8DDmYqk2M=; b=m4IN5g
	Sqj/Peb9NaJp1UyKtw3MBg9pwCnQmvJNHdCqfDRbTDBS6PuvvO67oYy6SCNmcRXo
	fnmTsXkTnxj6aqRHupFjsntQ5l+4ao6NBWbe9XSQHXyKnjd6C9yTUe72jPD8ucFm
	56QlmyOdfRYLnuRs/pTGIKMuhOD18IIDxC/uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aAz3pKT5SLYPJOAGZ/jUHGTNq3PLEyBp
	34i2iiV3DXO1WphZST6qkwrd7KO6GZOwGHQeJNDPiukioOO8TrIHiNQuk9RoQGtE
	ATRi0zGi6zC/AHp9J4PA10wmka7oHQNUlm+7vKOcCqTbGwxOfjQLhHovB+VwWJ83
	o23tHvG9c4E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6CCC9321;
	Mon,  2 Aug 2010 18:00:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B071C931F; Mon,  2 Aug
 2010 18:00:37 -0400 (EDT)
In-Reply-To: <1280780927-29006-1-git-send-email-kpfleming@digium.com> (Kevin
 P. Fleming's message of "Mon\,  2 Aug 2010 15\:28\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 635C0576-9E81-11DF-AC33-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152468>

"Kevin P. Fleming" <kpfleming@digium.com> writes:

> @@ -687,10 +699,12 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>  	# Output to the terminal in command line mode - if someone wanted to
>  	# resend an email; they could redirect the output to sendmail
>  	# themselves
> -	PAGER= generate_email $2 $3 $1
> +	prep_for_email $2 $3 $1
> +	PAGER= generate_email
>  else
>  	while read oldrev newrev refname
>  	do
> -		generate_email $oldrev $newrev $refname | send_mail
> +		prep_for_email $oldrev $newrev $refname
> +		generate_email | send_mail
>  	done

As "prep" exits, when this is run as a hook to read many updated refs, any
inappropriate update to one ref will cause messages for later refs from
getting sent out.  Earlier such an update may have sent an empty message
but at least didn't break messages for other refs, if I am reading the
code correctly.  Is that what you really want?

Perhaps you would want to do something like this instead, after adjusting
the exit code from the new "prep" shell function?

	while ...
        do
        	prep_for_email || continue
                generate_email | send_mail
	done
