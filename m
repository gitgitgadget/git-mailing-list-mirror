From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] recover from "failed to apply delta"
Date: Fri, 14 Jun 2013 15:23:16 -0700
Message-ID: <7vbo78miwb.fsf@alter.siamese.dyndns.org>
References: <20130613232608.GA9844@sigill.intra.peff.net>
	<alpine.LFD.2.03.1306132004090.18597@syhkavp.arg>
	<20130614214943.GA29138@sigill.intra.peff.net>
	<7vsj0kmkd4.fsf@alter.siamese.dyndns.org>
	<20130614215618.GB29138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 15 00:23:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UncP0-0002K9-8b
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 00:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab3FNWXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 18:23:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab3FNWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 18:23:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F35E277ED;
	Fri, 14 Jun 2013 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBpR3iPPPyRN5fDUp9/w8IuXSaI=; b=FIUlB7
	EXbDFMc5CB7R7hjoA2WsGIHilBJcq2qWOuKtIsFct0m1GeJk8r28BY7npG7eIJ9t
	8gt7fUn41M1Wk9KFqps4AbjR8sQZN+BJ8UDh8tMQXh6jncfsgHZ1I12tpc16ZBBo
	LlLW0o0cA5SbKWzETJGw72uFLKZrUhn6cUp1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdnnD/9w6RoQSKCZAdZyXQS6HF09YGo3
	C61KIhGPNPXyji8oBDWWDuTuFefHXQ2+vHoU7m8Oj3ZaTWdDgiK/BFu+DhSD++j1
	XYCEi5dPEP66eei6S5aNP0hqirVYq/BlJns7rqCLZ6dwfg+0yzv/KKJiyLY5e4qh
	C45AO/O8czY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36082277EC;
	Fri, 14 Jun 2013 22:23:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A34F6277E9;
	Fri, 14 Jun 2013 22:23:18 +0000 (UTC)
In-Reply-To: <20130614215618.GB29138@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Jun 2013 17:56:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03BBE074-D541-11E2-A5D9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227930>

Jeff King <peff@peff.net> writes:

>> +     # At the beginning of the REF_DELTA representation of $blob_3,
>> +     # write 20-byte base object name for $blob_1, instead of $blob_2.
>> +     # The binary representation of object name for $blob_1 is found
>> +     # at offset 4 + 4 + 256*4 = 1032 for 20 bytes.
>> +     dd if=${pack}.idx bs=1 count=20 skip=1032 | do_corrupt_object $blob_3 2 20 &&
>> +     test_must_fail git cat-file blob $blob_3 >/dev/null &&
>
> I didn't want to bother coming up with the binary version of the
> REF_DELTA sha1, so I used OFS_DELTA. :)

Yeah, I contemplated on doing something like this

	printf "$(echo $blob_3 | sed -e 's/\(..\)/\\x\1/g')"

but of course printf "\xAA" is not in POSIX and at that point I
punted and instead read from .idx at the known offset ;-)
