From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't sanitize remote names in config
Date: Sat, 28 Jun 2008 20:40:32 -0700
Message-ID: <20080629034032.GA23492@untitled>
References: <1214322898-9272-1-git-send-email-apenwarr@gmail.com> <20080625064435.GL21299@hand.yhbt.net> <20080625065556.GM21299@hand.yhbt.net> <7vfxr23s6m.fsf@gitster.siamese.dyndns.org> <20080625074548.GA8984@hand.yhbt.net> <32541b130806250801p1508d15axc610f335b8d235ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 05:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCnn9-0007Vu-QR
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 05:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbYF2Dkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 23:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYF2Dkf
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 23:40:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45874 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYF2Dkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 23:40:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 234422DC095;
	Sat, 28 Jun 2008 20:40:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130806250801p1508d15axc610f335b8d235ef@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86758>

The original sanitization code was just taken from the
remotes2config.sh shell script in contrib.

Credit to Avery Pennarun for noticing this mistake, and Junio
for clarifying the rules for config section names:

Junio C Hamano wrote <7vfxr23s6m.fsf@gitster.siamese.dyndns.org>:
> In
>
> 	[foo "bar"] baz = value
>
> foo and baz must be config.c::iskeychar() (and baz must be isalpha()), but
> "bar" can be almost anything.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Avery Pennarun <apenwarr@gmail.com> wrote:
  > On 6/25/08, Eric Wong <normalperson@yhbt.net> wrote:
  > > No, nothing to do with DNS hostnames in the remote names.  I think I
  > >  just looked at remotes2config.sh one day and used it as a reference :x
  > >
  > >  It's late and I've had a rough few days, but shouldn't
  > >  sanitize_remote_name() just escape . and "?  Right now it's converting
  > >  stuff to . which has me very confused...
  > 
  > I think there might be higher-level problems here: what is it
  > sanitizing anyway, and why?  If it found my D2007_Win32 svn-remote
  > entry in the config (as it seems to have done when trying to locate
  > its parent branch during fetch), and *then* it sanitized it to
  > D2007.Win32, that doesn't even make any sense.  Clearly something
  > straight from the config file doesn't need to be sanitized.
  > 
  > However, I don't understand the code well enough to be able to say a)
  > whether that's exactly what happened, or b) other places where
  > sanitize_remote_name() *is* important, or c) whether
  > sanitize_remote_name() is even correct.

  Nope.  It's not important anywhere from what I can tell.

-- 

 git-svn.perl |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 50ace22..f789a6e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1462,13 +1462,6 @@ sub verify_remotes_sanity {
 	}
 }
 
-# we allow more chars than remotes2config.sh...
-sub sanitize_remote_name {
-	my ($name) = @_;
-	$name =~ tr{A-Za-z0-9:,/+-}{.}c;
-	$name;
-}
-
 sub find_existing_remote {
 	my ($url, $remotes) = @_;
 	return undef if $no_reuse_existing;
@@ -2853,7 +2846,7 @@ sub _new {
 	unless (defined $ref_id && length $ref_id) {
 		$_[2] = $ref_id = $Git::SVN::default_ref_id;
 	}
-	$_[1] = $repo_id = sanitize_remote_name($repo_id);
+	$_[1] = $repo_id;
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
 	$_[3] = $path = '' unless (defined $path);
 	mkpath(["$ENV{GIT_DIR}/svn"]);
@@ -4707,8 +4700,7 @@ sub minimize_connections {
 
 		# skip existing cases where we already connect to the root
 		if (($ra->{url} eq $ra->{repos_root}) ||
-		    (Git::SVN::sanitize_remote_name($ra->{repos_root}) eq
-		     $repo_id)) {
+		    ($ra->{repos_root} eq $repo_id)) {
 			$root_repos->{$ra->{url}} = $repo_id;
 			next;
 		}
@@ -4747,8 +4739,7 @@ sub minimize_connections {
 	foreach my $url (keys %$new_urls) {
 		# see if we can re-use an existing [svn-remote "repo_id"]
 		# instead of creating a(n ugly) new section:
-		my $repo_id = $root_repos->{$url} ||
-		              Git::SVN::sanitize_remote_name($url);
+		my $repo_id = $root_repos->{$url} || $url;
 
 		my $fetch = $new_urls->{$url};
 		foreach my $path (keys %$fetch) {
-- 
Eric Wong
