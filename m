From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Sat, 08 Sep 2012 11:59:49 -0700
Message-ID: <7v1uicuyqi.fsf@alter.siamese.dyndns.org>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
 <1347124173-14460-2-git-send-email-jengelh@inai.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:00:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQG8-0006te-NB
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2IHS7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 14:59:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab2IHS7w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 14:59:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55E3B728A;
	Sat,  8 Sep 2012 14:59:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rJ1S/KyBtMKIceRC1ZCPHTYUKIk=; b=b+AhNn
	9piXGNr30BrbEgeCyrjMxWqzDQJRlFtjjwktXcBPYkMy6aB4lYLfZDVW7701OLkt
	Qns1XIX2zQ6cbGKmamVwtnywHEozuzppcbAC2DMQYvRjgGn9NDcKim2qo9gtlM6x
	CHkTOP+20auXkxKuxERVzGgje14euoBM1cy3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qlSk7nBrlXxJDdJAeFDP0XPoU5/94Az5
	cia7t8Qm5exIjopqr8Hn8yO/AT7G3Td4y9ZTAfpjEy+lYH99GAxXS8rh7E0EPFOq
	7pWBYUv+xPNpzJJ/FVSRFfjCb3U7fOMVh86HceHEyGRsuDgNcMQuxl9zIotm+DRC
	YVg/55vmhro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 433E87289;
	Sat,  8 Sep 2012 14:59:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B2FA7288; Sat,  8 Sep 2012
 14:59:51 -0400 (EDT)
In-Reply-To: <1347124173-14460-2-git-send-email-jengelh@inai.de> (Jan
 Engelhardt's message of "Sat, 8 Sep 2012 19:09:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E71F53E-F9E7-11E1-85B7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205026>

Jan Engelhardt <jengelh@inai.de> writes:

> This reverts f9c87be6b42dd0f8b31a4bb8c6a44326879fdd1a, in a sense,
> because that commit broke logging of "Connection from ..." when
> git-daemon is run under xinetd.
>
> This patch here computes the text representation of the peer and then
> copies that to environment variables such that the code in execute()
> and subfunctions can stay as-is.
>
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  daemon.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 4602b46..eaf08c2 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1,3 +1,4 @@
> +#include <stdbool.h>
>  #include "cache.h"
>  #include "pkt-line.h"
>  #include "exec_cmd.h"

Platform agnostic parts of the code that use "git-compat-util.h"
(users of "cache.h" are indirectly users of it) are not allowed to
do platform specific include like this at their beginning.

This is the first use of stdbool.h; what do you need it for?

> @@ -1164,6 +1165,54 @@ static int serve(struct string_list *listen_addr, int listen_port,
>  	return service_loop(&socklist);
>  }
>  
> +static void inetd_mode_prepare(void)
> +{
> +	struct sockaddr_storage ss;
> +	struct sockaddr *addr = (void *)&ss;
> +	socklen_t slen = sizeof(ss);
> +	char addrbuf[256], portbuf[6] = "";
> +
> +	if (!freopen("/dev/null", "w", stderr))
> +		die_errno("failed to redirect stderr to /dev/null");
> +
> +	/*
> +	 * Windows is said to not be able to handle this, so we will simply
> +	 * ignore failure here. (It only affects a log message anyway.)
> +	 */
> +	if (getpeername(0, addr, &slen) < 0)
> +		return;
> +
> +	if (addr->sa_family == AF_INET) {
> +		const struct sockaddr_in *sin_addr = (void *)addr;
> +
> +		if (inet_ntop(addr->sa_family, &sin_addr->sin_addr,
> +			      addrbuf, sizeof(addrbuf)) == NULL)
> +			return;
> +		snprintf(portbuf, sizeof(portbuf), "%hu",
> +			 ntohs(sin_addr->sin_port));
> +#ifndef NO_IPV6
> +	} else if (addr->sa_family == AF_INET6) {
> +		const struct sockaddr_in6 *sin6_addr = (void *)addr;
> +
> +		addrbuf[0] = '[';
> +		addrbuf[1] = '\0';
> +		if (inet_ntop(AF_INET6, &sin6_addr->sin6_addr, addrbuf + 1,
> +			      sizeof(addrbuf) - 2) == NULL)
> +			return;
> +		strcat(addrbuf, "]");
> +
> +		snprintf(portbuf, sizeof(portbuf), "%hu",
> +			 ntohs(sin6_addr->sin6_port));
> +#endif
> +	} else {
> +		snprintf(addrbuf, sizeof(addrbuf), "<AF %d>",
> +			 addr->sa_family);
> +	}
> +	if (setenv("REMOTE_ADDR", addrbuf, true) < 0)
> +		return;
> +	setenv("REMOTE_PORT", portbuf, true);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int listen_port = 0;
> @@ -1341,10 +1390,8 @@ int main(int argc, char **argv)
>  		die("base-path '%s' does not exist or is not a directory",
>  		    base_path);
>  
> -	if (inetd_mode) {
> -		if (!freopen("/dev/null", "w", stderr))
> -			die_errno("failed to redirect stderr to /dev/null");
> -	}
> +	if (inetd_mode)
> +		inetd_mode_prepare();
>  
>  	if (inetd_mode || serve_mode)
>  		return execute();
