From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Mon, 19 Mar 2007 22:34:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192212280.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <200703191932.26856.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703190804350.6730@woody.linux-foundation.org>
 <200703201013.39169.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWzD-0000YL-RQ
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030831AbXCTFeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030834AbXCTFeO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:34:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47654 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030831AbXCTFeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:34:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K5YBcD024052
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 22:34:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K5YAgc026768;
	Mon, 19 Mar 2007 21:34:11 -0800
In-Reply-To: <200703201013.39169.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.476 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42711>



On Tue, 20 Mar 2007, Alexander Litvinov wrote:
> 
> Actualy, I have packed that objects already, so fsck warn me:
> $ git fsck --full
> error: packed 8edc906985f00cf27180b1d9d4c3217ffd1896f8 from .git/objects/pack/pack-abc5cbabfc05c213e50c43ea07f43158bf1de236.pack is corrupt
> error: packed f6aca57bb30a12e9ac5d71558e0b6052d6fb67a8 from .git/objects/pack/pack-abc5cbabfc05c213e50c43ea07f43158bf1de236.pack is corrupt
> sha1 mismatch 8edc906985f00cf27180b1d9d4c3217ffd1896f8
> sha1 mismatch f6aca57bb30a12e9ac5d71558e0b6052d6fb67a8

Ok, this is different from what I expected. 

Since your pack-file seems to pass its own internal SHA1 checks, it means 
that it was likely corrupt already when it was written out in the pack. 
What's interesting is that it seems to unpack, but then the SHA1 of the 
unpacked object doesn't match.

The reason I say that's interesting is that it would seem to mean that the 
zlib CRC/adler check didn't trigger - which probably means that the object 
was corrupted *before* it was compressed (but after it was originally 
SHA1-summed), or the compression itself was corrupting (eg a libz 
problem).

And since the SHA1 of the pack-file matches, the thing was apparently 
also written out "correctly" after compression (but by that "correctly" I 
obviously mean that the *corrupted* data was written out). 

Sadly, by the time it's in a pack-file, it is *really* hard to figure out 
what went wrong: I see your unpacked data, but it's really the packed raw 
objects that I wanted to look at, in case there would be some pattern in 
the actual corruption (the corruption will then result in random crud when 
actually unpacking, which is why the unpacked data isn't that interesting, 
simple because there's no pattern left to analyze - it got inflated to 
bogus "data").

> I also use autocrlf feature:
> $ git config core.autocrlf
> true

I doubt autocrlf affects anything here, it's only used at checkin and 
checkout time, and it wouldn't affect the raw internal git objects.

More interesting might be if you might be using any of the other flags 
that actually affect internal git object packing: "use_legacy_headers" in 
particular? If we have a bug there, that could be nasty.

But to really look at this we should probably add a "really_careful" flag 
that actually re-verifies the SHA1 on read so that we'd catch these kinds 
of corruptions early. 

> This files are cpp code from our project and tham need to be private. Really.

Ok, no problem. I added back the git list (but not your attachments, 
obviously) but as explained above, there is not a lot I can do with the 
unpacked data, I'd like to see the actual "raw" stuff.

I'm hoping somebody has any ideas. We really *could* check the SHA1 on 
each read (and slow down git a lot) and that would catch corruption much 
faster and hopefully pinpoint it more quickly where exactly it happens. 
But maybe somebody has some other smart idea?

		Linus
