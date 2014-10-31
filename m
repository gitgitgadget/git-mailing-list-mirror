From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 10:34:03 +0000
Message-ID: <20141031103403.GA6190@dcvr.yhbt.net>
References: <20141031101530.GA29248@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 11:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk9X2-0005X4-3b
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 11:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015AbaJaKeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 06:34:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44325 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757958AbaJaKeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 06:34:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91BF1F838;
	Fri, 31 Oct 2014 10:34:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141031101530.GA29248@dcvr.yhbt.net>
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
 Sorry, waaay past my bed time.  This version doesn't infinite loop
 on autoload or older SVN(*) (at least I hope it doesn't)

 perl/Git/SVN/Ra.pm | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 82d6108..496f430 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -177,7 +177,17 @@ sub get_dir {
 		}
 	}
 	my $pool = SVN::Pool->new;
-	my ($d, undef, $props) = $self->SUPER::get_dir($dir, $r, $pool);
+	my ($d, undef, $props);
+
+	if (::compare_svn_version('1.4.0') >= 0) {
+		# n.b. in addition to being potentially more efficient,
+		# this works around what appears to be a bug in some
+		# SVN 1.8 versions
+		my $kind = 1; # SVN_DIRENT_KIND
+		($d, undef, $props) = $self->get_dir2($dir, $r, $kind, $pool);
+	} else {
+		($d, undef, $props) = $self->SUPER::get_dir($dir, $r, $pool);
+	}
 	my %dirents = map { $_ => { kind => $d->{$_}->kind } } keys %$d;
 	$pool->clear;
 	if ($r != $cache->{r}) {
-- 
EW
