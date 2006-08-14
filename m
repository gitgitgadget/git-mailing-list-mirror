From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/9] gitweb: Change appereance of marker of refs pointing to given object
Date: Mon, 14 Aug 2006 02:14:20 +0200
Message-ID: <200608140214.20450.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVC-0001tP-FW
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWHNKQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWHNKQo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:653 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751977AbWHNKQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:40 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20995nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Us7x1piK8Uh/nN/u23sek9u6D+gMDICpC9P1OryJRbbPLGkIdZ58Rsv0eUXBvZxu2C+C+oaYAK49dxO3o0Yh3PUH4OvUkw154z5ssHZCFP9WeB174jepCpj3Uo0mgUlVvpfJ89YXiX9u5jXj6weTRJdNCNye9FCpQINo+Cj/gow=
Received: by 10.49.75.2 with SMTP id c2mr932527nfl;
        Mon, 14 Aug 2006 03:16:40 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.39;
        Mon, 14 Aug 2006 03:16:39 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25345>

Change git_get_references to include type of ref in the %refs value, which
means putting everything after 'refs/' as a ref name, not only last
part of the name.  Instead of separating refs pointing to the same
object by " / " separator, use anonymous array reference to store all
refs pointing to given object.

Use 'git-ls-remote .' if $projectroot/$project/info/refs does not
exist.  (Perhaps it should be used always.)

Refs are now in separate span elements.  Class is dependent on the ref
type: currently known classes are 'tag', 'head', 'remote', and 'ref'
(last one for HEAD and other refs in the main directory).  There is
encompassing span element of class refs, just in case of unknown ref
type.

This might be considered cleaner separating of git_get_references into
filling %refs hash only, and not taking part in formatting ref marker.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Alternate solution to the one proposed by Thomas Kolejka in
 "[PATCH] gitweb: Different colours for tags and heads"
  Message-Id: <20060811151224.177110@gmx.net>

CSS and format_ref_marker is conservative: as of now it should not be
"ref" (generic) type of references. 

 gitweb/gitweb.css  |   19 +++++++++++++++++--
 gitweb/gitweb.perl |   37 ++++++++++++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index f58a418..21ce99c 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -326,15 +326,30 @@ a.rss_logo:hover {
 	background-color: #ee5500;
 }
 
-span.tag {
+span.refs span {
 	padding: 0px 4px;
 	font-size: 10px;
 	font-weight: normal;
-	background-color: #ffffaa;
 	border: 1px solid;
+	background-color: #ffaaff;
+	border-color: #ffccff #ff00ee #ff00ee #ffccff;
+}
+
+span.refs span.ref {
+	background-color: #aaaaff;
+	border-color: #ccccff #0033cc #0033cc #ccccff;
+}
+
+span.refs span.tag {
+	background-color: #ffffaa;
 	border-color: #ffffcc #ffee00 #ffee00 #ffffcc;
 }
 
+span.refs span.head {
+	background-color: #aaffaa;
+	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
+}
+
 span.atnight {
 	color: #cc0000;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6be6c55..4fe3fc7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -364,9 +364,26 @@ sub format_log_line_html {
 # format marker of refs pointing to given object
 sub format_ref_marker {
 	my ($refs, $id) = @_;
+	my $markers = '';
 
 	if (defined $refs->{$id}) {
-		return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
+		foreach my $ref (@{$refs->{$id}}) {
+			my ($type, $name) = qw();
+			# e.g. tags/v2.6.11 or heads/next
+			if ($ref =~ m!^(.*?)s?/(.*)$!) {
+				$type = $1;
+				$name = $2;
+			} else {
+				$type = "ref";
+				$name = $ref;
+			}
+
+			$markers .= " <span class=\"$type\">" . esc_html($name) . "</span>";
+		}
+	}
+
+	if ($markers) {
+		return ' <span class="refs">'. $markers . '</span>';
 	} else {
 		return "";
 	}
@@ -561,18 +578,24 @@ sub git_get_project_owner {
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
+	my $fd;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
-	open my $fd, "$projectroot/$project/info/refs" or return;
+	if (-f "$projectroot/$project/info/refs") {
+		open $fd, "$projectroot/$project/info/refs"
+			or return;
+	} else {
+		open $fd, "-|", $GIT, "ls-remote", "."
+			or return;
+	}
+
 	while (my $line = <$fd>) {
 		chomp $line;
-		# attention: for $type == "" it saves only last path part of ref name
-		# e.g. from 'refs/heads/jn/gitweb' it would leave only 'gitweb'
-		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
+		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
 			if (defined $refs{$1}) {
-				$refs{$1} .= " / $2";
+				push @{$refs{$1}}, $2;
 			} else {
-				$refs{$1} = $2;
+				$refs{$1} = [ $2 ];
 			}
 		}
 	}
-- 
1.4.1.1
