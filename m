From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 08:48:18 -0800
Message-ID: <7vobgpxeel.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWAQ-0006wQ-Em
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081Ab3APQs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:48:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115Ab3APQsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:48:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D85CEA736;
	Wed, 16 Jan 2013 11:48:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6LRXozWrWv4fsJw44q8S0YfFdC4=; b=abo1pp
	C8/IiVx+1wVmdTJpqVoy1EeejteawxIvqdyLwDdOJQFxPbSl7jRSymjZTAosp2/G
	xsKWHl5rFvERfAdxByR4q0O52W6L6nd3sKZZmIuHBp0zlCFISkiOvqup96XpGQqQ
	3GAvZF7xzGie+G0+naiCqRfmpidRYhtNv3sJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6VlnPx7cppztwnvzfiCmz0ueRA5sJxI
	G/y/Op/OMtbVf0WoaxWM29kSz0qLAoWI/zlXfhipIQ/uQethrvZlGWwn4LRZ7Uh0
	6CRz6e5ZWO4hDM0JlOfKgjtxJnJovixWMBrabn0vpYQ+DKixDsjLPD+LygaZ2Cr6
	dosLJrpRCFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAE16A735;
	Wed, 16 Jan 2013 11:48:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EE82A731; Wed, 16 Jan 2013
 11:48:20 -0500 (EST)
In-Reply-To: <7vsj61xez2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Jan 2013 08:36:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 889E3608-5FFC-11E2-82B8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213768>

Junio C Hamano <gitster@pobox.com> writes:

> Max Horn <max@quendi.de> writes:
>
>> But with next, I get this:
>>
>>  ! [rejected]        master -> master (already exists)
>> error: failed to push some refs to '/Users/mhorn/Proje...o_orig'
>> hint: Updates were rejected because the destination reference already exists
>> hint: in the remote.
>>
>> This looks like a regression to me.
>
> It is an outright bug.  The new helper function is_forwrdable() is
> bogus to assume that both original and updated objects can be
> locally inspected, but you do not necessarily have the original
> locally.

The way the caller uses the result of this function is equally
questionable.  If this function says "we do not want to let this
push go through", it translates that unconditionally into "we
blocked it because the destination already exists".

It is fine when pushing into "refs/tags/" hierarchy.  It is *NOT*
OK if the type check does not satisfy this function.  In that case,
we do not actually see the existence of the destination as a
problem, but it is reported as such.  We are blocking because we do
not like the type of the new object or the type of the old object.
If the destination points at a commit, the push can succeed if the
user changes what object to push, so saying "you cannot push because
the destination already exists" is just wrong in such a case.
