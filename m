From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix rel_path() when not connected to the repository root
Date: Sun, 25 Mar 2007 16:35:31 -0700
Message-ID: <20070325233531.GA13433@muzzle>
References: <20070325180218.GI942MdfPADPa@greensroom.kotnet.org> <20070325201943.GE846@localdomain> <20070325204156.GK942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 01:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcFb-0000q4-6q
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXCYXfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbXCYXfh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:35:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44696 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbXCYXfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:35:33 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A69002DC01A;
	Sun, 25 Mar 2007 16:35:31 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 25 Mar 2007 16:35:31 -0700
Content-Disposition: inline
In-Reply-To: <20070325204156.GK942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43094>

This should fix fetching for people who did not use
"git svn --minimize" or cannot connect to the repository root
due to the lack of permissions.

I'm not sure what I was on when I made the change to the
rel_path() function in 4e9f6cc78e5d955bd0faffe76ae9aea6590189f1
that made it die() when we weren't connected to the repository
root :x

Thanks to Sven Verdoolaege for reporting this bug.
---

Sven: Let me know if this fixes things for your repo.

 git-svn.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e845789..e0a48c2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1327,8 +1327,10 @@ sub rel_path {
 	my ($self) = @_;
 	my $repos_root = $self->ra->{repos_root};
 	return $self->{path} if ($self->{url} eq $repos_root);
-	die "BUG: rel_path failed! repos_root: $repos_root, Ra URL: ",
-	    $self->ra->{url}, " path: $self->{path},  URL: $self->{url}\n";
+	my $url = $self->{url} .
+	          (length $self->{path} ? "/$self->{path}" : $self->{path});
+	$url =~ s!^\Q$repos_root\E(?:/+|$)!!g;
+	$url;
 }
 
 sub traverse_ignore {
-- 
Eric Wong
