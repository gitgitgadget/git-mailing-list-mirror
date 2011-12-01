From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Wed, 30 Nov 2011 16:41:15 -0800
Message-ID: <1322700075.1710.157.camel@yos>
References: <1322546563.1719.22.camel@yos>
	 <20111129090733.GA22046@sigill.intra.peff.net>
	 <1322603788.1728.190.camel@yos>
	 <20111130062512.GA5317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 01:41:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuiM-0000DB-RA
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1LAAlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:41:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34814 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab1LAAlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:41:21 -0500
Received: by iage36 with SMTP id e36so1582185iag.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 16:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=9jQIi8Ojt3MZONQkqSHqW+pljQ/bQik6epeqMH6tRko=;
        b=JUa02pWppc7JAZNxoDvDHQSwq/5z2c28NxhrQ6SSuHUcQnxF1gOlh4asnVTYj4RV7S
         tnEFWUsapNAJ15dbword3LHKC7ORWYH+s0xAGxyfdGQz8AFeBrY5nBiFwZXtqrCts9zr
         LPrVDNtLUwMR5vXsxIe+iURZLqyl2ckQXG3/s=
Received: by 10.43.46.1 with SMTP id um1mr5921508icb.18.1322700080620;
        Wed, 30 Nov 2011 16:41:20 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id l28sm14172879ibc.3.2011.11.30.16.41.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 16:41:18 -0800 (PST)
In-Reply-To: <20111130062512.GA5317@sigill.intra.peff.net>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186154>

On Wed, 2011-11-30 at 01:25 -0500, Jeff King wrote:
> On Tue, Nov 29, 2011 at 01:56:28PM -0800, Bill Zaumen wrote:
> But I
> think the important attacks bypass your CRC anyway. Consider this attack
> scenario:
> 
>   1. Linus signs a tag (or a commit) and pushes it to kernel.org.
> 
>   2. kernel.org gets hacked, and the attacker replaces an object with
>      an evil colliding version[1].
> 
>   3. I clone from kernel.org, and run "git tag --verify". Git says it's
>      OK, because the signature checks out, but I have a bogus object.
> 
> How does your CRC help? If I understand your scheme correctly,
> kernel.org will have told me the CRC of all of the objects during the
> clone. But that isn't part of what Linus signed, so the attacker in step
> 2 could just as easily have overwritten kernel.org's crc file, and the
> signature will remain valid.

First, there is a misconception - the server will not tell you the CRC.
The CRC will be computed locally by the client instead.  

Aside from that, suppose the attacker does what you suggests (providing
a valid CRC so that git commands like verify-pack don't have an error
to detect).  You can't tell that something is wrong, but Linus can - 
the next time he does a fetch.  If he fetches, the server sends
some SHA-1 hashes and the client responds with 'have' or 'want' in a
reply.  If the client wants it, the client doesn't have a CRC, if the
client sends 'have', the CRCs are available so those get sent.  The
server then checks, notices a mismatch (probably in the CRC of the CRCs
of all the blobs in the commit's tree), and generates an error.

It's also possible to write some additional commands to (for example)
fetch the SHA-1 hashes and CRCs from all remote repositories you use
and compare these to make sure they are all consistent, something that
can be run ocassionally.


> > An efficient algorithm to do both simultaneously does not yet exist.
> > So, if we could generate a SHA-1 collision in one second, it would
> > presumably take billions of seconds (many decades of continuous
> > computation) to generate a SHA-1 hash with the same CRC, and well
> > before a year has elapsed, the original object should have been in all
> > the repositories, preventing a forged object from being inserted. Of
> > course, eventually you might need a real message digest.
> 
> This is wrong, for two reasons.
> 
>   1. The method for generating an object that collides in both sha-1 and
>      CRC is not necessarily to generate a colliding sha-1 and then do a
>      pre-image attack on the CRC. It is to do a birthday attack on the
>      sha-1 and the CRC together. Which halves the bit-strength of the
>      CRC to 16 bits (just as we can generally find collisions in 160-bit
>      sha1s in 2^80). 

That result for birthday attack assumes the goal is to find two files
that will have the same SHA-1 value (or SHA-1 + CRC).  The case I was
talking about (apologies if I did not state this clearly) is that you
have an existing object and an existing CRC and you want to generate
a second object with the same SHA-1 and same CRC as the first.  A
birthday attack doesn't work so well in that case - the number of tries
is much higher than half the number of bits in the digest.

http://en.wikipedia.org/wiki/Birthday_attack#Digital_signature_susceptibility
has a discussion regarding digital signatures.  The trick is for a
person to create a large number of variations of a "fair" and "unfair"
contract, and use a birthday attack to find a pair that have the same
hash.  The variations are typically inconsequential changes (extra
spacing, commas, etc.)  In the case I was discussing, a developer
creates some code,  commits it and pushes it to a shared repository -
the developer is not given code by the attacker.  The attacker can,
however, see the code by fetching it.  An attack then consists of
generating a collision, change the object in the attacker's local
repository, and then push the original developer's commit (with the
modified object) to another shared repository before someone else
puts the correct objects into that repository.  A birthday attack
does not work in this case.

