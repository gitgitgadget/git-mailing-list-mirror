From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 09/16] Read index-v5
Date: Wed, 08 Aug 2012 09:49:54 -0700
Message-ID: <7vr4rhtjkd.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-10-git-send-email-t.gummerer@gmail.com>
 <7v4nog1twd.fsf@alter.siamese.dyndns.org>
 <20120808074138.GD867@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:50:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz9SO-0002Zu-49
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 18:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758887Ab2HHQt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 12:49:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab2HHQt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 12:49:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3040982BC;
	Wed,  8 Aug 2012 12:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zbmHngzznWF5B+XMr0wi6OOdhg8=; b=hH6jyI
	47IGAlAdSxuw3tBSWUyZ9vL7vfRqpPkfJkOWl9UNsjyqtUzA/r2pNB/p3BvjP2V6
	c79S3wB6Uyubz4k/JnoCOhbKxLUZJuYNUo0MfGH57oBnXiynjb2wKNLTYye85utR
	9W648kng/ta39uM3Rs2/ljXbp0N6xB36SOglI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JiIcoIhlBqvvhqmcpX0oshivV81s3jfo
	E/uMIou/HoCypsGIYFt66adbRurcMCXkEwVtYWP6nbpBD5JV093e394xcLNS0kDM
	msHehCXon8GG+kXk2MeVsTXIptDVEyyb49meovk4VaAgJkv5hTJiYkt26kthSvdW
	3vW1xTS7CBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD2282BB;
	Wed,  8 Aug 2012 12:49:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EDEC82B8; Wed,  8 Aug 2012
 12:49:56 -0400 (EDT)
In-Reply-To: <20120808074138.GD867@tgummerer.surfnet.iacbox> (Thomas
 Gummerer's message of "Wed, 8 Aug 2012 09:41:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1563B926-E179-11E1-BD60-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203098>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> > +	name = (char *)mmap + *dir_offset;
>> > +	beginning = mmap + *dir_table_offset;
>> 
>> Notice how you computed name with pointer arithmetic by first
>> casting mmap (which is "void *") and when computing beginning, you
>> forgot to cast mmap and attempted pointer arithmetic with "void *".
>> The latter does not work and breaks compilation.
>> 
>> The pointer-arith with "void *" is not limited to this function.
> ...
> I've used the type of the respective assignment for now. e.g. i have
> struct cache_header *hdr, so I'm using
> hdr = (struct cache_header *)mmap + x;

You need to be careful when rewriting the above to choose the right
value for 'x' if you go that route (which I wouldn't recommend).

With

    hdr = ptr_add(mmap, x);

you are making "hdr" point at x BYTES beyond mmap, but

    hdr = (struct cache_header *)mmap + x;

means something entirely different, no?  "hdr" points at x entries
of "struct cache_header" beyond mmap (in other words, if mmap[] were
defined as "struct cache_header mmap[]", the above is saying the
same as "hdr = &mmap[x]").

I think the way you casted to compute the value for the "name"
pointer is the (second) right thing to do.  The cast (char *)
applied to "mmap" is about "mmap is a typeless blob of memory I want
to count bytes in.  Give me *dir_offset bytes into that blob".  It
is not tied to the type of LHS (i.e. "name") at all.  The result
then needs to be casted to the type of LHS (i.e. "name"), and in
this case the types happen to be the same, so you do not have to
cast the result of the addition but that is mere luck.

The next line is not so lucky and you would need to say something
like:

    beginning = (uint32_t *)((char *)mmap + *dir_table_offset);

Again, inner cast is about "mmap is a blob counted in bytes", the
outer cast is about type mismatch between a byte-address and LHS of
the assignment.

If mmap variable in this function were not "void *" but something
more sane like "const char *", you wouldn't have to have the inner
cast to begin with, and that is why I said the way you did "name" is
the second right thing.  Then you can write them like

    name = mmap + *dir_offset;
    beginning = (uint32_t *)(mmap + *dir_offset);

After thinking about this, the ptr_add() macro might be the best
solution, even though I originally called it as a band-aid.  We know
mmap is a blob of memory, byte-offset of each component of which we
know about, so we can say

    name = ptr_add(mmap, *dir_offset);
    beginning = ptr_add(mmap, *dir_offset);

Hmmm..
