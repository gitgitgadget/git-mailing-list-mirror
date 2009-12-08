From: Greg Price <price@ksplice.com>
Subject: [PATCH] git svn: Don't create empty directories whose parents were
	deleted
Date: Mon, 7 Dec 2009 22:28:32 -0500
Message-ID: <20091208032831.GL30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 04:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqko-0002Yg-6d
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 04:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935824AbZLHD2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 22:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935820AbZLHD2c
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 22:28:32 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63607 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935761AbZLHD2a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 22:28:30 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nB83S4V0007360;
	Mon, 7 Dec 2009 22:28:04 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nB83SgxO023167;
	Mon, 7 Dec 2009 22:28:43 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134811>

Commit 6111b93 "git svn: attempt to create empty dirs on clone+rebase"
will create empty directories 'a/b' and 'a/c' if they were previously
created in SVN, even if their parent directory 'a' was deleted.

For example, unhandled.log may contain lines like this:

r32
  +empty_dir: packages/sipb-xen-remctl-auto/sipb-xen-remctl-auto/files/etc/remctl/sipb-xen-auto/acl
  +empty_dir: packages/sipb-xen-remctl-auto/sipb-xen-remctl-auto/files/etc/remctl/sipb-xen-auto/machine.d
  +empty_dir: packages/sipb-xen-remctl-auto/sipb-xen-remctl-auto/files/etc/remctl/sipb-xen-auto/moira-acl
[...]
r314
  -empty_dir: packages/sipb-xen-remctl-auto

Reported-by: Evan Broder <broder@mit.edu>
Signed-off-by: Greg Price <price@ksplice.com>
---

This is a regression in v1.6.6-rc0, so it would be good to fix before v1.6.6.

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 957d44e..5c35494 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2748,7 +2748,7 @@ sub mkemptydirs {
 		} elsif (/^  \+empty_dir: (.+)$/) {
 			$empty_dirs{$1} = 1;
 		} elsif (/^  \-empty_dir: (.+)$/) {
-			delete $empty_dirs{$1};
+			delete @empty_dirs{grep {m[^\Q$1\E(/|$)]} (keys %empty_dirs)};
 		}
 	}
 	close $fh;
-- 
1.6.4.4
