From: Junio C Hamano <gitster@pobox.com>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 11:55:45 -0800
Message-ID: <7vobho4hxa.fsf@alter.siamese.dyndns.org>
References: <20121217010538.GC3673@gmail.com>
 <20121220145519.GB27211@sigill.intra.peff.net>
 <7vk3sc606f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 20:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlmDv-0003F2-01
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 20:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab2LTTzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 14:55:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2LTTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 14:55:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81874A3C1;
	Thu, 20 Dec 2012 14:55:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=asihtzsE3qbBR/XAMbOsXlIUvPs=; b=AA5VxM
	BmTenjNY+OBno3P1cC1UcD0XbY/Zyw3sZKo5Dwx9acjgoNdpYFyRs2hXNdJyRx0n
	CSFn+ydM0NWwKbk+A5OxhV45fffdaz9m6qi56EBx+kBqFCNwHEJJr3jFTljW6Y3H
	oS0mL10EFOtAx5NX9z8bF7i4EsUurjp+lJkYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sWZH5FZ4+JMJI0FBs6H3ZvAzItHkUgZH
	XrqM/1ZNkhZRrH49GZeIo7yskqico3nqMShxhiMe1ERjiWsZ2/aYoDD3sf5um89r
	vwBT/uDA2/ieuapT1kRsozIuzdcz8o2nkN+I20C4VFBrHE70UVPG49uG6zAuZURy
	ipdBI95MoOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DEEFA3C0;
	Thu, 20 Dec 2012 14:55:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7EA3A3BD; Thu, 20 Dec 2012
 14:55:46 -0500 (EST)
In-Reply-To: <7vk3sc606f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 20 Dec 2012 10:36:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EE0C2CE-4ADF-11E2-AF72-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211921>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>   2. Loosen the test to look for the presence of "checkout", but not
>>      fail when other items are present. Bonus points if it makes sure
>>      that everything returned starts with "check".
>>
>> I think (2) is the ideal solution in terms of behavior, but writing it
>> may be more of a pain.
>
> Yeah, I think (2) is the way to go.

The beginning of such a change may look like the attached patch.

If we want to go for the bonus points, we would either add another
parameter "prefix" to the test_completion function, or introduce the
test_complete_command function that takes that prefix parameter, and
in addition to making sure lines from "expect" is fully contained in
the "actual", make sure that output from

	comm -13 expect.sorted actual.sorted

all begin with that "prefix" string, perhaps with

	grep -v "^$prefix"

or something.  The test_fully_contains function needs to be renamed
if somebody goes that additional step.

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..5fab389 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -54,10 +54,16 @@ run_completion ()
 	__git_wrap__git_main && print_comp
 }
 
+test_fully_contains () {
+	sort "$1" >expect.sorted &&
+	sort "$2" >actual.sorted &&
+	test $(comm -23 expect.sorted actual.sorted | wc -l) = 0
+}
+
 # Test high-level completion
 # Arguments are:
 # 1: typed text so far (cur)
-# 2: expected completion
+# 2: expected completion (if missing, this is read from stdin)
 test_completion ()
 {
 	if test $# -gt 1
@@ -67,7 +73,7 @@ test_completion ()
 		sed -e 's/Z$//' >expected
 	fi &&
 	run_completion "$1" &&
-	test_cmp expected out
+	test_fully_contains expected out
 }
 
 # Test __gitcomp.
