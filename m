From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: avoid respewing similar error messages for missing paths
Date: Fri, 30 Mar 2007 17:54:48 -0700
Message-ID: <20070331005448.GA6948@muzzle>
References: <m28xdkvsxx.fsf@ziti.fhcrc.org> <20070327190004.GD16591@localdomain> <m23b3qts11.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 02:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXRrx-0008Qb-Ia
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 02:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbXCaAyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 20:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933231AbXCaAyv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 20:54:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46736 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933223AbXCaAyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 20:54:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1FBB37DC094;
	Fri, 30 Mar 2007 17:54:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 30 Mar 2007 17:54:48 -0700
Content-Disposition: inline
In-Reply-To: <m23b3qts11.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43517>

We ignore errors if the path we're tracking did not exist for
a particular revision range, but we still print out warnings
telling the user about that.

As pointed out by Seth Falcon, this amounts to a lot of warnings
that could confuse and worry users.  I'm not entirely comfortable
completely silencing the warnings, but showing one warning per
path that we track should be reasonable.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index adc976c..d307d43 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2843,8 +2843,7 @@ package Git::SVN::Ra;
 use vars qw/@ISA $config_dir $_log_window_size/;
 use strict;
 use warnings;
-my ($can_do_switch);
-my $RA;
+my ($can_do_switch, %ignored_err, $RA);
 
 BEGIN {
 	# enforce temporary pool usage for some simple functions
@@ -3216,9 +3215,16 @@ sub skip_unknown_revs {
 	# 175007 - http(s):// (this repo required authorization, too...)
 	#   More codes may be discovered later...
 	if ($errno == 175007 || $errno == 175002 || $errno == 160013) {
-		warn "W: Ignoring error from SVN, path probably ",
-		     "does not exist: ($errno): ",
-		     $err->expanded_message,"\n";
+		my $err_key = $err->expanded_message;
+		# revision numbers change every time, filter them out
+		$err_key =~ s/\d+/\0/g;
+		$err_key = "$errno\0$err_key";
+		unless ($ignored_err{$err_key}) {
+			warn "W: Ignoring error from SVN, path probably ",
+			     "does not exist: ($errno): ",
+			     $err->expanded_message,"\n";
+			$ignored_err{$err_key} = 1;
+		}
 		return;
 	}
 	die "Error from SVN, ($errno): ", $err->expanded_message,"\n";
-- 
Eric Wong
