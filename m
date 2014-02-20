From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Thu, 20 Feb 2014 11:22:36 -0800
Message-ID: <xmqqsird6137.fsf@gitster.dls.corp.google.com>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
	<BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Feb 20 20:23:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGZD8-0006Bh-2S
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 20:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbaBTTW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 14:22:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbaBTTW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 14:22:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE0826CBA2;
	Thu, 20 Feb 2014 14:22:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gtblmYrabSd6TECa9Pz5AVBPzYU=; b=uAfdRE
	qfaxpuhhUFv5ZMMae1dDTbE3VZylvQbDhu6FwD6xlQ3P7KeaemmSrn7qwn8YHbY6
	2vt+CrjKlhDv8poAXq4H9LNWTnZz8joW3qdDBKt6PvPmXWCGw2SPQTk4Oqy3Tkkg
	5k0gXynvSAExj6vy6nP9xJ9ObVeYibn5aovxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEkiU1GMCOISaTAJhlN4pXN3UvsX5cn2
	zAWoRNHmGPIpI1PeFjmLmMjPZHAUpzvN06vFQ2ize9/iyA3/PfNnJhaoXeZCYjeA
	pJ7n22E8la4EkQxw0BtERCXYEWvChfmq7QWm8LY523PWK+Yx7UTgngqTJECcALpx
	pUBIew8b5mg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D9A6CBA1;
	Thu, 20 Feb 2014 14:22:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C1516CB6D;
	Thu, 20 Feb 2014 14:22:37 -0500 (EST)
In-Reply-To: <BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de> (Max Horn's
	message of "Thu, 20 Feb 2014 19:39:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BE813D8-9A64-11E3-A909-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242442>

Max Horn <max@quendi.de> writes:

> On 19.02.2014, at 22:41, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * fc/transport-helper-fixes (2013-12-09) 6 commits
>> - remote-bzr: support the new 'force' option
>> - test-hg.sh: tests are now expected to pass
>> - transport-helper: check for 'forced update' message
>> - transport-helper: add 'force' to 'export' helpers
>> - transport-helper: don't update refs in dry-run
>> - transport-helper: mismerge fix
>> 
>> Reported to break t5541, and has been stalled for a while without
>> fixes.
> ...
> Since I somewhat care about transport-helpers, I had a closer look
> at this failure.

Thanks.  Let's keep it a bit longer and see how your new
investigation (and possibly help from others) develops to a
solution.

> Torsten already narrowed it down to f9e3c6bebb89de12
> (transport-helper: check for 'forced update' message).
>
> Looking at that commit, the problem is the new line
>
>    (*ref)->forced_update = forced;
>
> which is supposed to set forced_update to 1 in certain cases; but
> the code which sets "forced = 1" ever triggered (at least in my
> limited tests). Worse, it seems forced_update can be set to 1
> before we ever get there, and in these casss, we end up reseting
> forced_update from 1 back to 0. This triggers the test failure.
>
> So a simple fix for the test failure is to drop that
> patch. Another would be to change the assignment to
>
>    (*ref)->forced_update |= forced;
>
> But I haven't spent enough time to look at the patch to determine
> if one of these two possible changes is correct. All I can say is
> that dropping that single commit fixes the test failure for me and
> seems to cause now new failures.
