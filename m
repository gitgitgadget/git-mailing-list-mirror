From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Move Git::SVN::get_tz to Git::get_tz_offset
Date: Wed, 16 Jan 2013 12:36:18 -0800
Message-ID: <7vehhkx3ul.fsf@alter.siamese.dyndns.org>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
 <1358291405-10173-2-git-send-email-bdwalton@gmail.com>
 <7vehhlyw90.fsf@alter.siamese.dyndns.org>
 <CAP30j164UD9gNRbZ=uCQjgpDODWnGtYmHcWES2P=YPryL=FbZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvZj1-0005oM-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 21:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab3APUgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 15:36:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab3APUgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 15:36:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7D7CC73;
	Wed, 16 Jan 2013 15:36:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xlY7LxVO7Y2no5HG4tj4y4c/r1M=; b=clK4HZ
	kd3id8CRWqTehskUOHKIsp9UQxNlw0OptXwX71BqdlTnShSY+C0y7xh4KkgqSG0a
	+pNO02A5tP8aXXZbgel21yAhRXOHgdSOxUH4TWtkpk8/fNXTZZ2H5TX3UqmsrREb
	b8Pe156Lu1KUG9qn/zhQ5ofwQ5g6Q0d7DQ7n0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wI98cwU0ZwNPkIilFt6D8GHiMRqVb3f6
	7QJ7rNghv53LYwFuou9vgQoWkeNEHfSLWvqf1tYQL3kkjo58HgaMdAv47c5uJVub
	upwAt0EQhORPKgcQnd1AFwkH8ehgTcWnq/obEU15UK80yqMjYz1UATPIqJNRZemY
	MRJOZnJlVwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C77FECC71;
	Wed, 16 Jan 2013 15:36:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34D06CC6D; Wed, 16 Jan 2013
 15:36:20 -0500 (EST)
In-Reply-To: <CAP30j164UD9gNRbZ=uCQjgpDODWnGtYmHcWES2P=YPryL=FbZA@mail.gmail.com> (Ben
 Walton's message of "Wed, 16 Jan 2013 20:16:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 627CEF62-601C-11E2-A740-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213811>

Ben Walton <bdwalton@gmail.com> writes:

> On Wed, Jan 16, 2013 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ben Walton <bdwalton@gmail.com> writes:
>>
>>> +sub get_tz_offset {
>>> +     # some systmes don't handle or mishandle %z, so be creative.
>>
>> Hmph.  I wonder if we can use %z if it is handled correctly and fall
>> back to this code only on platforms that are broken?
>
> That would be perfectly acceptable to me.  The reason I set it up to
> always run through this function here is that when I originally added
> this function for git-svn, I'd made it conditional and Eric Wong
> preferred that the function be used exclusively[1].  I opted to take
> the same approach here to keep things congrous.
>
> If it were to be conditional, I think I'd add a variable to the build
> system and have the code leverage that at runtime instead of the
> try/except approach I attempted in 2009.

If the code was originally unconditional for a reason (and I think
being bug-to-bug compatible across platforms is actually a good
thing in a tool like importers), I would not object to it.  Thanks
for the back-story.
