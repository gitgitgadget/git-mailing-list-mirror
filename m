From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack operation is thrashing my server
Date: Sun, 07 Sep 2008 10:41:51 -0700
Message-ID: <7vljy3n99c.fsf@gitster.siamese.dyndns.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
 <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
 <7vbpz0r8gb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0809071310030.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcOI9-0007VB-81
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYIGRmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbYIGRmI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:42:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbYIGRmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:42:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DD6278848;
	Sun,  7 Sep 2008 13:42:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 72FAA78845; Sun,  7 Sep 2008 13:41:54 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0809071310030.23787@xanadu.home> (Nicolas
 Pitre's message of "Sun, 07 Sep 2008 13:11:36 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 49EA179A-7D04-11DD-BA86-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95157>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 6 Sep 2008, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> ...
>> > Which it does - but the patch kind of violates that whole design.
>> >
>> > Now, it so happens that things seem to work, probably because the zlib 
>> > format does have enough synchronization in it to not try to continue past 
>> > the end _anyway_, but I think this makes the patch be of debatable value.
>> 
>> I thought the fact we do check the status with Z_STREAM_END means that we
>> do already expect and rely on zlib to know where the end of input stream
>> is, and stop there (otherwise we say something fishy is going on and we
>> error out), and it was part of the design, not just "so happens" and "has
>> enough synch ... _anyway_".
>> 
>> If input zlib stream were corrupted and it detected the end of stream too
>> early, then check of "stream.total_out != size" would fail even though we
>> would see "st == Z_STREAM_END".  If input stream were corrupted and it
>> went past the end marker, we will read past the end and into some garbage
>> that is the in-pack header of the next object representation, but zlib
>> shouldn't go berserk even in that case, and would stop after filling the
>> slop you allocated in the buffer --- we would detect the situation from
>> stream.total_out != size and most likely st != Z_STREAM_END in such a
>> case.
>
> Unless I'm missing something, I think your analysis is right and 
> everything should be safe.

I obviously agree with you but what I forgot to mention in the above is
that we also make sure stream.avail_in is set not to overrun the end of
the current pack window (or the entire loose object data that is
mmapped).
