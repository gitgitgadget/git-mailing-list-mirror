From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unused #include statements
Date: Thu, 15 Jan 2015 10:50:45 -0800
Message-ID: <xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
	<CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
	<20150115063307.GA11028@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Robert Schiele <rschiele@gmail.com>,
	Zoltan Klinger <zoltan.klinger@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:51:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBpVe-0003WO-GP
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbbAOSvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:51:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755770AbbAOSus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:50:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74FD92FC7F;
	Thu, 15 Jan 2015 13:50:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t7jaw+CgS9CbFvrrGGyzt/i7N0Q=; b=Kg/J2y
	4NJHZYUMbc35dRPCSf/r1AyPqjdXGOLz/gwWwUtvpjUPv2RsoTZhqZcOdxtFpAY5
	pTKcfBDy+ORn+M/9sv2FFO0rG5KeI842vtAtOZ0GoMPjqNiX7IcHnDGuSIPGDY8V
	c0obuHtV7pTJW0GX76pBtQhaN9SBHm9bjwnkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uA02QDoENSU4xMIgo4JgAoeNcaOV1UEB
	VW+UI2MoOcZQgvv3PO+zIvHUHWd5FAezV66AkoKd6cfqVHb9zS3QTAp//T7QbkUn
	NQ8DJYTvhpjj9ZSmGUlQ8ACp4CeilKhd90SdG1BSt5NqVPOtEPDR169CGOns5iJd
	ycXN8jzO19I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 643DE2FC7E;
	Thu, 15 Jan 2015 13:50:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B15B12FC7D;
	Thu, 15 Jan 2015 13:50:46 -0500 (EST)
In-Reply-To: <20150115063307.GA11028@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 01:33:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A93DCC4-9CE7-11E4-B0A6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262499>

Jeff King <peff@peff.net> writes:

> One of our rules is that git-compat-util.h (or one of the well-known
> headers which includes, cache.h or builtin.h) is included first in any
> translation unit.

Perhaps by now we can spell it out a bit more explicitly and update
CodingGuidelines.  We have:

 - The first #include in C files, except in platform specific
   compat/ implementations, should be git-compat-util.h or another
   header file that includes it, such as cache.h or builtin.h.

"such as" might be making things unnecessarily vague; I do not think
a valid reason why we should say a .c file that includes "advice.h"
as the first thing satisfies this requirement, for example.

Because:

 - A command that interacts with the object store, config subsystem,
   the index, or the working tree cannot do anything without using
   what is declared in "cache.h".

 - A built-in command must be declared in "builtin.h", so anything
   in builtin/*.c must include it.

it may be reasonable to say the first *.h file included must be one
of git-compat-util.h, cache.h or builtin.h (and then we make sure
that compat-util is the first thing included in either of the latter
two).

While I very much agree with the principle Robert alluded to [*1*],
we may want to loosen that for .c files that include "builtin.h" or
"cache.h" for the sake of brevity.  For example, if you are builtin
(hence you start by #include "builtin.h"), it may be reasonable to
allow you to take whatever is in "cache.h" for granted [*2*].

So the rule might be:

 - The first #include in C files, except in platform specific
   compat/ implementations, must be either git-compat-util.h,
   cache.h or builtin.h.

 - A C file must directly include the header files that declare the
   functions and the types it uses, except for the functions and
   types that are made available to it by including one of the
   header files it must include by the previous rule.

Optionally, 

 - A C file must include only one of "git-compat-util.h", "cache.h"
   or "builtin.h"; e.g. if you include "builtin.h", do not include
   the other two, but it can consider what is availble in "cache.h"
   available to it.

Thoughts?  I am not looking forward to a torrent of patches whose
sole purpose is to make the existing C files conform to any such
rule, though.  Clean-up patches that trickle in at a low rate is
tolerable, but a torrent is too distracting.


[Footnote]

*1* For example, even though "diff.h" may include "tree-walk.h" for
its own use, a .c file that includes "diff.h" without including
"tree-walk.h" that uses update_tree_entry() or anything that is
declared in the latter is very iffy from semantic point of view.

*2* Because that facility is so widely used inside the codebase,
"builtin.h" includes "strbuf.h", so in addition to what are in
"cache.h", we may want to allow builtin implementations to take
strbufs for granted as well.
