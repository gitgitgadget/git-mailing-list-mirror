Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E6F20179
	for <e@80x24.org>; Sun, 19 Jun 2016 06:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbcFSGSY (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 02:18:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751422AbcFSGSX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 02:18:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B9502171C;
	Sun, 19 Jun 2016 02:18:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fgT30JSOO30Yc2+yXfQXTqAI1Xk=; b=sf1hSg
	OZmSEHY2dvnTKFTjHZ/I6hggMEXr/2zrF8bAwviSf5GEXDWF2XEcmX29wM1+nJYC
	CX4yUMJweaG3uSGlfoRGVJ5VbbOVIAZGUNUqRAmPMMi272KLa53ihxKLw3V2KjsQ
	ltj4rieGarUzZAH4TvAyYfrl+AKf6JdZsV7z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hogvPa7ZxSv+yMh3FOc3PenF/6AGarKR
	r1pbSChxo0f80lUZgRDVe0ZYHm6VRRmot8aKawHJXr/Vt4AR0fP5Yz1YWPIQFIoH
	I0qxFICPg54zCBvdTRqnyl2AkzmVNaSUArlE0JYiZqEBWYFl9an6agQLZRdbqeZ3
	MvLiCDahmUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13FF32171B;
	Sun, 19 Jun 2016 02:18:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A42F52171A;
	Sun, 19 Jun 2016 02:18:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Turner <novalis@novalis.org>
Cc:	Emily Xie <emilyxxie@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pathspec: prevent empty strings as pathspecs
References: <20160619005704.1771-1-emilyxxie@gmail.com>
	<xmqqmvmhyiut.fsf@gitster.mtv.corp.google.com>
	<576623F7.3020700@novalis.org>
Date:	Sat, 18 Jun 2016 23:18:14 -0700
In-Reply-To: <576623F7.3020700@novalis.org> (David Turner's message of "Sun,
	19 Jun 2016 00:47:51 -0400")
Message-ID: <xmqq60t5ya55.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F3E4DFE-35E5-11E6-83D9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> The help for rev-parse --show-prefix says:
> "When the command is invoked from a subdirectory, show the path of
> the current directory relative to the top-level directory."
>
> This doesn't say what it does when invoked at the top-level.  Maybe we
> should just change it to output "./", which would make such scripts
> work?  It would not necessarily fix all possible scripts, but it would
> fix these.  It seem odd to insist on preserving this undocumented
> behavior of git add/rm.

For two obvious reasons, you do not want to go there.

As you seem to understand in the above, "--show-prefix" was given
merely as an example, so updating its behaviour would not change the
fundamental problem with the patch under discussion at all.  It will
break scripts that knew, documented or not, that pathspec match is a
prefix substring match that honors directory boundary and an empty
string is defined long time ago to match any path and it does not
matter if that definition was made by mistake.

Also, if you change "--show-prefix" output, documented or not, that
will break other scripts that knew that checking it against an empty
string is a valid way to check if you are already at the top level
of the working tree.  And I highly suspect that such a change is
much harder to advertise and warn existing scripts, compared to the
change proposed by the patch under discussion.  The output routine
in show-prefix knows what it is giving to the caller, but does not
know how the caller uses it and what for.  Compared to that, ...

>> At least you would need two-step process to introduce a change like
>> this to warn the people whose tools and workflows you are breaking.
>> That is, (1) in one release, you add code to only detect the case
>> you will be changing the behaviour in a later version and give
>> warning messages, and (2) in another release that is several release
>> cycles later, stop warning and actually change the behaviour.

... is a lot easier transition (again, assuming that this change is
worth doing in the first place).
