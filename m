From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 10:16:49 -0700
Message-ID: <7v626udse6.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
 <50695ECE.5010101@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, s.oosthoek@xs4all.nl,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:26:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjc7-00010b-Ei
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071Ab2JARQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:16:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2JARQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:16:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4FDC8EA6;
	Mon,  1 Oct 2012 13:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JKqii+1QNh7y5rAR1/TVEbqWm18=; b=xivPT7
	1EWsvbljisfv/mmPo8pHo3+mF7Qtn4Wwxbwoqdha55/NDdJ7yblO0T4gDyOAYplE
	y367oprxQ9PU7ecrN+3ZWS9XgLffPCMfUh3kuyo9sQEwYNohump3qVAACbtGCKne
	1k3qOQa9zIPV/CjvNAQJ2Di3RedI1cEDGHnKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oaOaJ96HS6LjoaBeRtlKAPJPIyvUX3+R
	qwFzBsbwUzkOv1h4WCyyL1yy0/HdhfVfioK6AMHIKYu6BlNCoO5DezkdFqjpIDZV
	PnnK3RM8hecq1CBeK81D5OFCLvu+5D6O4vs5zmOG5mZ0xseV+Nv1uOpXxKTBmIfU
	8G7e1Wi5HL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9254D8EA5;
	Mon,  1 Oct 2012 13:16:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3D188EA4; Mon,  1 Oct 2012
 13:16:50 -0400 (EDT)
In-Reply-To: <50695ECE.5010101@nieuwland.nl> (Simon Oosthoek's message of
 "Mon, 01 Oct 2012 11:13:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA0EAECA-0BEB-11E2-8CB1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206742>

Simon Oosthoek <soosthoek@nieuwland.nl> writes:

> On 09/28/2012 07:58 PM, Junio C Hamano wrote:
>> Simon Oosthoek <soosthoek@nieuwland.nl> writes:
>>
>>> +# __git_ps1_pc accepts 0 arguments (for now)
>>> +# It is meant to be used as PROMPT_COMMAND, it sets PS1
>>> +__git_ps1_pc ()
>>> +{
>>> +	local g="$(__gitdir)"
>>> +	if [ -n "$g" ]; then
>>> +...
>>> +	fi
>>> +}
>>
>> This looks awfully similar to the existing code in __git_ps1
>> function.  Without refactoring to share the logic between them, it
>> won't be maintainable.
>>
>
> I agree that it's ugly. How about the following:
>
> I modified __git_ps1 to work both in PROMPT_COMMAND mode and in that
> mode support color hints.
>
> This way there's one function, so no overlap.

I think the logical progression would be

 - there are parts of __git_ps1 you want to reuse for your
   __git_ps1_pc; separate that part out as a helper function,
   and make __git_ps1 call it, without changing what __git_ps1
   does (i.e. no colors, etc.)

 - add __git_ps1_pc that uses the helper function you separated
   out.

 - add whatever bells and whistles that are useful for users of
   either __git_ps1 or __git_ps1_pc to that helper function.
