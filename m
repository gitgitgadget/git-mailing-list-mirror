From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Efficient parsing of `status -z` output
Date: Sun, 08 Mar 2015 00:14:06 -0800
Message-ID: <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com>
References: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthew Rothenberg <mrothenberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:14:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUWLr-0008Ec-Us
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 09:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbbCHION (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 04:14:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751382AbbCHIOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 04:14:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E85C37A98;
	Sun,  8 Mar 2015 04:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3cJIeNcjvbqnxv2Mr7Wkb4Mh9/c=; b=eKVV8k
	p9moEwhQQE0p9TkckvvqKQDBlz6VmbI3P6iWeAu8p7yPToG/mzqYcfeqa0pSyyTD
	OLFNq46on1j5GE4/4ELPYTOlRV3O0zYMw3x8BI0r7XqGc4XUeW2b8tWpIMLRYI+B
	flsRUNE/UnmcI2StZzhB6twGkqAlAUKLnTZ7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTNuh34bqGu0iGs4Zsw4k9CT9QU14Mbi
	OM//O1wNHtGUqNJxvj740coIdHEdkyyOHNjKmWVVVl4JYN3ueZCQSl8r8SyM5Os9
	mcN9m8tlsHmBBvps6+1Si3D3i27Epc+zCB4uGKE1qvRc/C9DDCmKRF4GsKlOf8+O
	cIvDl6tm4r4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 655D437A97;
	Sun,  8 Mar 2015 04:14:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D617A37A96;
	Sun,  8 Mar 2015 04:14:07 -0400 (EDT)
In-Reply-To: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
	(Matthew Rothenberg's message of "Sat, 7 Mar 2015 18:00:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 17C4DB72-C56B-11E4-91F7-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265046>

Matthew Rothenberg <mrothenberg@gmail.com> writes:

>  2. Read from buffer until the first NUL, parse the entry status
> codes, and if the entry status code represents a status that *should*
> have multiple filenames, read from buffer until a second NUL is found,
> and then reparse that entry with both filenames. The issues I see with
> this approach:
>    a.) One has to know exactly which status code combinations will end
> up with two filenames, and this list has to be exhaustive. As far as I
> can tell, there is no canonical documentation for this?
>    b.) It seems a bit brittle, because if the logic from the above is
> wrong and we miss an extended entry or ask for one when it doesn't
> exist we will leave the buffer an essentially corrupt state for future
> reads.

I think this is how -z was designed to be used, and if that isn't
clear, then the documentation must be updated to clarify.  Rename
and Copy are the only ones that needs two pathnames, and I suspect
that whoever did the original description of the short format in the
documentation knew Git too well that he forgot to mention it ;-)
