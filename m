From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 13:12:22 -0800
Message-ID: <7vmz3gmojt.fsf@assigned-by-dhcp.cox.net>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRQQ-0005NT-Od
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbXBNVMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbXBNVMX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:12:23 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53890 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599AbXBNVMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:12:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214211222.SLQW4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 16:12:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PZCN1W00M1kojtg0000000; Wed, 14 Feb 2007 16:12:22 -0500
In-Reply-To: <17875.30187.289679.417079@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 14 Feb 2007 14:49:47 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39746>

Bill Lear <rael@zopyra.com> writes:

>>How big is this pack, what platform are you working on and whose
>>SHA-1 implementation do you use?
>
> In order:
>
> % cd .git/objects/pack
> % ls -l
> -r--r--r--  1 rael software    77360 Feb 13 10:18 pack-23d1a9af78b4b78d...
> -r--r--r--  1 rael software 87874337 Feb 14 10:00 pack-23d1a9af78b4b78d...
>
> [output of ls trimmed to width]
>
> % uname -a
> Linux lisa.zopyra.com 2.6.9-34.0.2.ELsmp #1 SMP Fri Jul 7 18:22:55 CDT 2006 x86_64 x86_64 x86_64 GNU/Linux
>
> I don't know which SHA-1 implementation I use --- I just installed git
> and off I went.  I do see this:
>
> % which sha1sum
> /usr/bin/sha1sum
> % sha1sum --version
> shasum (coreutils) 5.2.1
> Written by Ulrich Drepper and Scott Miller.
> [...]
>
> But I'm not sure which library is in use --- how do I know?

"ldd ~/git-master/bin/git" tells me that it links with libcrypto.so,
so I am using OpenSSL's SHA-1 implementation.  I do not know
what your distro uses (or you hand built git yourself?).

I asked this question, because... 

>>Also, do you have a huge blob in the repository?  I do not know
>>if it is related but the write_sha1_file_prepare() function on
>>the codepath to write loose objects out would trigger the same
>>bug...
>
> I don't know what "huge" is, but the pack file seems to be the largest
> and then one of the objects is listed at 28,604,986 bytes, but nothing
> else is very large.

... we had a problem that some SHA-1 implementation gave bogus
results when we did this:

	SHA_CTX ctx;
	unsigned char sha1[20];
      
	SHA1_Init(&ctx);
        /* hash len bytes starting from buf */
	SHA1_Update(&ctx, buf, len);
	SHA1_Final(sha1, &ctx);

and asked to hash a large buffer in one go.  One of the SHA1
implementations we ship ourselves (I think it was handcrafted
PPC one) used to have problems.  But I do not think 27MB is
large enough to trigger such a library bug (the bug was integer
wraparound of a bit counter, I think).

So it looks more and more like a bit decay as Linus suspected...
