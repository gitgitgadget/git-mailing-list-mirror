From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix SVN 1.1.x compatibility
Date: Sun, 18 Jan 2009 16:45:57 -0800
Message-ID: <20090119004556.GA25038@dcvr.yhbt.net>
References: <496722CF.1060802@statsbiblioteket.dk> <20090112010354.GB23377@yp-box.dyndns.org> <496AF964.1070208@statsbiblioteket.dk> <20090117105811.GB15801@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Jan 19 01:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOiIT-0006Nw-5v
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 01:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbZASAp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 19:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbZASAp6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 19:45:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40247 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbZASAp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 19:45:57 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC731F5D0;
	Mon, 19 Jan 2009 00:45:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090117105811.GB15801@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106297>

The get_log() function in the Perl SVN API introduced the limit
parameter in 1.2.0.  However, this got discarded in our SVN::Ra
compatibility layer when used with SVN 1.1.x.  We now emulate
the limit functionality in older SVN versions by preventing the
original callback from being called if the given limit has been
reached.  This emulation is less bandwidth efficient, but SVN
1.1.x is becoming rarer now.

Additionally, the --limit parameter in svn(1) uses the
aforementioned get_log() functionality change in SVN 1.2.x.
t9129 no longer depends on --limit to work and instead uses
Perl to parse out the commit message.

Thanks to Tom G. Christensen for the bug report.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Hi Tom, this should fix things for you.  I've tested this in an old
 Debian Sarge chroot running SVN 1.1.4

 git-svn.perl                           |   15 ++++++++++++++-
 t/t9129-git-svn-i18n-commitencoding.sh |   13 +++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e3e125b..71b8ef4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4130,10 +4130,23 @@ sub DESTROY {
 	# do not call the real DESTROY since we store ourselves in $RA
 }
 
+# get_log(paths, start, end, limit,
+#         discover_changed_paths, strict_node_history, receiver)
 sub get_log {
 	my ($self, @args) = @_;
 	my $pool = SVN::Pool->new;
-	splice(@args, 3, 1) if ($SVN::Core::VERSION le '1.2.0');
+
+	# the limit parameter was not supported in SVN 1.1.x, so we
+	# drop it.  Therefore, the receiver callback passed to it
+	# is made aware of this limitation by being wrapped if
+	# the limit passed to is being wrapped.
+	if ($SVN::Core::VERSION le '1.2.0') {
+		my $limit = splice(@args, 3, 1);
+		if ($limit > 0) {
+			my $receiver = pop @args;
+			push(@args, sub { &$receiver(@_) if (--$limit >= 0) });
+		}
+	}
 	my $ret = $self->SUPER::get_log(@args, $pool);
 	$pool->clear;
 	$ret;
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 8a9dde4..9c7b1ad 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -15,8 +15,17 @@ compare_git_head_with () {
 }
 
 compare_svn_head_with () {
-	LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
-		sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&
+	# extract just the log message and strip out committer info.
+	# don't use --limit here since svn 1.1.x doesn't have it,
+	LC_ALL=en_US.UTF-8 svn log `git svn info --url` | perl -w -e '
+		use bytes;
+		$/ = ("-"x72) . "\n";
+		my @x = <STDIN>;
+		@x = split(/\n/, $x[1]);
+		splice(@x, 0, 2);
+		$x[-1] = "";
+		print join("\n", @x);
+	' > current &&
 	test_cmp current "$1"
 }
 
-- 
Eric Wong
