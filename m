From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] drop unnecessary copying in credential_ask_one
Date: Tue, 07 Jan 2014 11:44:00 -0800
Message-ID: <xmqqlhyrd1bz.fsf@gitster.dls.corp.google.com>
References: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
	<20140102030330.GA10976@sigill.intra.peff.net>
	<20140102073835.GA5431@sigill.intra.peff.net>
	<xmqq7gaiqjzw.fsf@gitster.dls.corp.google.com>
	<20140107175009.GA19691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:44:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cZS-0004MV-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbaAGToL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:44:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbaAGToI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:44:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8FC25F35A;
	Tue,  7 Jan 2014 14:44:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ejY8KpGnuFtT8M11+i9mG0EHAZo=; b=MQZ8BC
	sioYNZe/dgB41+FYGCZdPpwG9I6WB/PCTmvs3bIQuwJcvK4py79KhdRZ1J7Tx/tU
	v82n0QRvVAujbOiR63bhFd4mqZaOXa3R0n/MWTmWNmmEg4+tSAouOmSnXXYnQvZo
	Azrv928LD5aaAJfneOJfLo3KXzTtNZVXzsTcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9aaWVUcFvFWy+reaG6iDA6D8NIhoS6B
	2tD52i09AVttNKbXjydE3fylrU08Pe4mIMcgNLynnTHa2QjJL8o2P54Gmyd1Srr5
	6TO4Usry2lKZyDG0l+QHcoi2PxU7ssQ8rYfeIbEX1gm2SOVFn/+Y5A54zJ33VEMl
	lcy6L45fUpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C005F358;
	Tue,  7 Jan 2014 14:44:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 328E75F352;
	Tue,  7 Jan 2014 14:44:06 -0500 (EST)
In-Reply-To: <20140107175009.GA19691@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 12:50:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 118847AC-77D4-11E3-98B1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240136>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 02, 2014 at 11:08:51AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > ... But the test suite, of course, always uses askpass because it
>> > cannot rely on accessing a terminal (we'd have to do some magic with
>> > lib-terminal, I think).
>> >
>> > So it doesn't detect the problem in your patch, but I wonder if it is
>> > worth applying the patch below anyway, as it makes the test suite
>> > slightly more robust.
>> 
>> Sounds like a good first step in the right direction.  Thanks.
>
> I took a brief look at adding "real" terminal tests for the credential
> code using our test-terminal/lib-terminal.sh setup. Unfortunately, it
> falls short of what we need.
>
> test-terminal only handles stdout and stderr streams as fake terminals.
> We could pretty easily add stdin for input, as it uses fork() to work
> asynchronously.  But the credential code does not actually read from
> stdin. It opens and reads from /dev/tty explicitly. So I think we'd have
> to actually fake setting up a controlling terminal. And that means magic
> with setsid() and ioctl(TIOCSCTTY), which in turn sounds like a
> portability headache.

I wonder if "expect" has already solved that for us.

> So it's definitely possible under Linux, and probably under most Unixes.
> But I'm not sure it's worth the effort, given that review already caught
> the potential bug here.
>
> Another option would be to instrument git_terminal_prompt with a
> mock-terminal interface (say, reading from a file specified in an
> environment variable). But I really hate polluting the code with test
> cruft, and it would not actually be testing an interesting segment of
> the code, anyway.

Agreed.
