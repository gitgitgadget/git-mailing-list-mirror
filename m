From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: SHA1 hash safety
Date: Sun, 17 Apr 2005 00:38:37 -0400
Message-ID: <4261E84D.6040208@dwheeler.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>	<20050416123155.GA19908@elte.hu>	<Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>	<4261132A.3090907@khandalf.com>	<Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>	<20050416151116.GC19099@pasky.ji.cz>	<Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu>	<Pine.LNX.4.62.0504161549410.22652@qynat.qvtvafvgr.pbz> <20050416161153.534b47d5.pj@sgi.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Lang <dlang@digitalinsight.com>, cscott@cscott.net,
	pasky@ucw.cz, omb@bluewin.ch, mingo@elte.hu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:33:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN1TE-0004ZS-Fy
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDQEg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDQEg5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:36:57 -0400
Received: from cujo.runbox.com ([193.71.199.138]:12255 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261253AbVDQEgx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 00:36:53 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DN1WW-0003OU-3f; Sun, 17 Apr 2005 06:36:44 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DN1WV-0005La-Ku; Sun, 17 Apr 2005 06:36:44 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416161153.534b47d5.pj@sgi.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson wrote:
>>what I'm talking about is the chance that somewhere, sometime there will 
>>be two different documents that end up with the same hash
> 
> I have vastly greater chance of a file colliding due to hardware or
> software glitch than a random message digest collision of two legitimate
> documents.

The probability of an accidental overlap for SHA-1 for two
different files is absurdly remote; it's just not worth worrying about.

However, the possibility of an INTENTIONAL overlap is a completely
different matter.  I think the hash algorithm should change in the
future; I have a proposal below.

Someone has ALREADY broken into a server to modify the Linux kernel
code already, so the idea of an attack on kernel code
is not an idle fantasy. MD5 is dead, and SHA-1's work factor has
already been sufficiently broken that people have already been told
"walk to the exits" (i.e., DO NOT USE SHA-1 for new programs like git).

The fact that blobs are compressed first, with a length header
in front, _may_ make it harder to attack.  But maybe not.
I haven't checked for this case, but most decompression algorithms
I know of have a "don't change" mode that essentially just copies the
data behind it.  If the one used in git has such a mode
(I bet it does!), an attacker could use that mode to
make it MUCH easier to create an attack vector than it would
appear at first.  Now the attacker just needs to create a collision
(hmmm, where was that paper?).  Remember, you don't need to
run a hash algorithm over an entire file; you can precompute
to near the end, and then try your iterations from there.
A little hardware (inc. FPGAs) would speed the attack.

Of course, that assumes you actually
check everything to make sure that an attacker can't slip
in something different. After each rsync, are all new files'
hash values checked?  Do they uncompress to right length?
Do they have excess data after the decompression?
I'm hoping that sort of input-checking (since the data
might be from an attacker, if indirectly!) is already going on,
though I haven't reviewed the git source code.

While the jury's still out, the current belief by most folks
I talk to is that SHA-1 variants with more bits, such as SHA-256,
are the way to go now.  The SHA-1 attack simply reduces
the work factor (it's not a COMPLETE break), so adding
more bits is believed to increase the work factor
enough to counter it.

Adding more information to the hash can make attacking even harder.
Here's one idea: whenever that hash algorithm
switch occurs, create a new "hash" value as this:
   SHA-256 "+" uncompressed-length
Where SHA-256 is computed just like SHA-1 is now, e.g.,
SHA-256(file) where file = typecode + length + compressed data.
Leave the internal format as-is (with the length embedded as well).
This means that an attacker has to come up with an attack
that creates the same length uncompressed, yet has the same hash
of the compressed result. That's harder to do.
Length is also really, really cheap to compute :-).
That also might help the convince the "what happens if there's
an accidental collision" crowd: now, if the file lengths
are different, you're GUARANTEED that the hash values are different,
though that's not the best reason to do that.

One reason to think about switching sooner rather than later
is that it'd be really nice if the object store also included
signatures, so that in one fell swoop you could check who signed what
(and thus you could later on CONFIRM with much more certainty who
REALLY submitted a given change... say if it was clearly malicious).
If you switch hash algorithms, the signatures might not work,
depending on how you do it.

--- David A. Wheeler
