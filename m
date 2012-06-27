From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 01/10] git p4 test: wait longer for p4d to start and
 test its pid
Date: Wed, 27 Jun 2012 14:16:42 -0700
Message-ID: <7vfw9g78w5.fsf@alter.siamese.dyndns.org>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
 <1340798463-14499-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzbV-0004kz-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab2F0VQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:16:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab2F0VQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:16:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83CC99D37;
	Wed, 27 Jun 2012 17:16:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H4IGJhtsm9eyir/A+pwH51X9P3g=; b=ca9Pzs
	JisShGvf17G/wPOeX5Q8RfkdHnu9Oo027JW44cu4NvywlDq3WApdHGRcpaD/JNYl
	iKkj3AAyfNQpgcO7NiQadMFVo9motaFXWu5sB2MbC4n7e94nyW7keUt+1I9jy8ty
	SANA/PuyLxfWgYq66kr9EQwIrJZOW9NOBe3Do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=liQmacG43csizRq0gkkSAQjTPjm1iZo9
	N/+PdfqOegYhVdsLozG9rxgRaJ25Xql4JDN0W9JvBGytmdA2A/utaYuYAj+jfJ1J
	5H/W9odgghiJaqhWq+uLdzvTwbBnXJDD1id90HDhnGzmXavrnOleCVNKFavKQk5V
	MCrPAcaMAb0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B45C9D36;
	Wed, 27 Jun 2012 17:16:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5E49D34; Wed, 27 Jun 2012
 17:16:43 -0400 (EDT)
In-Reply-To: <1340798463-14499-2-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Wed, 27 Jun 2012 08:00:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6539476A-C09D-11E1-AE00-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200756>

Pete Wyckoff <pw@padd.com> writes:

> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 121e380..2e3706a 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -33,14 +33,27 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"
>  
>  start_p4d() {
>  	mkdir -p "$db" "$cli" "$git" &&
> +	rm -f "$pidfile" &&
>  	(
>  		p4d -q -r "$db" -p $P4DPORT &
>  		echo $! >"$pidfile"
>  	) &&
> -	for i in 1 2 3 4 5 ; do
> +	# This gives p4d a long time to start up, as it can be
> +	# quite slow depending on the machine.  Set this environment
> +	# variable to something smaller to fail faster in, say,
> +	# an automated test setup.
> +	i=${P4D_START_PATIENCE:-300} &&
> +	while [ $i -gt 0 ]; do

Don't write "test" as "[".

> +		# succeed when p4 client commands start to work
>  		p4 info >/dev/null 2>&1 && break || true &&

This is not a new problem but isn't it much clearer to write this as

		p4 info >/dev/null 2>&1 && break

without the fake && cascade that does not help anybody?

> +		# fail if pid goes away
> +		if [ -f "$pidfile" ] ; then
> +		    kill -0 $(cat "$pidfile") || break
> +		fi &&

I am not sure what you are trying to do here.  What happens if
$pidfile goes away?

In other words, I think it would make it much more clear to write
this part like this:

	pid=$(cat "$pidfile") ready=
        while test $i -gt 0
        do
		if p4 info >/dev/null 2>&1
                then
			ready=true
                        break
		fi
        	kill -0 $pid || break
		echo waiting for p4d to start
		sleep 1
		i=$(( $i - 1 ))
	done

        if test -z "$ready"
        then
		... p4d failed to start ...
		... clean up and kill the whole thing ...
	fi
