From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Don't rely on strerror text when testing rmdir failure
Date: Mon, 31 Mar 2014 10:35:48 -0700
Message-ID: <xmqqvbuu6zkb.fsf@gitster.dls.corp.google.com>
References: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
	<1396107541-22974-3-git-send-email-cbailey32@bloomberg.net>
	<5336EB5C.6040103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:35:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUg7p-00075X-EP
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbaCaRfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:35:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbaCaRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:35:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1E175218;
	Mon, 31 Mar 2014 13:35:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfyaM3eAywSFOnZbX+gOhgocYWI=; b=t7HSeL
	dwv1LWmRYvd5x8GgH4uKq55C82fO1eD/KwMX7wDbjHH2gfJNMkxAU6hbxjn2i+oK
	C7gGfa5rrJflbld23PU30JDHGNPyg4oQnNKCDcQG/twHjM0Qzk8cktBYu+PV+ejs
	MTpc/BwETGGVBsfLJaYzlsSGWnDF7x3m1JhUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vV/7LGcc3OnVsJWXtLz1o1me4OK28LSI
	jlBvwBK9W8XKiRXTEQHMAr08D2rssEF8nC+6YUF4gz3oI1e9jYa3J/5SmjpBxPtp
	7rAIwjKPqOKtSGRRpEpSPvEekS+HgaIGWTuGACRumazmQUpoWlVK6g4jz2Jg/+/D
	9nH38BqwLeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3960875216;
	Mon, 31 Mar 2014 13:35:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 904B075213;
	Mon, 31 Mar 2014 13:35:50 -0400 (EDT)
In-Reply-To: <5336EB5C.6040103@web.de> (Jens Lehmann's message of "Sat, 29 Mar
	2014 16:48:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6DFF5F0-B8FA-11E3-8DE7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245498>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 29.03.2014 16:39, schrieb Charles Bailey:
>> AIX doesn't make a distiction between EEXIST and ENOTEMPTY so relying on
>> the strerror string for the rmdir failure is fragile. Just test that the
>> start of the string matches the Git controlled "failed to rmdir..."
>> error. The exact text of the OS generated error string isn't important
>> to the test.
>
> Makes sense.
>
>> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
>> ---
>>  t/t3600-rm.sh | 5 ++---
>>  t/t7001-mv.sh | 3 +--
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
>> index 3d30581..23eed17 100755
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -709,10 +709,9 @@ test_expect_success 'checking out a commit after submodule removal needs manual
>>  	git commit -m "submodule removal" submod &&
>>  	git checkout HEAD^ &&
>>  	git submodule update &&
>> -	git checkout -q HEAD^ 2>actual &&
>> +	git checkout -q HEAD^ 2>/dev/null &&
>
> Isn't this unrelated to the strerror issue you are fixing here?
> Why not just drop the redirection completely? But maybe I'm just
> being to pedantic here ;-)

No, that sounds like a very reasonable suggestion.  Especially given
that the redirection destination is overwritten immediately after.

In general tests should not have to squelch their standard error
output with 2>/dev/null; that is a job for the test harness, and
they will be shown in the output of "./t3600-rm -v" to serve as
anchor point while finding where a test goes wrong, which is a good
thing.
