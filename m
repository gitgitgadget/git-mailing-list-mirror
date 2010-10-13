From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 11/15] daemon: report connection from root-process
Date: Wed, 13 Oct 2010 15:55:12 -0700
Message-ID: <7vlj61hfe7.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-12-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6AES-0007cm-AE
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab0JMWz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:55:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0JMWz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:55:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2025DE26C;
	Wed, 13 Oct 2010 18:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LxKLlX+DEPnok1P8+QSHUkgsywk=; b=Jmi9kC
	Nj3qD0pKib076dr8Bk3YLnbjUavPFNW70U3yok4BgGV/Uss2X7kM4YvN6wWN+NLl
	JAZ0CWUJzZSCJ+4QlSaHuoTwnrjonvbybkOS9d7h/8YKu4i8AavJyzUBgeg8BnUE
	7k1tRXoV9MuTHiM/p25kwmMlFj2kHzrFZnsaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pj3+FIrkryjy2BmXpfcekl4uVrdh9Uyg
	o1i5vm1kG6lGXuCbdbyhuW6yxDNZ4uqQCqJliWQqCwuKpT1UfkSJ8/l3kF0ifJ10
	CxvMYCYDNxLdXYf106/o4PQwT6F3ZiVMbS+ZLVcu3TLxxZ1KKrqNsjR8kjYvk0Eu
	7F6mTrln3Kw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A4A2DE268;
	Wed, 13 Oct 2010 18:55:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51EE1DE267; Wed, 13 Oct
 2010 18:55:14 -0400 (EDT)
In-Reply-To: <1286833829-5116-12-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon\, 11 Oct 2010 23\:50\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F50BB01A-D71C-11DF-A3C6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159001>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Report incoming connections from the process that
> accept() the connection instead of the handling
> process.
>
> This enables "Connection from"-reporting on
> Windows, where getpeername(0, ...) consistently
> fails.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  daemon.c |   72 ++++++++++++++++++++++++++++++-------------------------------
>  1 files changed, 35 insertions(+), 37 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 8a44fb9..1574f75 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -516,38 +516,11 @@ static void parse_host_arg(char *extra_args, int buflen)
>  }
>  
>  
> -static int execute(struct sockaddr *addr)
> +static int execute(void)
>  {
> -...
> -		}
> -		loginfo("Connection from %s:%d", addrbuf, port);
> -		setenv("REMOTE_ADDR", addrbuf, 1);
> ...
> +	else {
> +		loginfo("[%"PRIuMAX"] Connection from %s:%d",
> +		    (uintmax_t)cld.pid, addrstr, port);
>  		add_child(&cld, addr, addrlen);

Hmm, loginfo() calls logreport() and adds the process information as
necessary to the output.  Wouldn't this patch give the pid information
twice?
