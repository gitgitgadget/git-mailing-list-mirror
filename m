From: Junio C Hamano <gitster@pobox.com>
Subject: Re: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 13:55:28 -0700
Message-ID: <xmqqy47fc7y7.fsf@gitster.mtv.corp.google.com>
References: <20160512182432.GA27427@kitenet.net>
	<xmqq7fezdoe7.fsf@gitster.mtv.corp.google.com>
	<20160512204634.GA9292@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Thu May 12 22:55:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xdw-0000EE-AA
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcELUzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:55:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751216AbcELUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:55:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A5C01A830;
	Thu, 12 May 2016 16:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dr6X7817SbnK0ZrAtpmwD+WjWzI=; b=TMifUj
	jjZ/XaqstemZXCh7h9sRxZzt59n0SHBl4tJVGqX1Z9rcPXlDFdMJqVtHpVYB+h4z
	0Wd/Mu6nMCcBfkGerDX8ab/7cv2IsntirV3Hzb08pbfPU5B5S/WV7TUdr7+oI9c9
	G0ukDgW+xbqy8+mH1W7UaII6VUK8em0sDrQGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=luBvbxp1/di7xIbuxS6l1byq6w3vUTBj
	wnTeRxXetYApPvUtGSJCmK052grjUWcs9lXcrtuBe0Rh1sSHMnNFj7vWU4KzLY7d
	M1JWBv8IrKiCvOzJPoPEWu1Dlc6fSina0F/9Z7ziZeqaB94/R7xV5gSE2y6K+uK/
	TwMLKAwwJ10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 236751A82F;
	Thu, 12 May 2016 16:55:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 912CB1A82C;
	Thu, 12 May 2016 16:55:30 -0400 (EDT)
In-Reply-To: <20160512204634.GA9292@kitenet.net> (Joey Hess's message of "Thu,
	12 May 2016 16:46:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DCD42AAA-1883-11E6-A2E6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294475>

Joey Hess <id@joeyh.name> writes:

> Junio C Hamano wrote:
>> This side, I do not think we even need a new variant.  We can just
>> update the code to interact with "clean" so that it the writer to
>> the pipe ignores SIGPIPE, detects EPIPE on write(2), says "ah, the
>> other end does not need the full input to produce its output".  The
>> reader from the pipe consumes its output without failing AS LONG AS
>> the "clean" filter exits with zero (we do check its exit status,
>> right?)
>
> There are two problems with doing that. First, any clean filter that
> relied on that would not work with older versions of git.

That's a fair point.

> Secondly, and harder to get around, the filename passed to the clean
> filter is not necessarily a path to the actual existing file that is
> being cleaned.

Either one of us is confused.  I was talking about updating the
current "clean" implementation without changing its interface,
i.e. gets fed via its standard input, expected to respond to its
standard output.  There is no filename involved.

And yes, "clean-from-fs" that is spawned by us with the name of the
file in the filesystem that has the contents as its argument, must
be prepared to see a filename that does not have any relation to the
filename in the working tree.
