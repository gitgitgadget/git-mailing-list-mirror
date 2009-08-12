From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Wed, 12 Aug 2009 02:49:40 -0700
Message-ID: <20090812094940.GA22273@dcvr.yhbt.net>
References: <20090810083234.GA8698@dcvr.yhbt.net> <1250046867-13655-1-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 11:49:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbASu-0000Mh-HA
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 11:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbZHLJtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 05:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbZHLJtm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 05:49:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43973 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932296AbZHLJtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 05:49:41 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4E3251F509;
	Wed, 12 Aug 2009 09:49:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250046867-13655-1-git-send-email-adambrewster@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125688>

Adam Brewster <adambrewster@gmail.com> wrote:
> Eric,
> 
> Any thoughts on the other patch?
> 
> Am I close or is there a better way to go about this?
> 
> I didn't really know what to do with .git/svn/*.  The easy answer is
> 
>   mkdir -p $GIT_DIR/svn/refs/remotes &&
>   mv $GIT_DIR/svn/* $GIT_DIR/svn/refs/remotes

That should be acceptable.  I don't think it's worth the trouble to
force the majority of existing repos to move over to the new layout
(in case the user wants to switch between multiple versions of git).

> From the comments in the Migration module, it seems like that's frowned
> upon, so I came up with looking for .rev_map (or .rev_db) in both
> locations (.git/svn/git-svn and .git/svn/refs/remotes/svn) and letting
> it stay in whichever location it already exists.  (The next email has a
> slightly improved version of the patch.)
> 
> This solution is particularly inelegant in it's handling of
> unhandled.log, but as far as I know that file is unused.

I'd still rather avoid creating unhandled.log in two places and
having an unused set of directories.

I think the following change on top of yours would make most
sense:

diff --git a/git-svn.perl b/git-svn.perl
index cafd7fe..1117f28 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3325,8 +3325,18 @@ sub _new {
 	}
 	$_[1] = $repo_id;
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
+
+	# Older repos imported by us used $GIT_DIR/svn/foo instead of
+	# $GIT_DIR/svn/refs/remotes/foo when tracking refs/remotes/foo
+	if ($ref_id =~ m{^refs/remotes/(.*)}) {
+		my $old_dir = "$ENV{GIT_DIR}/svn/$1";
+		if (-d $old_dir && ! -d $dir) {
+			$dir = $old_dir;
+		}
+	}
+
 	$_[3] = $path = '' unless (defined $path);
-	mkpath(["$ENV{GIT_DIR}/svn/$ref_id"]);
+	mkpath([$dir]);
 	bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
 	        path => $path, config => "$ENV{GIT_DIR}/svn/config",
@@ -3355,16 +3365,7 @@ sub rev_db_path {
 sub map_path {
 	my ($self, $uuid) = @_;
 	$uuid ||= $self->ra_uuid;
-	my $map_path = "$self->{map_root}.$uuid";
-	return $map_path if ( -f $map_path );
-
-	my $db_path = $map_path;
-	$db_path =~ s/\.rev_map/.rev_db/;
-	return $map_path if ( -f $db_path );
-
-	return $1 if ($map_path =~ m(refs/remotes/(.*)) && -f $1);
-	return $1 if ($db_path =~ m(refs/remotes/(.*)) && -f $1);
-	return $map_path;
+	"$self->{map_root}.$uuid";
 }
 
 sub uri_encode {
----

The map_path() changes you originally made didn't work, either, since
the -f $1 never took GIT_DIR or GIT_DIR/svn into account.

> There's also the problem of what to do if someone has a ref called
> ref/remotes/refs/remotes/..., but that seems unlikely enough to not
> cause concern.

I concur.  There's always cases where things will be ambiguous
and cases where a user is just asking for trouble :)

I think the below is a good enough test case to for compatibility
against existing repos.  Let me know what you think, thanks!

diff --git a/t/t9144-git-svn-old-rev_map.sh b/t/t9144-git-svn-old-rev_map.sh
new file mode 100755
index 0000000..7600a35
--- /dev/null
+++ b/t/t9144-git-svn-old-rev_map.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+
+test_description='git svn old rev_map preservd'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup test repository with old layout' '
+	mkdir i &&
+	(cd i && > a) &&
+	svn_cmd import -m- i "$svnrepo" &&
+	git svn init "$svnrepo" &&
+	git svn fetch &&
+	test -d .git/svn/refs/remotes/git-svn/ &&
+	! test -e .git/svn/git-svn/ &&
+	mv .git/svn/refs/remotes/git-svn .git/svn/ &&
+	rm -r .git/svn/refs
+'
+
+test_expect_success 'old layout continues to work' '
+	svn_cmd import -m- i "$svnrepo/b" &&
+	git svn rebase &&
+	echo a >> b/a &&
+	git add b/a &&
+	git commit -m- -a &&
+	git svn dcommit &&
+	! test -d .git/svn/refs/ &&
+	test -e .git/svn/git-svn/
+'
+
+test_done
-- 
Eric Wong
