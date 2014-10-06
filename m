From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] config: Add safe-include directive
Date: Mon, 06 Oct 2014 10:58:36 -0700
Message-ID: <xmqq7g0djd0z.fsf@gitster.dls.corp.google.com>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
	<1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
	<1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk>
	<CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
	<878uktwnqs.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:58:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbCYb-00005q-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 19:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbaJFR6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 13:58:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50896 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753065AbaJFR6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 13:58:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF8F213BFF;
	Mon,  6 Oct 2014 13:58:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DY8KiTJlWfDZ+pbgy0/NXqW+Uk=; b=DuKxxE
	LdUu9LTQSbO2PDcxHvZHkwd0QsNrdMlWHuqJe65n41fBu1Odb1+P5dIOU6DEJnYb
	7d+Ktd2ne88NxTDpJiyLJNYPWnYwg8kYm7i1HUXpq5pyBakalw+idUKSRoMXnG4Q
	RHF4qIxvuQDhX24yd71C1g1/4qRI1rufzD5Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cmGFBUXBOjBE+18KlKvzqRULzvPOC2qP
	YSWSVRf1ziWAtCP/6dD63nzY3GrnzjX4/DhXQQMJk+F9jPHKn6aBo+Z3vtUiFWgE
	Rgvx7RSF9uAek789izmUOe+QRGWh1JD7VexldxDsK+xjfSeMndoOok3anf1l8PbS
	JzdIz4pBuU4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D723B13BFE;
	Mon,  6 Oct 2014 13:58:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 428FA13BF8;
	Mon,  6 Oct 2014 13:58:37 -0400 (EDT)
In-Reply-To: <878uktwnqs.fsf@rasmusvillemoes.dk> (Rasmus Villemoes's message
	of "Mon, 06 Oct 2014 11:28:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 658E1B2C-4D82-11E4-AB87-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257911>

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> (by the way, we do not do dashes in names for configuration by
>> convention)
>
> OK. Actually, I now think I'd prefer a subsection [include "safe"], but
> I don't have any strong preferences regarding the names.

I think Peff mentioned something about having the second level
between include and path, so I'll defer it to him.

>> That syntax _could_ be just a relative path (e.g. project.gitconfig names
>> the file with that name at the top-level of the working tree), and if we are
>> to do so, we should forbid any relative path that escapes from the working
>> tree (e.g. ../project.gitconfig is forbidden, but down/down/../../.gitconfig
>> could be OK as it is the same as .gitconfig). For that matter, anything with
>> /./ and /../ in it can safely be forbidden without losing functionality.
>
> I agree that it would be most useful to interpret relative paths as
> being relative to the working tree. I'm not sure what would be gained by
> checking for ./ and ../ components, a symlink could easily be used to
> circumvent that.

If the "limit to the the working tree" is the reason to suggest a
relative path to be taken as relative to the working tree, which my
suggestion clearly was, the reader should be intelligent enough to
infer that an implementation working in that mode should make sure
symlinks and any other means do not step outside it.

And as you noticed that, you apparently are ;-)

> One might (ab)use the feature to only use some settings from a global
> file, e.g.
>
> [include "safe"]
>     whitelist = !foo.*
>     path = ~/extra.gitconfig

You do not have to write something you do not want to use in your
own ~/extra.gitconfig that is under your $HOME/, so I'd prefer to
explicitly forbidding such a use case at least in the beginning.
