From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" flaky?
Date: Fri, 30 Oct 2015 14:00:08 -0700
Message-ID: <xmqqvb9ojcmf.fsf@gitster.mtv.corp.google.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
	<CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
	<CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com>
	<xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Medley <fredrik.medley@gmail.com>, peff@peff.net,
	patrick.reynolds@github.com, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:00:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsGmZ-0002L4-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760809AbbJ3VAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:00:13 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757943AbbJ3VAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:00:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C20CD2854F;
	Fri, 30 Oct 2015 17:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TzlRJ3k3oDhQ5UB34cCSdwAX8t8=; b=pdJaz+
	eGMJMZo0+I0vdJPFPzXtcdzOmz1utzRXZHSC7J17BnqL7QgYBYiHerYoqFDBDhWT
	jEHzkNWPSNHvm7weKPG7uEW7b57aqzxe9L2AmNBxxhe+6U0UTUvD3dWoD3qVcas4
	cxHhsFAh8GcQPaNL2shvJprBDmKU1RRBoZvwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FjjRlHL5vmFFDp8A2Z/BksQPpmYyiz/k
	YVq3ujsy0nnhyJnRNWPdraa+ZeJ06Wakfb7bL6se+rjCqnTyVFmSOPlGcvhlS8oa
	+2ln4Y0iJhpplwMIyt0j60/oLKVeEjvMTqKW4pYNVBMR9APzPfOD3movkAsUgBzu
	OOatzYv8b68=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B9BF92854E;
	Fri, 30 Oct 2015 17:00:10 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 405342854D;
	Fri, 30 Oct 2015 17:00:10 -0400 (EDT)
In-Reply-To: <xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 25 Oct 2015 10:38:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34F9211A-7F49-11E5-A95A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280541>

Junio C Hamano <gitster@pobox.com> writes:

> That leaves us to something along this line...
>
>> (3) Add a method "test_must_fail_or_die" to
>> "test-lib-functions.sh". This method accepts exit codes 129<x<192,
>> too. Use the new method in t5516.
>
> ... but I have to wonder if 129<x<192 is loosening too much, given
> that the only error we expect, other than the orderly shutdown, is
> reception of sigpipe.

So, how about doing something like this as a starter.  All of the
object transport codepath share "we may notice that the other end
disconnected, or that the other end explicitly told us it found an
error, and die, or the other end may have died, perhaps after giving
a human-readable error message, and we end up dying when we try to
tell them more with SIGPIPE", and that by itself is not a bug in the
real life---we will exit with non-zero status and that is a sign
enough for the user to know that the command has failed.



 t/test-lib-functions.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6dffb8b..b1f950d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -579,6 +579,9 @@ test_must_fail () {
 	if test $exit_code = 0; then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
+	elif test $exit_code -eq 141; then
+		echo >&2 "test_must_fail: died with sigpipe: $*"
+		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
