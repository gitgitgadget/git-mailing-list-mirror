From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [bug][bisected] git-svn with root branches
Date: Wed, 21 Oct 2009 23:30:36 -0700
Message-ID: <20091022063036.GA8081@dcvr.yhbt.net>
References: <20091021144113.GA7440@cumin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Cordero <theappleman@gmail.com>,
	Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 08:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0rC9-0006QL-Us
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 08:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZJVGag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZJVGaf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 02:30:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54505 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbZJVGaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 02:30:35 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id ECF191F9B9;
	Thu, 22 Oct 2009 06:30:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091021144113.GA7440@cumin>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130995>

Daniel Cordero <theappleman@gmail.com> wrote:
> Hello,
> 
> when trying to clone a svn repo with the command-line:
> 
> 	$ git svn clone -b / http://svn.collab.net/repos/svn/
> 
> (that is, each folder in the root of the repo should be considered it's
> own branch)
> the clone sometimes[1] fails saying:
> 
> 	ref: 'refs/remotes/' ends with a trailing slash, this is not permitted by git nor Subversion
> 
> The offending config is:
> [svn-remote "svn"]
>         url = http://svn.collab.net/repos/svn
>         branches = /*:refs/remotes/*
> 
> 
> This used to work in the past; I bisected the bad commit to
> 
> commit 6f5748e14cc5bb0a836b649fb8e2d6a5eb166f1d
> Author: Adam Brewster <adambrewster@gmail.com>
> Date:   Tue Aug 11 23:14:03 2009 -0400
> 
>     svn: allow branches outside of refs/remotes
> 
> 
> Thanks in advance.

Thanks for bisecting it for us!

Reverting the left hand side of these two regexps from Adam's commit
seems to fix the problem.

diff --git a/git-svn.perl b/git-svn.perl
index eb4b75a..56af221 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1765,7 +1765,7 @@ sub read_all_remotes {
 	my $use_svm_props = eval { command_oneline(qw/config --bool
 	    svn.useSvmProps/) };
 	$use_svm_props = $use_svm_props eq 'true' if $use_svm_props;
-	my $svn_refspec = qr{\s*/?(.*?)\s*:\s*(.+?)\s*};
+	my $svn_refspec = qr{\s*(.*?)\s*:\s*(.+?)\s*};
 	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
 		if (m!^(.+)\.fetch=$svn_refspec$!) {
 			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
@@ -1979,7 +1979,7 @@ sub find_ref {
 	my ($ref_id) = @_;
 	foreach (command(qw/config -l/)) {
 		next unless m!^svn-remote\.(.+)\.fetch=
-		              \s*/?(.*?)\s*:\s*(.+?)\s*$!x;
+		              \s*(.*?)\s*:\s*(.+?)\s*$!x;
 		my ($repo_id, $path, $ref) = ($1, $2, $3);
 		if ($ref eq $ref_id) {
 			$path = '' if ($path =~ m#^\./?#);
---

I'm not sure why Adam decided the leading slash needed to be removed for
the git refspec.  That said, the globbing/branching code still makes me
want to hide under a rock and I'm generally afraid to touch it.
I'll wait for Adam to chime in since he's braver than I am :)

-- 
Eric Wong
