From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] format-patch --signature-file <file>
Date: Thu, 22 May 2014 13:52:45 -0700
Message-ID: <xmqqtx8hmt7m.fsf@gitster.dls.corp.google.com>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
	<1400723589-8975-3-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 22:53:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnZz4-00039i-9L
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 22:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaEVUwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 16:52:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60534 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbaEVUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 16:52:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78B751986F;
	Thu, 22 May 2014 16:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=84vGed6+YLpuK0QAJ4WlFJtHWsg=; b=c5FGDA
	VjNgd62oiF/b+snsBfqAAaF1jEEHMJFFnZeWcknMcj0OiK6IQq/36hvnTX7zVThi
	RCVXGjBIG3FB/3a3ATIIH2W/Hm85yawULXRNvUxa5qSE4zKf0/yJg0D1hN4A5Wp2
	rr3DX6VZSp45iMOC8INCkVTceJEJy7T4BmxDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=km0DjDtCroIZZvJXWcN35hOTo+yC7CgP
	sZYYS8m++gZiCoZ9IRBE4CJX6yDyCVs2mKj/hGr2P0mP4vK0xq+TFMckgMazMpMJ
	+PL1e+w46CBm7ylSICxl8joatnkGUMM7tjflHUteWyl3y0TMTNtrjxvSqKH+XfnE
	kh/rU6ujZ0k=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D7801986E;
	Thu, 22 May 2014 16:52:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5291E1986A;
	Thu, 22 May 2014 16:52:47 -0400 (EDT)
In-Reply-To: <1400723589-8975-3-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Wed, 21 May 2014 18:53:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07AF7226-E1F3-11E3-8B18-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249944>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Added option that allows a signature file to be used with format-patch
> so that signatures with newlines and other special characters can be
> easily included.

s/Added option/Add an option/.  I do not think "with newlines and
other special characters" is the primary issue---isn't it more about
"I have chosen to use this mail-signature; do not force me to retype
the same all the time"?

>   $ git format-patch --signature-file ~/.signature -1

The recommended command-line convention (see gitcli(7)) is to use
"--option=value", so an example would be better to follow it, i.e.

    $ git format-patch -1 --signature-file=$HOME/.signature

> The config variable format.signaturefile is also provided so that it
> can be added by default.
>
>   $ git config format.signaturefile ~/.signature
>   $ git format-patch -1

Something like:

    To countermand the configuration variable for a specific run:

	$ git format-patch -1 --signature="This time only"
        $ git format-patch -1 --signature    ;# to use the default
        $ git format-patch -1 --signature="" ;# to add nothing

is also needed here, I think.  Similarly, these two needs to be
tested in the test scripts you are modifying.  Specifically:

> +test_expect_success 'format-patch --no-signature and --signature-file OK' '
> +	git format-patch --stdout --no-signature --signature-file=mail-signature -1
> +'

should not just make sure "format-patch" does _something_, but needs
to make sure it does not contain the contents of the configured mail
signagture file.

I didn't see offhand if the tests make sure that a configured mail
signature can be overriden from the command line.  I think you would
want to test, with format-patch.signature-file pointing at the
mail-signature file, at least these three cases:

 - Run "format-patch --no-signature" and make sure that stops the
   contents from mail-signature file from being shown, and instead
   no mail-signature is given.

 - Run "format-patch --signature='this time only'" and make sure
   that stops the contents from mail-signature file from being shown
   and "this time only" is used instead.

 - Run "format-patch --signature-file=another-mail-signature" and
   make sure that stops the contents from mail-signature file from
   being shown and the contents from the other file is used instead.

Test for these "negative cases" is often what we forget, when we are
thrilled to show off that the shiny new feature works as expected.
We need to ensure that the ways to stop the shiny new feature from
kicking in will not be broken as well.

Thanks.
