From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] describe: use argv-array
Date: Tue, 09 Jul 2013 09:00:20 -0700
Message-ID: <7vehb7wwob.fsf@alter.siamese.dyndns.org>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
	<1373236424-25617-4-git-send-email-gitster@pobox.com>
	<20130709045151.GE27903@sigill.intra.peff.net>
	<7vip0jwzou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 09 18:00:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwaL7-0000Sh-5V
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 18:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab3GIQAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 12:00:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab3GIQAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 12:00:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E922F137;
	Tue,  9 Jul 2013 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CB0GowTZiGJCvp9yjQbI18TnCTY=; b=fd07H+
	CkiJ/EjsE7KHvG5Gk893KrMg3FvypFB7tRKg+ljDJrHIGMSe4tpk+dre07BSsdgd
	c7pgE9xYSb56+M7vkTXupb0Bgu52wl/ki+cYwVcdswnDwn+r7N3IUrD5Hw+MGFJl
	qB2W2fyUwcDQTKuUwavGIsRHBDJo+YFydoNjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuVYjtnkoI6A9p3wbf/+iLp+/VTBZYeq
	gd+wZPgylDNvCzOCPpgAdJnnqz3Z9iuU6mRQjb+Mofuuajx3ALIOBW6gWizY5a5/
	SJZC5p4mTtpFe8fR+ckb8XFpB3o/mazE/d3jg1ezH7yDD0CyMocnWo3DKDrq8pIA
	Pg8NosEu+18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3A02F136;
	Tue,  9 Jul 2013 16:00:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BA532F134;
	Tue,  9 Jul 2013 16:00:22 +0000 (UTC)
In-Reply-To: <7vip0jwzou.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 09 Jul 2013 07:55:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A93D67F2-E8B0-11E2-8240-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229964>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sun, Jul 07, 2013 at 03:33:43PM -0700, Junio C Hamano wrote:
>>
>>> +		argv_array_init(&args);
>>> +		argv_array_push(&args, "name-rev");
>>> +		argv_array_push(&args, "--name-only");
>>> +		argv_array_push(&args, "--no-undefined");
>>> [...]
>>> -		memcpy(args + i, argv, argc * sizeof(char *));
>>> -		args[i + argc] = NULL;
>>> -		return cmd_name_rev(i + argc, args, prefix);
>>> +		return cmd_name_rev(args.argc, args.argv, prefix);
>>
>> This leaks the memory allocated by "args". The original did, too, and it
>> is probably not that big a deal (we exit right after anyway). The fix
>> would be something like:
>>
>>   rc = cmd_name_rev(args.argc, args.argv, prefix);
>>   argv_array_clear(&args);
>>   return rc;
>
> Yes; this was meant as a straight rewrite and I did not bother, but
> I should have cleaned it up as I meant to build on top.
>
> Will amend, even though I do not think we need to build anything on
> top.

Heh, you fooled me.  cmd_name_rev() uses the usual parse-options
machinery that updates args.argv[].  Dashed options that were
consumed will not remain in args.argv[] and argv_array_clear() will
not have a chance to free them, and besides, args.argc and args.argv
will be out of sync and wreaks havoc in argv_array_clear().

We could expose argv_array_push_nodup() and use it in this caller
and then free the args.argv[] but not its contents, but I do not
think it is worth it.
