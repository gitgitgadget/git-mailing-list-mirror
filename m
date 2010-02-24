From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH 1/2] git-svn: Fix merge detecting with rewrite-root
Date: Wed, 24 Feb 2010 20:09:01 +0200
Message-ID: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 19:09:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLfx-00058G-O3
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab0BXSJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:09:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:15254 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab0BXSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 13:09:28 -0500
Received: by fg-out-1718.google.com with SMTP id e12so428757fga.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ord2XCVJv7Wej24s2U0yN+9eBAQb6xA2x+IBIX5qAMg=;
        b=YTb+6BNHb32J1nnVQXIC9qCT++5/6mP1KP10CLxDCgKOPAYJx6eh+OPmEK6F+Dq/hr
         xRuHJTg3Ffau3xIde9WpIyK79TLb/txOsBiXm3E0mfqA1L3F8RTX/KGXMY8muPi+ZO2A
         h4d8GwyCTGUGj2Tiic88qXQmlMCW3S0i1h9pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wCo1Y1p0O766QcHHmFhI7VrvJhG1KTbuGMFbrfFt0aUf9bl/iZH3hRvKZWLIY80zai
         9tTW1pxdDGn8t5utC6EFYNbSTOx2ng0AC3bYEEZ9qvySOtbIKCsdd1OX9XXennQfHcHu
         UYWfENEH2a1sHmB5ok2ef+S1fqIoQJUF+SaUU=
Received: by 10.87.68.17 with SMTP id v17mr620277fgk.20.1267034966435;
        Wed, 24 Feb 2010 10:09:26 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id l19sm11598420fgb.0.2010.02.24.10.09.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 10:09:25 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2.ged48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140964>

Detecting of merges from svn:mergeinfo or svk merge tickets failed
with rewrite-root option. This fixes it.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---
Hi again,

now I found another problem while importing SVN repo with git-svn.

To speed-up the import, I copied the SVN repo with rsync to localhost
and used file:// URL for the import, but because I want to be able to
track the history with svn+ssh:// later, I used the rewrite-root
option. That seemed to break the merge detecting.

With this patch the merge detecting works also with rewrite-root
option, but since there are no comments why the $self->rewrite_root
was used in the first place, I have no idea, if this is the right
thing to do.

 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..1cbddca 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2993,7 +2993,7 @@ sub find_extra_svk_parents {
 	for my $ticket ( @tickets ) {
 		my ($uuid, $path, $rev) = split /:/, $ticket;
 		if ( $uuid eq $self->ra_uuid ) {
-			my $url = $self->rewrite_root || $self->{url};
+			my $url = $self->{url};
 			my $repos_root = $url;
 			my $branch_from = $path;
 			$branch_from =~ s{^/}{};
@@ -3201,7 +3201,7 @@ sub find_extra_svn_parents {
 	# are now marked as merge, we can add the tip as a parent.
 	my @merges = split "\n", $mergeinfo;
 	my @merge_tips;
-	my $url = $self->rewrite_root || $self->{url};
+	my $url = $self->{url};
 	my $uuid = $self->ra_uuid;
 	my %ranges;
 	for my $merge ( @merges ) {
-- 
1.7.0.2.ged48
