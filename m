From: linux@horizon.com
Subject: Re: Compression and dictionaries
Date: 15 Aug 2006 20:37:12 -0400
Message-ID: <20060816003712.32000.qmail@science.horizon.com>
References: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Aug 16 02:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD9PT-0005bO-WA
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 02:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHPAhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 20:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWHPAhW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 20:37:22 -0400
Received: from science.horizon.com ([192.35.100.1]:52534 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750728AbWHPAhV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 20:37:21 -0400
Received: (qmail 32001 invoked by uid 1000); 15 Aug 2006 20:37:12 -0400
To: jonsmirl@gmail.com
In-Reply-To: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25496>

> I explained our situation to Mark Adler, zlib author, and he recommend
> checking out this book for techniques that can be used.
> 
> http://www.cs.mu.oz.au/mg/

I was about to suggest the same thing!  It's an excellent book.

It's about a piece of software and the choices made there, but it
explains in detail many alternatives and why they weren't chosen for
the mg software, but what they might be useful for.

The mg software itself is designed for human-language text, and does
indexing as well.  So it does a fixed breakdown into alternate word and
non-word tokens, builds a lexicon with frequency tables, then uses the
frequencies to build Huffman trees, and Huffman-compresses each token.
The "word" dictionary is also used as part of the search index, as each
word has a (very cleverly compressed to less than one byte on average)
pointer to each document it appears in with a count of the number of
appearances.

The word encoding is straight zero-order Huffman, so inter-word
correlations are not used.

For software, with lots of punctuation and multi-word idioms
("for (i = 0; i < n; i++) {"), the basic design is not very well suited.
(To say nothing of binary data, like some people who want to
check images or multi-megabyte video files into git.)

But there is a good description of many possible algorithms, with
lots of emphasis on practicalities.

And the software *does* support dynamic collections, via auxiliary indexes
and escape codes for any new words not found in the main dictionary.
In fact, generating the Huffman tree from as little as 1/8 of the material
to be compressed only loses you 5.7% of the compression.  (Table 9011,
p. 360.)

However, that is for English text, with a pretty Zipf-like distribution.
In code, we generate new words (new function names) frequently, and
proceed to use them heavily.

It's worth noting the similarity between generating a good base dictionary
with finding a good base version of a file for delta-encoding.
You may end up having to divide the documents into classes (different
source languages for example - C vs. asm vs. perl vs. python vs.
docs vs. GIFs), and use a different dictionary per class.  But that
drives up the cost of compression (you have to see which class the
file to be compressed falls into).

Anyway, highly recommended.
