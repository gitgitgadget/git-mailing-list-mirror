From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Fri, 09 Sep 2011 15:54:08 -0700
Message-ID: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
References: <7vwrf6qh49.fsf@alter.siamese.dyndns.org>
 <1315558437-6295-1-git-send-email-zapped@mail.ru>
 <1315558437-6295-2-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Sat Sep 10 00:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R29xj-0006nI-0v
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 00:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336Ab1IIWyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 18:54:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759098Ab1IIWyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 18:54:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8490B55BD;
	Fri,  9 Sep 2011 18:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c30CrPyK6Yiz2YFdIZi7gCzATdI=; b=uACzCG
	TP1fRpOk6sL6yuwK6SE4Q+x/ggmVY8QGpL8WjQMQikKcmx71kwyj7eX5u2yvtCA1
	0A8kOVbDhLOFEuyKnxLN2PSLzojpOuFEjYsDvvoBscR4F8t5uX6oGtSrIeNkFFaI
	Tqf4BRXRDrodWvkyXkts/9LjTFskbiPopB4Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tiw/xWxk0SpLlCdHSJ5aKWrBvSq07ZOU
	1ByAb+B/CYfIe1VkHef1AZFKpOreExB4w8ECa8R1Le6a+ba0uj67RGg53ttcHbvX
	yVZcQE0D/+mH6H5oVaJyNnX3vV+uSfW7m1WAwkeSfFQzLmZNVGWnGOVyZzCyRhwu
	6qVD3gTPFUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C81455BC;
	Fri,  9 Sep 2011 18:54:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06C3755BB; Fri,  9 Sep 2011
 18:54:09 -0400 (EDT)
In-Reply-To: <1315558437-6295-2-git-send-email-zapped@mail.ru> (Alexey
 Shumkin's message of "Fri, 9 Sep 2011 12:53:56 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A134228C-DB36-11E0-BCCB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181128>

Alexey Shumkin <zapped@mail.ru> writes:

> The following two ought to give the same output to a terminal:
>
> 	$ git log --oneline --no-color
> 	$ git log --pretty=format:'%h %s'
>
> However, the former pays attention to i18n.logOutputEncoding
> configuration, while the latter does not when it format "%s". A log
> messages written in an encoding i18n.commitEncoding that differs
> from terminal encoding are shown corrupted with the latter even
> when i18n.logOutputEncoding and terminal encoding are the same.

You seem to have inherited bad grammar from some example; I wonder
where... ;-)

> @@ -19,8 +21,12 @@ add_file () {
>  		echo "$name" > "$name" &&
>  		git add "$name" &&
>  		test_tick &&
> -		git commit -m "Add $name"
> +		git config i18n.commitEncoding cp1251 &&
> +		echo "Add $name ($added $name)" \
> +			| iconv -f utf-8 -t cp1251 \
> +			| xargs -I{} git commit -m "{}"

Don't do this. Format it this way instead if you want to use multi-line:

	echo "..." |
        iconv ... |
        xargs ...

I also am not sure if -I{} in xargs is all that portable. Why isn't it
more like this, which would be far easier to read?

	msg_in_cp1251=$(echo "Add ..." | iconv ...) &&
        git commit -m "$msg_in_cp1251" &&
        ...

Also do not break the && chain.

>  	done >/dev/null
> +	git config --unset i18n.commitEncoding
>  	git rev-parse --verify HEAD | cut -c1-7
>  	cd "$owd"
>  }
