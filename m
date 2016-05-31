From: Matteo Bertini <naufraghi@develer.com>
Subject: [PATCH 3/4] SVN/Fetcher.pm: Add svn-remote.<id>.enable-filters to enable the filters.
Date: Tue, 31 May 2016 17:07:48 +0200
Message-ID: <20160531150749.24840-4-naufraghi@develer.com>
References: <20160531150749.24840-1-naufraghi@develer.com>
Cc: Matteo Bertini <matteo@naufraghi.net>, normalperson@yhbt.net,
	gitster@pobox.com, Matteo Bertini <naufraghi@develer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:15:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lNn-0002Hr-9k
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbcEaPOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:14:52 -0400
Received: from neo.develer.net ([2.228.72.10]:39509 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbcEaPOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:14:49 -0400
Received: from odello.trilan (odello.trilan [10.3.15.118])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id D1A445E3123;
	Tue, 31 May 2016 17:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464707277;
	bh=9Ffju3UMG6povlbneKEwV2xuOciKu5pfOlEkM8orkvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x/+n4AqG2eyi3WNRZ/eH1NqR2oP/tZaEjAGq0vEwKyv8zrEjmJd+1SDir5yk5G28g
	 HWK98lgW+gQbcBpAl+I1ocakiYYkJe7gdPy5Tl10O7j9ZsYlIZoopAD3tshr+fGbnW
	 X2TPo2UPJ+lyMRbQnJj7d65QbfMmExy9faOg4Y4w=
X-Mailer: git-send-email 2.9.0.rc0.39.gb9f310b.dirty
In-Reply-To: <20160531150749.24840-1-naufraghi@develer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295982>

From: Matteo Bertini <matteo@naufraghi.net>

Given the fact that git-svn uses temporary files to build the index,
provide the real $path to hash_and_insert_object if the filters are
enabled.

Signed-off-by: Matteo Bertini <naufraghi@develer.com>
---
 perl/Git/SVN/Fetcher.pm | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index d8c21ad..3557abe 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -1,7 +1,7 @@
 package Git::SVN::Fetcher;
 use vars qw/@ISA $_ignore_regex $_include_regex $_preserve_empty_dirs
             $_placeholder_filename @deleted_gpath %added_placeholder
-            $repo_id/;
+            $repo_id $_enable_filters/;
 use strict;
 use warnings;
 use SVN::Delta;
@@ -46,6 +46,10 @@ sub new {
 		$_placeholder_filename = $v;
 	}
 
+	$k = "svn-remote.$repo_id.enable-filters";
+	$v = eval { command_oneline('config', '--get', '--bool', $k) };
+	$_enable_filters = 1
+		if ($v && $v eq 'true');
 	# Load the list of placeholder files added during previous invocations.
 	$k = "svn-remote.$repo_id.added-placeholder";
 	$v = eval { command_oneline('config', '--get-all', $k) };
@@ -415,9 +419,13 @@ sub close_file {
 				Git::temp_release($tmp_fh, 1);
 			}
 		}
-
-		$hash = $::_repository->hash_and_insert_object(
-				Git::temp_path($fh));
+		if ($_enable_filters) {
+			$hash = $::_repository->hash_and_insert_object(
+					Git::temp_path($fh), $path, $_enable_filters);
+		} else {
+			$hash = $::_repository->hash_and_insert_object(
+					Git::temp_path($fh));
+		}
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 
 		Git::temp_release($fb->{base}, 1);
-- 
2.9.0.rc0.39.gb9f310b.dirty
