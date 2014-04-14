From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/27] refs: add a concept of a reference transaction
Date: Mon, 14 Apr 2014 14:25:03 -0700
Message-ID: <xmqqa9bnmwnk.fsf@gitster.dls.corp.google.com>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
	<1396878498-19887-20-git-send-email-mhagger@alum.mit.edu>
	<xmqq8urhlzr1.fsf@gitster.dls.corp.google.com>
	<534BBE67.3040100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:25:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZoNQ-0005DA-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 23:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbaDNVZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 17:25:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461AbaDNVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 17:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 845CB7DFB2;
	Mon, 14 Apr 2014 17:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qgZr655snhZJSjZav+G6Z74xeKI=; b=FCdgkJCvw8pAKIfLNNtP
	yg2Wgw5PJlzbZbzBcB6iThCbklAbNNutqYfsMowyhB3rc/6al/l3khui3S4JEdIK
	cH9T24AA48oEGyqXTxIj8m559N5pSs1aswwM24mUY2mTC0p75KnwCDwHrCGtFUr7
	vD9lMXMeRg57HHp4m5z45G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YRtNPXuvdBdwWJ98DDMXOCWrxLQZFOcOk0FyGQmEGrLjEQ
	aBdAf+aueLIMBiSPl/H2hVISZY7JKGOm6kJnJBwgrfhXVWS+ivgu+IKxDKCqhNAo
	GLu2ZrmSDazGyfyYwNxN0ZaGDAkm1ZmMfrRHqnJHMLV0h09mHd/VU+9aP1Z3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 659AC7DFB1;
	Mon, 14 Apr 2014 17:25:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 187BF7DFAE;
	Mon, 14 Apr 2014 17:25:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F033DF2-C41B-11E3-AE88-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246267>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I forgot to confirm that the callers *do* verify that they don't pass
> incorrect values to ref_transaction_create() and
> ref_transaction_delete().  But if they wouldn't, then die("BUG:") would
> not be appropriate either, would it?  It would have to be die("you silly
> user...").

Having the assert() there gives a confused message to the readers
(at least it did to this reader).

assert() implies that callers that are not buggy should not give
input that triggers the condition, which would mean it is the
callers' responsibility to sanity check the user-input to reject
creating a ref at 0{40} or deleting a ref whose old value is 0{40},
which in turn means these input are errors that need to be diagnosed
and documented.

But as you said below...

> ... even if the preconditions are not met, nothing really crazy
> happens.

I agree that it also is perfectly fine to treat such input as
not-an-input-error.

It is a signal that these checks are not 'if (...) die()' that the
code may take that stance.

I cannot tell which interpretation the code is trying to implement.

Any one of the following I can understand:

 (1) drop the assert(), declaring that the user input is perfectly
     fine;

 (2) keep the assert(), reject such user input at the callers, and
     document that these are invalid inputs;

 (3) replace the assert() with 'if (...) die("you silly user...")',
     and document that these are invalid inputs; or

 (4) same as (3) but replace with warn(), declaring such input as
     suspicious.

but the current assert() makes the code look "cannot decide" ;-).

I would consider the first two more sensible than the other two, and
am leaning slightly towards (1) over (2).

Thanks.
