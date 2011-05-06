From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git failure on HP-UX - more data
Date: Fri, 06 May 2011 13:11:36 -0700
Message-ID: <7vliyjzj0n.fsf@alter.siamese.dyndns.org>
References: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
 <7vfwot6k7a.fsf@alter.siamese.dyndns.org>
 <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF67E@GVW1362EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>,
	"kibler\@psyber.com" <kibler@psyber.com>
To: "Kibler\, Bill" <bill.kibler@hp.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:11:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIRNV-0003UR-0y
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 22:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1EFULw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 16:11:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab1EFULv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 16:11:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F5995528;
	Fri,  6 May 2011 16:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8G3pvR7LiI1P3NfmAspXrWN7O/c=; b=R6U6Jp
	VAHWKd0mH2f6DbIeEDMyS6ZAwtWnjkxkCri1mnrpY2iMuS/8i5K/kmTcS4q+J6Ds
	2rj4NHvL5nHWonHwxSXnUHM2gl4sJhJYoGVupp81eMOaHTtyUhoiHbjsXR/fYLVP
	xETmRR+GyvCf72Bh2n1vnjmBwI642Tq8tih9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rr6IBtYMF2ovwNBM9/u+LvmB5lHWJCZY
	H9QhsTz3x2st7GyEOgzvUl+IQwJG+VSOifC7kUU9eebkMuqRy+ZMw9bsAuyhylIY
	rhamA7NLpMmXdTw9+cGvSvfTuLrlqgTpOa+8RhdBO0vFn6b5R9A6uOqMgQesftmn
	qa3pzZEzT2o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54B195527;
	Fri,  6 May 2011 16:13:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E5E1B5526; Fri,  6 May 2011
 16:13:41 -0400 (EDT)
In-Reply-To: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF67E@GVW1362EXC.americas.hpqcorp.net>
 (Bill Kibler's message of "Fri, 6 May 2011 19:02:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59882F22-781D-11E0-8DC0-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173004>

"Kibler, Bill" <bill.kibler@hp.com> writes:

> I just ran several tests on hp-UX using various values for the
> "LARGE_PACKET_MAX", ...

The original sideband protocol had a fixed receiver side buffer that was
only 1000 bytes long.  When we updated the protocol so that we can carry
more payload with a single logical pkt-line format, which has the maximum
packet length of a bit less than 64k (it has a fixed 4 hexadecimal digits
field at the front that indicates its size, so the maximum payload size is
64k minus 4 or something like that), we added a protocol extension that is
negotiated between the server and the client for both sides to make sure
that they have the updated implementation in which the receiver is
prepared to accept a 64k packet, not just a small 1000-byte static buffer.

But all of that is at the logical protocol level.

Even if the transfer goes over the Ethernet, this size is in no way
limited by its MTU of 1500 bytes, because the kernel will take care of
buffering and reassembling for us.

It is the same deal for the pkt-line protocol, where we issue a write(2)
and expect that the system may write less than what we asked it to write,
and return us how many bytes it has actually written. As long as write(2)
correctly returns the number of bytes it wrote, and our code that calls
write(2) correctly expects a short-write and loops until writing
everything out, there is no need to worry about LARGE_PACKET_MAX.

At least, that is the theory.

I think already said this in my previous message to you, but it is
possible that we have a bug in our code that fails to expect write(2) to
result in short-write and loop until we write everything out.  My gut
feeling is that it is slightly more plausible that we have such a bug than
that your libc has a buggy implementation of write(2) that returns a bogus
value (say 64k) when in fact it wrote only what would fit in your pipe
buffer (you said 8k, I think) when asked to write 64k.

And the right thing to do is to find and fix such a bug. I am afraid you
are wasting your time by futzing LARGE_PACKET_MAX. Even if you find a good
small value that happens to work on _your_ machine, it would not be a real
fix for the problem.
