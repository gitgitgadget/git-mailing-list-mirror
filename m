From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Regression: git-svn clone failure
Date: Tue, 22 Dec 2009 11:21:15 -0800
Message-ID: <20091222192115.GA10313@dcvr.yhbt.net>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 20:21:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNAIM-0005yX-DY
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 20:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbZLVTVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 14:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZLVTVR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 14:21:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37141 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbZLVTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 14:21:16 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E471F4F1;
	Tue, 22 Dec 2009 19:21:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135595>

Andrew Myrick <amyrick@apple.com> wrote:
> [Resending because I forgot to make the message plain text]
> 
> I was testing the latest changes to git-svn pushed to Eric's repo
> (git://git.bogomips.org/git-svn) by cloning a few other projects that
> I work on, and one of those clones failed where it had succeeded with
> git 1.6.5.  The error message I received is:
> 
> W:svn cherry-pick ignored (/branches/BranchA:3933-3950) - missing 1 commit(s) (eg 3fc50d3a7e0f555547ab34bb570db47ce71e1abb)
> W:svn cherry-pick ignored (/branches/BranchB:3951-3970) - missing 1 commit(s) (eg 3beb9f2fde0a91aa0e8097e05f9054b23b221daf)
> W:svn cherry-pick ignored (/branches/BranchC:3971-3985) - missing 1 commit(s) (eg a7ae202254604f8a78cca391be36c58efc79eb20)
> Found merge parent (svn:mergeinfo prop): 8b2cf9e9250b5ff1fe47c68215d0a178cfe35a3b
> Found merge parent (svn:mergeinfo prop): 59f8c571ae77885469bb31f007b0048ee7812e07
> fatal: ambiguous argument '0..1': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> rev-list -1 0..1: command returned error: 128

Hi Andrew,

That looks like a simple error, does the following patch help?

diff --git a/git-svn.perl b/git-svn.perl
index 3670960..dba0d12 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3163,7 +3163,8 @@ sub find_extra_svn_parents {
 				next unless $new_parents[$i];
 				next unless $new_parents[$j];
 				my $revs = command_oneline(
-					"rev-list", "-1", "$i..$j",
+					"rev-list", "-1",
+					"$new_parents[$i]..$new_parents[$j]",
 				       );
 				if ( !$revs ) {
 					undef($new_parents[$i]);


Unfortunately I don't know my way around the rest of this code well
so I shall defer to Sam if it's something else...
-- 
Eric Wong
