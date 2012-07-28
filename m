From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 8/8] Remove some ad hoc canonicalizations.
Date: Sat, 28 Jul 2012 02:47:52 -0700
Message-ID: <1343468872-72133-9-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3dv-0005QI-MA
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab2G1Jsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab2G1JsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503035pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DLEOHudKH48MheRmMsJ+CxrhIGZocH7tLoaDfc8qM5M=;
        b=gN8VAdox3FgaInKgAV6vxfGWeX2iEUDwWDu/b1lBBs6eEjCb5JtAYeWNvdaWygkz5u
         LACXghGCb7ZJkXcg1cagUTcQbhrHkf2wsQghV39DVhKiiIv0I9W24UNqB8pf3rAx/v3B
         3RjMiGIu47uAK7oKaYBjjisk8tznY4mkZXmE3tfzpBN16RWlMMGPLj9wD3PmJ7/5b1m7
         HbRwNadSD/g2skVcxI6G7rTsqj/3S33YP9/THeggSKKRSxQAlyjGQhkFO40IRsO/mlXM
         2GMvL/rATUlTz6LD9JM/4/C9458QYqW1ElusEWU95Kk9ELC/En0pYc24N4B8m6UWO6tq
         +VIA==
Received: by 10.68.116.203 with SMTP id jy11mr19953615pbb.129.1343468892483;
        Sat, 28 Jul 2012 02:48:12 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202423>

From: "Michael G. Schwern" <schwern@pobox.com>

---
 git-svn.perl    | 8 ++++----
 perl/Git/SVN.pm | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3d120d5..56d1ba7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -36,6 +36,7 @@ use Git::SVN::Utils qw(
 	canonicalize_url
 	join_paths
 	add_path_to_url
+	join_paths
 );
 
 use Git qw(
@@ -1598,7 +1599,7 @@ sub post_fetch_checkout {
 
 sub complete_svn_url {
 	my ($url, $path) = @_;
-	$path =~ s#/+$##;
+	$path = canonicalize_path($path);
 
 	# If the path is not a URL...
 	if ($path !~ m#^[a-z\+]+://#) {
@@ -1617,7 +1618,7 @@ sub complete_url_ls_init {
 		print STDERR "W: $switch not specified\n";
 		return;
 	}
-	$repo_path =~ s#/+$##;
+	$repo_path = canonicalize_path($repo_path);
 	if ($repo_path =~ m#^[a-z\+]+://#) {
 		$ra = Git::SVN::Ra->new($repo_path);
 		$repo_path = '';
@@ -1638,9 +1639,8 @@ sub complete_url_ls_init {
 	}
 	command_oneline('config', $k, $gs->url) unless $orig_url;
 
-	my $remote_path = $gs->path . "/$repo_path";
+	my $remote_path = join_paths( $gs->path, $repo_path );
 	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
-	$remote_path =~ s#/+#/#g;
 	$remote_path =~ s#^/##g;
 	$remote_path .= "/*" if $remote_path !~ /\*/;
 	my ($n) = ($switch =~ /^--(\w+)/);
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index e5f7acc..3c68c09 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -460,7 +460,6 @@ sub new {
 	}
 	{
 		my $path = $self->path;
-		$path =~ s{/+}{/}g;
 		$path =~ s{\A/}{};
 		$path =~ s{/\z}{};
 		$self->path($path);
-- 
1.7.11.3
