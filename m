From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Sat, 6 Sep 2008 18:46:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org> <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 03:51:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc9Qf-0006Yx-N0
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 03:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYIGBr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 21:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYIGBr1
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 21:47:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59275 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753222AbYIGBr0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2008 21:47:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m871kUj0004852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Sep 2008 18:46:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m871kTPS014469;
	Sat, 6 Sep 2008 18:46:29 -0700
In-Reply-To: <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95100>



On Sat, 6 Sep 2008, Junio C Hamano wrote:
> 
> This is reproducible  "rev-list --objects --all" in my copy of the kernel
> repo takes around 47-48 seconds user time, and with the (idiotic) patch it
> is cut down to 41-42 seconds.

So I had forgotten about that patch since nobody reacted to it.

I think the patch is wrong, please don't apply it, even though it does 
help performance.

The reason? 

Right now we depend on "avail_out" also making zlib understand to stop 
looking at the input stream. Sad, but true - we don't know or care about 
the compressed size of the object, only the uncompressed size. So in 
unpack_compressed_entry(), we simply set the output length, and expect 
zlib to stop when it's sufficient.

Which it does - but the patch kind of violates that whole design.

Now, it so happens that things seem to work, probably because the zlib 
format does have enough synchronization in it to not try to continue past 
the end _anyway_, but I think this makes the patch be of debatable value.

I'm starting to hate zlib. I actually spent almost a week trying to clean 
up the zlib source code and make it something that gcc can compile into 
clean code, but the fact is, zlib isn't amenable to that. The whole "shift 
<n> bits in from the buffer" approach means that there is no way to make 
zlib generate good code unless you are an insanely competent assembly 
hacker or have tons of registers to keep all the temporaries live in.

Now, I still do think that all my reasons for choosing zlib were pretty 
solid (it's a well-tested piece of code and it is _everywhere_ and easy to 
use), but boy do I wish there had been alternatives. 

			Linus
