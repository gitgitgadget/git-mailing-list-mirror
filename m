From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack operation is thrashing my server
Date: Sat, 06 Sep 2008 19:33:24 -0700
Message-ID: <7vbpz0r8gb.fsf@gitster.siamese.dyndns.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 04:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcA71-0004UJ-4g
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 04:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYIGCdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 22:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbYIGCdh
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 22:33:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbYIGCdh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 22:33:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F4D377A05;
	Sat,  6 Sep 2008 22:33:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1A75977A04; Sat,  6 Sep 2008 22:33:26 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sat, 6 Sep 2008 18:46:29 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EDE6874-7C85-11DD-8D3F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95104>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The reason? 
>
> Right now we depend on "avail_out" also making zlib understand to stop 
> looking at the input stream. Sad, but true - we don't know or care about 
> the compressed size of the object, only the uncompressed size. So in 
> unpack_compressed_entry(), we simply set the output length, and expect 
> zlib to stop when it's sufficient.
>
> Which it does - but the patch kind of violates that whole design.
>
> Now, it so happens that things seem to work, probably because the zlib 
> format does have enough synchronization in it to not try to continue past 
> the end _anyway_, but I think this makes the patch be of debatable value.

I thought the fact we do check the status with Z_STREAM_END means that we
do already expect and rely on zlib to know where the end of input stream
is, and stop there (otherwise we say something fishy is going on and we
error out), and it was part of the design, not just "so happens" and "has
enough synch ... _anyway_".

If input zlib stream were corrupted and it detected the end of stream too
early, then check of "stream.total_out != size" would fail even though we
would see "st == Z_STREAM_END".  If input stream were corrupted and it
went past the end marker, we will read past the end and into some garbage
that is the in-pack header of the next object representation, but zlib
shouldn't go berserk even in that case, and would stop after filling the
slop you allocated in the buffer --- we would detect the situation from
stream.total_out != size and most likely st != Z_STREAM_END in such a
case.

While I think 5% is large enough, I'll leave this on the backburner for
now.  I think it is more grave issue that we inflate the same object many
times as you noticed during the discussion.
