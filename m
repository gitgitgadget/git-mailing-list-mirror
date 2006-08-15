From: linux@horizon.com
Subject: Re: Compression and dictionaries
Date: 15 Aug 2006 04:33:03 -0400
Message-ID: <20060815083303.13253.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 15 10:33:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCuMl-0006LM-9f
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 10:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbWHOId3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 04:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWHOId3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 04:33:29 -0400
Received: from science.horizon.com ([192.35.100.1]:25662 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965300AbWHOId2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 04:33:28 -0400
Received: (qmail 13254 invoked by uid 1000); 15 Aug 2006 04:33:03 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25444>

Just to inform this discussion, a brief description of the zlib
"deflate" algorithm.  A full description is in RFC1951.

This is LZ77 compression, meaning that what is actually encoded is
a series of instruction to either
- Insert a specified byte, or
- Copy a run of n bytes, starting m bytes ago.

I.e. roughly

union {
	struct { bool is_literal, char literal};
	struct { bool is_literal; uint8_t length; uint16_t distance; } copy;
};

Note that 100 repetitions of a character can be unambiguously encoded
as the character, followed by "copy 99 chars starting at offset -1".

There are also 257 possible literals, the 256 bytes plus a special EOF token.

The valid copy lengths are 3..258, and the valid distances are 1..32768.

Anyway, the deflate algorithm operates in a couple of steps:

- Translate the input into an (uncompressed) series of literals and
  copies.
- Take the literals and the lengths and put them into one big Huffman tree.
- Take the distances (actually, the simplified distances; large
  distances are grouped into ranges, which are followed by a binary suffix)
  and put them in a separate Huffman tree.
- A Huffman tree can be transmitted by encoding the number of bits assigned
  to each symbol, with a apecial value (infinity is mathematically
  the most logical but deflate calls it zero) for a symbol that does
  not appear in the tree at all.
- The way that deflate sends the lengths involves run-length encoding
  and a third Huffman tree, but I won't go into it now.

The finding of the copies is the most expensive part.  The minimum
copy length is 3 bytes, so the 3 bytes starting at each position are
hashed and the result put in a hash table, then you search the hash
chain looking for the longest match.  There are various heuristics
for aborting the search early, which the compression level adjusts.
-1 doesn't look very hard at all, while -9 always does exhaustive search.

(For example, when searching at all aggressively, when you've found a
match, you search starting at the next byte position in the input as well.
If that produces a longer match, you emit the skipped byte as a literal
and take the longer match and start looking for an improvement on it.)


Anyway, input is divided into blocks.  Each block is has a 2-bit
prefix that encodes one of three possibilities:
- Send uncompressed
- Send compressed, with fixed (specified in the standard) literal/length &
  distance Huffman code.  This "static Huffman tree" case is useful for
  short blocks where the overhead of encoding the Huffman tree is
  significant.
- Send compressed, using dynamic (encoded in the file) Huffman codes.
  This is the most commonly used case for large, compressible files.

Note that "copy" intructions can span blocks; the block boundaries are
only opportunities to change the way that the copy instructions are
coded if the file changes character (like text vs. data parts of an
executable).  Deciding when to end one block and start a new one is
another set of heuristics.


Only thing like a "dictionary" is the codes used for Huffman
compression.

Now, what you *could* do is pre-load the "copy from this text" buffer
(hash table) with up to 32K of example data, before you start encoding
data for real.   Basically, run some example text through the compresser
to warm it up, but throw away the compressed form.

This isn't a "dictionary" in the LZ78 sense (to start with, there are
no boundaries between entries), but serves the same purpose.  Note that
since the distance to copy from is limited to 32768, there's no point
to having more warm-up text than that.
