From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 9
Date: Mon, 18 Jun 2012 20:46:14 +0200
Message-ID: <20120618184613.GA1439@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, mhagger@alum.mit.edu, pclouds@gmail.com,
	trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 20:46:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sggy7-0002B6-J0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 20:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2FRSqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 14:46:20 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36408 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2FRSqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 14:46:19 -0400
Received: by wibhn6 with SMTP id hn6so2395901wib.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=wS9zh8he43otsKCrTUIqxPE2+jKMuJAtINKzAXI1tcE=;
        b=uMNQOC/ceprTisHc2C+XyrH1z+BDDugzFxylHeZNZ/3LtDOvzs6pDzwUDixYn20b36
         uEmWzausuUcLnfzMH4cQksYENjw4nvD32oSnjUurVBgYI1Z5iRkYBDMjdFDM2f0UEVtF
         Um2P9lUrwSteLYWCvyoTrFQmFX1XYyd3U9050yl9Fm3ZCoLOnMoMYyUV02kbjH/jaU4T
         UzIpF4XtdFVZoSjHGhmIdAknpNkCQwEyshk9pfMl9zOJ+RtYFEF6lFEjKkBspx2HLjd7
         l0vzfpdU/OmB6xijCcXoGrC8KAwshbnm3EHbTSQk/S56vWbcA8YlCfCjkhrNPR0KiRhC
         /L7w==
Received: by 10.180.102.9 with SMTP id fk9mr30106772wib.1.1340045178239;
        Mon, 18 Jun 2012 11:46:18 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id ez4sm27087126wid.3.2012.06.18.11.46.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 11:46:17 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200158>

== Work done in the previous 8 weeks ==

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

== Work done in the last week ==

- Thomas and me discussed [5] what the best way going forward would be
  and decided to go with the writer as the next step, and start with
  the api, once this is finished.
  Also since there are currently exams at the university, development
  will be a bit slower than in the previous weeks.
  I started implementing the writer last week, and it currently
  extracts the directories from the index entries and writes the
  header and the directories to the index file. (Writing the files
  to disk is still missing, and the cache-tree data is not yet
  considered)

== Outlook for the next week ==

- Next week I'll try to implement the writing of the files to disk,
  with the correct offsets.

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/199727/focus=200053
