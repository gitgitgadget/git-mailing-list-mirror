From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Sun, 07 Sep 2008 13:11:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809071310030.23787@xanadu.home>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcNoe-0007Xa-Px
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbYIGRLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYIGRLn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:11:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14316 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYIGRLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:11:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6U00FAM53CR520@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Sep 2008 13:11:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vbpz0r8gb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95152>

On Sat, 6 Sep 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > The reason? 
> >
> > Right now we depend on "avail_out" also making zlib understand to stop 
> > looking at the input stream. Sad, but true - we don't know or care about 
> > the compressed size of the object, only the uncompressed size. So in 
> > unpack_compressed_entry(), we simply set the output length, and expect 
> > zlib to stop when it's sufficient.
> >
> > Which it does - but the patch kind of violates that whole design.
> >
> > Now, it so happens that things seem to work, probably because the zlib 
> > format does have enough synchronization in it to not try to continue past 
> > the end _anyway_, but I think this makes the patch be of debatable value.
> 
> I thought the fact we do check the status with Z_STREAM_END means that we
> do already expect and rely on zlib to know where the end of input stream
> is, and stop there (otherwise we say something fishy is going on and we
> error out), and it was part of the design, not just "so happens" and "has
> enough synch ... _anyway_".
> 
> If input zlib stream were corrupted and it detected the end of stream too
> early, then check of "stream.total_out != size" would fail even though we
> would see "st == Z_STREAM_END".  If input stream were corrupted and it
> went past the end marker, we will read past the end and into some garbage
> that is the in-pack header of the next object representation, but zlib
> shouldn't go berserk even in that case, and would stop after filling the
> slop you allocated in the buffer --- we would detect the situation from
> stream.total_out != size and most likely st != Z_STREAM_END in such a
> case.

Unless I'm missing something, I think your analysis is right and 
everything should be safe.


Nicolas
