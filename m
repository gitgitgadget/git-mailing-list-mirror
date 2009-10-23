From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: fix fetch where glob is on the top-level URL
Date: Thu, 22 Oct 2009 21:48:43 -0700
Message-ID: <20091023044843.GA16169@dcvr.yhbt.net>
References: <20091021144113.GA7440@cumin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Brewster <adambrewster@gmail.com>,
	Daniel Cordero <theappleman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 06:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1C57-0006Nv-2D
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 06:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbZJWEsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbZJWEsm
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 00:48:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37710 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbZJWEsm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 00:48:42 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id DD57F1F9B9;
	Fri, 23 Oct 2009 04:48:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091021144113.GA7440@cumin>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131085>

>From 3abaf9fdf216fd0307bb9e9f03772bd80a64177c Mon Sep 17 00:00:00 2001
From: Adam Brewster <adambrewster@gmail.com>
Date: Thu, 22 Oct 2009 21:26:32 -0700
Subject: [PATCH] git svn: fix fetch where glob is on the top-level URL

In cases where the top-level URL we're tracking is the path we
glob against, we can once again track odd repositories that keep
branches/tags at the top level.  This regression was introduced
in commit 6f5748e14cc5bb0a836b649fb8e2d6a5eb166f1d.

Additionally, the leading slash is now optional when tracking
the top-level path to be consistent with non-top-level paths.
We now allow both of the following "branches" in [svn-remote
"foo"] sections of $GIT_CONFIG:

	; with a leading slash (this worked before 6f5748e1)
        branches = /*:refs/remotes/*

	; now it it also works without a leading slash
        branches = *:refs/remotes/*

Thanks to Daniel Cordero for the original bug report and
bisection.

[ew: commit message]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

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
  > 
  > 
  > [1] It does work when the URL has at least 1 folder of depth
  > (e.g. suffix "trunk" to the above URL).
  > 
  > Its config section is:
  > [svn-remote "svn"]
  >         url = http://svn.collab.net/repos/svn
  > 	branches = trunk//*:refs/remotes/*
  > 

 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eb4b75a..2e9a720 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1768,7 +1768,7 @@ sub read_all_remotes {
 	my $svn_refspec = qr{\s*/?(.*?)\s*:\s*(.+?)\s*};
 	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
 		if (m!^(.+)\.fetch=$svn_refspec$!) {
-			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
+			my ($remote, $local_ref, $remote_ref) = ($1, "/$2", $3);
 			die("svn-remote.$remote: remote ref '$remote_ref' "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
@@ -1780,7 +1780,7 @@ sub read_all_remotes {
 			$r->{$1}->{url} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
 			my ($remote, $t, $local_ref, $remote_ref) =
-			                                     ($1, $2, $3, $4);
+			                                   ($1, $2, "/$3", $4);
 			die("svn-remote.$remote: remote ref '$remote_ref' ($t) "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
@@ -1980,7 +1980,7 @@ sub find_ref {
 	foreach (command(qw/config -l/)) {
 		next unless m!^svn-remote\.(.+)\.fetch=
 		              \s*/?(.*?)\s*:\s*(.+?)\s*$!x;
-		my ($repo_id, $path, $ref) = ($1, $2, $3);
+		my ($repo_id, $path, $ref) = ($1, "/$2", $3);
 		if ($ref eq $ref_id) {
 			$path = '' if ($path =~ m#^\./?#);
 			return ($repo_id, $path);
-- 
Eric Wong
