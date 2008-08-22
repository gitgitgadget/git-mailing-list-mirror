From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 15:29:46 +0200
Message-ID: <1219411786-14073-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200808221501.54908.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 15:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWik-0001rf-Bl
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYHVN31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYHVN31
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:29:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:27182 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYHVN30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:29:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so256895fgg.17
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fImXjSVjixcempKt9y0HkJTosTavcda1ys1OSDiouPU=;
        b=MIy63DRsWBhJh7mqTZvJC8Q8gLi5FmNV/he8L2HbxOzC61T52O0ufZi6HJGQX4OdFo
         ercy5RfmOUzijtfkUiqTCj+g6BVp5/+3cFQkDO5LlpgphG6A5UQ+6syrkBLqTyKLCh11
         VACWbDMwRuxREbQDShEDpQOWRPDbexE76WYfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V4UO9sEOe7p53tcE737qx8Lcmqv/eFdm0qir7drfVY6Y60iV8gIppLwwgq8ebfC9GJ
         S6lHLDySaEvYB77tj79xDOoKfcfM8WARd4t5/xZqZpBZpd+VZVwagqBAioT0GXcHEn3n
         1kspGoXuYGHE9lXAwiQZyh4AcN+KYbuqK/aSE=
Received: by 10.86.90.13 with SMTP id n13mr856105fgb.3.1219411764644;
        Fri, 22 Aug 2008 06:29:24 -0700 (PDT)
Received: from localhost ( [78.13.49.52])
        by mx.google.com with ESMTPS id 12sm1290902fgg.0.2008.08.22.06.29.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 06:29:23 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <200808221501.54908.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93294>

This patch turns ref markers for tags and heads into links to
appropriate views for the ref name. For annotated tags, we link to the
tag view, while shortlog is used for anything else.

Appropriate changes are made in the CSS to prevent ref markers from
being annoyingly blue and underlined, unless hovered. A visual
indication of the target view difference is also implemented by making
annotated tags show up in italic.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

As suggested by Jakub Narebski, the git_get_references() format
gets extended to include the final ^{} for tag objects, and the
name cleanup and indirection detection is moved to format_ref_marker()

 gitweb/gitweb.css  |   13 +++++++++++++
 gitweb/gitweb.perl |   16 +++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

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
index a0d9272..def4136 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1202,7 +1202,11 @@ sub format_ref_marker {
 
 	if (defined $refs->{$id}) {
 		foreach my $ref (@{$refs->{$id}}) {
+			# this code exploits the fact that non-lightweight tags are the
+			# only indirect objects, and that they are the only objects for which
+			# we want to use tag instead of shortlog as action
 			my ($type, $name) = qw();
+			my $indirect = ($ref =~ s/\^\{\}$//);
 			# e.g. tags/v2.6.11 or heads/next
 			if ($ref =~ m!^(.*?)s?/(.*)$!) {
 				$type = $1;
@@ -1212,8 +1216,14 @@ sub format_ref_marker {
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
 
@@ -2035,7 +2045,7 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
-- 
1.5.6.3
