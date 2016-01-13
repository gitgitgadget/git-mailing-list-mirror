From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work as expected
Date: Wed, 13 Jan 2016 09:20:08 -0800
Message-ID: <xmqqh9ihpfav.fsf@gitster.mtv.corp.google.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
	<cover.1452585382.git.johannes.schindelin@gmx.de>
	<7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de>
	<5695E4FB.2060705@web.de> <56967CA3.7040103@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP5n-0004iS-B3
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbcAMRUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:20:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932153AbcAMRUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:20:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 588FF3A89F;
	Wed, 13 Jan 2016 12:20:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UK1/GvVolZ1iX4YeG5PU8BUv3I0=; b=GcEHk0
	oBdoBtIB8oVbXEOcnYTHuDOoNHiTPOe3BnXBgBB6e68JZH4N8soce8tQRqq2ztOc
	uBz4J5+YjnflGUmUiPzU0vjkdtKocUR6dY1khCax+4x1+Z/9vdSrgaH8XOy7+MWl
	5x6bPoMBeBfuS/CNP5G/BJhrh+zHHKI1UKOBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TuieL55q5zLldj7uEDKPo50BwtgvKqI5
	LVjf2eUQRCh8Ob3WlIDswgdRjwHtMAgB9BT1mm+dXo8QuZuWDj9/AddONJpbGn90
	YYlR1dlclwkQttVdjxUF7Z0o+IMbOqTSY1lFPknYAVJmhriQZvsY5nD1wNcx6ENz
	7qPIOk6MoE8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FE043A89E;
	Wed, 13 Jan 2016 12:20:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BEE53A89C;
	Wed, 13 Jan 2016 12:20:09 -0500 (EST)
In-Reply-To: <56967CA3.7040103@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 13 Jan 2016 16:34:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5C58294-BA19-11E5-AAD0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283946>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> This particular section documents what is almost certainly a bug
> in the cygwin basename() and also documents my choice of 'fix'.
> (ie. in my implementation I chose to return '/' for '//', which
> is one of the possible options that POSIX allows.)
> ...
> POSIX says, in part [1]:
>
>     If the string pointed to by path consists entirely of the '/' character,
>     basename() shall return a pointer to the string "/". If the string pointed
>     to by path is exactly "//", it is implementation-defined whether '/' or "//"
>     is returned.
>
> [1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.html
>
> So we should expect other systems to differ, even if they support POSIX. (and maybe
> not just this test case.)

Doesn't that mean the test shouldn't be insisting on the output
being one that you arbitrarily pick?  It feels to me that it is
wrong to say "We require // to become / unless we know we are on
such and such systems".  Instead, shouldn't it be doing "We feed //
to the function.  Either / or // is acceptable; any other value is a
bug"?

It is tempting to have a "check" feature to the test program for the
curious which one of the two acceptable results a particular platform
(or more precisely, implementation of basename/dirname) produces, but
I do not think "test" feature should insist on / and reject //.
