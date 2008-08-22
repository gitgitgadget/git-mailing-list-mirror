From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v4] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 14:39:37 +0200
Message-ID: <1219408777-13513-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200808221256.21805.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 14:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWVwK-0006lD-DR
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 14:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbYHVMjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 08:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbYHVMjS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 08:39:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:3683 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbYHVMjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 08:39:17 -0400
Received: by ug-out-1314.google.com with SMTP id c2so124268ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KNQN3Jd0qMgXlPjbbfWHn0gTg7ZzZI64VrB/Ncl2/WI=;
        b=gjS/aLy8MEz8OkDLlbyYZOEShC2OpzYtWvWHh8oVQSAIzy3TryEOYAnqoDIQJq9D+P
         ltaBBpqAtbc/BvGhx7imu469tt0rk+wLA71J+vP5kco0aCP88tX5b4d7PBKDdqUHkKuW
         9MnojRTdZoigqM7AzveTxEuX1kCdmHJ4rSoZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ankJl4WaWgHsGpPQA3ta1kKRIodVPQBn8UVUjPEfYey+mFmvOJdr1ph+pJVk3+NbXE
         FiHXueOliTBSKD2SUc44KgCjEV1YLm7NcyCdNnhv9W3Ff5u1S+12MVCq9KkhCpPoJePO
         V4VKEdHAs7opJ33ZXGj9FPXiG4RhZQZ+vxAKA=
Received: by 10.67.116.15 with SMTP id t15mr2534255ugm.53.1219408755312;
        Fri, 22 Aug 2008 05:39:15 -0700 (PDT)
Received: from localhost ( [78.13.49.52])
        by mx.google.com with ESMTPS id b23sm3686282ugd.27.2008.08.22.05.39.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 05:39:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <200808221256.21805.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93289>

This patch turns ref markers for tags and heads into links to
appropriate views for the ref name. For annotated tags, we link to the
tag view, while shortlog is used for anything else.

Appropriate changes are made in the CSS to prevent ref markers from
being annoyingly blue and underlined, unless hovered. A visual
indication of the target view difference is also implemented by making
annotated tags show up in italic.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

This version collects the suggestions made by Jakub Narebski, including an
enhancement to git_get_references() to preserve information on the
nature of a tag, and the exploitation of this extra information to
differentiate between shortlog an tag view. Tag objects are also
made visually different from lightweight tags by use of italics.

 gitweb/gitweb.css  |   13 +++++++++++++
 gitweb/gitweb.perl |   23 +++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5f4a4b8..3e50060 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -491,6 +491,19 @@ span.refs span {
 	border-color: #ffccff #ff00ee #ff00ee #ffccff;
 }
 
+span.refs span a {
+	text-decoration: none;
+	color: inherit;
+}
+
+span.refs span a:hover {
+	text-decoration: underline;
+}
+
+span.refs span.indirect {
+	font-style: italic;
+}
+
 span.refs span.ref {
 	background-color: #aaaaff;
 	border-color: #ccccff #0033cc #0033cc #ccccff;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a0d9272..5cb332f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1201,7 +1201,12 @@ sub format_ref_marker {
 	my $markers = '';
 
 	if (defined $refs->{$id}) {
-		foreach my $ref (@{$refs->{$id}}) {
+		foreach my $aref (@{$refs->{$id}}) {
+			# this code exploits the fact that non-lightweight tags are the
+			# only indirect objects, and that they are the only objects for which
+			# we want to use tag instead of shortlog as action
+			my $ref = $aref->[0];
+			my $indirect = $aref->[1];
 			my ($type, $name) = qw();
 			# e.g. tags/v2.6.11 or heads/next
 			if ($ref =~ m!^(.*?)s?/(.*)$!) {
@@ -1212,8 +1217,14 @@ sub format_ref_marker {
 				$name = $ref;
 			}
 
-			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+			my $class = $type;
+			if ($indirect) {
+				$class .= " indirect";
+			}
+
+			$markers .= " <span class=\"$class\" title=\"$ref\">" .
+				$cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"), hash=>$ref)}, $name) .
+				"</span>";
 		}
 	}
 
@@ -2035,11 +2046,11 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)(\^\{\})?$!) {
 			if (defined $refs{$1}) {
-				push @{$refs{$1}}, $2;
+				push @{$refs{$1}}, [$2, $3];
 			} else {
-				$refs{$1} = [ $2 ];
+				$refs{$1} = [ [$2, $3] ];
 			}
 		}
 	}
-- 
1.5.6.3
