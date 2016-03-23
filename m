From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward slashes
Date: Wed, 23 Mar 2016 09:34:56 -0700
Message-ID: <xmqqpoulcfv3.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de>
	<xmqqbn66iedh.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1603230821420.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:35:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ailkQ-0003qj-St
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 17:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbcCWQfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 12:35:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751430AbcCWQe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 12:34:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F3524E199;
	Wed, 23 Mar 2016 12:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XfG61OsbjJUzcUczmfW2nwBLh2Y=; b=GcU5ft
	IuFix+XeiQQFLzy5RXbfT2F6x52krh92WLK2FFP058hyyEw/srfNGcars1kA1Gio
	Ih9hITfoWCZs/g6TQURndCCsReqi9D4lA6nPzjUVAsMy+TJ9FdLGVUmxkT88Q1gz
	S6tGPTyDMLXcmsB61Y86xKD3H/ZckeWaRiOEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZWSCGiUVxiegbuCX8JTuZVaVzpH1oe6+
	ElKsDrLFAfL81SEikIgHia46aHPUmV7WCmW0/qfd73fW1EX3IbeiLB9uPUGjTjdV
	rhjDjZ8o7ileV7VwnR7XJb9GLEryX3t7yRmYKp1i597JV2JyS8QA4Tms61cr0DfK
	gJqR2D1u9Rs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26FB54E197;
	Wed, 23 Mar 2016 12:34:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E9BB4E196;
	Wed, 23 Mar 2016 12:34:57 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603230821420.4690@virtualbox> (Johannes
	Schindelin's message of "Wed, 23 Mar 2016 09:20:27 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E4124A6-F115-11E5-B65E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289667>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > diff --git a/path.c b/path.c
>> > index 8b7e168..969b494 100644
>> > --- a/path.c
>> > +++ b/path.c
>> > @@ -584,6 +584,9 @@ char *expand_user_path(const char *path)
>> >  			if (!home)
>> >  				goto return_null;
>> >  			strbuf_addstr(&user_path, home);
>> > +#ifdef GIT_WINDOWS_NATIVE
>> > +			convert_slashes(user_path.buf);
>> > +#endif
>> 
>> Hmm, I wonder if we want to do this at a bit lower level,
>
> Well, I tried to be careful. There *are* circumstamces when backslashes
> are required (CreateProcess() comes to mind), so I wanted to have this
> conversion as much only in the user-visible output as possible.

I was able to guess that it would be the reason, and I was willing
to accept this as a short-term workaround.

As you are very well aware, the usual pattern we use is to implement
a higher level function (e.g. expand_user_path() in this case) in
terms of helpers that offer abstraction of implementation details
that may be platform specific (e.g. getenv() may be implemented
differently on Windows).  An "#ifdef" in otherwise platform agnostic
codepath like this one is a sign that the code is not well thought
out to find the right abstraction to use to follow that pattern.

I was mostly reacting to that "#ifdef" and thinking aloud what the
right abstraction is appropriate.  As a short-term workaround, the
above would have to do.

And no, I do not think convert_slashes() that becomes no-op on
non-windows platforms is the right abstraction.