There one issue that this suggests however - it is not clear if the
2^57 number given for the best SHA-1 attacks were attempts to generate
a new file with the same SHA-1 hash as an existing file or a pair of
files that have the same SHA-1 hash.  If it is the latter, then an
attack is significantly harder than I assumed as a worst case, but
still possibly much, much better than brute force.

http://en.wikipedia.org/wiki/Birthday_problem has an analysis of the
birthday problem (the basis of a birthday attack) and clearly notes that
this is different than the "same birthday as you" variation - you don't
do nearly so well in that case.

> Anyway, all of that is just reiterating that CRC should not be used
>      as a security function. It can easily be replaced in your scheme by
>      sha-256, which does have the desired properties.

Oh, I'm perfectly happy with sha-256 (and indicated that in the
documentation that is in the patch) - there's a tradeoff between error
detection and speed, and I simply guessed that the community was more
concerned with speed.

>   2. Your attack seems to be "find the sha-1 collision, publish one of
>      your colliding objects (i.e., the innocent-looking half), then try
>      to break the CRC". And then you claim that by the time you find the
>      CRC, everybody will already have the object.
> 
>      But wouldn't a smarter attack be to first find the collision, including
>      the CRC, and only _then_ start the attack? Then nobody will have
>      the object.

My assumption was that legitimate developer wrote some code, put it in
one of the remote repositories, and than an attacker downloaded that
code and tried to get a modified version into a different remote
repository.

> 
>      Moreover, it's not true that after a year everyone will have the
>      object. People still run "git clone" against kernel.org. Those
>      repos do not have the object.

This isn't the problem - a clone is going to be an exact copy of an
existing repository.  I was referring to the case where a commit made it
into one remote repository but not another - to get into the second one,
someone else would have had to review the code, creating a window where
an attacker with write access to the second repository could put the
modified object there.

> Right, but we are assuming that sha1 is broken. That's the whole
> security problem. So the existing digest is not worth much.

The assumption was more that "J Random Hacker's" code would be
trusted far less than code submitted by Linus, so if "J Random Hacker"
can generate create a replacement file with the same SHA-1 hash as
one in one of Linus' commits, others will initially assume that Linus
wrote that code. But, Git uses a "first in wins" rule so the bad guy
has to generate the replacement file and get it inserted before Linus'
commit reaches all the shared repositories for the project.  A SHA-1
collision is harmless if computed too late to get in.

> > Second, any value of the CRC that is stored permanently (baring bugs,
> > in my implementation, of course) is computed locally 

> But if I don't already have the object, then I have nothing to compare
> against. So when I get it from kernel.org, I have to simply accept that
> the object I'm getting is good, and write it into my object db.

The value is computed locally but can be compared remotely.

You (specifically) won't find anything while talking to kernel.org in
this example, but when you try to fetch from a different repository,
instead of just noting that you have the object, you'll get a
notification that there was a collision, so you'll find the problem
earlier than you would otherwise.  Also, anyone who had the right object
from kernel.org (the object before the repository was 'hacked' would get
a warning when trying to fetch from kernel.org after the change.

> Yes, the header has to go at the end of the existing headers. But I
> don't see any reason that would be a problem for the scheme I described.

Thanks for mentioning it - I tried putting the header in multiple
locations and probably missed the one spot where it would work.

> Current git should ignore headers that it doesn't understand. I haven't
> tested this, but Junio recently has been experimenting with
> gpg-signature lines in commits, and I'm pretty sure he checked that
> older gits properly ignore them.

Possibly there was another bug in the test I tried as well - something
was preventing the directory cleanup in one of the 'notes' test.

Anyway, thanks for the comments.

Bill
