From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Mon, 28 Apr 2014 10:48:21 -0700
Message-ID: <xmqqa9b5s5ui.fsf@gitster.dls.corp.google.com>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
	<20140425231953.GB3855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:29:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerEg-0003DE-D6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbaD1TZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:25:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932477AbaD1TZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:25:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F9BF7EDC6;
	Mon, 28 Apr 2014 13:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GbOSiE71F/0F30EwIv4kYWmMnfU=; b=YgzGR2
	Tjrgbr1YbtmWWcqNYkRSxqtw2YRb8DVHoUIDMaju8uRYW6hc1h9pserUHkYpFgk7
	l4AEld1aqM4gcGDpytoIGi04shUkEvomTSvRGgBQuSZt91Bv72IILL7qyqvaea7V
	zn4gFfQWhQ1yuV++OJwM6ROmjQv+SZ43gn3OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h6UUYvYP9vANvBGAZAhapZaFEiuPL0xe
	oCX/XPiBV2K0uOT1ouY4QR3/9c2vPPxEsmE47O79IL/JreDKRmSiu9gVndeZQiwX
	Sx1iei+5bF2P2WAokg7yqKf/Im47fD3GFxLIa/LsUbdPMH0Masu6XtwutAYUASxa
	+i80HmyowTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114DC7EDC5;
	Mon, 28 Apr 2014 13:48:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 266EC7EDC1;
	Mon, 28 Apr 2014 13:48:23 -0400 (EDT)
In-Reply-To: <20140425231953.GB3855@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 25 Apr 2014 19:19:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B03A3D4-CEFD-11E3-A86C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247406>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:
>
>> * jk/external-diff-use-argv-array (2014-04-21) 6 commits
>>   (merged to 'next' on 2014-04-22 at e6d92d7)
>>  + run_external_diff: refactor cmdline setup logic
>>  + run_external_diff: hoist common bits out of conditional
>>  + run_external_diff: drop fflush(NULL)
>>  + run_external_diff: clean up error handling
>>  + run_external_diff: use an argv_array for the environment
>>  + run_external_diff: use an argv_array for the command line
>> 
>>  Code clean-up.
>> 
>>  Will keep in 'next' for the remainder of the cycle.
>
> The first one does fix a possible stack overflow (albeit of one NULL,
> not arbitrary content, so I don't think it's exploitable). We may want
> to do:
>
> diff --git a/diff.c b/diff.c
> index 54d5308..a03744b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2894,7 +2894,7 @@ static void run_external_diff(const char *pgm,
>  			      int complete_rewrite,
>  			      struct diff_options *o)
>  {
> -	const char *spawn_arg[10];
> +	const char *spawn_arg[11];
>  	int retval;
>  	const char **arg = &spawn_arg[0];
>  	struct diff_queue_struct *q = &diff_queued_diff;
>
> as a fix for maint/2.0.0 in the interim. I can write a commit message
> for that if you're interested.

I think we should merge the first one (and possibly the second one,
too) as-is for 2.0 instead.  No change can possibly be more
trivially correct than these two ;-)
