From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.h: add includes of "diff.h" and "commit.h"
Date: Sun, 05 Apr 2009 01:02:09 -0700
Message-ID: <7v3acnzfy6.fsf@gitster.siamese.dyndns.org>
References: <20090404214554.75ada117.chriscool@tuxfamily.org>
 <20090405162841.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 10:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqNKn-0004FB-B5
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 10:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076AbZDEICa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 04:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758074AbZDEIC3
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 04:02:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757839AbZDEIC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 04:02:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DA87A8A23;
	Sun,  5 Apr 2009 04:02:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DF129A8A1F; Sun,
  5 Apr 2009 04:02:13 -0400 (EDT)
In-Reply-To: <20090405162841.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sun, 05 Apr 2009 16:28:41 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18F17BE8-21B8-11DE-87C4-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115639>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Christian Couder <chriscool@tuxfamily.org>:
>
>> Because they are needed by some features included in
>> "revision.h".
>>
>> This makes the following just work:
>>
>>         $ cat >1.c <<\EOF
>>         #include "cache.h"
>>         #include "revision.h"
>>         EOF
>>         $ cc -Wall -DSHA1_HEADER='<openssl/sha.h>' -c 1.c
>
> I'm sorry if this is obvious to experienced people, but I don't understand what benefit there is to make such an empty program compilable.

I believe this was prompted by my earlier comment on the header clean-up
($gmane/115443), but I'd say it does not make much sense.  I have already
explained why it doesn't, and in addition, as the above example shows, you
still have to include "cache.h" in your 1.c file anyway, so it is not
making the header "usable standalone" either.

If you have a follow-up patch that removes the inclusion of diff.h and
commit.h to millions of .c files that already include revision.h, it might
start to make sense, but it goes against one of the rules Christian wanted
to add, namely:

    a header file should be included in a C file only if it is needed to 
    compile the C file (it is not ok to include it only because it includes 
    many other headers that are needed)

in the sense that if somebody wants to run diff in his C code, he should
explicitly include diff.h (or diffcore.h if necessary), instead of relying
on the fact that revision.h happens to include it, and he happens to
include revision.h because he uses setup_revisions() to parse the command
line arguments (and I happen to think that guideline makes sense).

Even though including the same .h file twice is protected with the
standard:

	#ifndef FROTZ_H
        #define FROTZ_H
        ...
        #endif

it does make C preprocessor do extra work to open the header twice (and
skip the whole file in its second inclusion), so there is a slight
performance issue.

You can argue revision.h is somewhat special---it are so central that
almost all core-ish history inspection commands in git revolve around
them, and it is not particularly a bad idea to say "you can rely on
revision.h to include diff.h" in practice.  That would give you an escape
hatch to omit inclusion of diff.h from programs that include revision.h
and avoid the performance issue.

But then that introduces new rules on which ones are special and which
ones are not, and overall it does not help simplifying the life of the
programmers.

So I do not feel strongly supportive about this patch.
