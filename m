From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically update it
Date: Fri, 11 Apr 2014 12:24:22 -0700
Message-ID: <xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
	<xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
	<CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYh3u-0005WY-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbaDKTY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:24:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbaDKTYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:24:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C5717A17C;
	Fri, 11 Apr 2014 15:24:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ok1BM4x0rbJ8ls8oFtLblhSIkuo=; b=QBi4Tk
	o+8mBeeMNpHUbTdofMmA4cEcV7Zad/8vi3xoThoFlfL1Xcs2syno+D7TZmzDmY/U
	ycTxwyjzr8aZCTeYWFn+KfYOAk8+DjayJHt3HfwiZLvObAId11Yg5XewIcAPfWNX
	U3myLsh5pPWYGqh0Auvbyky68TCwWiLpLDtGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ikZSJBF3giSW+KQIfLMCeKjuP02VrEX2
	WWSlerObQmO21dA14e0dt6z7EjxyxqsLXw3wz72+wwhkcDlvuWq1enQGihPXMOUg
	BhEVIpkauTZOpOxtUcp9HCLQuF1bgjIZ7xzBXKiHT+jDXSg5WZNvCjzagon6GzyA
	GHlHYagvjzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA717A178;
	Fri, 11 Apr 2014 15:24:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D20C67A175;
	Fri, 11 Apr 2014 15:24:23 -0400 (EDT)
In-Reply-To: <CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 11 Apr 2014 09:57:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3A1AC82-C1AE-11E3-8C86-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246132>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Apr 11, 2014 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Yiannis Marangos <yiannis.marangos@gmail.com> writes:
>>
>>> +     n = xpread(fd, sha1, 20, st.st_size - 20);
>>> +     if (n != 20)
>>> +             goto out;
>>
>> I think it is possible for pread(2) to give you a short-read.
>>
>> The existing callers of emulated mmap and index-pack are prepared to
>> handle a short-read correctly, but I do not think this code does.
>>
>> I'll queue this instead in the meantime.
>
> There are two things to sort out (sorry I can't spend much time on it
> right now): should the same sha1 test be done in write_index(), in
> addition to update_index_if_able(). And what do we do about
> istate->sha1[] in discard_index(), keep it or clear it.

Yeah, I was hoping that the real write codepath (as opposed to "this
is read only and we read the index without holding a lock---now we
noticed that the index needs refreshing, and we know how the
resulting refreshed index should look like, perhaps we can write it
to save cycles for other processes" codepath where we cannot and
should not take a lock early) would take the lock and then read, but
because that is not the way they work, the need the same protection,
I would think.  As discard_index() is not "we are removing all the
entries because the user told us to 'rm -r .'" but is "for the
purpose of our internal processing we do not need the old contents
of the index", my knee-jerk reaction is that we should not clear it.

Any operation that makes the resulting index empty (i.e. no path
being tracked) should still write an empty index (with the usual
header and the most importantly the trailing file checksum), but
that goes without saying.
