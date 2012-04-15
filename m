From: Christian Engwer <christian.engwer@wwu.de>
Subject: Re: [PATCH] prohibit "svn dcommit" on remote-tracking-branches
Date: Sun, 15 Apr 2012 20:55:35 +0200
Message-ID: <20120415185535.GA9150@mathe-macht-spass.de>
References: <handler.667488.B.133354466019267.ack@bugs.debian.org>
 <20120410211732.GB27555@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	667488@bugs.debian.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 20:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJUbG-0007L1-Gj
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 20:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab2DOSyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 14:54:23 -0400
Received: from marnach.net ([87.230.94.153]:41045 "EHLO
	lvps87-230-94-153.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812Ab2DOSyW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 14:54:22 -0400
Received: from dslb-084-060-028-065.pools.arcor-ip.net ([84.60.28.65] helo=sansibar)
	by lvps87-230-94-153.dedicated.hosteurope.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <christi@mathe-macht-spass.de>)
	id 1SJUaV-0002Kh-Qd; Sun, 15 Apr 2012 20:54:15 +0200
Received: from christi by sansibar with local (Exim 4.77)
	(envelope-from <christi@mathe-macht-spass.de>)
	id 1SJUbo-0002OV-0n; Sun, 15 Apr 2012 20:55:36 +0200
Content-Disposition: inline
In-Reply-To: <20120410211732.GB27555@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195573>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi!

On Tue, Apr 10, 2012 at 09:17:32PM +0000, Eric Wong wrote:
> Christian Engwer <christian.engwer@wwu.de> wrote:
> > A branch should either be a local copy of an svn branch, or a remote
> > tracking branch. After a "git svn dcommit" a remote tracking branch
> > could not be synced with the git remote due to the rebase that occured
> > during the dcommit. Thus we check for a remote entry in the git config
> > for the current branch and prohibit the "dcommit" if such an entry
> > exists.
> 
> Should there be an option to force/override this?

As stated there is the alternative idea to use pre-dcommit-hook.

I prepared an updated version which behaves as follows:

a) prohibit commit if a remote-tracking branch is used
b) allow commit if --commit-url is used
c) allow commit if the allow-dcommit flag is true in .git/config

Please give comments...

<snip/>

Cheers
Christian


--9amGYk9869ThD9tj
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-prohibit-svn-dcommit-on-remote-tracking-branches.patch"

>From 1e1e151c358b9a8c472e70eaf7aa3f6855554f6c Mon Sep 17 00:00:00 2001
From: Christian Engwer <christian.engwer@wwu.de>
Date: Sun, 15 Apr 2012 19:27:55 +0200
Subject: [PATCH] prohibit "svn dcommit" on remote-tracking-branches

A branch should either be a local copy of an svn branch, or a remote
tracking branch. After a "git svn dcommit" a remote tracking branch
could not be synced with the git remote due to the rebase that occured
during the dcommit. Thus we check for a remote entry in the git config
for the current branch and prohibit the "dcommit" if such an entry
exists.

This behaviour can be overwritten by either providing an explicit commit url
on the command line via "--commit-url" or by setting branch.${branch}.allow-dcommit
to true.
---
 git-svn.perl |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..4a334b9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -759,6 +759,30 @@ sub cmd_dcommit {
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
 	$head ||= 'HEAD';
+	my ($branches,$ctx) = eval { command_output_pipe('branch') };
+	my $branch = undef;
+	while (<$branches>) {
+		chomp;
+		if (s/^\* +//) {
+			$branch = $_;
+		}
+	}
+	command_close_pipe($branches, $ctx);
+
+	my $allowdcommit = eval { command_oneline('config', '--get',
+										      "branch.${branch}.allow-dcommit") };
+
+	if ((! defined $_commit_url) and $allowdcommit ne 'true') {
+		my $remote = eval { command_oneline('config', '--get',
+										  "branch.${branch}.remote") };
+		if ($remote) {
+			die "You specified a non-svn remote for branch ${branch}.\n".
+				"To commit to an svn repository, you can either remove the\n".
+				"  \"branch.${branch}.remote\" entry, or explicitly set a commit url\n".
+				"  on the command-line via \"--commit-url\" or override the bahavior\n".
+				"  by setting \"branch.${branch}.allow-dcommit = true\" via git config";
+		}
+	}
 
 	my $old_head;
 	if ($head ne 'HEAD') {
-- 
1.7.9.5


--9amGYk9869ThD9tj--
