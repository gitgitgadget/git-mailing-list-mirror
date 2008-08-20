From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problem with git-svn
Date: Wed, 20 Aug 2008 01:11:05 -0700
Message-ID: <20080820080528.GA16665@untitled>
References: <5979e28c0808190641l343ed48fi75c55f9f0cdb1bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Boaz Stuller <boazstuller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 10:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVink-0007pS-KX
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 10:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYHTILN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 04:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYHTILN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 04:11:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43301 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbYHTILG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 04:11:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 9D6522DC01B;
	Wed, 20 Aug 2008 01:11:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5979e28c0808190641l343ed48fi75c55f9f0cdb1bcf@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92971>

Boaz Stuller <boazstuller@gmail.com> wrote:
> I'm having a problem with git-svn.  I was connecting to a remote svn
> repository via the svn+ssh:// protocol using an embedded username in
> the url, i.e svn+ssh://boazstuller@svn.example.com/some/complicated/path.
>  When I upgraded to 1.6.0, 'git svn dcommit' stopped working and
> instead kept asking me for a password.   I tracked the problem down to
> the following commit:
> 
> commit ba24e7457aa1f958370bbb67dfb97e3ec806fd4a
> Author: Eric Wong <normalperson@yhbt.net>
> Date:   Thu Aug 7 02:06:16 2008 -0700
>     git-svn: add ability to specify --commit-url for dcommit
> 
> I don't know perl, but the problem seems to be where around line 446,
> '$gs->full_url' gets changed to  '$url'.  Apparently, $gs->full_url
> contained the embedded username but $url has it stripped out, i.e
> svn+ssh://svn.example.com/some/complicated/path , so ssh can't tell
> what username I'm trying to log in as.

Hi Boaz, thanks for tracking this down.  The following patch should
fix your issue (and another potential one I noticed).

I've lightly tested it and it appears to work for me.

>From de9e79c4a7bdec5481dc0d19ae21ced3a403c0c9 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Wed, 20 Aug 2008 00:30:06 -0700
Subject: [PATCH] git-svn: fix dcommit to urls with embedded usernames

Don't rely on the extracted URL from working_head_info since
that has the username removed.  Instead use the $gs->full_url
method (as before with ba24e7457aa1f958370bbb67dfb97e3ec806fd4a)
to give us the URL to commit to if --commit-url is not
specified.

Aditionally, since we clean usernames from URLs, checking the
URL after rebase can fail because it doesn't match the URL we
used to commit; so unconditionally provide a username-free
URL for checking the result of the refetch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 099fd02..7a1d26d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -421,7 +421,7 @@ sub cmd_dcommit {
 	$head ||= 'HEAD';
 	my @refs;
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
-	$url = $_commit_url if defined $_commit_url;
+	$url = defined $_commit_url ? $_commit_url : $gs->full_url;
 	my $last_rev = $_revision if defined $_revision;
 	if ($url) {
 		print "Committing to $url ...\n";
@@ -437,6 +437,8 @@ sub cmd_dcommit {
 		     "If these changes depend on each other, re-running ",
 		     "without --no-rebase may be required."
 	}
+	my $expect_url = $url;
+	Git::SVN::remove_username($expect_url);
 	while (1) {
 		my $d = shift @$linear_refs or last;
 		unless (defined $last_rev) {
@@ -511,9 +513,9 @@ sub cmd_dcommit {
 					  $gs->refname,
 					  "\nBefore dcommitting";
 				}
-				if ($url_ ne $url) {
+				if ($url_ ne $expect_url) {
 					fatal "URL mismatch after rebase: ",
-					      "$url_ != $url";
+					      "$url_ != $expect_url";
 				}
 				if ($uuid_ ne $uuid) {
 					fatal "uuid mismatch after rebase: ",
-- 
Eric Wong
