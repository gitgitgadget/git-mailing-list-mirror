From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all requested bytes
Date: Tue, 20 Aug 2013 11:27:51 -0700
Message-ID: <xmqq8uzw6wuw.fsf@gitster.dls.corp.google.com>
References: <521333AE.1090506@kdbg.org>
	<xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
	<CALWbr2yaQaCte6+Y3GEa8Hxyhq6GPS64aTNzkGo8pdpcd9ZVUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqf0-0000Fr-5O
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab3HTS14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:27:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab3HTS1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:27:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C670139117;
	Tue, 20 Aug 2013 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/UAI3d5g1RKL6JfId9oBD7Tb520=; b=PFoknp
	5XYGfAq2nCJD5HOYmBCMsD6ELAMkQ+Zg3lBhoLwwz3uQoxSItFxxrIweu+qWD3BR
	4hrOJEyxtyXHRwxcJT/12/I+FLiuct69dqULuZrcKZ92D2j+sWIHXkcND0G+QsVh
	J1XPLIZx0azelGUxlvx3wAcxVN4JwxO+SotFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTx41BZj99tN6uJnJs1Xr0oW+9iMpY0P
	IW5cZO2jyVnY8ZenJAQUNmozQmBAcsdznxQp9UvWPPOQycuMS8BBkT8GS+x/LC1U
	7MdVoNhiIefxOMocxdiJWEDUoGqU+/emQmcAiXfkPjWSouJohkfkSzeEIBZwn0wk
	zpY5o/LnWFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5E4139116;
	Tue, 20 Aug 2013 18:27:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210D439111;
	Tue, 20 Aug 2013 18:27:53 +0000 (UTC)
In-Reply-To: <CALWbr2yaQaCte6+Y3GEa8Hxyhq6GPS64aTNzkGo8pdpcd9ZVUg@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 20 Aug 2013 17:16:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 39EFBCCE-09C6-11E3-803D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232624>

Antoine Pelisse <apelisse@gmail.com> writes:

> I was actually wondering when it's better to use xread() over
> read_in_full()?

When the caller wants to do more control over a read that may have
to loop.  For example, this loop in builtin/index-pack.c::fill()

	do {
		ssize_t ret = xread(input_fd, input_buffer + input_len,
				sizeof(input_buffer) - input_len);
		if (ret <= 0) {
			if (!ret)
				die(_("early EOF"));
			die_errno(_("read error on input"));
		}
		input_len += ret;
		if (from_stdin)
			display_throughput(progress, consumed_bytes + input_len);
	} while (input_len < min);

cannot be replaced blindly with read_in_full() because (1) the
caller wants to do the "display_throughput()" part in the loop, and
(2) the caller wants to fill at least "min" bytes but can happily
accept to read more up to the size of the input_buffer.
