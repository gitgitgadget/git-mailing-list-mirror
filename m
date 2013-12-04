From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 5/5] gitweb: Denote non-heads, non-remotes branches
Date: Wed,  4 Dec 2013 14:43:03 +0100
Message-ID: <1386164583-14109-6-git-send-email-krzesimir@endocode.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 14:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCk6-0007JN-P9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab3LDNnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 08:43:41 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:49186 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468Ab3LDNnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:43:37 -0500
Received: by mail-ee0-f48.google.com with SMTP id e49so2387874eek.21
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ghiBn/bWc7xtOil+TWJb7mGl9NYxosHXXF1VdouXFmg=;
        b=WAAlSwu1me9juC+2dsozWrkEq11zB2TtZ88fJVsGJFLQHj0rXW3yb570fspHy/R4XZ
         /dbM7zSYM51K6DpKmXf7N680lisRMP6tCSGiiBXsOWZbSuV51kQKAm+skvWRCiYeiIcZ
         iwgZLZZ4mn3uVKSf2UtxxtKXNBO9jwT2AsTTOKGWqOPZRnHuVG0q+P7t5GSm62kOBxrL
         eRbAmmTqjiE0OqLKBeYmWq7gvP08KUdm932r3zQtRhX8UMmivXdK4jb8CNzo/ooPYdo0
         Vd5eo6wVi4d8kAJzYDt7Axzu3pPR46jbVnwGYrLHbYhjzvzjL472NPAOkjNRzdwgnvLF
         mVMA==
X-Gm-Message-State: ALoCoQlqVJFqhHmtBftOXcohTkQG0CYg7UGEtHu6h/tYoeptk7DNaxB5Ro0JaKXXq78MvuhPYS0+
X-Received: by 10.14.241.131 with SMTP id g3mr76425eer.116.1386164615894;
        Wed, 04 Dec 2013 05:43:35 -0800 (PST)
Received: from localhost.home (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id z42sm22327433eeo.17.2013.12.04.05.43.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2013 05:43:35 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238782>

Given two branches residing in refs/heads/master and refs/wip/feature
the list-of-branches view will present them in following way:
master
feature (wip)

When getting a snapshot of a 'feature' branch, the tarball is going to
have name like 'project-wip-feature-<short hash>.tgz'.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6d3d52d..9a63ea9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3739,8 +3739,14 @@ sub git_get_heads_list {
 		$ref_item{'fullname'}  = $name;
 		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
 		$name =~ s!^refs/($strip_refs|remotes)/!!;
+		$ref_item{'name'} = $name;
+		# for refs neither in 'heads' nor 'remotes' we want to
+		# show their different ref dir
+		my $ref_dir = (defined $1) ? $1 : '';
+		if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes') {
+		    $ref_item{'name'} .= ' (' . $ref_dir . ')';
+		}
 
-		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
 		$ref_item{'title'} = $title || '(no commit message)';
 		$ref_item{'epoch'} = $epoch;
@@ -7257,7 +7263,24 @@ sub snapshot_name {
 		# branches and other need shortened SHA-1 hash
 		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
 		if ($hash =~ m!^refs/($strip_refs|remotes)/(.*)$!) {
-			$ver = $1;
+			my $ref_dir = $1;
+			$ver = $2;
+
+			if (defined $ref_dir) {
+				# this is going to be a part of
+				# filename, so lets stick to
+				# alphanumerics, dashes and underlines
+				# only - some filesystems do not like
+				# some punctuation symbols for
+				# example.
+				$ref_dir =~ s/[^[:alnum:]_-]//g;
+			}
+
+			# for refs not in heads nor remotes we want to
+			# add a ref dir to archive name
+			if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes') {
+				$ver = $ref_dir . '-' . $ver;
+			}
 		}
 		$ver .= '-' . git_get_short_hash($project, $hash);
 	}
-- 
1.8.3.1
