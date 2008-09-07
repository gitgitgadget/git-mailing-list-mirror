From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Unable to clone svn repository
Date: Sat, 6 Sep 2008 21:04:01 -0700
Message-ID: <20080907040401.GA19659@untitled>
References: <1293837402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: m.skoric@web.de
X-From: git-owner@vger.kernel.org Sun Sep 07 06:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcBWX-0001CC-3L
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 06:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbYIGEEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 00:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbYIGEEF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 00:04:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42126 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbYIGEEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 00:04:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 411432DC01B;
	Sat,  6 Sep 2008 21:04:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1293837402@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95110>

m.skoric@web.de wrote:
> Hi guys,

Hi,

> Found possible branch point: https://SECRETURL/trunk => https://SECRETURL/branches/dirk/Abo-Uebernahme (Bug #994), 203
> Found branch parent: (Abo-Uebernahme (Bug #994)@341) bb831869748c98bf97d105c5894ae65331c95c08
> Bad URL passed to RA layer: Malformed URL for repository at /usr/bin/git-svn line 3792

The following patch should fix it.  The strange URL with '#' and ')'
threw it off.

I've also pushed this out to git://git.bogomips.org/git-svn.git

>From f4392df485b197a0797cc503b1e1a71350abfe56 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 6 Sep 2008 20:18:18 -0700
Subject: [PATCH] git-svn: fix handling of even funkier branch names

Apparently do_switch() tolerates the lack of escaping in less
funky branch names.  For the really strange and scary ones, we
need to escape them properly.  It strangely maintains compatible
with the existing handling of branch names with spaces and
exclamation marks.

Reported-by: m.skoric@web.de ($gmane/94677)
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                          |    1 +
 t/t9118-git-svn-funky-branch-names.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ee3f5ed..ecacf74 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4025,6 +4025,7 @@ sub gs_do_switch {
 		}
 	}
 	$ra ||= $self;
+	$url_b = escape_url($url_b);
 	my $reporter = $ra->do_switch($rev_b, '', 1, $url_b, $editor, $pool);
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
 	$reporter->set_path('', $rev_a, 0, @lock, $pool);
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 3281cbd..43ceb75 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -6,6 +6,10 @@
 test_description='git-svn funky branch names'
 . ./lib-git-svn.sh
 
+# Abo-Uebernahme (Bug #994)
+scary_uri='Abo-Uebernahme%20%28Bug%20%23994%29'
+scary_ref='Abo-Uebernahme%20(Bug%20#994)'
+
 test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
@@ -15,6 +19,8 @@ test_expect_success 'setup svnrepo' '
 	                "$svnrepo/pr ject/branches/fun plugin" &&
 	svn cp -m "more fun!" "$svnrepo/pr ject/branches/fun plugin" \
 	                      "$svnrepo/pr ject/branches/more fun plugin!" &&
+	svn cp -m "scary" "$svnrepo/pr ject/branches/fun plugin" \
+	              "$svnrepo/pr ject/branches/$scary_uri" &&
 	start_httpd
 	'
 
@@ -23,6 +29,7 @@ test_expect_success 'test clone with funky branch names' '
 	cd project &&
 		git rev-parse "refs/remotes/fun%20plugin" &&
 		git rev-parse "refs/remotes/more%20fun%20plugin!" &&
+		git rev-parse "refs/remotes/$scary_ref" &&
 	cd ..
 	'
 
@@ -35,6 +42,15 @@ test_expect_success 'test dcommit to funky branch' "
 	cd ..
 	"
 
+test_expect_success 'test dcommit to scary branch' '
+	cd project &&
+	git reset --hard "refs/remotes/$scary_ref" &&
+	echo urls are scary >> foo &&
+	git commit -m "eep" -- foo &&
+	git svn dcommit &&
+	cd ..
+	'
+
 stop_httpd
 
 test_done
-- 
Eric Wong
