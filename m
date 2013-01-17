From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Thu, 17 Jan 2013 17:02:09 +0000
Message-ID: <20130117170209.GF4574@serenity.lan>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <1358376443-7404-2-git-send-email-apelisse@gmail.com>
 <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
 <20130117110008.GD4574@serenity.lan>
 <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:02:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvsrV-00028j-5E
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 18:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab3AQRCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 12:02:24 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:51272 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab3AQRCX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 12:02:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 78CF222FE1;
	Thu, 17 Jan 2013 17:02:22 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SI+kXIqYSCN; Thu, 17 Jan 2013 17:02:21 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 1B09F22FDA;
	Thu, 17 Jan 2013 17:02:20 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E1436161E591;
	Thu, 17 Jan 2013 17:02:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qcEhAqpWXSf; Thu, 17 Jan 2013 17:02:20 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EEAA9161E58A;
	Thu, 17 Jan 2013 17:02:11 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213859>

On Thu, Jan 17, 2013 at 08:44:20AM -0800, Linus Torvalds wrote:
> On Thu, Jan 17, 2013 at 3:00 AM, John Keeping <john@keeping.me.uk> wrote:
>>
>> There's also a warning that triggers with clang 3.2 but not clang trunk, which
>> I think is a legitimate warning - perhaps someone who understands integer type
>> promotion better than me can explain why the code is OK (patch->score is
>> declared as 'int'):
>>
>> builtin/apply.c:1044:47: warning: comparison of constant 18446744073709551615
>>     with expression of type 'int' is always false
>>     [-Wtautological-constant-out-of-range-compare]
>>         if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~
> 
> The warning seems to be very very wrong, and implies that clang has
> some nasty bug in it.
> 
> Since patch->score is 'int', and UNLONG_MAX is 'unsigned long', the
> conversion rules for the comparison is that the int result from the
> assignment is cast to unsigned long. And if you cast (int)-1 to
> unsigned long, you *do* get ULONG_MAX. That's true regardless of
> whether "long" has the same number of bits as "int" or is bigger. The
> implicit cast will be done as a sign-extension (unsigned long is not
> signed, but the source type of 'int' *is* signed, and that is what
> determines the sign extension on casting).
> 
> So the "is always false" is pure and utter crap. clang is wrong, and
> it is wrong in a way that implies that it actually generates incorrect
> code. It may well be worth making a clang bug report about this.

The warning doesn't occur with a build from their trunk so it looks like
it's already fixed - it just won't make into into a release for about 5
months going by their timeline.

Thanks for the clear explanation.
