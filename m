From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Gitweb caching v7
Date: Sat, 30 Oct 2010 21:24:21 -0700
Message-ID: <7v1v773s7e.fsf@alter.siamese.dyndns.org>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
 <7vbp6c63gt.fsf@alter.siamese.dyndns.org>
 <m3k4l0girs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 05:24:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCPTD-0007Yt-8Z
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 05:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab0JaEYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 00:24:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0JaEYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 00:24:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EBD71410;
	Sun, 31 Oct 2010 00:24:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tskAGpBe6vqw43Prjp/HJ+WFSKk=; b=e26QZi
	aFovu+6hXO3PnbB7Yzn4GMWyL/NbyRP+Fskd06dEIF1/SqQB2NnNQTFa0H5Evlbi
	v8A8OUFtkrZGhW6LzT6j4PuIHwAIA4g5WtYbj/70jnuw9O3ICN3Qkew9wRhu5xZp
	aCr+fjnPk/Mc1Uz59Pr5QwoYXzylu0Wn5V7BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOEBey9jsRZsa8A1kmohvukMoK1ISQRX
	WynYmwbV5k1xzGl1iJloHG2IvvN40nhrsFuSCglVWua41Yut9ijew704FlrI2QHe
	AEsUb+SjhcAYNUqle9U5WUrFAosR8nSPe50hwP/qY6DKgAzX7qK51KZjzhyrbKo7
	muZwD6IK8XM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB636140F;
	Sun, 31 Oct 2010 00:24:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02662140E; Sun, 31 Oct
 2010 00:24:22 -0400 (EDT)
In-Reply-To: <m3k4l0girs.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat\, 30 Oct 2010 01\:58\:29 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF483B46-E4A6-11DF-8311-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160415>

Jakub Narebski <jnareb@gmail.com> writes:

>> I am getting this in the gitweb.log:
>> 
>>     [Fri Oct 29 22:21:12 2010] gitweb.perl: Undefined subroutine 
>>     &main::cache_fetch called at .../t/../gitweb/gitweb.perl line 1124.
>> 
>> which seems to cause t9500 to fail.
>
> This is caused by three issues (bugs) in v7 caching code.
>
> First is the reason why t9500 exhibits this bug.  The gitweb caching
> v7 includes file with subroutines related to caching in the following
> way:
>
>   do 'cache.pm';
>
> Note that the relative path is used; for t9500 it is relative from
> somewhere witjin 't/', and not from 'gitweb/', so "do 'cache.pm';"
> doesn't find it.

John, where should cache.pm go in the installed system?  Does it typically
go next to gitweb.perl?

I think "do 'that-file'" honors path specified by the -I option, so I do
not think "do $cache_pm" is necessary.  My preference is to run gitweb
tests with appropriate -I pointing at the cache.pm in the directory.

> ...  It should be
>
>   do $cache_pm;
>   die $@ if $@;
>
> at least.

Catching failure is a good thing to do.

> Perhaps even better would be to simply turn off caching
> support if there is an error in 'cache.pm'

That can come later.

Jakub, can we have an absolute minimum fix-up, so that we can give
this wider exposure?  I think there are only
four issues:

 (1) exclude Ajax-y stuff from caching;
 (2) install cache.pm the same way gitweb.perl is installed via
     the Makefile;
 (3) running tests with appropriate -I so that cache.pm is found; and
 (4) die if 'cache.pm' cannot be "done").

I think the change in gitweb-cache v7 is small and safe enough that we
should fast-track it to give usability to the real world sites.  It may be
a low-risk "obviously correct" approach that is quick-and-dirty, but that
is exactly why this should be fast-tracked.  It does not touch the logic
or formatting in any way, just bypasses the page generation altogether
when it can clearly do so when it can tell the output cannot possibly be
incorrect (albeit sometimes it might be stale if in certain cases, e.g. it
is relative to HEAD).

I know you and others were aiming to split things up, but I think the
amount of the effort that is needed for that line of work on top of the
current codebase is not much different from what is needed on top of
gitweb-cache v7.
