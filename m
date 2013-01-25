From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 20:19:30 -0800
Message-ID: <7vr4l97v3h.fsf@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
 <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyalf-00061M-9O
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab3AYETe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:19:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab3AYETd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:19:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA355CD60;
	Thu, 24 Jan 2013 23:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bz/r7Rz93lHC6bZi19biT5iJAWo=; b=jIff5J
	UiOnb81zpWXeFmoWBM7XiLjygNr2uzzFmcjrAYD6+kGjXbQbRqKKJV5zwfVLOrXG
	LO9TQS29g6dB4KExb4csKBeZyJkuf0X+grnDqMx1wJOruHYfF6QDj2fa/2MH9YSu
	pv5thZfpl1jJFWPGtg9R0a0HMM9Ulb1ylWJtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DVK5IFlSO1T5uyP0mLXwCKmMEKH2GvVT
	/4g4yoycpy9710pHZOd10wV/q/4tf3lhyxF1gs0a2nn3NiLtRwWHoBJlP5wy9t00
	zF3B4fIONxqkdaVUVBTCrrGd46q1IpsWPy40iUf7JPygaCtZZSf4hUro/q4CiVBN
	8B3soayOxhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA797CD5F;
	Thu, 24 Jan 2013 23:19:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46527CD5E; Thu, 24 Jan 2013
 23:19:32 -0500 (EST)
In-Reply-To: <7vvcal7vhg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Jan 2013 20:11:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B28880C-66A6-11E2-90F5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214489>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> This looks good to me.
>>
>> The only thing I might add is a test just to double-check that "git help
>> -a" is parsed correctly. Like:
>>
>>   test_expect_success 'command completion works without test harness' '
>>            GIT_TESTING_COMMAND_COMPLETION= run_completion "git bun" &&
>>            grep "^bundle\$" out
>>   '
>>
>> (we know we are running bash here, so the one-shot variable is OK to be
>> used with a function).
>
> I think you meant "^bundle $" there, but don't we have the same
> problem when there is an end-user subcommand "git bunny"?
>
> Ahh, ok, we show one element per line and just make sure "bundle"
> is there, and we do not care what other buns appear in the output.
>
> Will squash in, then.

Not so quick, though.  The lower level "read from help -a" is only
run once and its output kept in a two-level cache hierarchy; we need
to reset both.

It starts to look a bit too intimately tied to the implementation of
what is being tested for my taste, though.

 t/t9902-completion.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index adc1372..bb6ee1a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -286,4 +286,14 @@ test_expect_success 'send-email' '
 	test_completion "git send-email ma" "master "
 '
 
+# This is better to be at the end, as it resets the state by tweaking
+# the internals.
+test_expect_success 'help -a read correctly by command list generator' '
+	__git_all_commands= &&
+	__git_porcelain_commands= &&
+	GIT_TESTING_COMMAND_COMPLETION= &&
+	run_completion "git bun" &&
+	grep "^bundle $" out
+'
+
 test_done
-- 
1.8.1.1.525.gdace530
