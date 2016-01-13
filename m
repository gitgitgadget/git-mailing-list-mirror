From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: loosen config globs limitations
Date: Wed, 13 Jan 2016 03:16:01 +0000
Message-ID: <20160113031601.GA28224@dcvr.yhbt.net>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com, gitster@pobox.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 04:16:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJBuq-0006A5-IF
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 04:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbcAMDQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 22:16:04 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59801 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbcAMDQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 22:16:02 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB77F1FD21;
	Wed, 13 Jan 2016 03:16:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283873>

Thanks, I made a minor cleanup and applied with --whitespace=fix
to remove spaces from indentation.

--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -15,8 +15,10 @@ sub new {
 			 $part !~ /^\{[^{}]+\}/) {
 			die "Invalid pattern in '$glob': $part\n";
 		}
-		my $nstars = $part =~ tr/\*//;
-		die "Only one '*' is allowed in a pattern: '$part'\n" if $nstars > 1;
+		my $nstars = $part =~ tr/*//;
+		if ($nstars > 1) {
+			die "Only one '*' is allowed in a pattern: '$part'\n";
+		}
 		if ($part =~ /(.*)\*(.*)/) {
 			die $die_msg if $state eq "right";
 			my ($l, $r) = ($1, $2);

So I'll push out with the following commit message:

Subject: [PATCH] git-svn: loosen config globs limitations

Expand the area of globs applicability for branches and tags
in git-svn. It is now possible to use globs like 'a*e', or 'release_*'.
This allows users to avoid long lines in config like:

	branches = branches/{release_20,release_21,release_22,...}

In favor of:

	branches = branches/release_*

[ew: amended commit message, minor formatting and style fixes]

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>



I also noticed the "Only one set of wildcard directories" error
message is unnecessary long and "wildcard directories" should
probably be shortened to "wildcards" to avoid wrapping in a terminal.
That will probably be a separate patch for me.
