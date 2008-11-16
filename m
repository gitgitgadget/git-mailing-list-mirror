From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 1/4] gitweb: introduce remote_heads feature
Date: Sun, 16 Nov 2008 14:28:06 +0100
Message-ID: <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 14:29:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1hh7-00027T-R7
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 14:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYKPN2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 08:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbYKPN2D
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 08:28:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57037 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYKPN17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 08:27:59 -0500
Received: by ug-out-1314.google.com with SMTP id 39so219624ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 05:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IMIogBy8Ge9YFRQIPDQWpiMOUH+wDZNG2ludwBHvpkM=;
        b=eafNbV1DaL6BnYtsNKN97Xk74PfjhBg6sP76h1NrjBH/ZxEvE8cR0fb8+7EAyYb18R
         l5wIntYI9waLjRySwJOO1MLNUOlqEPnU7epfDVWLmfCln9lcPzePQPp89p20ezO5Ez+8
         gxzfnHzFSB5UVZQHGYhLoTO6hZwysbhh7sHqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mr7p6LyfS7lqAUjNbPx5QY5q6Frsfmf4Il/43amusHR5aZnCpsyVQQc+emCJ3hIeeA
         whXo2wErx5u0OijzG2bLetUY0oU5M4zIOavrRZ1O/XqDzqLGXupaHmMI0lzL7In8mbUo
         kTK0JX3ZrVANm3HWeWiVsm/swWhW1Kj3DVY7M=
Received: by 10.67.89.15 with SMTP id r15mr835058ugl.59.1226842078883;
        Sun, 16 Nov 2008 05:27:58 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id p34sm1463278ugc.29.2008.11.16.05.27.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 05:27:58 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101126>

With this feature enabled, remotes are retrieved (and displayed)
when getting (and displaying) the heads list. Typical usage would be for
local repository browsing, e.g. by using git-instaweb (or even a more
permanent gitweb setup), to check the repository status and the relation
between tracking branches and the originating remotes.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b0d00ea..e1f81f6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -329,6 +329,18 @@ our %feature = (
 	'ctags' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Make gitweb show remotes too in the heads list
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'override'} = 1;
+	# and in project config gitweb.remote_heads = 0|1;
+	'remote_heads' => {
+		'sub' => \&feature_remote_heads,
+		'override' => 0,
+		'default' => [0]},
 );
 
 # retrieve the value of a given feature, as an array
@@ -410,6 +422,18 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+sub feature_remote_heads {
+	my ($val) = git_get_project_config('remote_heads', '--bool');
+
+	if ($val eq 'true') {
+		return (1);
+	} elsif ($val eq 'false') {
+		return (0);
+	}
+
+	return ($_[0]);
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -2660,10 +2684,12 @@ sub git_get_heads_list {
 	my $limit = shift;
 	my @headslist;
 
+	my $remote_heads = gitweb_check_feature('remote_heads');
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
+		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
@@ -2674,8 +2700,9 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/(head|remote)s/!!;
 
+		$ref_item{'class'} = $1;
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
 		$ref_item{'title'} = $title || '(no commit message)';
-- 
1.5.6.5
