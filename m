From: Christian Thaeter <ct@pipapo.org>
Subject: Re: (class=ham score=-4.96032) memmem.c improvement
Date: Sat, 01 Dec 2007 03:30:35 +0100
Message-ID: <4750C74B.8060308@pipapo.org>
References: <4750AF4F.6090207@pipapo.org> <Pine.LNX.4.64.0711301954370.9426@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: libc-alpha@sourceware.org,  git@vger.kernel.org
To: Tor Myklebust <tmyklebu@csclub.uwaterloo.ca>
X-From: libc-alpha-return-20628-glibc-alpha=m.gmane.org@sourceware.org Sat Dec 01 03:32:25 2007
Return-path: <libc-alpha-return-20628-glibc-alpha=m.gmane.org@sourceware.org>
Envelope-to: glibc-alpha@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IyI9W-0002XU-JN
	for glibc-alpha@gmane.org; Sat, 01 Dec 2007 03:32:23 +0100
Received: (qmail 12211 invoked by alias); 1 Dec 2007 02:32:05 -0000
Received: (qmail 12202 invoked by uid 22791); 1 Dec 2007 02:32:04 -0000
X-Spam-Check-By: sourceware.org
Received: from pipapo.org (HELO mail.pipapo.org) (217.140.77.75)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 01 Dec 2007 02:32:00 +0000
Received: from [10.20.70.10] (mercur.pipapo.org [10.20.70.10]) 	by mail.pipapo.org (Postfix) with ESMTP id 797F734EEDA95; 	Sat,  1 Dec 2007 03:30:07 +0100 (CET)
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
In-Reply-To: <Pine.LNX.4.64.0711301954370.9426@caffeine.csclub.uwaterloo.ca>
Mailing-List: contact libc-alpha-help@sourceware.org; run by ezmlm
Precedence: bulk
List-Id: <libc-alpha.sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Delivered-To: mailing list libc-alpha@sourceware.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66675>

Tor Myklebust wrote:
> On Sat, 1 Dec 2007, Christian Thaeter wrote:
> 
>> Short story, 'memmem()' is a gnuish, nonstandard function. I wanted to
>> provide a generic fallback in some code. So, lets borrow it somewhere
>> else:
>>
>> First looking at git's compat/memmem.c which I found was suboptimal
>> with roughly O(M*N) performance (albeit ok for that case since it was
>> just a generic fallback).
>>
>> Well, second taking a look at glibc's source surprised me, there is
>> the same code as in git. I somewhat expected a faster implementation
>> from a generic C library.
> 
> I don't think anybody involved with glibc really feels like having
> strstr() (or memmem(), for that matter) go fast.  (The grounds I heard
> were that "applications requiring large searches are more likely to have
> own fast string search implementations.')
> 
>> That thought and done, the code is attached to this mail. The
>> algorithm is similar to the Rabin/Karp method for string searches but
>> uses a weaker and simpler additive rolling hash.
> 
> There are rolling hashes based on arithmetic in fields of order 2^k.
> These can typically be computed using a bunch of bit-shifts and
> additions; have you tried using one?  There are lots of irreducible
> polynomials over Z_2 of degree k, so you can even fall back to a
> different one every few false positives.
> 
>> The result is still somewhat like O(M+N) for most cases
> 
> I don't think you get linear performance in the average case.  (But I do
> think you shave a factor of 256 off of the quadratic term.  The same
> algorithm, where your hash function is the population count, gives a
> collision between two random strings of length m with probability
> sum_(i=0)^m (m choose i)^2 / 4^m, which grows like sqrt(m).  Your
> algorithm helps this by a factor of 256.)
...
> 
>> (There may be corner cases where it not that good, but its really hard
>> to imagine those).
> 
> The needle "1100110011001100...1100" and the haystack
> "10101010101010...10" will produce quite a few false matches with your
> hash function (simply because every substring of the haystack of the
> appropriate length has the same hash as your needle).  (Making the
> needle "1010101010...101100" makes it even worse.)

I am fully aware that this is not the best possible search algorithm. It
is considerably better than the actual one for 'common' data. Having a
string with few symbols or other corner cases needs an algorithm better
suited for that task. But well, this was just reaching a low hanging
fruit. I just wanted to share it because it is better than the algorithm
which is in git and glibc, feel free to submit a even better one or keep
the old one, whatever. For me it suffices and I won't put more efforts
into improving or lobbying it, its just not worth it.

	Christian
