From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH v7 4/4] gitweb: Denote non-heads, non-remotes branches
Date: Wed, 11 Dec 2013 12:54:44 +0100
Message-ID: <1386762884-7564-5-git-send-email-krzesimir@endocode.com>
References: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 12:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiO3-0003A9-IM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab3LKLz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:55:27 -0500
Received: from mail-ea0-f171.google.com ([209.85.215.171]:41775 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab3LKLzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:55:25 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so2848200eak.2
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 03:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2hNsmCTHJ5/NbVd0e70pEC5/z981oYElbzwxeCZvH4=;
        b=BjfFjZZz7cJA4cLBAbVcO9AFxiQg+al/GR+TBoJRb0wJNZirPkia0Mc8hrvG82WS2j
         uhNge7z7H3Pv46zvD+GqxfNUZobP7VZi9s1Bd8sJ2Rokv4fZ/kYpiH530i67lDCgj69O
         zLGKK2n8G5ELgLWgJXJnpHvR7lomz29hUbpTxnWQknvi80/+9Et7Glc/D87txmbi6HKJ
         GD9NbrRK/sZRe/R7H3fXK+uVbiQ29so4/ZRQPAXKo13lMvG4V21RWixLSGNgNvq6J4j1
         s24yrIYZLnx+RVANz4xQkclWs2Kdt7U/mwOTqpi2bMN9Ry/e7nv3dNeUF3XruKgLTWHu
         0NxQ==
X-Gm-Message-State: ALoCoQmlfgY1rFCEedJbT9YSyDneoPQmT1KnT/00D/dsuX+fE0SCFoKgXI+EABQ1agI8fwdloIZL
X-Received: by 10.15.82.8 with SMTP id z8mr1362262eey.25.1386762924529;
        Wed, 11 Dec 2013 03:55:24 -0800 (PST)
Received: from localhost.home (95-91-241-58-dynip.superkabel.de. [95.91.241.58])
        by mx.google.com with ESMTPSA id z42sm52742677eeo.17.2013.12.11.03.55.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 03:55:23 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239190>

Given two branches residing in refs/heads/master and refs/wip/feature
the list-of-branches view will present them in following way:
master
feature (wip)

When getting a snapshot of a 'feature' branch, the tarball is going to
have name like 'project-wip-feature-<short hash>.tgz'.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 222699a..3bc0f0b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3730,8 +3730,14 @@ sub git_get_heads_list {
 		$ref_item{'fullname'}  = $name;
 		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
 		$name =~ s!^refs/($strip_refs|remotes)/!!;
+		$ref_item{'name'} = $name;
+		# for refs neither in 'heads' nor 'remotes' we want to
+		# show their ref dir
+		my $ref_dir = (defined $1) ? $1 : '';
+		if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes') {
+		    $ref_item{'name'} .= ' (' . $ref_dir . ')';
+		}
 
-		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
 		$ref_item{'title'} = $title || '(no commit message)';
 		$ref_item{'epoch'} = $epoch;
@@ -7223,6 +7229,15 @@ sub git_tree {
 	git_footer_html();
 }
 
+sub sanitize_for_filename {
+    my $name = shift;
+
+    $name =~ s!/!-!g;
+    $name =~ s/[^[:alnum:]_.-]//g;
+
+    return $name;
+}
+
 sub snapshot_name {
 	my ($project, $hash) = @_;
 
@@ -7230,9 +7245,7 @@ sub snapshot_name {
 	# path/to/project/.git -> project
 	my $name = to_utf8($project);
 	$name =~ s,([^/])/*\.git$,$1,;
-	$name = basename($name);
-	# sanitize name
-	$name =~ s/[[:cntrl:]]/?/g;
+	$name = sanitize_for_filename(basename($name));
 
 	my $ver = $hash;
 	if ($hash =~ /^[0-9a-fA-F]+$/) {
@@ -7248,12 +7261,23 @@ sub snapshot_name {
 		# branches and other need shortened SHA-1 hash
 		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
 		if ($hash =~ m!^refs/($strip_refs|remotes)/(.*)$!) {
-			$ver = $1;
+			my $ref_dir = (defined $1) ? $1 : '';
+			$ver = $2;
+
+			$ref_dir = sanitize_for_filename($ref_dir);
+			# for refs neither in heads nor remotes we want to
+			# add a ref dir to archive name
+			if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes') {
+				$ver = $ref_dir . '-' . $ver;
+			}
 		}
 		$ver .= '-' . git_get_short_hash($project, $hash);
 	}
+	# special case of sanitization for filename - we change
+	# slashes to dots instead of dashes
 	# in case of hierarchical branch names
 	$ver =~ s!/!.!g;
+	$ver =~ s/[^[:alnum:]_.-]//g;
 
 	# name = project-version_string
 	$name = "$name-$ver";
-- 
1.8.3.1
