From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: reduce memory usage for large commits
Date: Sat, 14 Oct 2006 15:48:35 -0700
Message-ID: <20061014224834.GB12565@soma>
References: <00f701c6ef92$88b84840$1267a8c0@Jocke> <00f301c6ef76$62172060$1267a8c0@Jocke> <20061014224636.GA12565@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 00:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYsJ7-0004p5-Mq
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 00:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbWJNWsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbWJNWsh
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 18:48:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52886 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752228AbWJNWsg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 18:48:36 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4E3317DC08D;
	Sat, 14 Oct 2006 15:48:35 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 14 Oct 2006 15:48:35 -0700
To: Junio C Hamano <junkio@cox.net>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Disposition: inline
In-Reply-To: <20061014224636.GA12565@soma>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28892>

apply_textdelta and send_stream can use a separate pool from the
rest of the editor interface, so we'll use a separate SVN::Pool
for them and clear the pool after each file is sent to SVN.

This drastically reduces memory usage per-changeset committed,
and makes large commits (and initial imports) of several
thousand files possible.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0f968c8..54d2356 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3354,9 +3354,11 @@ sub chg_file {
 	seek $fh, 0, 0 or croak $!;
 
 	my $exp = $md5->hexdigest;
-	my $atd = $self->apply_textdelta($fbat, undef, $self->{pool});
-	my $got = SVN::TxDelta::send_stream($fh, @$atd, $self->{pool});
+	my $pool = SVN::Pool->new;
+	my $atd = $self->apply_textdelta($fbat, undef, $pool);
+	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
 	die "Checksum mismatch\nexpected: $exp\ngot: $got\n" if ($got ne $exp);
+	$pool->clear;
 
 	close $fh or croak $!;
 }
-- 
1.4.3.rc2.ge931
