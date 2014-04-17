From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: [PATCH 2/2] git-svn: only look at the root path for svn:mergeinfo
Date: Wed, 16 Apr 2014 23:54:06 -0700
Message-ID: <1397717646-54248-2-git-send-email-stoklund@2pi.dk>
References: <1397717646-54248-1-git-send-email-stoklund@2pi.dk>
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>,
	Jakob Stoklund Olesen <stoklund@2pi.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 08:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WagEG-00087V-GJ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 08:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbaDQGzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 02:55:17 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:42479 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaDQGzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 02:55:15 -0400
Received: from homiemail-a115.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 761EA92E06
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 23:55:14 -0700 (PDT)
Received: from homiemail-a115.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a115.g.dreamhost.com (Postfix) with ESMTP id EFD9D5629;
	Wed, 16 Apr 2014 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=2pi.dk; bh=4V
	8iZ9qtfPkgfSfJlPwCMMcdrKs=; b=xUcNHEq++jtdSbT4AvEsLDoocPoeWcD8qK
	pMJW9SyGmPIBXvNCkpCHSYZKuwmG8kZ/Vqg7d+EwreC1ivks/M8pnR53cl6Sv7Cy
	AZTRKyQzQSoX/TOWZxcQtCz4rpnNaOvqlAgb2y91kEX2lvnV0w76L3uQdVAv/t6y
	eqF1bDHJ8=
Received: from localhost.localdomain (173-228-90-133.dsl.dynamic.sonic.net [173.228.90.133])
	(using TLSv1 with cipher ADH-SEED-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a115.g.dreamhost.com (Postfix) with ESMTPSA id 83CFE4422;
	Wed, 16 Apr 2014 23:54:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <1397717646-54248-1-git-send-email-stoklund@2pi.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246411>

Subversion can put mergeinfo on any sub-directory to track cherry-picks.
Since cherry-picks are not represented explicitly in git, git-svn should
just ignore it.

Signed-off-by: Jakob Stoklund Olesen <stoklund@2pi.dk>
---
 perl/Git/SVN.pm | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index d3785ab..0aa4dd3 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1210,7 +1210,7 @@ sub do_fetch {
 	unless ($self->ra->gs_do_update($last_rev, $rev, $self, $ed)) {
 		die "SVN connection failed somewhere...\n";
 	}
-	$self->make_log_entry($rev, \@parents, $ed, $last_rev);
+	$self->make_log_entry($rev, \@parents, $ed, $last_rev, $self->path);
 }
 
 sub mkemptydirs {
@@ -1859,21 +1859,18 @@ sub make_log_entry {
 	my $untracked = $self->get_untracked($ed);
 
 	my @parents = @$parents;
-	my $ps = $ed->{path_strip} || "";
-	for my $path ( grep { m/$ps/ } %{$ed->{dir_prop}} ) {
-		my $props = $ed->{dir_prop}{$path};
-		if ( $props->{"svk:merge"} ) {
-			$self->find_extra_svk_parents
-				($ed, $props->{"svk:merge"}, \@parents);
-		}
-		if ( $props->{"svn:mergeinfo"} ) {
-			my $mi_changes = $self->mergeinfo_changes
-				($parent_path || $path, $parent_rev,
-				 $path, $rev,
-				 $props->{"svn:mergeinfo"});
-			$self->find_extra_svn_parents
-				($ed, $mi_changes, \@parents);
-		}
+	my $props = $ed->{dir_prop}{$self->path};
+	if ( $props->{"svk:merge"} ) {
+		$self->find_extra_svk_parents
+			($ed, $props->{"svk:merge"}, \@parents);
+	}
+	if ( $props->{"svn:mergeinfo"} ) {
+		my $mi_changes = $self->mergeinfo_changes
+			($parent_path, $parent_rev,
+			 $self->path, $rev,
+			 $props->{"svn:mergeinfo"});
+		$self->find_extra_svn_parents
+			($ed, $mi_changes, \@parents);
 	}
 
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
-- 
1.8.5.2 (Apple Git-48)
