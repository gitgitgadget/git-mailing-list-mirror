From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Thu, 24 May 2012 22:01:59 +0200
Message-ID: <87vcjll554.fsf@thomas.inf.ethz.ch>
References: <20120523122135.GA58204@tgummerer.unibz.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>,
	<gitster@pobox.com>, <pclouds@gmail.com>, <mhagger@alum.mit.edu>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeEj-0006K1-8g
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966249Ab2EXUCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:02:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:58280 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966267Ab2EXUCG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:02:06 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 24 May
 2012 22:02:01 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 24 May
 2012 22:02:00 +0200
In-Reply-To: <20120523122135.GA58204@tgummerer.unibz.it> (Thomas Gummerer's
	message of "Wed, 23 May 2012 14:21:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198412>

Thomas asked for feedback on IRC, and Michael requested that I put it in
email for posterity, so here goes.

This is referring to 0c9214a from git://github.com/tgummerer/git.git,
where Thomas put the very early beginnings of wiring v5 parsing code
into read_index_from().

* On the high-level history making side of things: You structured your
  commits by "steps of implementation", but that sometimes does not give
  very useful intermediate steps. for example, now your index-v5~1 just
  prints "Header verified". That means it cannot be meaningfully tested,
  or judged by tests, or some such.

  That's ok as long as you are still drafting up things, but from
  experience the most workable approach is refactor-patch-improve (or
  sometimes patch-refactor-improve).  That is, you proceed in up to
  three steps, each spelled as one or more commits:

  - (Optionally, but in this case crucially) refactor the existing code
    into a shape where your feature patches become simpler.  This should
    be a true refactoring, i.e., not changing any observable behavior.

  - Optionally fix any bugs you encounter along the way.

  - Patch in your shiny new feature.

  (Tests should of course go with the last two steps.)

  This tends to make the feature patches simpler, and thus easier to
  review.  For a long project like yours, you may end up having several
  feature patches or even several iterations of this approach.

  For a great example of just this happening, consider Junio's index-v4
  series:

  - Preparations:
    varint: make it available outside the context of pack
    cache.h: hide on-disk index details
    read-cache.c: allow unaligned mapping of the index file
    read-cache.c: make create_from_disk() report number of bytes it consumed

  - Bugfix (ok, it only makes the error better)
    read-cache.c: report the header version we do not understand

  - Refactoring:
    read-cache.c: move code to copy ondisk to incore cache to a helper function
    read-cache.c: move code to copy incore to ondisk cache to a helper function

  - The feature itself:
    read-cache.c: read prefix-compressed names in index on-disk version v4
    read-cache.c: write prefix-compressed names in the index

  - The supporting mini-features required to use it:
    update-index: upgrade/downgrade on-disk index version
    unpack-trees: preserve the index file version of original

  - The docs:
    index-v4: document the entry format

  Ok, you can already see that the reality is not quite as simple as my
  initial explanations...


* The code structure itself:

  I like the split you made in the verify_hdr_* family, like so:

    -static int verify_hdr(struct cache_header *hdr, unsigned long size)
    +static int verify_hdr_version(struct cache_header *hdr, unsigned long size)
     {
    -       git_SHA_CTX c;
    -       unsigned char sha1[20];
            int hdr_version;
     
            if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
                    return error("bad signature");
            hdr_version = ntohl(hdr->hdr_version);
    -       if (hdr_version < 2 || 4 < hdr_version)
    +       if (hdr_version < 2 || 5 < hdr_version)
                    return error("bad index version %d", hdr_version);
    +       return 0;
    +}
    +
    +static int verify_hdr(struct cache_header *hdr, unsigned long size)
    +{
    +       git_SHA_CTX c;
    +       unsigned char sha1[20];
    +
            git_SHA1_Init(&c);
            git_SHA1_Update(&c, hdr, size - 20);
            git_SHA1_Final(sha1, &c);

  since it decouples version checking from the checksumming.  (Without
  the change to make 5 an acceptable version, this could actually go in
  a refactoring patch.)

  On the other hand the read_index_from() changes show none of that
  "function modularity".  Your results would be much better if you first
  refactored the meat of read_index_from to read_index_v2_from(),
  so that read_index_from() is essentially:

    mmap();
    verify_hdr();
    read_index_v2_from(...);
    munmap();

  Then, in another patch, wire in your shiny new read_index_v5_from()
  function.  Then change required to read_index_from() will be a
  two-liner, which makes it *much* easier to see what is going on,
  especially if you compare with your f50c747b

     read-cache.c | 118 ++++++++++++++++++++++++++++++++++--------------------

  80% of that is just reindentation because you are wrapping things in a
  version test!

* There's little code at this point, but I like the general direction
  you are taking: for now, start with a flat array of index entries and
  slurp everything in there, like the v3 code does.  Later patches can
  then improve on that to use the features of the new format.

* The struct{} layout should be such that it is not a pure coincidence
  that hdr_version has the same position in all structures.  You
  basically have two options to achieve this:

  - You write it as a concatenation of two structs, such as

      struct cache_version_header { unsigned hdr_signature, hdr_version; }
      struct cache_header_v2      { unsigned hdr_entries; }

    and similarly for v5.  The code then just reads the first struct,
    and dispatches to read the second one depending.

  - You write it as a struct-within-a-struct, so that the generic header
    becomes a part of the version-specific ones, like

      struct cache_header_v2 {
        struct cache_version_header foo;
        unsigned hdr_entries;
      }

    Finding a good substitute for "foo" is left as an exercise for the
    reader.

* Finally, on style: Your indentation is off in parts, please use a
  tab-width of 8 spaces and use tabs for the leading indentation.

Cheers,
Thomas

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
