From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some options"
Date: Fri, 26 Feb 2016 15:44:01 -0800
Message-ID: <xmqqbn73hwam.fsf@gitster.mtv.corp.google.com>
References: <20160226232507.GA9404@sigill.intra.peff.net>
	<20160226232957.GB9552@sigill.intra.peff.net>
	<20160226233449.GA9622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 00:44:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZS3O-0006kw-Tt
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbcBZXoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:44:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754818AbcBZXoD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:44:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC161476EF;
	Fri, 26 Feb 2016 18:44:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+9V9y0iwmQ6KILe6xqLUqIKN2CY=; b=FaHum1
	tI4gQeEusHFD+nfqt4Y1fDS2d5cGEQ4C0ABbSBAWsEf+ghkDUNc95SeU87u5c/lc
	CxiRdlg4ZAa4qmA62RTL8iXPAhdFLdZU+PEs+y6yItqCRgausxTN2Lv16q8S8FRw
	nlBwnxKsle6kM6mtlCVVbDyWXv7JIfAIuzV0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YMjzSpoJ23JAj0AFIoPSHQdSrVsDnwmA
	gY1Q7BgCLmXbGtNWiLpUHb30stTI8a8e0PUqKEq/cyKUTgKL2EJLaK93MhPTfm1o
	iNX4mHY4ktYJN2mrDksMXAG23twPPxIoUv7P76ZP4daLg0r50IBKCWn+lPqsMaaG
	S3EQdkrGY5g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3D65476EE;
	Fri, 26 Feb 2016 18:44:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59504476ED;
	Fri, 26 Feb 2016 18:44:02 -0500 (EST)
In-Reply-To: <20160226233449.GA9622@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Feb 2016 18:34:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D085972A-DCE2-11E5-878B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287642>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 26, 2016 at 06:29:57PM -0500, Jeff King wrote:
>
>> The best solution here would be to have a full parsing loop
>> that handles all options, but only calls setup_git_directory
>> as appropriate. Unfortunately, that's a bit complicated to
>> implement. We _have_ to handle each option in the order it
>> appears on the command line. If the caller asked for:
>> 
>>   git rev-parse --resolve-git-dir foo/.git --show-toplevel
>> 
>> then it must receive the two lines of output in the correct
>> to know which is which. But asking for:
>> 
>>   git rev-parse --show-toplevel --resolve-git-dir foo/.git
>> 
>> is weird; we have to setup_git_directory() for the first
>> option.
>> 
>> So any implementation would probably have to either:
>> 
>>   - make two passes over the options, first figuring out
>>     whether we need a git-dir, and then actually handling
>>     the options. That's possible, but it's probably not
>>     worth the trouble.
>> 
>>   - call setup_git_directory() on the fly when an option
>>     needs it; that requires annotating all of the options,
>>     and there are a considerable number of them.
>
> Having just sent this, of course, it occurs to me that a loop like:
>
>    setup_git_directory_gently(&nongit);
>    for (i = 0; i < argc; i++) {
>   	if (!strcmp(argv[i], "--local-env-vars"))
>   	... and other nongit-ok options ...
>   
>   	if (nongit)
>   		die("need a repo");
>   
>   	if (!strcmp(argv[i], "--git-dir"))
>   	... and other options ...
>    }
>
> would probably work. It does still leave things like --parseopt and
> --sq-quote as one-offs, though, because they consume the rest of the
> command line. And the fact remains that --local-repo-env isn't really
> suitable for use with other options.
>
> So I'm still tempted by this "lazy" approach.
>
> -Peff

Yup.

But why do you even need to run local-env-vars from outside a
repository in the first place?
