From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 12
Date: Mon, 9 Jul 2012 21:46:48 +0200
Message-ID: <20120709194648.GA2385@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 21:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoJvC-0007Gh-KT
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 21:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2GITq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 15:46:57 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52994 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab2GITq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 15:46:56 -0400
Received: by gglu4 with SMTP id u4so10494367ggl.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=0C9a1t/RJMJPwHfYavpDjDnE5n4fqKfswA/TOQythIk=;
        b=eO+HxpcVWEciZQmitQyLq1RWeXjESj0E3OVaignF4I3d/4wcD3koxF6zWC0kY/ctA1
         og6ijmDUP+3l1pk/ix/70tN4jH1yIR0RaxblWjUkwOEnNxS85Lx2kDZsIIA8BTWd1Lem
         BBr8mbs06h1186LXuj1JH+li1bgLh2t827+f2pVqFMdQjCdxrc/kmcSW8/9kFBMKuNnt
         8zPT8Q9nmCAjow5UnnkHYS/ThMBOs9LFZ/OjZXu0cwfEBiUEzHFHjBUpxVk3Up6RCDqM
         n+g8/HRGUm9VMs4k1+nFL/V2BF0RhVkA08fZq2dRvdvrVDo/wBlLqOsCQaqdFOmFTX+u
         uz/Q==
Received: by 10.60.154.232 with SMTP id vr8mr43072468oeb.30.1341863215823;
        Mon, 09 Jul 2012 12:46:55 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id n7sm19435092oec.2.2012.07.09.12.46.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jul 2012 12:46:54 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201222>



== Work done in the previous 11 weeks ==

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

== Work done in the last week ==

- Unfortunately this weeks progress was slower than expected due to
  exams at university. Those are now over however, so I can fully
  concentrate on the work for Google Summer of Code.
- This week I started implementing a patch to replace the ce_namelen()
  function with a field ce_namelen field in struct cache_entry. This
  will both give us some extra bits of performance in some (rare)
  cases with the old index format, and is a refactoring for index-v5,
  which won't store the length in the flags. The thread for the patch
  is here [5]. Thanks to Junio, Duy and Thomas for reviews of this patch.

== Outlook for the next week ==

- Polish the patch for the ce_namelen field.
- Implement the cache-tree and conflict data writing to the index file.

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/200997
