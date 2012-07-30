From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 15
Date: Mon, 30 Jul 2012 22:20:11 +0200
Message-ID: <20120730202011.GC1006@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com, trast@student.ethz.ch,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 22:20:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvwRy-0002nD-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab2G3UUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:20:17 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42036 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195Ab2G3UUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:20:15 -0400
Received: by wibhm11 with SMTP id hm11so2176615wib.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=+cuckg/KJf/+mTJVaGPoc4gquX8+HpWbEWCqxUEJM4E=;
        b=bzsOM6ZtBYOE2smr7emsv7Y3Nt34HF0jf1BZ3yR+62IPcTnJQxGBEgpREqHr0liJrI
         GTtj5ggOQqqoFU2LqR2fTLD47EqlL9IDnKaN0icSvzLzWZw6S22o4HtXNZAwPUvmQ6Kz
         DWgDhU+7KRdDi0zJ0ZZzJSMJqKwS7SP+ax9RP7/QJmRh4+O+WZwA1RDgfHvCsghfpiKu
         A7E7Wq7Jky3euecX5b9PBHZw0/I5KHaPB6eCBvn45j9HxQx6X1zio4a4Bd7CEU92CgWR
         bUff3/eNQXf+ooxn5RxGjpVwsVTynytXiXQNKMv0crXET07B6Po5TABWBcBOU9GKFlDP
         BK7g==
Received: by 10.216.236.163 with SMTP id w35mr6290923weq.13.1343679613763;
        Mon, 30 Jul 2012 13:20:13 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id cl8sm18239159wib.10.2012.07.30.13.20.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 13:20:13 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202610>

== Work done in the previous 14 weeks ==

- Definition of a tentative index file v5 format [1]. This differs
  from the proposal in making it possible to bisect the directory
  entries and file entries, to do a binary search. The exact bits
  for each section were also defined. To further compress the index,
  along with prefix compression, the stat data is hashed, since
  it's only used for equality comparison, but the plain data is
  never used.
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
- Read the on-disk index file format and translate it to the current
  in memory format. This doesn't include reading any of the current
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
  disk. The algorithm uses a hash-table instead of a simple list,
  to avoid many corner cases.
- Implemented writing the file block to disk, and basic tests from the
  test suite are running fine, not including tests that require
  conflicted data or the cache-tree to work, which both are not
  implemented yet.
- Started implementing a patch to introduce a ce_namelen field in
  struct cache_entry and drop the name length from the flags. [5]
  Thanks to Junio, Duy and Thomas for reviews and suggestions for
  improving it.
- Implemented the cache-tree and conflict data writing to the
  index-v5 file.
- Implemented the rest of the index-v5 code, so that it passes the
  test suite.
- Added a hack for partial loading of index-v5 for git ls-files and
  git grep. For performance results of this hack see: [6]

== Work done in the last week ==

- Lots of refactoring of the index-v5 code
- Some slight optimizations of the code
- Brought the python reader up to date, and added the possibility to
  update a single index entry, to test the re-reading code when updating
  single index entry. (The updating of a single index entry is not
  implemented in C yet)
- Make the reader re-read a single index entry, if the crc code is wrong.
- Implement the new racy code for git, along the lines of what Thomas
  posted at [7]. The code also addresses the concerns of Johannes and
  Junio, by using the timestamp of the index, that is already written
  instead of the time of the index file that will be written. The checking
  if the index entry really changed will be left to the reader. If anyone
  is interested in the code it's at [8].

== Outlook for the next week ==

- Fix some minor nits in the code, which are still remaining.
- Bring the history to release format, and send the patches to the list.


[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/200997
[6] http://thread.gmane.org/gmane.comp.version-control.git/201964
[7] http://thread.gmane.org/gmane.comp.version-control.git/199309
[8] https://github.com/tgummerer/git/tree/racy-WIP
