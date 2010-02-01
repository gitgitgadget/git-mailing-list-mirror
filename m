From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: persistent memoization
Date: Sun, 31 Jan 2010 20:03:12 -0800
Message-ID: <20100201040312.GA26199@dcvr.yhbt.net>
References: <1264821262-28322-1-git-send-email-amyrick@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 05:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbnVP-0001tp-KC
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 05:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab0BAEDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 23:03:14 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58244 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470Ab0BAEDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 23:03:13 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76C41F688;
	Mon,  1 Feb 2010 04:03:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1264821262-28322-1-git-send-email-amyrick@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138578>

Andrew Myrick <amyrick@apple.com> wrote:
> Make memoization of the svn:mergeinfo processing functions persistent with
> Memoize::Storable so that the memoization tables don't need to be regenerated
> every time the user runs git-svn fetch.
> 
> The Memoize::Storable hashes are stored in ENV{GIT_DIR}/svn/caches.

Hi Andrew,

Perhaps "$ENV{GIT_DIR}/svn/.caches" is better here since older versions
of git svn used "$ENV{GIT_DIR}/svn/$refname" in the top-level and
"caches" may conflict with existing repos.

> -use File::Path qw/mkpath/;
> +use File::Path qw/mkpath make_path/;

File::Path::make_path is very recent not in Perls distributed by most
vendors.  My 5.10.0 installation (Debian stable) doesn't have it, and I
also don't see a good reason to use it over the traditional mkpath.

I think I'll squash the following patch and Ack.  Let me know if
you have any objections, thanks.!
(also wraps long lines to 80 chars)

diff --git a/git-svn.perl b/git-svn.perl
index 0153439..265852f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1652,7 +1652,7 @@ use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_use_svnsync_props $no_reuse_existing $_minimize_url
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
-use File::Path qw/mkpath make_path/;
+use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
 use Memoize;  # core since 5.8.0, Jul 2002
@@ -3126,25 +3126,25 @@ sub has_no_changes {
 		return if $memoized;
 		$memoized = 1;
 
-		my $cache_path = "$ENV{GIT_DIR}/svn/caches/";
-		make_path($cache_path) unless -d $cache_path;
+		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
+		mkpath([$cache_path]) unless -d $cache_path;
 
-		tie my %lookup_svn_merge_cache =>
-			'Memoize::Storable',"$cache_path/lookup_svn_merge.db", 'nstore';
+		tie my %lookup_svn_merge_cache => 'Memoize::Storable',
+		    "$cache_path/lookup_svn_merge.db", 'nstore';
 		memoize 'lookup_svn_merge',
 			SCALAR_CACHE => 'FAULT',
 			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
 		;
 
-		tie my %check_cherry_pick_cache =>
-			'Memoize::Storable',"$cache_path/check_cherry_pick.db", 'nstore';
+		tie my %check_cherry_pick_cache => 'Memoize::Storable',
+		    "$cache_path/check_cherry_pick.db", 'nstore';
 		memoize 'check_cherry_pick',
 			SCALAR_CACHE => 'FAULT',
 			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
 		;
 
-		tie my %has_no_changes_cache =>
-			'Memoize::Storable',"$cache_path/has_no_changes.db", 'nstore';
+		tie my %has_no_changes_cache => 'Memoize::Storable',
+		    "$cache_path/has_no_changes.db", 'nstore';
 		memoize 'has_no_changes',
 			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
 			LIST_CACHE => 'FAULT',
-- 
Eric Wong
