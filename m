From: Mike Hommey <mh@glandium.org>
Subject: Re: pack operation is thrashing my server
Date: Sun, 7 Sep 2008 09:45:44 +0200
Organization: glandium.org
Message-ID: <20080907074544.GA23488@glandium.org>
References: <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home> <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org> <7vk5dorclv.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 09:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcEzv-00055A-Cq
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 09:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYIGHqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 03:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYIGHqa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 03:46:30 -0400
Received: from vuizook.err.no ([194.24.252.247]:41637 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbYIGHq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 03:46:29 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KcEy8-0003u5-Eh; Sun, 07 Sep 2008 09:46:06 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KcExs-0006Vp-3u; Sun, 07 Sep 2008 09:45:44 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95124>

On Sat, Sep 06, 2008 at 06:46:29PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 6 Sep 2008, Junio C Hamano wrote:
> > 
> > This is reproducible  "rev-list --objects --all" in my copy of the kernel
> > repo takes around 47-48 seconds user time, and with the (idiotic) patch it
> > is cut down to 41-42 seconds.
> 
> So I had forgotten about that patch since nobody reacted to it.
> 
> I think the patch is wrong, please don't apply it, even though it does 
> help performance.
> 
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
> 
> I'm starting to hate zlib. I actually spent almost a week trying to clean 
> up the zlib source code and make it something that gcc can compile into 
> clean code, but the fact is, zlib isn't amenable to that. The whole "shift 
> <n> bits in from the buffer" approach means that there is no way to make 
> zlib generate good code unless you are an insanely competent assembly 
> hacker or have tons of registers to keep all the temporaries live in.
> 
> Now, I still do think that all my reasons for choosing zlib were pretty 
> solid (it's a well-tested piece of code and it is _everywhere_ and easy to 
> use), but boy do I wish there had been alternatives. 

I know at least 7-zip has its own gzip compression/decompression code
(though it's C++). Maybe some other tools have theirs too.

Anyways, if it can make a speed difference, it might be worth having a
minimalist custom gzip compression/decompression "library" embedded
withing git.

Mike
