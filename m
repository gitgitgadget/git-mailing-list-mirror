From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Change appereance of marker of refs pointing to given object
Date: Sat, 5 Aug 2006 00:43:18 +0200
Message-ID: <200608050043.18420.jnareb@gmail.com>
References: <200608050036.06490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98Np-0007PF-NA
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161548AbWHDWm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbWHDWm4
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:42:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2021 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161548AbWHDWmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:42:53 -0400
Received: by nf-out-0910.google.com with SMTP id k26so45232nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 15:42:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pGltXFoS3mp5iz8gyoqU+GIlrCsRWLqKScLQVW8M8e0Ii82sKVTWwlGnpE+qXy0cC4kBkhvbsZQ9u+oyxa8SMyGaZYmI1QZDOCEk3Bc+0mFB8Mh1p7rWc5haAAuZMQ3OiExHIsj0KKZlArkeS49JhvdudXQonHexbgoVl1914NE=
Received: by 10.49.29.3 with SMTP id g3mr6067986nfj;
        Fri, 04 Aug 2006 15:42:53 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id q28sm2928781nfc.2006.08.04.15.42.52;
        Fri, 04 Aug 2006 15:42:53 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608050036.06490.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24860>

Change default value of $type in git_read_info_refs to correctly show
full name of ref (and not only last part) if $type was not set.

Refs are now in separate span elements.  Class was changed from "tag"
to "ref", as ref can be head, not only tag.  Currently there is no way
to distinguish between tags and heads.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    2 +-
 gitweb/gitweb.perl |   12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 460e728..921b339 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -317,7 +317,7 @@ a.rss_logo:hover {
 	background-color: #ee5500;
 }
 
-span.tag {
+span.ref {
 	padding: 0px 4px;
 	font-size: 10px;
 	font-weight: normal;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9e4822b..e983452 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -350,9 +350,13 @@ sub format_mark_referencing {
 	my ($refs, $id) = @_;
 
 	if (defined $refs->{$id}) {
-		return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
+		my $markers = '';
+		foreach my $ref (split /:/, $refs->{$id}) {
+			$markers .= ' <span class="ref">' . esc_html($ref) . '</span>';
+		}
+		return $markers;
 	} else {
-		return "";
+		return '';
 	}
 }
 
@@ -496,7 +500,7 @@ sub git_read_projects {
 }
 
 sub git_read_info_refs {
-	my $type = shift || "";
+	my $type = shift || "(?:heads|tags)";
 	my %refs;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
@@ -507,7 +511,7 @@ sub git_read_info_refs {
 		# e.g. from 'refs/heads/jn/gitweb' it would leave only 'gitweb'
 		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
 			if (defined $refs{$1}) {
-				$refs{$1} .= " / $2";
+				$refs{$1} .= ':' . $2;
 			} else {
 				$refs{$1} = $2;
 			}
-- 
1.4.1.1
