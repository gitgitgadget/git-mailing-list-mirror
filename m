From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] [submodule] Add --depth to submodule update/add
Date: Tue, 02 Jul 2013 12:01:09 -0700
Message-ID: <7v7gh8947e.fsf@alter.siamese.dyndns.org>
References: <1372729167-23200-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jens.lehmann@web.de, hvoigt@hvoigt.net, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 21:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5pH-0008Nb-2n
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab3GBTBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 15:01:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3GBTBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:01:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DFDE2B468;
	Tue,  2 Jul 2013 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hHFY6OKu/xbIA19wCy/K/vhS9oY=; b=dqatGt
	folk9+uEXcpCiLpCmEbFn5uWEpM5qGpmVkfOyj66isI4jD4ym4GM2Y+VEi641/d2
	6XL+OKTfIqe9cFTbtaKDf6vGrSZwZtkikGC/3uw1/+jXnxUHcWtdemD4OAYXyJ2z
	U8BoWWLVfboJrRApB2mOFs60casilCnpZvlh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FMtpGxpL4oOnnQ1H88hG562lrNFhOny2
	1xHey7x0XLcZwXSB9IwP1lXHX+w700Q8nQGi9OeafrDGiJlkMZjtbYD2sCdqrYMZ
	BBgPSYLCqNWkOjPXolzsfgKrYjUiXE8TS1LqcYSmL+b2KtKMqWrz8PVzRW2K142Q
	PiNVrJaVhyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B3A32B466;
	Tue,  2 Jul 2013 19:01:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC70F2B464;
	Tue,  2 Jul 2013 19:01:10 +0000 (UTC)
In-Reply-To: <1372729167-23200-1-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Tue, 2 Jul 2013 03:39:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2612172-E349-11E2-A839-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229417>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> git clone dies with the error "too many arguments". This was solved with changing
> depth=$5
> to
> depth="$5"
>
> which I don't understand since variable assignment doesn't expand $5 and therefore
> "" should not be needed, AFAIK. Any comments on this?

A red herring?

> @@ -211,6 +212,7 @@ module_clone()
>  	name=$2
>  	url=$3
>  	reference="$4"
> +	depth="$5"

If the caller gave you only 4 arguments, depth will become an empty
string with or without dq around $5 here.  And

> -			git clone $quiet -n ${reference:+"$reference"} \
> +			git clone $quiet $depth -n ${reference:+"$reference"} \
>  				--separate-git-dir "$gitdir" "$url" "$sm_path"

... you use $depth without dq around it, so when $depth is empty
string, "git clone" will not see it at all (not even an empty string
as one of its arguments).

Which is probably fine, as long as the caller makes sure it will not
call this function as

	module_clone 1 2 3 4 "depth argument as multi-word"

which will be split at $IFS.

If you know $depth must be passed as a single argument (or no
argument when the caller did not give you any) to the underlying
"git clone", you can write it like so:

		...
		depth=$5
		...

		git clone $quiet ${depth:+"$depth"} -n ...
