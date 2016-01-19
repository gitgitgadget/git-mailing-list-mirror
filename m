From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 15:00:52 -0800
Message-ID: <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<20160119191234.GA17562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:01:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfGk-0002Zx-L7
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbcASXA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:00:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932414AbcASXAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:00:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA71D3D3E3;
	Tue, 19 Jan 2016 18:00:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JvJAr4a0zY6idHFO6HMjdGC9eOE=; b=wVsBB7
	wLISKaKH0zqdSFMP4qKCg+3GXe2eVV17Z/IiWjoP+gzwuS4tm7epE8cqHYMkzpib
	piuiz9mG+beXVOwj3+8gV0XC3HMSMjyKbPpBHb/ER+/ZUu/n3I61exhDzYXsRB0A
	YcFsJp7wiT1wgGDlFQZTguaI3UCZ62MMWo3AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xf1vKNOR6Q743gge7oESyM8APy2/XDCT
	ngnNJqXHaQmXs9q7QdhGnpb3Ji0B72gk86Hvwz89NPG5/8tLlFlAgB0NKQPNULKt
	N2KMoXBSIJEuwCXAH4IkCWmKc9DhOZCJsLTcoQ2i9cSGS/gqwx7SsLHOnuiyABP+
	3seDD2bWRVA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E23373D3E2;
	Tue, 19 Jan 2016 18:00:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 656833D3E1;
	Tue, 19 Jan 2016 18:00:53 -0500 (EST)
In-Reply-To: <20160119191234.GA17562@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Jan 2016 14:12:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DB077B8-BF00-11E5-8C2A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284392>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 19, 2016 at 10:24:29AM +0100, larsxschneider@gmail.com wrote:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Use the Travis-CI cache feature to store prove test results and make them
>> available in subsequent builds. This allows to run previously failed tests
>> first and run remaining tests in slowest to fastest order. As a result it
>> is less likely that Travis-CI needs to wait for a single test at the end
>> which speeds up the test suite execution by ~2 min.
>
> Thanks, this makes sense, and the patch looks good.
>
>> @@ -18,7 +22,7 @@ env:
>>      - P4_VERSION="15.2"
>>      - GIT_LFS_VERSION="1.1.0"
>>      - DEFAULT_TEST_TARGET=prove
>> -    - GIT_PROVE_OPTS="--timer --jobs 3"
>> +    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>
> Have you tried bumping --jobs here? I usually use "16" on my local box.

I think 3 comes from this:

  http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279674

>
> I also looked into the Travis "container" thing. It's not clear to me
> from their page:
>
>   https://docs.travis-ci.com/user/workers/container-based-infrastructure/
>
> whether we're using the new, faster container infrastructure or not.
> ...
> depends on when Travis "recognized" the repo, but I'm not quite sure
> what that means. Should we be adding "sudo: false" to the top-level of
> the yaml file?

In an earlier discussion

  http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279495

I found that we were not eligible for container-based sandbox as the
version of travis-yaml back then used "sudo".  I do not seem to find
the use of sudo in the recent one we have in my tree, so it would be
beneficial if somebody interested in Travis CI look into this.
