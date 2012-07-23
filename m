From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 14
Date: Mon, 23 Jul 2012 21:08:47 +0200
Message-ID: <20120723190847.GA40532@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com, trast@student.ethz.ch,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 21:09:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StO06-00085w-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2GWTI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:08:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47476 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab2GWTI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:08:56 -0400
Received: by yhmm54 with SMTP id m54so5836516yhm.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=MIDxtWQEPAXfuvgJ98iZuXiuiihjUvkGNJ7xW+gwBBE=;
        b=F3IxNAMQ6zwQXbmNZ51iu6Vj8NB7qO+3b+hxzTgfDzPSzd0P+g6eCHlM94reVo3oWV
         0bUj4wSOfcp9B5aNOwsuZqimAPH6PxUuOuwoyNzi9wPpAFr4HUOaqFWu5UxZaP8Q/XLN
         UtKBPN1MAFMSObwaQSPRshqjMiPJdKIKnNFOfApehWcmV+MrUftagK+k2t+YsdgsxszJ
         EH1QDlIQOx2Mnh7tHSiG/ll01mI51jYc/zedb0ayIpLKj00P2SOWKCkfxzrsWmb/YWMg
         kBQ+c8V+kDXDPttnGCoAu4wTW4wjXa4IQeD0mFuxaLX4rGBuxfQ4n+06aXbGz5HcaDed
         ZuZA==
Received: by 10.60.7.104 with SMTP id i8mr22373690oea.31.1343070535771;
        Mon, 23 Jul 2012 12:08:55 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id q7sm11530040obo.17.2012.07.23.12.08.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 12:08:54 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201964>

== Work done in the previous 13 weeks ==

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

== Work done in the last week ==

- Fixed a few bugs in cache-tree and conflict writing in my index-v5
  code.
- I visited Thomas in Zuerich this weekend, as some of you may
  have noticed on the mailing list, thanks a lot for the
  hospitality. And thanks also to Tomas for the company on saturday
  night.
- With the help of Thomas I fixed the resolve undo data writing,
  and a couple more bugs in my code, so that the test suite passes
  with INDEX_VERSION_DEFAULT = 5.
- We added a POC, for partial loading in git grep. This is still a
  pretty hacky implementation, but it demonstrates pretty well
  how much can be gained. Here are the timings Thomas posted on
  IRC yesterday. The improvements of ls-files are not drastic
  compared to index-v4, but git greps in subdirs benefit a lot
  from partial loading.

  Test                                      this tree
  -----------------------------------------------------------
  0002.2: v[23]: ls-files                   0.13(0.11+0.02)
  0002.3: v[23]: grep nonexistent -- subdir 0.12(0.10+0.02)
  0002.5: v4: ls-files                      0.11(0.09+0.01)
  0002.6: v4: grep nonexistent -- subdir    0.10(0.08+0.02)
  0002.8: v5: ls-files                      0.10(0.07+0.02)
  0002.9: v5: grep nonexistent -- subdir    0.01(0.00+0.00)

- All changes again are in my repository on github, in case someone
  wants to try them out. [4]

== Outlook for the next week ==

- Refactoring of the code. There are still some code smells in the
  current code, which need to be refactored.
- There are also still some possible optimizations for the code,
  which will be included.
- I'll also bring the reader up to date again, and make it possible
  for it to update a single index entry, to test the implementation 
  of rereading a entry when the crc is wrong (for the future partial
  write, both writer and reader side still have to be implemented).

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/200997
