From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu, 05 Nov 2015 10:45:11 -0800
Message-ID: <xmqqpozo5lqg.fsf@gitster.mtv.corp.google.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
	<1446747439-30349-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, tboegi@web.de,
	j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 19:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuPXG-0004gy-FL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbbKESpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:45:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbbKESpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:45:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90E57270BF;
	Thu,  5 Nov 2015 13:45:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FU+YdsbokZyjCYnVZHpt1hdHntU=; b=iMUoth
	1AvBRWG/IFB9TymvqEP0K9Da6vhPmNUHeZyca1PF7m5Vvu6QCTbM5kiQr1fCy1YV
	bt+R7FgAyj09rdECuxYuS7DJkrQ4QSX9ZfshMNb/7QzxfGYXn7XFGa7eLxJ5P6yk
	7vNGawZw10FC8LKNPZs1Hs79xmbsZoqACIssU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cr3a/G+KaFzfNIIOkJhnlZ2lfRwbeJ7q
	juWvUpTsI5qI5wi+zFhm1H9eeMloZ+WKKZjLIhL0rck+4ez3jQ1uKRgfFe+tuwgU
	dqCAGvNiRKpAbidFCW5wK1zGCufcfldOJt0hCPTCyIdPu5B395jS3MRUSS6PmMVk
	kH+uB4SYK98=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85E7C270BE;
	Thu,  5 Nov 2015 13:45:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E30F1270BC;
	Thu,  5 Nov 2015 13:45:12 -0500 (EST)
In-Reply-To: <1446747439-30349-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 5 Nov 2015 10:17:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 591B3E72-83ED-11E5-BB7A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280934>

Stefan Beller <sbeller@google.com> writes:

> strbuf_read_once can also operate on blocking file descriptors if we are
> sure they are ready. The poll (2) command however makes sure this is the
> case.
>
> Reading the manual for poll (2), there may be spurious returns indicating
> readiness but that is for network sockets only. Pipes should be unaffected.

Given the presence of "for example" in that bug section, I wouldn't
say "only" or "should be unaffected".

> By having this patch, we rely on the correctness of poll to return
> only pipes ready to read.

We rely on two things.  One is for poll to return only pipes that are 
non-empty.  The other is for read from a non-empty pipe not to block.

>
> This fixes compilation in Windows.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks.  Let's apply these fixes on sb/submodule-parallel-fetch,
merge the result to 'next' and have people play with it.

>  run-command.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 0a3c24e..51d078c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1006,17 +1006,6 @@ static void pp_cleanup(struct parallel_processes *pp)
>  	sigchain_pop_common();
>  }
>  
> -static void set_nonblocking(int fd)
> -{
> -	int flags = fcntl(fd, F_GETFL);
> -	if (flags < 0)
> -		warning("Could not get file status flags, "
> -			"output will be degraded");
> -	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
> -		warning("Could not set file status flags, "
> -			"output will be degraded");
> -}
> -
>  /* returns
>   *  0 if a new task was started.
>   *  1 if no new jobs was started (get_next_task ran out of work, non critical
> @@ -1052,8 +1041,6 @@ static int pp_start_one(struct parallel_processes *pp)
>  		return code ? -1 : 1;
>  	}
>  
> -	set_nonblocking(pp->children[i].process.err);
> -
>  	pp->nr_processes++;
>  	pp->children[i].in_use = 1;
>  	pp->pfd[i].fd = pp->children[i].process.err;
