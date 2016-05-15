From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] crlf: Add test showing double warning on commit
Date: Sun, 15 May 2016 11:55:22 -0700
Message-ID: <xmqqshxj5exx.fsf@gitster.mtv.corp.google.com>
References: <20160514111755.GG2345@dinwoodie.org>
	<baea5604-e786-5773-aa68-f311efb23752@web.de>
	<xmqqoa887a25.fsf@gitster.mtv.corp.google.com>
	<55965a71-7078-60ad-0746-6f677dbb3f06@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 20:55:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b21CS-0007wN-SX
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 20:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbcEOSz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 14:55:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160AbcEOSzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 14:55:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 735F818146;
	Sun, 15 May 2016 14:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T6cIotZszA1d
	0uysZfilvk96A5E=; b=bP4KnCJV+CYTw9pij5Q/b7kSZdEoWt/zPuo34MGcIEP6
	Kcpo/O/m9iGppfiMKw6RWhJCzjWf4Tv3NFIIg7vxPxNYzHEvD37HGvTYDDBOFtKj
	+mWqzhEG+79T4BLRmUpZWPAso+psSMGl28Aqw8dtcBQVzjQNDRHnYdAW3JtIjhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LHkjT+
	muUGw0h5C5M2D9bDpmxmWSaIX7XLXAS3vOwF5VXWAN0pIbwc8KH3G1ueUEGcsxuK
	e5K4jtS0UEJ3fSQVd0OQUgcZmRGLmT+s/UwiuPKVMfhxx9Yl0V9qVXsSWcET5u7N
	5hoHkC2/hhB60hHUhQuete1RSZC2f+mXzYs2g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A9C218145;
	Sun, 15 May 2016 14:55:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5A8A18144;
	Sun, 15 May 2016 14:55:23 -0400 (EDT)
In-Reply-To: <55965a71-7078-60ad-0746-6f677dbb3f06@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 15 May 2016 08:39:31
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 949184A2-1ACE-11E6-A7AF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294677>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Nja, (Or Nyes in English), the old handling tried to be "nice" to the=
 user:
> $ git add text # gave warning
> #User forgets, does other things, git reset HEAD....
> $ git commit # Gave the warning one more time, to remind the user,=20
>              # what he did, and what is really commited.
>
> But it may be, that diff_populate_filespec() is the wrong place for s=
peaches ?

It is *not* necessarily a wrong place for speeches, but certainly it
is wrong place to talk about whatever convert_to_git() does.

Let's step back and think what the warning is about.

I personally feel that "CRLF will be turned into LF" is pointless
when the user expressed her preference "I want to have LF in the
repository and CRLF in the working tree, when it makes sense".  It
is not even a warning but merely reports "we did what we were told
to do."  But for those who set safecrlf=3Dwarn to get that warning, we
should give the warning when we actually convert the the working tree
contents and strip CR from CRLF before recording it as an object.

An as-is "git commit" (nothing on command line affects the index
with working tree contents, e.g. "-a" or pathspec) does not do any
such conversion.  The "damage" the user requested to be warned has
long been done before the command is run.

So the warning from "git add" is good, but it shouldn't appear from
anything that does "diff".
