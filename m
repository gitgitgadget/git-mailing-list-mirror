From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 10:15:36 +0000
Message-ID: <20141031101530.GA29248@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 11:15:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk9F9-0002yF-55
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 11:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbaJaKPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 06:15:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44200 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756741AbaJaKPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 06:15:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8741F838;
	Fri, 31 Oct 2014 10:15:38 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids the following failure with normal "get_dir" on newer
versions of SVN (tested with SVN 1.8.8-1ubuntu3.1):

  Incorrect parameters given: Could not convert '%ld' into a number

get_dir2 also has the potential to be more efficient by requesting
less data.

ref: <1414636504.45506.YahooMailBasic@web172304.mail.ir2.yahoo.com>
ref: <1414722617.89476.YahooMailBasic@web172305.mail.ir2.yahoo.com>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
---
  This should fix the vbox clone problem.  SVN Perl binding
  breakage (again :<).  I shall revert the int() changes.

  > I added those two lines to my git and there is no improvement. It
  > still won't svn fetch the next revision. I think it may be
  > important/interesting to find out when or how it becomes non-int, so
  > I have tar'gz'ed my wont-fetch virtual box .git and in the middle of
  > uploading here: 
  >
  > http://sourceforge.net/projects/outmodedbonsai/files/R/

  > I am also uploading my old R clone also - maybe you'd like to see
  > why its .git/svn/.caches is so big compared to a recent one,

  Jakob's changes causes different access patterns, so it's expected the
  sizes vary.  I also changed the cherry pick cache and removed the
  _rev_list caching entirely, so it should be much smaller now.

  > as well as how and why there were an extra merge and two missing
  > merges compared to a recent clone?

  The different merges are fine, I think, as stated in
    http://mid.gmane.org/20141030230831.GA14160@dcvr.yhbt.net

 perl/Git/SVN/Ra.pm | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 82d6108..1e52709 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -177,7 +177,17 @@ sub get_dir {
 		}
 	}
 	my $pool = SVN::Pool->new;
-	my ($d, undef, $props) = $self->SUPER::get_dir($dir, $r, $pool);
+	my ($d, undef, $props);
+
+	if (defined &SVN::Ra::get_dir2) { # appeared in SVN 1.4
+		# n.b. in addition to being potentially more efficient,
+		# this works around what appears to be a bug in some
+		# SVN 1.8 versions
+		my $kind = 1; # SVN_DIRENT_KIND
+		($d, undef, $props) = $self->get_dir2($dir, $r, $kind, $pool);
+	} else {
+		($d, undef, $props) = $self->get_dir($dir, $r, $pool);
+	}
 	my %dirents = map { $_ => { kind => $d->{$_}->kind } } keys %$d;
 	$pool->clear;
 	if ($r != $cache->{r}) {
-- 
EW
