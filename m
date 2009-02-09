From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] t5400: allow individual tests to fail
Date: Mon, 09 Feb 2009 11:08:29 -0800
Message-ID: <7v4oz3v36a.fsf@gitster.siamese.dyndns.org>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <20090209184625.GA27037@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbW7-00056Y-Lf
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbZBITIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZBITIg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:08:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZBITIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:08:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D2602AC83;
	Mon,  9 Feb 2009 14:08:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 534412AC71; Mon, 
 9 Feb 2009 14:08:31 -0500 (EST)
In-Reply-To: <20090209184625.GA27037@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 9 Feb 2009 13:46:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0C1BF458-F6DD-11DD-B721-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109104>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 09, 2009 at 01:09:21AM -0800, Junio C Hamano wrote:
>
>> Each test chdir'ed around and ended up in a random place if any of the
>> test in the sequence failed but the entire test script was allowed to
>> run.  This wrapps each in a subshell as necessary.
>
> Certainly a good cleanup, but...
>
>> -test_expect_success \
>> -        'push can be used to delete a ref' '
>> +test_expect_success 'push can be used to delete a ref' '
>> +    (
>>  	cd victim &&
>>  	git branch extra master &&
>>  	cd .. &&
>>  	test -f victim/.git/refs/heads/extra &&
>>  	git send-pack ./victim/.git/ :extra master &&
>>  	! test -f victim/.git/refs/heads/extra
>> +    )
>>  '
>
> Wouldn't this be cleaner as:
>
>   (
>     cd victim &&
>     git branch extra master
>   ) &&
>   ...
>
> That is, it is not only safer but (IMHO) a bit easier to see which parts
> are happening in which directory.
>
>> +test_expect_success 'pushing a delete should be denied with denyDeletes' '
>> +    (
>>  	cd victim &&
>>  	git config receive.denyDeletes true &&
>>  	git branch extra master &&
>>  	cd .. &&
>>  	test -f victim/.git/refs/heads/extra &&
>>  	test_must_fail git send-pack ./victim/.git/ :extra master
>> +    )
>
> Ditto (and there are more, but I won't quote each one).
>
>> +test_expect_success 'pushing with --force should be denied with denyNonFastforwards' '
>> +    (
>>  	cd victim &&
>>  	git config receive.denyNonFastforwards true &&
>>  	cd .. &&
>>  	git update-ref refs/heads/master master^ || return 1
>>  	git send-pack --force ./victim/.git/ master && return 1
>>  	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
>> +    )
>
> And here I don't know what in the world is going on with those "return
> 1" lines. Shouldn't this be a chain of &&'s with a test_must_fail?
> I.e.,:
>
>   ( cd victim && git config receive.denyNonFastforwards true ) &&
>   git update-ref refs/heads/master master^ &&
>   test_must_fail git send-pack --force ./victim/.git/ master &&
>   ! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
>
> Not to mention that the final test_cmp would be more robust if written
> to make sure the victim's master ref stayed the same (instead of just
> making sure we didn't screw it up in one particular way). And it should
> probably use a git command rather than looking at the refs files (to be
> future-proof against any automatic ref-packing), but that is just
> nit-picking.
>
>
> All minor things, of course, but while we're cleaning up... :)

Sure.  This was made as a quick-fix to a mess others created, so I did not
study them very deeply.

Will reroll if I have the time but it is likely that I may be tending
other topics first.
