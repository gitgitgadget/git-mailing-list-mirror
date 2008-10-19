From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv2 8/8] gitweb: make the supported snapshot formats array global
Date: Sun, 19 Oct 2008 16:24:30 +0200
Message-ID: <1224426270-27755-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 04:55:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrZDp-00062W-6p
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 16:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYJSOYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 10:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYJSOYR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 10:24:17 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:46624 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYJSOYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 10:24:16 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1478177fkq.5
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8HGVwj98SkCguH76bTIgnYskFb7iON3wdpdBFyFmi2o=;
        b=NX5bFHMSYn/8LDgwUHWy6aH/u+lRYMIlEZnK4ZYLmSfmBxpJ96iFqLzaWs2+P7dzyS
         UCH1HP5WZLoLx9LsdoUyXaIhjv1qo4IQT7bEbXdROhselI4nLQg/8WCR1kfnro4cmLlX
         5GbVbAqiiGQaGyizV29ch0Yni9kgH16OM1j4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rUJs37DtTBbWcD/byRylRwAPaMSGLqIi5vlXtSXl1mj1OYVtP3whyGHOvZr2JM9Y8a
         CohSRVQIJOKOISasFGXDxFo8bLiKdH6bjUzQJhaHG0ki5IbmvcLtWvQTx4t1ZYUE11sh
         Ll0b84+7V3X9iX3pyFAy7qrdjiHWbb3hi4MRg=
Received: by 10.181.135.5 with SMTP id m5mr2311965bkn.87.1224426255092;
        Sun, 19 Oct 2008 07:24:15 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id d13sm12050577fka.19.2008.10.19.07.24.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 07:24:13 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98605>

The @snapshot_fmts array, containing the list of the supported snapshot
formats, was recreated locally in three different routines (with the
different name @supported_fmts in one of them).

Its local generation is particularly expensive because two of the
callers, href() and format_snapshot_links(), are often called many times
in a single page.

Simplify code and speed up page generation by making the array global.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5fd5a1f..d1475b7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -748,6 +748,10 @@ if (defined $searchtext) {
 our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
 
+# list of supported snapshot formats
+our @snapshot_fmts = gitweb_check_feature('snapshot');
+@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -858,11 +862,7 @@ sub href (%) {
 			# snapshot_format should always be defined when href()
 			# is called, but just in case some code forgets, we
 			# fall back to the default
-			if (!$fmt) {
-				my @snapshot_fmts = gitweb_check_feature('snapshot');
-				@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
-				$fmt = $snapshot_fmts[0];
-			}
+			$fmt ||= $snapshot_fmts[0];
 			$href .= $known_snapshot_formats{$fmt}{'suffix'};
 			delete $params{'snapshot_format'};
 		}
@@ -1695,8 +1695,6 @@ sub format_diff_line {
 # linked.  Pass the hash of the tree/commit to snapshot.
 sub format_snapshot_links {
 	my ($hash) = @_;
-	my @snapshot_fmts = gitweb_check_feature('snapshot');
-	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 	my $num_fmts = @snapshot_fmts;
 	if ($num_fmts > 1) {
 		# A parenthesized list of links bearing format names.
@@ -4898,20 +4896,17 @@ sub git_tree {
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
