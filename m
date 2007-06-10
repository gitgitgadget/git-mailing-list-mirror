From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Sun, 10 Jun 2007 19:40:00 +1200
Message-ID: <466BAAD0.9060408@vilain.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com> <20070509191052.GD3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxI29-0006Ng-9i
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761693AbXFJHkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761654AbXFJHkU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:40:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49203 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761621AbXFJHkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:40:19 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 5C8EF13A4FA; Sun, 10 Jun 2007 19:40:16 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id DAFB313A4F4;
	Sun, 10 Jun 2007 19:40:11 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070509191052.GD3141@spearce.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49662>

Shawn O. Pearce wrote:
>> On that note, has any thought been given to looking at other compression 
>> algorithms? Gzip is a great high-speed compressor, but there are others 
>> out there (some a bit slower, some much slower at both compression and 
>> decompression) that produce substantially smaller output.
>>     
> Its been discussed once before on the list, in very recent history,
> but not by a whole lot.  As Junio pointed out, I don't think there
> ever really was any discussion of is gzip the best way to deflate the
> objects.  I think gzip was just chosen simply because it was readily
> available in libz, stable, and has a pretty decent speed/size ratio.
>   

I think it's the right tool. I just don't see any point in changing to
anything slower for the sake of 20% space saving. Especially bzip2.

Consider this.

Compression works primarily through two things: huffman coding and
string matching. The larger the window for your string matching, the
slower the compression and the more memory you need thrashing your CPU
memory cache when decompressing.

Now I'm not an expert on compression algorithms but I think a large part
of the reason gzip is blindingly faster than bzip2 is because gzip uses
a 64k buffer and bzip2 a 900k one. Only now are CPUs getting caches
large enough to deal with that size of buffer, the rest of the time
you're waiting for your RAM. Moore's law was supposed to make bzip2 fast
one of these days but I'm still waiting.

But with git-repack the window is effectively the size of your
repository. So that blows bzip2 out of the water. Why else can git make
compressed packs smaller than a .bz2 of the raw files? This is the same
observation Shawn makes with the pack-wide dictionary, but he sounds
like he wants to apply it to the huffman coding stage as well as the
current delta/string matching stage. Now that would be interesting...

Anyway it's a free world so be my guest to implement it, I guess if this
was selectable it would only be a minor annoyance waiting a bit longer
pulling from from some repositories, and it would be interesting to see
if it did make a big difference with pack file sizes.

Sam
