From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: encode signal death as a positive integer
Date: Sat, 05 Jan 2013 23:05:54 -0800
Message-ID: <7v38yepz8t.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
 <20130105140316.GA7272@sigill.intra.peff.net>
 <20130105144949.GA24479@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 08:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrkJM-0006D3-Pu
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 08:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004Ab3AFHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 02:05:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab3AFHF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 02:05:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D374E748A;
	Sun,  6 Jan 2013 02:05:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wD4GbONzxF2HmYp5IAgd7swvCN4=; b=XX9st2
	CI3IUcKhGrJBbXhnqgjS5dEf6pZupnVTj+k6J4yh/ce9k9a7eud8B96+hwox562a
	6n9lpTbEJvXbbD6orh7/e0zp7nzxjkXHiyPUmrjGh2pZK2Wz3JhrU2yNrx+UIub1
	CIgomz+0UUjq9awBYTkerea8cR01b7NNRST7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vAe/kExyZUldV5tQIX0BNMEclfisSMT8
	TJj/RtKv8c+crDHpJzxNZHfauWj17JuGjwhuVfO90pi90DIHotG2n0BYCuWxo3+X
	rFlFd9oVRrQUho3bf7S1SwfLoAkHo47V8WtdjP3DvtIdNh3jxETXh2NcTeiW5fFH
	FX9MiFJ0GTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5D107489;
	Sun,  6 Jan 2013 02:05:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28A947488; Sun,  6 Jan 2013
 02:05:56 -0500 (EST)
In-Reply-To: <20130105144949.GA24479@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 5 Jan 2013 09:49:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 842A3746-57CF-11E2-9E51-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212781>

Jeff King <peff@peff.net> writes:

> On Sat, Jan 05, 2013 at 09:03:16AM -0500, Jeff King wrote:
> ...
> The downside is that callers of run_command can no longer
> differentiate between a signal received directly by the
> sub-process, and one propagated. However, no caller
> currently cares, and since we already optimize out some
> calls to the shell under the hood, that distinction is not
> something that should be relied upon by callers.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Very nicely explained.  Thanks.

>  Documentation/technical/api-run-command.txt | 6 ++----
>  editor.c                                    | 2 +-
>  run-command.c                               | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
> index f18b4f4..5d7d7f2 100644
> --- a/Documentation/technical/api-run-command.txt
> +++ b/Documentation/technical/api-run-command.txt
> @@ -55,10 +55,8 @@ The functions above do the following:
>    non-zero.
>  
>  . If the program terminated due to a signal, then the return value is the
> -  signal number - 128, ie. it is negative and so indicates an unusual
> -  condition; a diagnostic is printed. This return value can be passed to
> -  exit(2), which will report the same code to the parent process that a
> -  POSIX shell's $? would report for a program that died from the signal.
> +  signal number + 128, ie. the same value that a POSIX shell's $? would
> +  report.  A diagnostic is printed.
>  
>  
>  `start_async`::
> diff --git a/editor.c b/editor.c
> index 065a7ab..27bdecd 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -51,7 +51,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>  		sigchain_push(SIGINT, SIG_IGN);
>  		sigchain_push(SIGQUIT, SIG_IGN);
>  		ret = finish_command(&p);
> -		sig = ret + 128;
> +		sig = ret - 128;
>  		sigchain_pop(SIGINT);
>  		sigchain_pop(SIGQUIT);
>  		if (sig == SIGINT || sig == SIGQUIT)
> diff --git a/run-command.c b/run-command.c
> index 757f263..cfb7274 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -249,7 +249,7 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>  		 * mimics the exit code that a POSIX shell would report for
>  		 * a program that died from this signal.
>  		 */
> -		code -= 128;
> +		code += 128;
>  	} else if (WIFEXITED(status)) {
>  		code = WEXITSTATUS(status);
>  		/*
