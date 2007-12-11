From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] git-svn: get color config from --get-colorbool
Date: Tue, 11 Dec 2007 01:28:42 -0500
Message-ID: <20071211062842.GB21768@coredump.intra.peff.net>
References: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org> <20071211061743.GA21718@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yc6-0000c3-OL
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbXLKG2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754468AbXLKG2p
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:28:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1697 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584AbXLKG2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:28:45 -0500
Received: (qmail 6655 invoked by uid 111); 11 Dec 2007 06:28:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 01:28:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 01:28:42 -0500
Content-Disposition: inline
In-Reply-To: <20071211061743.GA21718@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67803>

git-config recently learned a --get-colorbool option. By
using it, we will get the same color=auto behavior that
other git commands have.

Specifically, this fixes the case where "color.diff = true"
meant "always" in git-svn, but "auto" in other programs.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-svn.perl |   35 ++---------------------------------
 1 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9f884eb..1c42c55 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3969,39 +3969,7 @@ sub cmt_showable {
 }
 
 sub log_use_color {
-	return 1 if $color;
-	my ($dc, $dcvar);
-	$dcvar = 'color.diff';
-	$dc = `git-config --get $dcvar`;
-	if ($dc eq '') {
-		# nothing at all; fallback to "diff.color"
-		$dcvar = 'diff.color';
-		$dc = `git-config --get $dcvar`;
-	}
-	chomp($dc);
-	if ($dc eq 'auto') {
-		my $pc;
-		$pc = `git-config --get color.pager`;
-		if ($pc eq '') {
-			# does not have it -- fallback to pager.color
-			$pc = `git-config --bool --get pager.color`;
-		}
-		else {
-			$pc = `git-config --bool --get color.pager`;
-			if ($?) {
-				$pc = 'false';
-			}
-		}
-		chomp($pc);
-		if (-t *STDOUT || (defined $pager && $pc eq 'true')) {
-			return ($ENV{TERM} && $ENV{TERM} ne 'dumb');
-		}
-		return 0;
-	}
-	return 0 if $dc eq 'never';
-	return 1 if $dc eq 'always';
-	chomp($dc = `git-config --bool --get $dcvar`);
-	return ($dc eq 'true');
+	return $color || Git->repository->get_colorbool('color.diff');
 }
 
 sub git_svn_log_cmd {
@@ -4060,6 +4028,7 @@ sub config_pager {
 	} elsif (length $pager == 0 || $pager eq 'cat') {
 		$pager = undef;
 	}
+	$ENV{GIT_PAGER_IN_USE} = defined($pager);
 }
 
 sub run_pager {
-- 
1.5.3.7.2230.g796d07-dirty
