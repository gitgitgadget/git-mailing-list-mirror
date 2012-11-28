From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] t9001: check send-email behavior with implicit
 sender
Date: Wed, 28 Nov 2012 12:42:41 -0800
Message-ID: <7vpq2xtq66.fsf@alter.siamese.dyndns.org>
References: <20121128182534.GA21020@sigill.intra.peff.net>
 <20121128184229.GA3993@sigill.intra.peff.net>
 <7vk3t5v9q1.fsf@alter.siamese.dyndns.org>
 <20121128200626.GA4292@sigill.intra.peff.net>
 <20121128201713.GA9249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdoTE-00070u-CP
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab2K1Umo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:42:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2K1Umo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:42:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ECCA89EB;
	Wed, 28 Nov 2012 15:42:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WvDIxNxM4oJWpBxMnmizB3ZgU/U=; b=wVXhVq
	SkiDmp09TwAqGPTtXV7ijvTrhfWW7Kd3VvPogODtcNH56ZFzSFl+8wo2wazz1Dij
	UGBtjEFu1ehC7fypxytwNMhvncf9YZAlKvm/QEDnPak+PxMiwhJWFZI1SuRyK3UR
	lOMsmZtlKzVQgdLczRCiEAVPFX8kNO5gNaILg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glE5MuFi0MRqvydIjJBfD+QyMg0EKT7/
	jtecnkelecGIC7UjYHcBz8P1B3scrFnrlRZrvXoNpjR5cRwaROm6ciCg533nTYZq
	utSCwIe7ptUfUSshZ86lKSwbq+j3QkJDVSFiYxZ19nmUXAC5Ys7W2gMvO78rRIaY
	+6HCPdQnAwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE7589EA;
	Wed, 28 Nov 2012 15:42:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D25789E8; Wed, 28 Nov 2012
 15:42:42 -0500 (EST)
In-Reply-To: <20121128201713.GA9249@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Nov 2012 15:17:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 283105CE-399C-11E2-B624-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210776>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 28, 2012 at 03:06:26PM -0500, Jeff King wrote:
>
>> Here's a cleaned up version that makes it more obvious the commands are
>> the same (it also fixes a few minor whitespace problems on the
>> indentation, which you can see from the quoting above).
>
> I wondered how painful it would be to actually run the command and then
> conditionally check the results inside the test. I ended up with this:
> ...
> which does work, though it is less nice that the protections and nice
> syntax of "test_must_fail" must be abandoned (unless we want to do
> something horrible like 'test_must_fail sh -c "exit $exit_code"'.
> I could go either way.

A change along that line did cross my mind, and I agree that it does
clarify that we are testing the same command produces an expected
result, the expectation may be different depending on external
conditions, and we can figure out what the expected values are
before running the test.  I do not think we use such a pattern in
very many places, though.

The differences in "expected results" are generally not limited to
the final outcome in $? (e.g. your "else" side not just checks $?
indicates an error, but makes sure that we got an expected error
message), which means that the if statement at the end has to be
there in some form anyway, which in turn means that a new test
helper function to abstract this pattern out further would not
buy us very much (either it would be too complex and bug prone to
implement, or it would be too simplistic and limited).

I'd prefer to leave these as two separate tests for now like your
previous patch.  People interested in consolidating/simplifying can
first audit the existing tests to find other instances of this
pattern to see if it is worth doing, and then come up with an
abstraction to be shared among them.

Thanks.
