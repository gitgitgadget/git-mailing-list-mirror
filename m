From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 09:15:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>  <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>  <4797095F.9020602@op5.se>  <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>  <4797518A.3040704@op5.se>
  <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>  <4798B633.8040606@op5.se> <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Marko Kreen <markokr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 18:17:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI5hS-0007Of-Lw
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 18:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYAXRQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 12:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYAXRQn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 12:16:43 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40093 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753047AbYAXRQm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 12:16:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0OHFhur023365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jan 2008 09:15:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0OHFhCV004253;
	Thu, 24 Jan 2008 09:15:43 -0800
In-Reply-To: <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71634>



On Thu, 24 Jan 2008, Dmitry Potapov wrote:
> 
> I don't think you can any meaningful unicode-juggling without converting
> symbols to UCS-4, and after that it makes much more sense to operate
> with uint32 than bytes. So, Jenkins' hash is still relevant, just because
> it does not operate on single bytes, but using uint32.

No, no, no, NO!

Egads! Why do people constantly do these totally idiotic things for 
Unicode?

You can do a perfectly fine 8-bytes-at-a-time hash for almost 100% of all 
source code projects in UTF-8, without *ever* doing any format changes at 
all. Admittedly, it's a lot easier if the hash is a pure in-memory one (ie 
we don't care about byte-order or size of integers or anything like that), 
but that's the common case for most hashes that aren't used for BTree 
lookup on disk or something like that.

Here, let me show you:

	unsigned int name_hash(const char *name, int size)
	{
		hash = HASH_INIT;
		do {
			unsigned char c;
			if (size >= sizeof(long)) {
				unsigned long val = get_unaligned_long(name);
				if (!(val & 0x8080808080808080)) {
					/* Make it equivalent in case */
					val &= ~0x2020202020202020;
					hash = hash_long(hash, val);
					name += sizeof(long);
					size -= sizeof(long);
					continue;
				}
			}

			c = *name;
			if (!(c & 0x80)) {
				hash = hash_long(hash, c & ~0x20);
				name++;
				size--;
				continue;
			}

			/* This is the unusual and slowish case */
			hash = hash_utf8_char(hash, c, &name, &size);
		} while (size);
		return hassh;
	}

and then the only point you ever do that actual UTF8->codepoint conversion 
is for that "high bit set" case.

A few things to note on the above:

 - the hash obviously has "odd" characteristics. We're not necessarily 
   hashing characters at a time at all, and the alignment of characters 
   with high bits *within*the*string* will make a difference to how we 
   hash them.

   But it's also important that the "get_unaligned_long()" means that the 
   alignment of the string itself doesn't matter, so its' purely a 
   "chunking within the string" thing, and the alignment of the string 
   itself won't affect the hash value

 - I'm not writing out hash_utf8_char(), because it's certainly not 
   totally trivial, but it's not *really* complex either. The 
   nontriviality isn't so much the decoding into a codepoint (which is 
   pretty simple), but the fact that when you have the codepoint you 
   should then decompose it and turn it into lower case, which is 
   generally two table lookups. Then, you just do

	for_each_decomposed_uppercased_codepoint(c)
		hash = hash_long(hash, c);

   and one thing to note is that for the hashing, the decomposition and 
   uppercasing doesn't even have to be "exact" (the same way I didn't do 
   an "exact" upper-casing for US-ASCII, just a "good enough" one!)

Similarly, when you actually do a unicode *compare* function, you should 
never *ever* actually convert to any unicode codepoints or do any 
expensive decomposition AT ALL by default! What you do is to compare 
things byte-by-byte, and only convert to unicode/decompse if there are any 
differences, and only for those parts of the sequence that differ!

So if you have two UTF-8 strings (even if they have "complex" characters, 
ie with the  high bit set), the *common* case is that you'll match them 
byte for byte, and they'll match without any Unicode conversion needed at 
all! This is common because:

 - normally, even if you don't ever normalize, people tend to input things 
   in a *similar* manner (again, OS X is the odd man out), so even 
   non-normalized strings are often non-normalized the same way!

 - we're only going to compare things that have hashed to the same thing 
   anyway, so the common case is that it's the same string, and most 
   likely had the same source. And if it's a collision, it's often totally 
   different. And even if it's different only in case, the *common* case 
   is going to be (for source code trees, at least) that the different 
   point is a US-ASCII letter, and the case-comparison will again be done 
   without any Unicode knowledge at all!

This is why normalization of strings before-hand is generally so utterly 
stupid. It doesn't buy you anything. It complicates things a lot (you 
don't want to normalize in-place, so you have memory management issues), 
and it actually SLOWS THINGS DOWN.

It's much better to do UTF-8 comparisons and hashing char-by-char. At 
least if you know that the common case is not going to be the complex part 
of the character set (which is undoubtedly true for source code 
filenames). 

Normalizing things ahead of time *only* makes sense if:

 - you expect complex characters to be a big part of your load

and

 - you're going to do literally *thousands* of comparisons against the 
   *same* strings over and over (so that the cost of normalization is
   literally up-front)

For example, for a filesystem, it's true that you're going to compare 
against the *target* (on-disk) multiple times, but that doesn't actually 
mean that normalizing it makes any sense - because the data you're going 
to compare against comes from user space and isn't guaranteed to be 
normalized, so you still cannot do a simple memcmp() without the expense 
of normalizing that.

And since you're going to hash the filenames anyway, you will not have 
"thousands of comparisons" per source lookup, you'll generally only have a 
couple, so now your normalization actually cost you *more* than doing the 
above on-the-fly comparison!

See?

Basically, it's almost always a stupid thing to actually normalize a whole 
string. You do those things character-by-character, and only lazily when 
you actually need to!

			Linus
