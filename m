From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git merge driver / attributes bug in 2.3.1?
Date: Fri, 06 Mar 2015 13:30:24 -0800
Message-ID: <xmqqlhj9yftb.fsf@gitster.dls.corp.google.com>
References: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
	<54F98EBE.8080903@drmicha.warpmail.net>
	<D8780C527EB1E642B3150E6D705B46D448E8058B@DWPWHMS531.dwpbank.local>
	<54F9B5C0.9050604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Gondek\, Andreas" <Andreas.Gondek@dwpbank.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 22:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTzpJ-0006ha-8f
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 22:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbbCFVa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 16:30:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751276AbbCFVa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 16:30:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF27E3E788;
	Fri,  6 Mar 2015 16:30:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y8N5zCeWz46QCwy/pA5wDaNEVY4=; b=mo/ff0
	ILC0XMdsgzNj8nf2gKpuMcrXm4eGf4w1zCscMwEa5d1gwSUVG0a9bpo4n1Yaj50s
	JHrCmMt5fVFJmgV2P5b1fUAD/MBPncg24fCtBOy2pUKEUb5UzZrbTwbcSYSV8/UN
	lQWa1K0LMYr4ChPWGfhiDSwyHxK+aPhdwiGt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D1ONPR/og1X+1H6NMamtJFpP1N/9yE8t
	JK3Hq/yHcY/J9R8BcfAN58KAnmcsQZO2xlhfxipEgqQV/Y3asGq7T3GNUzKNyMdS
	fhCL6rTnFRPy7Jpe7libuEcmKBHamd9KHWpu4Oe/mVo7OB07WZoucU7M8OZdvdpg
	PNHGsTzVXEg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7F0F3E787;
	Fri,  6 Mar 2015 16:30:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 290A23E786;
	Fri,  6 Mar 2015 16:30:26 -0500 (EST)
In-Reply-To: <54F9B5C0.9050604@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 06 Mar 2015 15:12:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0106AC22-C448-11E4-9C73-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264964>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Gondek, Andreas venit, vidit, dixit 06.03.2015 14:31:
>> The archive contains my test repository, the merge driver and the
> .gitconfig of the user. We don't have a global .gitconfig.
>
> Thanks for the test repo!
>
> Alas, the merge driver gets executed with v1.9.0-rc3, v1.8.5 and v1.7.0,
> at least over here - as it should be because of the conflict: two
> patches changing the same file. That conflict can be resolved
> automatically by the internal driver, of course.

That matches my expectation.  The whole point to have the merge
driver plug-in mechanism is to allow overriding the internal textual
3-way file-level merge, so we would have always called out to the
custom driver when the tree-level merge machinery says that the
content needs a file-level merge [*1*].


[Footnote]

*1* This is a tangent, but I've been wondering if we want some cases
where the tree-level merge machinery currently says that there is no
need for file-level merge to be fed to the merge driver.

Specifically, the tree-level merge machinery considers a case where
you and the other party changed the files identically to be cleanly
merged, but for contents of certain nature, that may not be always
desirable.

Imagine that I and my wife are sharing a note to record what is in
our refrigerator.  After I buy a carton of milk, I'd do

    $ echo "1 carton of milk" >>fridge.txt
    $ git commit && git push

and my wife would do the same.

    $ echo "1 carton of milk" >>fridge.txt
    $ git commit && git push

which would not fast-forward, and then she would

    $ git pull

which would result in only one carton of milk in our fridge, even
though when both of us got home, we will realize that we now have
two of them.
