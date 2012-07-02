From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 11
Date: Mon, 2 Jul 2012 21:55:49 +0200
Message-ID: <20120702195549.GA666@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, mhagger@alum.mit.edu, pclouds@gmail.com,
	trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 21:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slmj0-0000eX-Ts
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 21:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab2GBTzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 15:55:54 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50205 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab2GBTzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 15:55:53 -0400
Received: by werb14 with SMTP id b14so2767230wer.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=+Hc5hsNnoOuZbU1b0S4hFYUnL/IbPwto3ydq2RzHs7U=;
        b=PEb7wehBgZeWve/IhBxJHlLl9D47rbaQQ9Ov/mV6VkeooMO8LP3qhF1Rk9Gyeta/hg
         OCnAiVqSRPGz6McZc5NXNdH+kFrDw1D9Tye1zVxrCUglsLCBEWUMkxAu590kEODjxh0/
         8EtJI9MbxaAa0mtlwiiiOYEn9QyJlMdOBSNb3rMy8kvs1EsMJ/95vSOHfdfZf9vpmIxA
         hNBGVlvdwQAc7vsYvO2B/5rvlKJf0hK+jMckLq1ahslqeCZak6HY41RpE1ftjLkcCgDz
         ycfPUflJVydzCCIuE/5xBLyQSd9riHA/e/TLHiUZNffKQd58WR6im3kY4ut6M5o8EKuJ
         eGqA==
Received: by 10.180.80.134 with SMTP id r6mr25773305wix.1.1341258951899;
        Mon, 02 Jul 2012 12:55:51 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id j6sm13060171wiy.4.2012.07.02.12.55.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Jul 2012 12:55:51 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200858>

== Work done in the previous 10 weeks ==

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

== Work done in the last 2 weeks ==

- I found a few bugs in the algorithm for extracting the directories
  and decided to completely rewrite it, using a hash table instead of
  simple lists, since the old one would have to many corner cases to
  handle.
- Implemented writing the file block to disk, and basic tests from the
  test suite are running fine, not including tests that require
  conflicted data or the cache-tree to work, which both are not
  implemented yet.

== Outlook for the next week ==

- Implement a patch to replace the ce_namelen() function with a field
  ce_namelen field in struct cache_entry. This will both give us some
  extra bits of performance in some (rare) cases with the old index
  format, and is a refactoring for index-v5, which won't store the
  length in the flags. This patch will be sent to the list once it's
  done.
- Depending how long the patch takes, I'll try implementing the
  cache-tree and conflict data writing to the index file.

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
