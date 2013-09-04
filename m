From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 06/11] replace: bypass the type check if -f option is used
Date: Wed, 04 Sep 2013 13:44:26 -0700
Message-ID: <xmqq4na0mi51.fsf@gitster.dls.corp.google.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.76437.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJwM-0006XO-MF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab3IDUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:44:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab3IDUod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:44:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0A793E731;
	Wed,  4 Sep 2013 20:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3lkr0bZgItuDYPag2kIxiVjXnM=; b=IIBEQf
	YvrvZYtDxsLvzBs9HQGbuE6Y/eZYBquTlBtuYSQfBoLLlQg9ZEsJOzIC4Ak5bkNG
	vWVI2mimkeB1bBiKJABysE5U7Cou/aP3SJt7ST4HRJtxtZMXT3hPUZ9/tAy97KcI
	UM/qJECa4bm39ZogefKBVxLB0oHCWZd2L3k6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Se1pXnY4qtT0STfHqNUy/CXkSLXf4c2s
	Go9Hyrk07mRZtiBBb8Cmu26TnGTPhq61dxW43phxLJgiFbHZs5GnqfV9xaOZ/mTY
	Gwcv8TM83GFZfyHILv6Cw28DRvp8C+8Rr5j670iI69rjK2ZwMkHPCKt9Kt2SzUQF
	ZbGp2CV/S5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 883A73E72C;
	Wed,  4 Sep 2013 20:44:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1BA83E714;
	Wed,  4 Sep 2013 20:44:29 +0000 (UTC)
In-Reply-To: <20130903071026.29838.76437.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 03 Sep 2013 09:10:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC1E46A0-15A2-11E3-9430-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233872>

Christian Couder <chriscool@tuxfamily.org> writes:

> If -f option, which means '--force', is used, we can allow an object
> to be replaced with one of a different type, as the user should know
> what (s)he is doing.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

This does not matter in a larger picture, but between 1/11 and this
patch, there is a window where an operation that has been useful in
some workflows becomes unavailable to the user.

For future reference, it would be better to do this as a part of
1/11, to make sure that there always is an escape hatch available to
the users.

>  builtin/replace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 9a94769..95736d9 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -103,7 +103,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  
>  	obj_type = sha1_object_info(object, NULL);
>  	repl_type = sha1_object_info(repl, NULL);
> -	if (obj_type != repl_type)
> +	if (!force && obj_type != repl_type)
>  		die("Objects must be of the same type.\n"
>  		    "'%s' points to a replaced object of type '%s'\n"
>  		    "while '%s' points to a replacement object of type '%s'.",
