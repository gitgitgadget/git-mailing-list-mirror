From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Tue, 17 Jul 2012 10:24:52 +0200
Message-ID: <20120717082452.GC1849@tgummerer.surfnet.iacbox>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
 <7vwr23zb65.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 10:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr35h-00031m-85
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 10:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab2GQIY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 04:24:58 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46790 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2GQIYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 04:24:54 -0400
Received: by wgbdr13 with SMTP id dr13so147848wgb.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Nw6GZ+p1rbBTTKGkk1medxR3bL0n/CHMeqL/MQZV85E=;
        b=uuNFXp59A/DeDcFmTLC9yV+cV9icePM7gQeaSOdFwF6YRkoMchiD50hoaSt249GZ+u
         ECKmhrwVWks4X5+IlXtm6MHJ7+y2aGctZ25mJEd7tHZGqh4klwsa4hO9C7+KBgG9aVLV
         GcxHxoobVTHIKK4ho674VczdehgQ0Vcm4vIFLOax5BvAYuiXdC9ZnBIrJLmRoCYHvp85
         +G4ukhIsPFy9S9UFVHpLi7joinZ9o4q972SSwxLr4Ia5DO1rCsrHT0DPqAUfOzEXvunB
         tSKdCbM0WriIPMBnzAk0+LxM6f4WP1PopxDXM6UbLUJrH1zkBW6+jaTZC39FhFqSaLGD
         lW8Q==
Received: by 10.180.98.138 with SMTP id ei10mr2165970wib.1.1342513493514;
        Tue, 17 Jul 2012 01:24:53 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id b7sm38350285wiz.9.2012.07.17.01.24.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 01:24:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwr23zb65.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201593>

Thanks Junio for reading the progress report, this is just
corrected version without the errors that he pointed out.

== Work done in the previous 12 weeks ==

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
