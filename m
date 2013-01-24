From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] mergetool: clean up temp files when aborted
Date: Thu, 24 Jan 2013 13:23:49 -0500
Message-ID: <1359051829-21331-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, "Theodore Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 19:24:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyRTM-000445-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 19:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab3AXSYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 13:24:03 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:18131 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab3AXSYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 13:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1923; q=dns/txt; s=iport;
  t=1359051842; x=1360261442;
  h=from:to:cc:subject:date:message-id;
  bh=mk8kUeCOpoxfMlqK7LUM7J3d+5wb/XGahqwyZuOLY4k=;
  b=eVYQMytzPBZeT6cfIuaMZoKbb419ICwRiP5vgXBEead+/3w/kZBwv1W2
   sOil5cA/24ijU4TPPpq7KyvLbWRfP1tZekMAYngVwdUI6tiuuhxIi5DfI
   iNJ8EtIitmHGqCYCgkRUGZKcTLb7DgQKWdeKAjFZjQZzaYKdbjIrVQx41
   s=;
X-IronPort-AV: E=Sophos;i="4.84,530,1355097600"; 
   d="scan'208";a="167636784"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by rcdn-iport-4.cisco.com with ESMTP; 24 Jan 2013 18:24:01 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core2-1.cisco.com (8.14.5/8.14.5) with ESMTP id r0OIO0Ti002328;
	Thu, 24 Jan 2013 18:24:00 GMT
X-Mailer: git-send-email 1.8.1.1.ga649ac9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214438>

When handling a symlink conflict or a deleted-file conflict, mergetool
stops to ask the user what to do. If the user chooses any option besides
"(a)bort", then the temporary files which mergetool created in
preparation for handling the conflict are removed.  But these temporary
files are not removed when the user chooses to abort the operation.

    $ git cherry-pick other/branch
    error: could not apply 4e43581... Fix foo.c

    $ git status --short
    DU foo.c

    $ git mergetool
    Merging:
    foo.c

    Deleted merge conflict for 'foo.c':
      {local}: deleted
      {remote}: modified file
    Use (m)odified or (d)eleted file, or (a)bort? a
    Continue merging other unresolved paths (y/n) ? n

    $ git status --short
    DU foo.c
    ?? foo.c.BACKUP.16929.c
    ?? foo.c.BASE.16929.c
    ?? foo.c.LOCAL.16929.c
    ?? foo.c.REMOTE.16929.c

These temporary files should not remain after the mergetool operation is
completed.

Remove the temporary files by calling the cleanup_temp_files when the
user chooses to abort the mergetool operation.

It looks like 'cleanup_temp_files' without the --save-backups option is
the correct thing to do, and this is how this commit is implemented. But
some other paths do use --save-backups resulting in a foo.c.orig file
being left behind.  That seems to be a different bug, though.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 git-mergetool.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index c50e18a..bb93b70 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -90,6 +90,7 @@ resolve_symlink_merge () {
 			return 0
 			;;
 		[aA]*)
+			cleanup_temp_files
 			return 1
 			;;
 		esac
@@ -118,6 +119,7 @@ resolve_deleted_merge () {
 			return 0
 			;;
 		[aA]*)
+			cleanup_temp_files
 			return 1
 			;;
 		esac
-- 
1.8.1.1.ga649ac9.dirty
