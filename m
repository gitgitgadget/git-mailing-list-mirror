From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/7] gitweb: introduce remote_heads feature
Date: Thu, 16 Sep 2010 11:30:59 +0200
Message-ID: <1284629465-14798-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:31:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAoo-0007PY-O7
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab0IPJbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52672 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0IPJba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:30 -0400
Received: by wyf22 with SMTP id 22so1146293wyf.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YoaWLev7mUZk1EYdpYLz+oJBTi7wl2+KgILg/W7WPSQ=;
        b=ae76GiD6+Q/n8KoEgeOFY5MhFQ1OZHBSYIVgeIgsU8X8tKQeRnertmjd0KlAfc0Qwt
         oirDu67H3mh3QEYY/XZrZA3AocLH51GrcyYNaEJ6cPjU5+mO+Fi5BAh7GerjrGdfCtN/
         4UlYwwCApBLLp2/rLpiwqK/KZSOwX2Jxdy/3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nGE+Q/OeToJ7bsIIVM1cXlc2oIwgge6JGjOh80Ip9udNQRgcltn4OZ8Wzdm/GC3Dqz
         yDo+mrU2OAUzoYXn2jI/TJXoXN3haGeaanspAsCKXXSXwX56IMn/bps4IoBHhzIo83uD
         73J73vTe8BpvqPo1YiBV+vMOiEkanGumMmYX0=
Received: by 10.216.28.204 with SMTP id g54mr6342941wea.73.1284629489691;
        Thu, 16 Sep 2010 02:31:29 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id p42sm1668877weq.12.2010.09.16.02.31.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156305>

With this feature enabled, remotes are retrieved (and displayed)
when getting (and displaying) the heads list. Typical usage would be for
local repository browsing, e.g. by using git-instaweb (or even a more
permanent gitweb setup), to check the repository status and the relation
between tracking branches and the originating remotes.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..7116c26 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -486,6 +486,18 @@ our %feature = (
 		'sub' => sub { feature_bool('highlight', @_) },
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
+		'sub' => sub { feature_bool('remote_heads', @_) },
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3146,10 +3158,12 @@ sub git_get_heads_list {
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
@@ -3160,8 +3174,9 @@ sub git_get_heads_list {
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
1.7.3.rc1.230.g8b572
