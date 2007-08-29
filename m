From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Wed, 29 Aug 2007 12:26:07 -0700
Message-ID: <7vsl62p2gg.fsf@gitster.siamese.dyndns.org>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
	<7vy7fxyy52.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708291339580.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 21:26:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQTBf-0007az-3v
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 21:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXH2T0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbXH2T0Z
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 15:26:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbXH2T0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 15:26:24 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CDF62128FE4;
	Wed, 29 Aug 2007 15:26:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708291339580.16727@xanadu.home> (Nicolas
	Pitre's message of "Wed, 29 Aug 2007 14:21:33 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56972>

Nicolas Pitre <nico@cam.org> writes:

>> > Instead of treating the "the last used one happened to be on the
>> > horizon -- try not to drop it" special case, I wonder if it
>> > makes sense to float the last used delta base object early in
>> > the window _after_ it is used.  Wouldn't we keep more than one
>> > very recently used delta base objects in the window that way?
>> 
>> The attached is my quick-and-dirty one.  
>
> I like this.  A LRU sorting of base objects is obviously a good thing to 
> do.  Some comments below.

Well, I said it is Q&D, because _I_ didn't like what I did ;-).

The original implementation of window as a plain array of
"struct unpacked" made perfect sense because its use was strict
FIFO.  Adding new element and expiring oldest element was just
an increment of the "idx" integer, and there was no memmove
overhead.

If we are to make this into LRU (which I _do_ like), however,
the data structure's circular FIFO origin makes the code
unnecessary complex and inefficient, I think.

 - We can always say 0 is the bottom and (window-1) is the top.
   Then ((idx+1)%window) becomes unnecessary.  As a bonus, we do
   not have to disagree if it should be (window <= idx) or (idx
   >= window).

 - Shifting elements down to make room can become a single
   memmove() if we remove the circular FIFO origin from the
   window implementation.  The Q&D one has tons of structure
   assignments in each iteration.  It might even make sense to
   change the window itself an array of "struct unpacked *" and
   make LRU management into just memmove() of bunch of pointers.
