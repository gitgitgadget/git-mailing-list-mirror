From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 13
Date: Mon, 16 Jul 2012 22:33:00 +0200
Message-ID: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, mhagger@alum.mit.edu, pclouds@gmail.com,
	trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:33:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqrz5-0008Ig-1L
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab2GPUdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:33:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54056 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2GPUdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:33:08 -0400
Received: by pbbrp8 with SMTP id rp8so10564491pbb.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2012 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=3n2mGgwc4hJuTP8HMDFKxRBgFqWl4/LdpbyQnIZBY6c=;
        b=0cDltg6UrvLBqXvjxFAA7dp4ut+CdoB39Owc6Tuv7uXQ7vr1tl5/apsqQAyfj03ZhQ
         O7PieDCi5UXZURwOapvnKdKV1y8cPz4LwCNVSxiaQ9+IjewAsLVaUXdeNM6Zi9bwSaH6
         pb7SHjPZEUuYLae/xk2jY3Xfl59jyk+aD5iz9CI/KmvqdQFrxyUyK3jaZffTmHYZwTmM
         Tv7LWT0KX/4TDAo7i8r55sciGUHfF98KVasPKKN+/5dESRLHS0GuY86kW2Al0zEG62jG
         Zo7Wlb9E8ocaxGjbIRFyxbehzvEqgiiuM0o8DOIAd0HpGHlHHj2McnfDfVnfV2RQYb6x
         yKoQ==
Received: by 10.68.189.135 with SMTP id gi7mr29714297pbc.68.1342470788246;
        Mon, 16 Jul 2012 13:33:08 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id rd7sm12508838pbc.70.2012.07.16.13.33.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jul 2012 13:33:07 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201567>

== Work done in the previous 12 weeks ==

- Definition of a tentative index file v5 format [1]. This differs
  from the proposal in making it possible to bisect the directory
  entries and file entries, to do a binary search. The exact bits
  for each section were also defined. To further compress the index,
  along with prefix compression, the stat data is hashed, since
  it's only used for comparison, but the plain data is never used.
  Thanks to Michael Haggerty, Nguyen Thai Ngoc Duy, Thomas Rast
  and Robin Rosenberg for feedback.
- Prototype of a converter from the index format v2/v3 to the index
  format v5. [2] The converter reads the index from a git repository,
  can output parts of the index (header, index entries as in
  git ls-files --debug, cache tree as in test-dump-cache-tree, or
  the reuc data). Then it writes the v5 index file format to
  .git/index-v5. Thanks to Michael Haggerty for the code review.
- Prototype of a reader for the new index file format. [3] The
  reader has mainly the purpose to show the algorithm used to read
  the index lexicographically sorted after the full name which is
  required by the current internal memory format. Big thanks for
  reviewing this code and giving me advice on refactoring goes
  to Michael Haggerty.
- Read the index format format and translate it to the current in
  memory format. This doesn't include reading any of the current
  extensions, which are now part of the main index. The code again
  is on github. [4] Thanks for reviewing the first steps to Thomas
  Rast.
- Read the cache-tree data (formerly an extension, now it's integrated
  with the rest of the directory data) from the new ondisk format.
  There are still a few optimizations to do in this algorithm.
- Started implementing the API (suggested by Duy), but it's still
  in the very early stages. There is one commit for this on GitHub [1],
  but it's a very early work in progress.
- Started implementing the writer, which extracts the directories from
  the in-memory format, and writes the header and the directories to
  disk.
- I found a few bugs in the algorithm for extracting the directories
  and decided to completely rewrite it, using a hash table instead of
  simple lists, since the old one would have to many corner cases to
  handle.
- Implemented writing the file block to disk, and basic tests from the
  test suite are running fine, not including tests that require
  conflicted data or the cache-tree to work, which both are not
  implemented yet.
- Started implementing a patch to introduce a ce_namelen field in
  struct cache_entry and drop the name length from the flags. [5]

== Work done int the last week ==

- Polished the patch for the ce_namelen field. The thread for the
  patch can be found at [5]. Again thanks to Junio, Duy and Thomas
  for reviewing it and giving me suggestions for improving it.
- Implemented the cache-tree and conflict data writing to the
  index-v5 file.
  
== Outlook for the next week ==

- There are still a few bugs in the conflict writing, which will
  be fixed, to make the test suite pass with index-v5.
- Once the test suite passes, the code still needs to be refactored
  and optimized.
- If the two points above go well, I'll continue working on the api
  that Duy suggested.

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/200997
