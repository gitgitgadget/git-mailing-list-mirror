From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Don't create empty directories whose parents
	were deleted
Date: Mon, 7 Dec 2009 20:59:26 -0800
Message-ID: <20091208045926.GA17683@dcvr.yhbt.net>
References: <20091208032831.GL30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>
To: Greg Price <price@ksplice.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 05:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHsAt-0004cC-3p
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 05:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935788AbZLHE7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 23:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935784AbZLHE7c
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 23:59:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38555 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935626AbZLHE7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 23:59:21 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6451FA98;
	Tue,  8 Dec 2009 04:59:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091208032831.GL30538@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134814>

Greg Price <price@ksplice.com> wrote:
> This is a regression in v1.6.6-rc0, so it would be good to fix before v1.6.6.

Thanks Greg,

I found another git svn bug (fixed in a patch below) while writing a
test case for this.

Junio:

  The following are pushed out to git://git.bogomips.org/git-svn and
  should be ready for v1.6.6:

    Alex Vandiver (1):
          git-svn: sort svk merge tickets to account for minimal parents

    Eric Wong (1):
          git svn: log removals of empty directories

    Greg Price (1):
          git svn: Don't create empty directories whose parents were deleted

Thanks all

>From f9ad77a739c0d012ee58b64eda2d7ec0d4e1df9d Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 7 Dec 2009 20:49:38 -0800
Subject: [PATCH] git svn: log removals of empty directories

This also adds a test case for:
  "git svn: Don't create empty directories whose parents were deleted"
which was the reason we found this bug in the first place.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                  |    2 +-
 t/t9146-git-svn-empty-dirs.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index bdd1f96..5a52068 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3891,11 +3891,11 @@ sub delete_entry {
 		}
 		print "\tD\t$gpath/\n" unless $::_q;
 		command_close_pipe($ls, $ctx);
-		$self->{empty}->{$path} = 0
 	} else {
 		$self->{gii}->remove($gpath);
 		print "\tD\t$gpath\n" unless $::_q;
 	}
+	$self->{empty}->{$path} = 0;
 	undef;
 }
 
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 70c52c1..9b8d046 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -105,4 +105,14 @@ test_expect_success 'empty directories in trunk exist' '
 	)
 '
 
+test_expect_success 'remove a top-level directory from svn' '
+	svn_cmd rm -m "remove d" "$svnrepo"/d
+'
+
+test_expect_success 'removed top-level directory does not exist' '
+	git svn clone "$svnrepo" removed &&
+	test ! -e removed/d
+
+'
+
 test_done
-- 
Eric Wong
