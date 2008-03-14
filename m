From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't blindly append '*' to branch/tags config
Date: Fri, 14 Mar 2008 11:01:23 -0700
Message-ID: <20080314180123.GB3107@hand.yhbt.net>
References: <20080313112738.GA28589@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaEEJ-0008J8-9Z
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 19:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbYCNSB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758277AbYCNSB0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 14:01:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33467 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbYCNSBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 14:01:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 627CF7F4153;
	Fri, 14 Mar 2008 11:01:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080313112738.GA28589@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77268>

Previously, git-svn would blindly append '*' even if it was specified by
the user during initialization (for certain SVN setups, it is
necessary).

Now, the following command will work correctly:

  git svn init -T trunk/docutils \
               -t 'tags/*/docutils' \
               -b 'branches/*/docutils' \
               svn://svn.berlios.de/docutils

Thanks to martin f krafft for the bug report:
> My git-svn target configuration is
>
>   [svn-remote "svn"]
>     url = svn://svn.berlios.de/docutils
>     fetch = trunk/docutils:refs/remotes/trunk
>     branches = branches/*/docutils:refs/remotes/*
>     tags = tags/*/docutils:refs/remotes/tags/*
>
> Unfortunately, when I run
>
>   git-svn init -T trunk/docutils -t 'tags/*/docutils'
>    -b 'branches/*/docutils'
>
> then I get (note the two asterisks on the left hand side):
>
>     branches = branches/*/docutils/*:refs/remotes/*
>     tags = tags/*/docutils/*:refs/remotes/tags/*
>
> I took a brief stab at the code but I can't even figure out where
> the /* is appended, so I defer to you.
>
> It should be trivial to keep git-svn from appending /* if the left
> side already contains an asterisk.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d8b38c9..bba22c1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -958,9 +958,10 @@ sub complete_url_ls_init {
 		    "wanted to set to: $gs->{url}\n";
 	}
 	command_oneline('config', $k, $gs->{url}) unless $orig_url;
-	my $remote_path = "$ra->{svn_path}/$repo_path/*";
+	my $remote_path = "$ra->{svn_path}/$repo_path";
 	$remote_path =~ s#/+#/#g;
 	$remote_path =~ s#^/##g;
+	$remote_path .= "/*" if $remote_path !~ /\*/;
 	my ($n) = ($switch =~ /^--(\w+)/);
 	if (length $pfx && $pfx !~ m#/$#) {
 		die "--prefix='$pfx' must have a trailing slash '/'\n";
-- 
Eric Wong
