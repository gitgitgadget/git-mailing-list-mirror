From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 15:39:07 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
 <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4Be-00056J-T1
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 21:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbYAJUjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 15:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYAJUjK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 15:39:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15014 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYAJUjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 15:39:09 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUG009Q8417I461@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jan 2008 15:39:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080110091607.GA17944@artemis.madism.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Content-id: <alpine.LFD.1.00.0801101352201.3054@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70084>

On Thu, 10 Jan 2008, Pierre Habouzit wrote:

> Well, lzma is excellent for *big* chunks of data, but not that impressive for
> small files:
> 
> $ ll git.c git.c.gz git.c.lzma git.c.lzop
> -rw-r--r-- 1 madcoder madcoder 12915 2008-01-09 13:47 git.c
> -rw-r--r-- 1 madcoder madcoder  4225 2008-01-10 10:00 git.c.gz
> -rw-r--r-- 1 madcoder madcoder  4094 2008-01-10 10:00 git.c.lzma
> -rw-r--r-- 1 madcoder madcoder  5068 2008-01-10 09:59 git.c.lzop

This is really the big point here.  Git uses _lots_ of *small* objects, 
usually much smaller than 12KB.  For example, my copy of the gcc 
repository has an average of 270 _bytes_ per compressed object, and 
objects must be individually compressed.

Performance with really small objects should be the basis for any 
Git compression algorithm comparison.

> Though I don't agree with you (and some others) about the fact that 
> gzip is fast enough. It's clearly a bottleneck in many log related 
> commands where you would expect it to be rather IO bound than CPU 
> bound.  LZO seems like a fairer choice, especially since what it makes 
> gain is basically the compression of the biggest blobs, aka the delta 
> chains heads.

The delta heads, though, are far from being the most frequently accessed 
objects.  First they're clearly in minority, and often cached in the 
delta base cache.

> It's really unclear to me if we really gain in 
> compressing the deltas, trees, and other smallish informations.

Remember that delta objects represent the vast majority of all objects. 
For example, my kernel repo currently has 555015 delta objects out of 
677073 objects, or 82% of the total.  There is actually only 25869 non 
deltified blob objects which are likely to be the larger objects, but 
they represent only 4% of the total.

But just let's try not compressing delta objects so to check your 
assertion with the following hack:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a39cb82..252b03e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -433,7 +433,10 @@ static unsigned long write_object(struct sha1file *f,
 		}
 		/* compress the data to store and put compressed length in datalen */
 		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, pack_compression_level);
+		if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
+			deflateInit(&stream, 0);
+		else
+			deflateInit(&stream, pack_compression_level);
 		maxsize = deflateBound(&stream, size);
 		out = xmalloc(maxsize);
 		/* Compress it */

You then only need to run 'git repack -a -f -d' with and without the 
above patch.

Here's my rather surprising results:

My kernel repo pack size without the patch:	184275401 bytes
Same repo with the above patch applied:		205204930 bytes

So it is only 11% larger.  I was expecting much more.

I'll let someone else do profiling/timing comparisons.

> What is obvious to me is that lzop seems to take 10% more space than gzip,
> while being around 1.5 to 2 times faster. Of course this is very sketchy and a
> real test with git will be better.

Right.  Abstracting the zlib code and having different compression 
algorithms tested in the Git context is the only way to do meaningful 
comparisons.


Nicolas
