From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3030: fix accidental success in symlink rename
Date: Fri, 25 Mar 2011 10:42:05 -0700
Message-ID: <7v1v1v6qs2.fsf@alter.siamese.dyndns.org>
References: <20110325160013.GA25851@sigill.intra.peff.net>
 <20110325160326.GA26635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Ken Schalk <ken.schalk@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3B1l-0005Mb-Os
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1CYRmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 13:42:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab1CYRmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 13:42:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B6ED4691;
	Fri, 25 Mar 2011 13:44:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U2DWydbwmtpm3kVWuWWA6fLoI7c=; b=ABYK47
	ckWRXLnfE8HxZ1kBGeP0kO/vjDhIYNyjJ8nMonsB2xe8qjp1/2zio/Tg6jpYCPQ/
	RxvFueXXulikljxGKCQI5AYDrMwJlvKvXfkKgOgFNi3Icbkz2wDYBbkfM+MD8KXH
	jm6hXSBQNnlZdfREPcz4gSRM4EaxVmgOp9gz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jmDCa/PMQK6OtoEFLszaUWu7ufgfIPER
	jvWFiRKPUhbzX0hWcCO4kMhh02Hc5+lTnMp9sIGUEhCrrY61xTUuE6X2w1Mcqz0w
	m/7wmvS6syYiAF7nAg4MMBm0seG/srBYZ/Gr6WPzHbUNpZgaHBaoFitx3+xNKrh+
	L783siyVths=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0996E468B;
	Fri, 25 Mar 2011 13:43:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F64A4680; Fri, 25 Mar 2011
 13:43:49 -0400 (EDT)
In-Reply-To: <20110325160326.GA26635@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 25 Mar 2011 12:03:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 745A8BC4-5707-11E0-8D69-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170001>

Jeff King <peff@peff.net> writes:

> In this test, we have merge two branches. On one branch, we
> renamed "a" to "e". On the other, we renamed "a" to "e" and
> then added a symlink pointing at "a" pointing to "e".

I read this five times but still couldn't figure out that you meant that
the other side 'added a symlink "a" to allow people keep referring to "e"
with the old name "a"' until I actually read the actual test you are
describing here.

Besides, /we have merge/s/have//, I think.

> The results for the test indicate that the merge should
> succeed, but also that "a" should no longer exist. Since
> both sides renamed "a" to the same destination, we will end
> up comparing those destinations for content.
>
> But what about what's left? One side (the rename only),
> replaced "a" with nothing. The other side replaced it with a
> symlink. The common base must also be nothing, because any
> "a" before this was meaningless (it was totally unrelated
> content that ended up getting renamed).
>
> The only sensible resolution is to keep the symlink.

I agree.

We should treat structural changes and do a 3-way on that, and then
another 3-way on content changes, treating them as an independent thing.
One side has "create 'e' out of 'a', removing 'a'" and "_create_ 'a', that
is unrelated to the original 'a'", the other side has "create 'e' out of
'a', removing 'a'", so the end result should be that we do both,
i.e. "create 'e' out of 'a', removing 'a'" and "create 'a'".  At the
content level, the result in 'e' may have to be decided by 3-way.  The
result in 'a' should be a clean merge taken from the former "with b/c
link" branch, as this is not even a create (by the side that added a
backward compatibility symbolic link) vs a delete (by pure-rename side)
conflict.
