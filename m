From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 0/21] pack bitmaps
Date: Sat, 16 Nov 2013 11:28:28 +0100
Message-ID: <87k3g8ljxv.fsf@linux-k42r.v.cablecom.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<5285224A.2070606@ramsay1.demon.co.uk>
	<20131114213320.GA16466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 16 11:29:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhd7i-0004y8-Tm
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 11:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab3KPK2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 05:28:48 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38002 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab3KPK2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 05:28:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 9698B4D6570;
	Sat, 16 Nov 2013 11:28:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ba3e4VxT5Zxe; Sat, 16 Nov 2013 11:28:31 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EB7BE4D6414;
	Sat, 16 Nov 2013 11:28:30 +0100 (CET)
In-Reply-To: <20131114213320.GA16466@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 16:33:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237928>

Jeff King <peff@peff.net> writes:

>> >   - the ewah code used gcc's __builtin_ctzll, but did not provide a
>> >     suitable fallback. We now provide a fallback in C.
>> 
>> I was messing around with several implementations (including the use of
>> msvc compiler intrinsics) with the intention of doing some timing tests
>> etc. [I suspected my C fallback function (a different implementation to
>> yours) would be slightly faster.]
>
> Yeah, I looked around for several implementations, and ultimately wrote
> one that was the most readable to me. The one I found shortest and most
> inscrutable was:
>
>   return popcount((x & -x) - 1);

In two's complement, -x = ~x + 1 [1].  If you have a bunch of 0s at the
end, as in (binary; a=~A etc)

           x = abcdef1000

then

          ~x = ABCDEF0111
 ~x + 1 = -x = ABCDEF1000

      (x&-x) = 0000001000
  (x&-x) - 1 = 0000000111

popcount() of that is the number of trailing zeroes you started with.

Please don't ask me to work out what happens in border cases; my head
hurts already.


[1] because x + ~x is all one bits.  +1 makes it overflow to 0, so that
x + -x = 0 as it should.

-- 
Thomas Rast
tr@thomasrast.ch
