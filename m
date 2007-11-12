From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: support for funky branch and project names over HTTP(S)
Date: Sun, 11 Nov 2007 23:37:42 -0800
Message-ID: <20071112073742.GA28665@mayonaise>
References: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael J. Cohen" <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 08:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTrs-0005n4-AK
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 08:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbXKLHhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 02:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbXKLHho
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 02:37:44 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57218 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbXKLHho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 02:37:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3ABA07DC0FE;
	Sun, 11 Nov 2007 23:37:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 23:37:42 -0800
Content-Disposition: inline
In-Reply-To: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64570>

SVN requires that paths be URI-escaped for HTTP(S) repositories.
file:// and svn:// repositories do not need these rules.

Additionally, accessing individual paths inside repositories
(check_path() and get_log() do NOT require escapes to function
and in fact it breaks things).

Noticed-by: Michael J. Cohen <mjc@cruiseplanners.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                          |   24 ++++++++++++++++++-
 t/t9118-git-svn-funky-branch-names.sh |   40 +++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100755 t/t9118-git-svn-funky-branch-names.sh

  "Michael J. Cohen" <michaeljosephcohen@mac.com> wrote:
  > mini:TextMateBundles mjc$ git-svn fetch
  > Found possible branch point: 
  > http://macromates.com/svn/Bundles/trunk/Tools/Dialog PlugIn => 
  >  http://macromates.com/svn/Bundles/branches/Dialog PlugIn  Completion Menu, 
  > 8089
  > Initializing parent: Dialog PlugIn Completion Menu@8089
  > Bad URL passed to RA layer: Malformed URL for repository at /opt/local/ 
  > bin/git-svn line 1607
  > 
  > looks like that might need to be %20 ?
  > 
  > -mjc

diff --git a/git-svn.perl b/git-svn.perl
index 7589276..9ffda3e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3223,6 +3223,25 @@ sub _auth_providers () {
 	]
 }
 
+sub escape_uri_only {
+	my ($uri) = @_;
+	my @tmp;
+	foreach (split m{/}, $uri) {
+		s/([^\w.-])/sprintf("%%%02X",ord($1))/eg;
+		push @tmp, $_;
+	}
+	join('/', @tmp);
+}
+
+sub escape_url {
+	my ($url) = @_;
+	if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
+		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
+		$url = "$scheme://$domain$uri";
+	}
+	$url;
+}
+
 sub new {
 	my ($class, $url) = @_;
 	$url =~ s!/+$!!;
@@ -3255,10 +3274,11 @@ sub new {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
 	} # no warnings 'once'
-	my $self = SVN::Ra->new(url => $url, auth => $baton,
+	my $self = SVN::Ra->new(url => escape_url($url), auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
+	$self->{url} = $url;
 	$self->{svn_path} = $url;
 	$self->{repos_root} = $self->get_repos_root;
 	$self->{svn_path} =~ s#^\Q$self->{repos_root}\E(/|$)##;
@@ -3384,7 +3404,7 @@ sub gs_do_switch {
 
 	my $full_url = $self->{url};
 	my $old_url = $full_url;
-	$full_url .= "/$path" if length $path;
+	$full_url .= '/' . escape_uri_only($path) if length $path;
 	my ($ra, $reparented);
 	if ($old_url ne $full_url) {
 		if ($old_url !~ m#^svn(\+ssh)?://#) {
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
new file mode 100755
index 0000000..640bb06
--- /dev/null
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description='git-svn funky branch names'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svnrepo' "
+	mkdir project project/trunk project/branches project/tags &&
+	echo foo > project/trunk/foo &&
+	svn import -m '$test_description' project \"$svnrepo/pr ject\" &&
+	rm -rf project &&
+	svn cp -m 'fun' \"$svnrepo/pr ject/trunk\" \
+	                \"$svnrepo/pr ject/branches/fun plugin\" &&
+	svn cp -m 'more fun!' \"$svnrepo/pr ject/branches/fun plugin\" \
+	                      \"$svnrepo/pr ject/branches/more fun plugin!\" &&
+	start_httpd
+	"
+
+test_expect_success 'test clone with funky branch names' "
+	git svn clone -s \"$svnrepo/pr ject\" project &&
+	cd project &&
+		git rev-parse 'refs/remotes/fun%20plugin' &&
+		git rev-parse 'refs/remotes/more%20fun%20plugin!' &&
+	cd ..
+	"
+
+test_expect_success 'test dcommit to funky branch' "
+	cd project &&
+	git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
+	echo hello >> foo &&
+	git commit -m 'hello' -- foo &&
+	git svn dcommit &&
+	cd ..
+	"
+
+stop_httpd
+
+test_done
-- 
Eric Wong
