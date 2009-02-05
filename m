From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v4 0/4] Extend mailmap functionality
Date: Thu,  5 Feb 2009 09:06:37 +0100
Message-ID: <cover.1233819451.git.marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 09:09:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzIp-0002MM-3t
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbZBEIIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbZBEIIM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:08:12 -0500
Received: from hoat.troll.no ([62.70.27.150]:58557 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251AbZBEIIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:08:09 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 72F3D20F7B;
	Thu,  5 Feb 2009 09:08:01 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 5C20720F6F;
	Thu,  5 Feb 2009 09:08:01 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.354.g200fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108526>

  v4:
  ---
  * Refactored out name and email parsing into separate function
  * Added support for only email replacement (<new> <old> construct)
  * Added "static" to functions local to compile unit only
  * Fixed C++ style comment to bash style comment in commit message
  * Added more air in the commit messages
  * Rebased ontop of latest master
  v3:
  ---
  * Make log.mailmap augment repo "/.mailmap" rather than override
  * Remove second argument of read_mailmap(<map>, <file>, <abbrev>);
  * Wrap commit messages within column 70
  v2:
  ---
  * Folded in documentation fixup from patch 4 into patch 3.


This patch series extends the mailmap functionality to:
  1) Allow the mailmap file in any location (also outside repo)
  2) Enable mailmap to match on both Name and Email

So, why would this be a good thing?

2) Lets you replace both name and email of an author/committer, based
on a name and/or email, _and_ replace email only, based on old email.
So, should you have done commits with faulty address, or if an old
email simply isn't valid anymore, you can add a mapping for that to
replace it. So, the old style mapping is
    Proper Name <commit@email.xx>

while this patch series adds support for
    <proper@email.xx> <commit@email.xx>
    Proper Name <proper@email.xx> <commit@email.xx>
    Proper Name <proper@email.xx> Commit Name <commit@email.xx>

1) Lets you keep a private mailmap file, which is not distributed with
your repository.


This extended mapping is necessary when a company wants to have their
repositories open to the public, but needs to protect the identities
of the developers. It enables you to only show nicks and standardized
emails, like 'Dev123 <bugs@company.xx>' in the public repo, but by
using an private mailmap file, map the name back to
'John Doe <john.doe@company.xx>' inside the company.


Patch serie applies cleanly on master branch (88ccb9f9), and test run
shows no regressions.


Marius Storm-Olsen (4):
  Add log.mailmap as configurational option for mailmap location
  Add find_insert_index, insert_at_index and clear_func functions to
    string_list
  Add map_user() and clear_mailmap() to mailmap
  Change current mailmap usage to do matching on both name and email of
    author/committer.

 Documentation/config.txt         |    8 ++
 Documentation/git-shortlog.txt   |   67 +++++++++---
 Documentation/pretty-formats.txt |    2 +
 builtin-blame.c                  |   52 ++++++----
 builtin-shortlog.c               |   25 ++++-
 cache.h                          |    1 +
 config.c                         |   10 ++
 mailmap.c                        |  208 +++++++++++++++++++++++++++++++------
 mailmap.h                        |    6 +-
 pretty.c                         |   59 ++++++-----
 string-list.c                    |   43 +++++++-
 string-list.h                    |    9 ++
 t/t4203-mailmap.sh               |  215 ++++++++++++++++++++++++++++++++++++++
 13 files changed, 601 insertions(+), 104 deletions(-)
 create mode 100755 t/t4203-mailmap.sh
