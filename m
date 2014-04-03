From: Junio C Hamano <gitster@pobox.com>
Subject: Re: socket_perror() "bug"?
Date: Thu, 03 Apr 2014 12:01:32 -0700
Message-ID: <xmqq1txeqltf.fsf@gitster.dls.corp.google.com>
References: <CACnwZYc2py4dxehg2=gnnPLxwJaRqXYTLQvC1O7YuoqAWsZ0Tg@mail.gmail.com>
	<xmqqy4zq3xek.fsf@gitster.dls.corp.google.com>
	<CACnwZYf30KLVLkaB4mNrW12DHwrf=RT7H-DBNvQYs0y6RqVGLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 21:01:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVmtW-0000tz-H4
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 21:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbaDCTBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 15:01:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbaDCTBf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 15:01:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F5E179465;
	Thu,  3 Apr 2014 15:01:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HgBJd5x3ZLtHR65mzHlrgicjw1E=; b=cNO5Xj
	+fmoXC0q+ZU5I00fr1ZPrZsLkQpEBdktOADNOu8qV4AIsi7ppubCd2XrQxZJp/8o
	sch7BGpJyACjECnO9jOYTTxkn+FbvNoUk0cOi/tjGMDS5PJj3aJaoyEH160rXApE
	v/VR0Sfi2BjFJTSFqLGfQ3U0idiKCB4oK0JOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pIRq/jzi+tIg9no5PVOMAIz/Z8pMNHWA
	g6P5USJoJ/eyEEtEVLsmvkpezkHQFWgBJAac+zqFQoDSIgcl1ErDyUWZM9UeTqJb
	zF29d9hX/enxAKXw1/v4J+nRp2QE0ue3aowlDEZxbVn1JtZZVEMpd4GUY2xiqD/U
	tpYLGp5TbPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E87379464;
	Thu,  3 Apr 2014 15:01:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5802D79460;
	Thu,  3 Apr 2014 15:01:34 -0400 (EDT)
In-Reply-To: <CACnwZYf30KLVLkaB4mNrW12DHwrf=RT7H-DBNvQYs0y6RqVGLw@mail.gmail.com>
	(Thiago Farina's message of "Wed, 2 Apr 2014 20:05:01 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6009F336-BB62-11E3-8D30-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245750>

Thiago Farina <tfransosi@gmail.com> writes:

> On Mon, Mar 31, 2014 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thiago Farina <tfransosi@gmail.com> writes:
>>
>>> In imap-send.c:socket_perror() we pass |func| as a parameter, which I
>>> think it is the name of the function that "called" socket_perror, or
>>> the name of the function which generated an error.
>>>
>>> But at line 184 and 187 it always assume it was SSL_connect.
>>>
>>> Should we instead call perror() and ssl_socket_error() with func?
>>
>> Looks that way to me, at least from a cursory look.
> Would you accept such a patch?

This back-and-forth makes me wonder what is going on.  Why not send
a full patch with a proper proposed commit log message to the list
and see what happens?

> diff --git a/imap-send.c b/imap-send.c
> index 0bc6f7f..bb04768 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -181,10 +181,10 @@ static void socket_perror(const char *func,
> struct imap_socket *sock, int ret)
>                 case SSL_ERROR_NONE:
>                         break;
>                 case SSL_ERROR_SYSCALL:
> -                       perror("SSL_connect");
> +                       perror(func);
>                         break;
>                 default:
> -                       ssl_socket_perror("SSL_connect");
> +                       ssl_socket_perror(func);
>                         break;
>                 }
>         } else
>
> --
> Thiago Farina
