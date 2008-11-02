From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv3 1/3] gitweb: make the supported snapshot formats array global
Date: Sun,  2 Nov 2008 10:21:37 +0100
Message-ID: <1225617699-30004-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1225617699-30004-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:22:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZ9o-0002l1-Gp
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYKBJUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbYKBJUx
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:20:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:11631 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbYKBJUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:20:51 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1532305ugf.37
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zwIYeZTlo6oQ+7QEDlXOPl548hKTr0byH5iglqN/tKk=;
        b=FVf+SDp7lXjRccoy3pwh2ryKQy3nY+KR3gA/wS9dbzajGEsshRC8Y8aJcWpNJ5THLl
         ed3tc7d6I6vZonw26GdTG3QwYZ1qbQV99+V7G4yJQxFLrlA8Nq5DkBHJZAF9mJcwl1Fq
         3pNveHtt8ocrbw/u4d2DIBKtja0VbVsu8OuqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r5LhEiYbBiFJ8x/sbM+xOJyIoE5S7C1MY2pijRxJdN2MsxTor4ZtbSfPl9UNB/tQbi
         2DsOCScbbhClCaWeeTz+svwZzOSUyU4uONMeewXN9cXTr3gyBtLeLQ15EM0L6ezuJobu
         MJXx95Lk+unvlDtfSY7b8KJkbEAbgY9p0hukw=
Received: by 10.67.115.14 with SMTP id s14mr1202345ugm.59.1225617648166;
        Sun, 02 Nov 2008 01:20:48 -0800 (PST)
Received: from localhost ([94.37.26.217])
        by mx.google.com with ESMTPS id 6sm7560155ugc.39.2008.11.02.01.20.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 01:20:47 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225617699-30004-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99826>

The array of supported snapshot format is used and defined (with two
different names) in two routines, one of which (format_snapshot_links)
is often called multiple times per page.

Simplify code and speed up page generation by making the array global.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9d1af7e..8441912 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -721,6 +721,10 @@ if (defined $searchtext) {
 our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
 
+# list of supported snapshot formats
+our @snapshot_fmts = gitweb_check_feature('snapshot');
+@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -1647,8 +1651,6 @@ sub format_diff_line {
 # linked.  Pass the hash of the tree/commit to snapshot.
 sub format_snapshot_links {
 	my ($hash) = @_;
-	my @snapshot_fmts = gitweb_check_feature('snapshot');
-	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 	my $num_fmts = @snapshot_fmts;
 	if ($num_fmts > 1) {
 		# A parenthesized list of links bearing format names.
@@ -4850,20 +4852,17 @@ sub git_tree {
 }
 
 sub git_snapshot {
-	my @supported_fmts = gitweb_check_feature('snapshot');
-	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
-
 	my $format = $input_params{'snapshot_format'};
-	if (!@supported_fmts) {
+	if (!@snapshot_fmts) {
 		die_error(403, "Snapshots not allowed");
 	}
 	# default to first supported snapshot format
-	$format ||= $supported_fmts[0];
+	$format ||= $snapshot_fmts[0];
 	if ($format !~ m/^[a-z0-9]+$/) {
 		die_error(400, "Invalid snapshot format parameter");
 	} elsif (!exists($known_snapshot_formats{$format})) {
 		die_error(400, "Unknown snapshot format");
-	} elsif (!grep($_ eq $format, @supported_fmts)) {
+	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-- 
1.5.6.5
