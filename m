From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: avoid crashing svnserve when creating new directories
Date: Sat, 19 May 2007 02:58:37 -0700
Message-ID: <20070519095837.GA387@muzzle>
References: <vpq7irfengj.fsf@bauges.imag.fr> <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com> <vpqtzuf46k9.fsf@bauges.imag.fr> <20070519061422.GA17528@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 11:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpLi2-0005M0-Cr
	for gcvg-git@gmane.org; Sat, 19 May 2007 11:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXESJ6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 05:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbXESJ6j
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 05:58:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59165 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767AbXESJ6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 05:58:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6D5F37DC0A4;
	Sat, 19 May 2007 02:58:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 19 May 2007 02:58:37 -0700
Content-Disposition: inline
In-Reply-To: <20070519061422.GA17528@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47733>

When sorting directory names by depth (slash ("/") count) and
closing the deepest directories first (as the protocol
requires), we failed to put the root baton (with an empty string
as its key "") after top-level directories (which did not have
any slashes).

This resulted in svnserve being in a situation it couldn't
handle and caused a segmentation fault on the remote server.

This bug did not affect users of DAV and filesystem repositories.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e38811a..6d0cdac 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2841,8 +2841,10 @@ sub close_edit {
 	my ($self) = @_;
 	my ($p,$bat) = ($self->{pool}, $self->{bat});
 	foreach (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$bat) {
+		next if $_ eq '';
 		$self->close_directory($bat->{$_}, $p);
 	}
+	$self->close_directory($bat->{''}, $p);
 	$self->SUPER::close_edit($p);
 	$p->clear;
 }
-- 
Eric Wong
