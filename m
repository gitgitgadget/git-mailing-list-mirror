From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix handling of whitespace in generated links
Date: Tue, 14 Dec 2010 16:54:31 +0100
Message-ID: <20101214155331.23853.71834.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 16:55:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSXDj-0002Ag-7H
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 16:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490Ab0LNPzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 10:55:12 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57412 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758956Ab0LNPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 10:55:10 -0500
Received: by wyb28 with SMTP id 28so595984wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=D1RMLgM/08zRESq7QelxQwh7cw/LJY4i/yxq8Tz7Glo=;
        b=hCmuKdJtT9KwaeVzZScNKpSxIi74ZbbbdCK8589o8r8Mm7rRGfDDFkObCp7IW7LXdA
         7q6plLJ0Lq4prb3a51VThUSpYO3AM03bmyouoAa2AEKwjSRSTx3+97OyvOzSst8Kr/cB
         VzhvDXTCKaJOxxd3X/MZx/MjxHkeFt1QELSJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=gpx4P/OXP/yur5buiy4snK7lNVVg2J7pzk8+IxaRnD2TjO9A5nbpA4D7R1yg6RFd5W
         6ycwZQNqgQELIadlngljAuUGrL6Re9kGn5xFnrNU25eiv3i9R6xrFliWo+h/usnvT1LM
         oAWL+XK5+X1bQM6l7oE7UHEkQRvz0Ob1itTSc=
Received: by 10.216.144.205 with SMTP id n55mr3469987wej.5.1292342108900;
        Tue, 14 Dec 2010 07:55:08 -0800 (PST)
Received: from localhost.localdomain (abvn89.neoplus.adsl.tpnet.pl [83.8.211.89])
        by mx.google.com with ESMTPS id b30sm165539wen.1.2010.12.14.07.55.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 07:55:07 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBEFsVdo023891;
	Tue, 14 Dec 2010 16:54:39 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163655>

When creating path_info part of link, don't encode space as '+', because
while $cgi->param('foo') translates '+' in query param to ' ', neither
$ENV{'PATH_INFO'} nor $cgi->path_info() do.

This fixes the issue with pathnames with embedded whitespace and
$feature{'pathinfo'} / path_info links.  It is done bu using newly
introduced esc_path_info() instead of esc_url() in href() subroutine.

Also while links are more clear not escaping space (' ') characters in
generated links, the trailing space must be URI-encoded, otherwise would
get discarded.

Issue noticed thanks to John 'Warthog9' Hawley.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
J.H., this fixes the noticed issue.

 gitweb/gitweb.perl |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d0dd4d..f5bfb87 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1230,7 +1230,7 @@ sub href {
 		$href =~ s,/$,,;
 
 		# Then add the project name, if present
-		$href .= "/".esc_url($params{'project'});
+		$href .= "/".esc_path_info($params{'project'});
 		delete $params{'project'};
 
 		# since we destructively absorb parameters, we keep this
@@ -1240,7 +1240,8 @@ sub href {
 		# Summary just uses the project path URL, any other action is
 		# added to the URL
 		if (defined $params{'action'}) {
-			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
+			$href .= "/".esc_path_info($params{'action'})
+				unless $params{'action'} eq 'summary';
 			delete $params{'action'};
 		}
 
@@ -1250,13 +1251,13 @@ sub href {
 			|| $params{'hash_parent'} || $params{'hash'});
 		if (defined $params{'hash_base'}) {
 			if (defined $params{'hash_parent_base'}) {
-				$href .= esc_url($params{'hash_parent_base'});
+				$href .= esc_path_info($params{'hash_parent_base'});
 				# skip the file_parent if it's the same as the file_name
 				if (defined $params{'file_parent'}) {
 					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {
 						delete $params{'file_parent'};
 					} elsif ($params{'file_parent'} !~ /\.\./) {
-						$href .= ":/".esc_url($params{'file_parent'});
+						$href .= ":/".esc_path_info($params{'file_parent'});
 						delete $params{'file_parent'};
 					}
 				}
@@ -1264,19 +1265,19 @@ sub href {
 				delete $params{'hash_parent'};
 				delete $params{'hash_parent_base'};
 			} elsif (defined $params{'hash_parent'}) {
-				$href .= esc_url($params{'hash_parent'}). "..";
+				$href .= esc_path_info($params{'hash_parent'}). "..";
 				delete $params{'hash_parent'};
 			}
 
-			$href .= esc_url($params{'hash_base'});
+			$href .= esc_path_info($params{'hash_base'});
 			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
-				$href .= ":/".esc_url($params{'file_name'});
+				$href .= ":/".esc_path_info($params{'file_name'});
 				delete $params{'file_name'};
 			}
 			delete $params{'hash'};
 			delete $params{'hash_base'};
 		} elsif (defined $params{'hash'}) {
-			$href .= esc_url($params{'hash'});
+			$href .= esc_path_info($params{'hash'});
 			delete $params{'hash'};
 		}
 
@@ -1309,6 +1310,9 @@ sub href {
 	}
 	$href .= "?" . join(';', @result) if scalar @result;
 
+	# final transformation: trailing spaces must be escaped (URI-encoded)
+	$href =~ s/(\s+)$/CGI::escape($1)/e;
+
 	return $href;
 }
 
@@ -1391,6 +1395,17 @@ sub esc_param {
 	return $str;
 }
 
+# the quoting rules for path_info fragment are slightly different
+sub esc_path_info {
+	my $str = shift;
+	return undef unless defined $str;
+
+	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
+
+	return $str;
+}
+
 # quote unsafe chars in whole URL, so some characters cannot be quoted
 sub esc_url {
 	my $str = shift;
