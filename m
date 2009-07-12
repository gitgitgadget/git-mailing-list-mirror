From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: allow uppercase UUIDs from SVN
Date: Sun, 12 Jul 2009 11:58:21 -0700
Message-ID: <20090712185821.GA26749@dcvr.yhbt.net>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com> <20090710033133.GA23082@dcvr.yhbt.net> <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com> <20090710203322.GA18051@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Esben Skovenborg <esskov@oncable.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 20:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ4GP-0006oD-34
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 20:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbZGLS6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 14:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbZGLS6Z
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 14:58:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58765 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646AbZGLS6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 14:58:24 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D15DC1F5D0;
	Sun, 12 Jul 2009 18:58:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090710203322.GA18051@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123157>

SVN allows uppercase A-F characters in repositories.  Although
`svnadmin' does not create UUIDs with uppercase by default, it
is possible to change the UUID of a SVN repository and SVN
itself will make no attempt to normalize them.

Thanks to Esben Skovenborg for discovering this issue.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Esben: thank you for helping me find and confirming the fix!

  Junio: pushed out to git://git.bogomips.org/git-svn along with
         some patches I think I forgot to tell you about:

    Eric Wong (1):
          git svn: allow uppercase UUIDs from SVN

    Mattias Nissler (2):
          git-svn: Always duplicate paths returned from get_log
          git-svn: Fix branch detection when repository root is inaccessible

 git-svn.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ec84758..cfade63 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1359,11 +1359,11 @@ sub read_repo_config {
 sub extract_metadata {
 	my $id = shift or return (undef, undef, undef);
 	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
-							\s([a-f\d\-]+)$/x);
+							\s([a-f\d\-]+)$/ix);
 	if (!defined $rev || !$uuid || !$url) {
 		# some of the original repositories I made had
 		# identifiers like this:
-		($rev, $uuid) = ($id =~/^\s*git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
+		($rev, $uuid) = ($id =~/^\s*git-svn-id:\s(\d+)\@([a-f\d\-]+)/i);
 	}
 	return ($url, $rev, $uuid);
 }
@@ -2010,7 +2010,7 @@ sub _set_svm_vars {
 
 		chomp($src, $uuid);
 
-		$uuid =~ m{^[0-9a-f\-]{30,}$}
+		$uuid =~ m{^[0-9a-f\-]{30,}$}i
 		    or die "doesn't look right - svm:uuid is '$uuid'\n";
 
 		# the '!' is used to mark the repos_root!/relative/path
@@ -2096,7 +2096,7 @@ sub svnsync {
 		   die "doesn't look right - svn:sync-from-url is '$url'\n";
 
 		my $uuid = tmp_config('--get', "$section.svnsync-uuid");
-		($uuid) = ($uuid =~ m{^([0-9a-f\-]{30,})$}) or
+		($uuid) = ($uuid =~ m{^([0-9a-f\-]{30,})$}i) or
 		   die "doesn't look right - svn:sync-from-uuid is '$uuid'\n";
 
 		$svnsync = { url => $url, uuid => $uuid }
@@ -2114,7 +2114,7 @@ sub svnsync {
 	           die "doesn't look right - svn:sync-from-url is '$url'\n";
 
 	my $uuid = $rp->{'svn:sync-from-uuid'} or die $err . "uuid\n";
-	($uuid) = ($uuid =~ m{^([0-9a-f\-]{30,})$}) or
+	($uuid) = ($uuid =~ m{^([0-9a-f\-]{30,})$}i) or
 	           die "doesn't look right - svn:sync-from-uuid is '$uuid'\n";
 
 	my $section = "svn-remote.$self->{repo_id}";
@@ -2130,7 +2130,7 @@ sub ra_uuid {
 	unless ($self->{ra_uuid}) {
 		my $key = "svn-remote.$self->{repo_id}.uuid";
 		my $uuid = eval { tmp_config('--get', $key) };
-		if (!$@ && $uuid && $uuid =~ /^([a-f\d\-]{30,})$/) {
+		if (!$@ && $uuid && $uuid =~ /^([a-f\d\-]{30,})$/i) {
 			$self->{ra_uuid} = $uuid;
 		} else {
 			die "ra_uuid called without URL\n" unless $self->{url};
@@ -2848,7 +2848,7 @@ sub make_log_entry {
 			die "Can't have both 'useSvmProps' and 'rewriteRoot' ",
 			    "options set!\n";
 		}
-		my ($uuid, $r) = $headrev =~ m{^([a-f\d\-]{30,}):(\d+)$};
+		my ($uuid, $r) = $headrev =~ m{^([a-f\d\-]{30,}):(\d+)$}i;
 		# we don't want "SVM: initializing mirror for junk" ...
 		return undef if $r == 0;
 		my $svm = $self->svm;
-- 
Eric Wong
