From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: parse_host_and_port SIGSEGV if port is specified
Date: Sat, 20 Mar 2010 08:49:23 -0700
Message-ID: <7vk4t7kn7g.fsf@alter.siamese.dyndns.org>
References: <1269051838-25734-1-git-send-email-imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Imre Deak <imre.deak@gmail.com>
To: imre.deak@nokia.com
X-From: git-owner@vger.kernel.org Sat Mar 20 16:49:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt0vk-0004s6-Kq
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0CTPtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:49:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0CTPtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 11:49:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B69A2F61;
	Sat, 20 Mar 2010 11:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uPdh6xK0QCqO/mUP5iDk4B0oymE=; b=Af82EX
	jNBA3cGahbxrqxNVc84Lh6zH12xkg44ynbHrTLUDGeCZ5FIapeq2uVAAu7OAwxAL
	8OVFsISTN1mgfwHgXjNSBcjxWzChA/LTQ0D9Nd3oOBJHUVBxwceQayA9p7cClsBk
	43mgQSCH7rHUdp1D4gVunHvT913fOUVLD2xHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d0P35aGSEt7J0tzyiLMYPhd7MRYSKut2
	pCg9anMg7Kbf2kMrthU/lMRCzDi8A6bIfMolSNYQ/JtlZlrNa0dU78aBqBkIzbZw
	JyTCrjXax1k2oF0BhCkzro8ZyXjuuKCY6lWt/vgPZK5EXvB8stUE8v8Jnuv6qvkl
	dL9tg6SxBo8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED83EA2F5D;
	Sat, 20 Mar 2010 11:49:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26CA0A2F5B; Sat, 20 Mar
 2010 11:49:25 -0400 (EDT)
In-Reply-To: <1269051838-25734-1-git-send-email-imre.deak@nokia.com> (imre
 deak's message of "Sat\, 20 Mar 2010 04\:23\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B0BBE68-3438-11DF-BEBB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142719>

imre.deak@nokia.com writes:

> From: Imre Deak <imre.deak@gmail.com>
>
> This typo will lead to git-daemon dying any time the connect
> string includes a port after the host= attribute. This can lead
> for example to one of the following error messages on the client
> side when someone tries git clone git://...:<port>.
>
> When the daemon is running on localhost:
>   fatal: The remote end hung up unexpectedly
>
> or when the daemon is connected through an ssh tunnel:
>   fatal: protocol error: bad line length character: erro
>
> In the latter case 'erro' comes from the daemon's reply:
>   error: git-daemon died of signal 11
>
> Signed-off-by: Imre Deak <imre.deak@gmail.com>
> ---

I wonder why I have this feeling that I've seen this patch before...

Thanks.

>  daemon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 3769b6f..7d9e1c0 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -420,7 +420,7 @@ static void parse_host_and_port(char *hostport, char **host,
>  		*host = hostport;
>  		*port = strrchr(hostport, ':');
>  		if (*port) {
> -			*port = '\0';
> +			**port = '\0';
>  			++*port;
>  		}
>  	}
> -- 
> 1.7.0.2
