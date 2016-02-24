From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is sloppy
Date: Wed, 24 Feb 2016 13:23:10 -0800
Message-ID: <xmqqtwkxsszl.fsf@gitster.mtv.corp.google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
	<1456284017-26141-3-git-send-email-sbeller@google.com>
	<xmqqa8mpub1y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYv-dKMnON=Hj2fUNEbUXz=8ti3x3tNG2WxWmdr5CA2tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:23:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgu7-0001Fz-67
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbcBXVXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:23:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752057AbcBXVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:23:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8C4346B4D;
	Wed, 24 Feb 2016 16:23:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iHr4yEoqpG2UeRQtH8vliyfMOJ4=; b=qHcw0k
	HPg+/QJd7tT6c9VxHY3VcBNKqADq/lcSksHHT9sRKDwi6HBQlLOsYiTX46+yVR/t
	rYdgZsC/AxuAwv4SegFtVaGbieunZ8jRLWd1F+U37GBRnOt+dB+HRMpBJAhDZV6a
	lsWuwD05xS8diq3JCdJm1U6nMcg5umqfpIvI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lAGOZhqmWkbFUA3SuBE8CqEvYkC3qtls
	5UxhrYSHW/GJApR4pCSFJIg+UL8kaOkAZiK05/Xog8Okl/Kj0dizkwTtTN65ZxEh
	qeLm23htttxvUiu0V02PUUbGhq/Ux2Qe1GjhOizkVk9I8sdd5xp5t7xFlliqxLNQ
	p/tV3ZHFEF0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFA3E46B4C;
	Wed, 24 Feb 2016 16:23:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29B7E46B49;
	Wed, 24 Feb 2016 16:23:11 -0500 (EST)
In-Reply-To: <CAGZ79kYv-dKMnON=Hj2fUNEbUXz=8ti3x3tNG2WxWmdr5CA2tA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 24 Feb 2016 13:19:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE6E828C-DB3C-11E5-8FB8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287232>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 24, 2016 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The inconsistency may not hurt as long as (1) the producers of the
>> message will never stuff a NUL in the middle, and (2) strbuf always
>> has the guard NUL after its contents.  Even though we know that the
>> latter will hold true for the foreseeable future, it also is easy to
>> do the right thing here, too, so why not?
>
> What is the right thing? I asked myself and obviously it is treating the
> child->err the same in both cases of checking for a trailing LF and
> when outputting.
>
> But what is the right way to look at child->err? I would argue that
> we should allow for children to have a NUL in its output stream and
> replay their output as literal as possible.
>
> i.e. my conclusion is to replace the fputs by fwrite as opposed to
> using strlen to determine the length of string output.

Yup, that is what I meant; sorry if I were too oblique.

There are two fputs() that assumes there is no embedded NUL around
there, by the way.

Thanks.
