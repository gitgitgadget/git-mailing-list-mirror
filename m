From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 01/10] gitweb: introduce remote_heads feature
Date: Sun, 24 Oct 2010 12:45:27 +0200
Message-ID: <1287917136-26103-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5O-0004kV-Bm
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab0JXKpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:45:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0JXKpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:45:54 -0400
Received: by wyf28 with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yg90CDh8M4rSiLl4m+LQ2IOUYAmTY8u6RtUInvNxZlA=;
        b=GhDTaWS/K+z0wZtaCpnzUbjO70k9ME5ZWVSJdxD2imgH/42wUIhRQq0AfOzqBZDPP2
         WbjX+25hsthD6TiaGhC5wob71nKmXVC3i6/kUz6NFz2V7Ead5Ms9aLfIGLv42G8h3ftz
         VOpvcffwEpCyqE8MaPNEJmznhnBCOevDVpKxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rb9FOI6jbO6OkQ5jlH8dCbzrVY3LTWa1uylZJ2eLxPhOX3HQ1QzIJSzStXusi3xMW9
         oENA0iyNfmT+7CHn5yvOmPgujPohg+qqbOoJkg5l8xWnut5gOgx6XjnzMdMq3EfOqr9t
         CTKiQPf2GvXlXOqdCou03h7unCqeA0eYClzLI=
Received: by 10.216.19.134 with SMTP id n6mr4912321wen.9.1287917152981;
        Sun, 24 Oct 2010 03:45:52 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id l51sm2949195wer.2.2010.10.24.03.45.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159843>

With this feature enabled, remote heads are retrieved (and displayed)
when getting (and displaying) the heads list. Typical usage would be for
local repository browsing, e.g. by using git-instaweb (or even a more
permanent gitweb setup), to check the repository status and the relation
between tracking branches and the originating remotes.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 253f41a..0e71749 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -493,6 +493,18 @@ our %feature = (
 		'sub' => sub { feature_bool('highlight', @_) },
 		'override' => 0,
 		'default' => [0]},
+
+	# Enable displaying of remote heads in the heads list
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'override'} = 1;
+	# and in project config gitweb.remote_heads = 0|1;
+	'remote_heads' => {
+		'sub' => sub { feature_bool('remote_heads', @_) },
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3160,10 +3172,12 @@ sub git_get_heads_list {
 	my $limit = shift;
 	my @headslist;
 
+	my $remote_heads = gitweb_check_feature('remote_heads');
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
+		'refs/heads', ($remote_heads ? 'refs/remotes' : ())
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
@@ -3174,7 +3188,7 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/(?:head|remote)s/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
-- 
1.7.3.68.g6ec8
