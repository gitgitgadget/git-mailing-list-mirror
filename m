From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] submodule foreach: correct path computation in recursive submodules
Date: Tue, 29 Mar 2016 12:00:44 -0700
Message-ID: <xmqqk2klxg6b.fsf@gitster.mtv.corp.google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-3-git-send-email-sbeller@google.com>
	<xmqq60w525yd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:01:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akysm-0000Kf-O6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbcC2TAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:00:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757457AbcC2TAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:00:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 373DB4FB66;
	Tue, 29 Mar 2016 15:00:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6N+malmeMYAor770zqG5t/n3UoI=; b=B2VOj3
	RDIUJLixeHz3J0oVtVmnTPj9JL6TN1dNvVuorvb07cA9U5U/AtPC8SiKouJGP4af
	RM6DOU7v7WLK+gnHUQBCUXJJQnNgBU2aoAFIcLRhv5HQ33K6wsHzeVHTWARIzvGB
	wqGFy32jB0oYfHDSUGBTDrDQVrmgpeNVMiLy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZWsz9/0FlV8hO6wlnH9zPC08IixLdjJQ
	o6sN3l3UPK4pFE3s0Vgb76DQXJlsJNLWRTKERnIsqJsb/ub1GBjzO6EDOzKJz1fc
	zi2dvIpeo9Ve6AZX9V5hnr0NmyhhLJqVmJdFGF4dnEqQoi6d1fxujVIIz4UkeLKL
	tHZQyDIpq1g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F5124FB65;
	Tue, 29 Mar 2016 15:00:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9DCE84FB64;
	Tue, 29 Mar 2016 15:00:45 -0400 (EDT)
In-Reply-To: <xmqq60w525yd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Mar 2016 22:44:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8AE81C26-F5E0-11E5-A8B8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290161>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> The test which is fixed by this patch would report
>>     Entering 'nested1/nested2/../nested3'
>> instead of the expected
>>     Entering '../nested1/nested2/nested3'
>>
>> because the prefix is put unconditionally in front and after that a
>> computed display path with is affected by `wt_prefix`. This is wrong as
>> any relative path computation would need to be at the front. By emptying
>> the `wt_prefix` in recursive submodules and adding the information of any
>> relative path into the `prefix` this is fixed.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Nicely explained and executed.

Interestingly, this breakage, as 1/7 shows, only affects the
"Entering $there" message--I somehow expected from reading the
description above that the command given to "foreach" is run
in a wrong submodule directory, but there is no such bug that
is fixed by this change, as far as "foreach" is concerned.

Which might be an indication that it wasn't so "Nicely explained"
after all X-<.  Are there codepaths that use the same incorrect
information (which was fixed by this patch) for things other than
the message and chdir to an incorrect place?  Then this change is
fixing more than "just a bug in foreach message".

The explanation does not make it clear what the extent of the fix
is, in other words.

Nevertheless, it is a good fix for "foreach message".  Thanks.  It
just needs to clarify if that is the only change, or if it fixes
other things.
