From: Tor Myklebust <tmyklebu@csclub.uwaterloo.ca>
Subject: Re: (class=ham score=-4.96032) memmem.c improvement
Date: Fri, 30 Nov 2007 20:58:10 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711301954370.9426@caffeine.csclub.uwaterloo.ca>
References: <4750AF4F.6090207@pipapo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: libc-alpha@sourceware.org, git@vger.kernel.org
To: Christian Thaeter <ct@pipapo.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 02:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyHcm-00047G-JA
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 02:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598AbXLAB6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 20:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757557AbXLAB6M
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 20:58:12 -0500
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:46940 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757396AbXLAB6M (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 20:58:12 -0500
Received: from caffeine.csclub.uwaterloo.ca (localhost [127.0.0.1])
	by caffeine.csclub.uwaterloo.ca (Postfix) with ESMTP id 2665173DBA;
	Fri, 30 Nov 2007 20:58:11 -0500 (EST)
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca [129.97.134.17])
	by caffeine.csclub.uwaterloo.ca (Postfix) with ESMTP id 057D573DB9;
	Fri, 30 Nov 2007 20:58:11 -0500 (EST)
In-Reply-To: <4750AF4F.6090207@pipapo.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66673>

On Sat, 1 Dec 2007, Christian Thaeter wrote:

> Short story, 'memmem()' is a gnuish, nonstandard function. I wanted to 
> provide a generic fallback in some code. So, lets borrow it somewhere 
> else:
>
> First looking at git's compat/memmem.c which I found was suboptimal with 
> roughly O(M*N) performance (albeit ok for that case since it was just a 
> generic fallback).
>
> Well, second taking a look at glibc's source surprised me, there is the 
> same code as in git. I somewhat expected a faster implementation from a 
> generic C library.

I don't think anybody involved with glibc really feels like having 
strstr() (or memmem(), for that matter) go fast.  (The grounds I heard 
were that "applications requiring large searches are more likely to have 
own fast string search implementations.')

> That thought and done, the code is attached to this mail. The algorithm 
> is similar to the Rabin/Karp method for string searches but uses a 
> weaker and simpler additive rolling hash.

There are rolling hashes based on arithmetic in fields of order 2^k. 
These can typically be computed using a bunch of bit-shifts and additions; 
have you tried using one?  There are lots of irreducible polynomials over 
Z_2 of degree k, so you can even fall back to a different one every few 
false positives.

> The result is still somewhat like O(M+N) for most cases

I don't think you get linear performance in the average case.  (But I do 
think you shave a factor of 256 off of the quadratic term.  The same 
algorithm, where your hash function is the population count, gives a 
collision between two random strings of length m with probability 
sum_(i=0)^m (m choose i)^2 / 4^m, which grows like sqrt(m).  Your 
algorithm helps this by a factor of 256.)

> (There may be corner cases where it not that good, but its really hard 
> to imagine those).

The needle "1100110011001100...1100" and the haystack 
"10101010101010...10" will produce quite a few false matches with your 
hash function (simply because every substring of the haystack of the 
appropriate length has the same hash as your needle).  (Making the needle 
"1010101010...101100" makes it even worse.)

> Anyways, it is always faster than the current implementation,

Try the example above.  (Your code also needs a "return NULL;" at the end, 
by the way.)

> in my tests with common data (parsing multipart/form-data cgi responses) 
> it yields approx 20%-100% improvements and with little artificial 
> cheating (having strings in haystack which only differ at the last char 
> of needle) the improvements are much better (500%, since is another 
> complexity class). The fact is that the old implementation does a brute 
> force search which has corner cases which are quite easy to hit 
> (repeating symbol sequences, small set of possible symbols) while for my 
> implementation the corner cases are much more rare and even then, it 
> will still perform better than the old implementation.

The old implementation is about 50% faster than yours in the example 
above.

> The code is not much more complex as the old one, not the original 
> 'Rabin/Karp' algorithm because that would require a efficient modulo 
> operation with a prime number which might be slower on some platforms 
> (just a guess, I didn't even tried, the performance satisfies me 
> perfectly).

Karp-Rabin with hashing done mod a prime is an impractical string matching 
algorithm.

> Other search algorithms like 'Knuth/Morris/Pratt'

A KMP-like algorithm can be implemented in a way that uses constant 
additional space.  For unordered alphabets, it's called "Galil-Seiferas" 
and for ordered alphabets the analogous algorithm is to decompose (in 
linear time and constant space) the string into its lexicographically 
largest suffix and some prefix.  Then you look for the suffix.  Everywhere 
where the suffix appears and appears at least prefix-length later than the 
last occurrence of the suffix, you check for the prefix.

> or 'Boyer/More' are more complex to implement and require O(Needle) 
> extra memory

There are variants of both that require constant additional space.  (They 
also perform way better than anything else I've seen.)

> for common implementations, which reserve them for special purposes imo. 
> I just wanted to keep it simple but still considerably better than the 
> current one.

As it happens, the extra space consumed by the KMP and suffix shift tables 
(and the associated bad cache effects) make the usual KMP and Boyer-Moore 
way, way slower than naive string matching on random inputs.
