From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 01/10] merge-recursive: Remove redundant check for removing rename source
Date: Mon, 21 Mar 2011 12:30:55 -0600
Message-ID: <1300732264-9638-2-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmj-0000RW-5h
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1CUSYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62978 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1CUSYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:38 -0400
Received: by vws1 with SMTP id 1so5291756vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=bpsBmyTXvG2tp3FKpj0jY1lNZrO3i6ZJUzzjxRndxXw=;
        b=KjhRh8pR0aCAsP79wbpUL6FSNLWkGDKU+ROrpKLMUCZC2kchNja2gpPNMJl/szfBQk
         VoMR8FQxrICZ2cmzuXywg8l8rCMFOFKXId0fu1+hdgCXnfGNd0bInjXlStPnGIIkq4H3
         JO3qHFRuKER0T2uJkUgwKx2hYkaW0j9kXiSEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qexq1PM715Du2ZrHzrS3b9WVQpQUjkX6TqrU5yNtGxRoBVNqDPcpoYcSZMc1TvtiYl
         H0az/ueUIKbjcalteLnUZcDDFZfhmhdSDAx/0QR697skLhu9EaDnNm9OQ7xd3cnp0/+b
         Nom616U3Q02PyQG5UcUKG0tIXR1PtThvq/sQU=
Received: by 10.220.176.203 with SMTP id bf11mr1310187vcb.57.1300731878173;
        Mon, 21 Mar 2011 11:24:38 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.36
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169630>

If a file is renamed on the side of history being merged into head, the
filename serving as the source of that rename needs to be removed from the
working directory.  (This statement is about a real merge rather than a
merge of merge bases to come up with a virtual ancestor; in the latter
case, no working directory changes of any type should be made).

The path to getting the above statement implemented in merge-recursive took
several steps.  The relevant bits of code may be instructive to keep in
mind for the explanation, especially since an English-only description
involves double negatives that are hard to follow.  These bits of code are:
  int remove_file(..., const char *path, int no_wd)
  {
    ...
    int update_working_directory = !o->call_depth && !no_wd;
and
  remove_file(o, 1, ren1_src, <expression>);
Where the choice for <expression> has morphed over time:

65ac6e9 (merge-recursive: adjust to loosened "working file clobbered"
check 2006-10-27), introduced the "no_wd" parameter to remove_file() and
used "1" for <expression>.  This meant ren1_src was never deleted, leaving
it around in the working copy.

In 8371234 (Remove uncontested renamed files during merge. 2006-12-13),
<expression> was changed to "index_only" (where index_only ==
!!o->call_depth; see b7fa51da).   This was equivalent to using "0" for
<expression> (due to the early logic in remove_file), and is orthogonal to
the condition we actually want to check at this point; it resulted in the
source file being removed except when index_only was false.  This was
problematic because the file could have been renamed on the side of history
including head, in which case ren1_src could correspond to an untracked
file that should not be deleted.

In 183d797 (Keep untracked files not involved in a merge. 2007-02-04),
<expression> was changed to "index_only || stage == 3".  While this gives
correct behavior, the "index_only ||" portion of <expression> is
unnecessary and makes the code slightly harder to follow.

There were also two further changes to this expression, though without
any change in behavior.  First in b7fa51d (merge-recursive: get rid of the
index_only global variable 2008-09-02), it was changed to "o->call_depth
|| stage == 3".  (index_only == !!o->call_depth).  Earlier in this series
(merge-recursive: Small code clarification -- variable name and comments),
this was changed to "o->call_depth || renamed_stage == 2" (where stage
was renamed to other_stage and renamed_stage == other_stage ^ 1).

So we ended with <expression> being "o->call_depth || renamed_stage == 2".
But the "o->call_depth ||" piece was unnecessary.  Remove it.
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 42d52cb..6dc74dc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1055,7 +1055,7 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
-			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
+			remove_file(o, 1, ren1_src, renamed_stage == 2);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
-- 
1.7.4
