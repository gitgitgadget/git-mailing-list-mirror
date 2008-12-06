From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv4 2/3] gitweb: add patches view
Date: Sat,  6 Dec 2008 16:02:34 +0100
Message-ID: <1228575755-13432-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 16:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8yhD-0001tF-D4
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 16:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbYLFPCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 10:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756527AbYLFPCS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 10:02:18 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:47170 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbYLFPCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 10:02:16 -0500
Received: by ey-out-2122.google.com with SMTP id 6so180690eyi.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 07:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ESQLE/110iAHJOhJVpM8hXhuSYLBjmVis/THEoBjjeA=;
        b=lQJZtSi2WvJWhgM2OB6KVKvPHr+ekPRJj9gO+sDf4xM/oij5MMf0NilcqjeUDl4NQS
         RLn6ejsd0qk46hilOmweZvk+Ikzuj1/LjUYuaCwDr/ld+EaeMMMV99qJ7bAQO0Xjk5ZK
         2tM54O8Kca1h37vhnNHGq0FU/3vTrjBxRKde8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZtjX0SqNyN0NyTQPC+G6svbT2U6pij5kqpsCiAzheLth++H3x3wSIsvpcfQNacB13U
         GkyEHVx9IReHzuCtT5Cf50Aifnp8IkgPEJb6B73JrnWXK2/s/XQCdzW9D+62xfc/vPu2
         tagJYzQaZ3m4DSvl3gX7jTOzrzyYJB17cDVIk=
Received: by 10.210.119.16 with SMTP id r16mr1335618ebc.36.1228575735216;
        Sat, 06 Dec 2008 07:02:15 -0800 (PST)
Received: from localhost ([78.13.53.163])
        by mx.google.com with ESMTPS id d27sm2858867nfh.75.2008.12.06.07.02.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 07:02:14 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102461>

The only difference between patch and patches view is in the treatement
of single commits: the former only displays a single patch, whereas the
latter displays a patchset leading to the specified commit.
---
 gitweb/gitweb.perl |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 71d5af4..dfc7128 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -525,6 +525,7 @@ our %actions = (
 	"history" => \&git_history,
 	"log" => \&git_log,
 	"patch" => \&git_patch,
+	"patches" => \&git_patches,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5408,6 +5409,9 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+	# for patch view: should we limit ourselves to a single patch
+	# if only a single commit is passed?
+	my $single_patch = shift && 1;
 
 	my $patch_max;
 	if ($format eq 'patch') {
@@ -5524,7 +5528,15 @@ sub git_commitdiff {
 			}
 			push @commit_spec, '-n', "$hash_parent..$hash";
 		} else {
-			push @commit_spec, '-1', '--root', $hash;
+			if ($single_patch) {
+				push @commit_spec, '-1';
+			} else {
+				if ($patch_max > 0) {
+					push @commit_spec, "-$patch_max";
+				}
+				push @commit_spec, "-n";
+			}
+			push @commit_spec, '--root', $hash;
 		}
 		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
 			'--stdout', @commit_spec
@@ -5620,7 +5632,11 @@ sub git_commitdiff_plain {
 
 # format-patch-style patches
 sub git_patch {
-	git_commitdiff('patch');
+	git_commitdiff('patch', 1);
+}
+
+sub git_patches {
+	git_commitdiff('patch', 0);
 }
 
 sub git_history {
-- 
1.5.6.5
