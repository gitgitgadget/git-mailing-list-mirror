From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Wed, 04 Nov 2015 10:14:43 -0800
Message-ID: <xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:14:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu2aB-0002zK-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 19:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbbKDSOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 13:14:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754990AbbKDSOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 13:14:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E84F3272C6;
	Wed,  4 Nov 2015 13:14:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jPM7k7F6EP7U6+kEPIJtXaPAYj8=; b=U4Sb7X
	6PYJTs07RHdvb0wRAhoArI1mf0M3lgc1GbjixaD+YNXdcUeNRFO4tSAOPvULEzHT
	jT2HEdpNGgYsK/sA0nnwpbI4M/Ah2R0mlQT2S/8vSF9fCUlMrwRSoulda9gsFB3h
	ldVuzwpDeHHV8k/ho/jKto/Lj3qvt8MPdgGFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuSBHoG3DWgCJ8+98yP2SpsFMYcpurpz
	98HdyqnKrumZWSYdKAEav0Cs14dG9Z/ckCuH8dEDlEhuIfrRCkrfa3Tuh8+ZLthA
	Z6a3c7BhW8ln7E8E1dnWmZvtTygZ6LOXDU6B7wtMIHeFzTNb1j1iDHeUM+9dXdGV
	FtPec0T8eb8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFD24272C5;
	Wed,  4 Nov 2015 13:14:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69653272C4;
	Wed,  4 Nov 2015 13:14:44 -0500 (EST)
In-Reply-To: <1446597434-1740-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 3 Nov 2015 16:37:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECD2587C-831F-11E5-BA05-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280863>

Stefan Beller <sbeller@google.com> writes:

> The warning message is cluttering the output itself,
> so just report it once.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  run-command.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 7c00c21..3ae563f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1012,13 +1012,21 @@ static void pp_cleanup(struct parallel_processes *pp)
>  
>  static void set_nonblocking(int fd)
>  {
> +	static int reported_degrade = 0;
>  	int flags = fcntl(fd, F_GETFL);
> -	if (flags < 0)
> -		warning("Could not get file status flags, "
> -			"output will be degraded");
> -	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
> -		warning("Could not set file status flags, "
> -			"output will be degraded");
> +	if (flags < 0) {
> +		if (!reported_degrade) {
> +			warning("Could not get file status flags, "
> +				"output will be degraded");
> +			reported_degrade = 1;
> +		}
> +	} else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK)) {
> +		if (!reported_degrade) {
> +			warning("Could not set file status flags, "
> +				"output will be degraded");
> +			reported_degrade = 1;
> +		}
> +	}
>  }

Imagine that we are running two things A and B at the same time.  We
ask poll(2) and it says both A and B have some data ready to be
read, and we try to read from A.  strbuf_read_once() would try to
read up to 8K, relying on the fact that you earlier set the IO to be
nonblock.  It will get stuck reading from A without allowing output
from B to drain.  B's write may get stuck because we are not reading
from it, and would cause B to stop making progress.

What if the other sides of the connection from A and B are talking
with each other, and B's non-progress caused the processing for A on
the other side of the connection to block, causing it not to produce
more output to allow us to make progress reading from A (so that
eventually we can give B a chance to drain its output)?  Imagine A
and B are pushes to the same remote, B may be pushing a change to a
submodule while A may be pushing a matching change to its
superproject, and the server may be trying to make sure that the
submodule update completes and updates the ref before making the
superproject's tree that binds that updated submodule's commit
availble, for example?  Can we make any progress from that point?

I am not convinced that the failure to set nonblock IO is merely
"output will be degraded".  It feels more like a fatal error if we
are driving more than one task at the same time.
