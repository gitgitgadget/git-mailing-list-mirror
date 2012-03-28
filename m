From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 10:42:26 -0700
Message-ID: <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 19:42:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCwtM-0004g1-2W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab2C1Rma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 13:42:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270Ab2C1Rm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 13:42:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280CA7F40;
	Wed, 28 Mar 2012 13:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h6qoyOdfqFsdEwfq0Fer8YN3Wn0=; b=XnKRsA
	7aLWvZziKz5YcUZ4ICtGfNUCzH49GlxpnGse5XaaoNkCwy+0rLEoIxuA3Rx5BonL
	XNfodTotceZRoefZD8JToSvmhUIY52Y2VCJdo38cR0vmXHspB0kZuMSChDZ53bhq
	1ZtHWboUx5BebRkxNp2Pk64GJlgBrsCNN/Hec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7P4WKqc7E9G90QFD7zDk5NrA5ZTt4Cw
	dQY2RoK+jZSIxCAkkDIvwN6idkA8z6840g7uD/MVBfbZ5GzIrI/SRYMuXn7ox5Gq
	SRvnGix00IuoQeSNsc2HNoaoNds52ySV0VphTkxU6xrs5n8AKvq4SFpBsRAQZLEU
	mwXdrF08m2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7947F3F;
	Wed, 28 Mar 2012 13:42:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5F6C7F3E; Wed, 28 Mar 2012
 13:42:27 -0400 (EDT)
In-Reply-To: <20120328043058.GD30251@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Mar 2012 00:30:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62C4197A-78FD-11E1-9836-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194148>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 27, 2012 at 12:16:36PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If git receives an EACCES error while trying to execute an
>> > external command, we currently give up and report the error.
>> > However, the EACCES may be caused by an inaccessible
>> > directory in the user's PATH.
>> 
>> Regardless of EACCES/ENOENT change we discussed, the observable behaviour
>> should be testable.  Something like this?
>
> Yes, though I held back on writing tests, because I don't think we've
> quite decided what the behavior _should_ be. Should we be
> differentiating "chmod -x /bin/ls" from "chmod -x /bin"? Should we be
> continuing alias lookup on EACCES? Should we print edit-distance
> suggestions on EACCES?

I am leaning to think that it would be the least surprising if we treat as
if /bin/ls does not even exist if /bin is not searchable.  If /bin/ls is
unreadable or unexecutable but /bin is searchable, then we _know_ it
exists, and we follow the usual exec*p() rule to ignore it so "git ls"
would try to find an alias and when all else fails will give the edit
distance suggestions but should exclude /bin/ls from candidates.  If /bin
itself is unsearchable, we do not even know what it contains, so it is
needless to say that /bin/ls will not be part of suggestion candidates.

That way, the only thing people _could_ complain about is "I have a
directory $HOME/sillybin in my $PATH but do not have an executable bit on
it.  When I try to run 'git stupid', 'git-stupid' in that diretory is not
executed, and I do not even get an error message to point out that I am
missing the executable bit on $HOME/sillybin directory".  And you can say
"Ah, just like the shell.  So make sure you have necessary permission bits
on things".  Very easy and straightforward to explain and understand.
