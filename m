From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: generate parent..current URLs
Date: Thu,  2 Oct 2008 02:10:34 +0200
Message-ID: <1222906234-8182-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnL-00017h-N3
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbYJBAKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYJBAKX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48915 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYJBAKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:10:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so341125nfc.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qg0LIMyEvha+nJUA9RRhWMYZ1qyKF/M8koDrrz4Hds4=;
        b=dxwyItBMHh4KUHVeObZgdWMAszICHSCJRE7hlrdkePKzLQRWCcUJkrNmt6eUH79ezT
         HTObCBuX/DmrHL5EUC70ZVYgpKkBBC6MF+I0QRdeKnwVEDWmLOGIbgfD3pY8+gBlmTrm
         0vsrwpL2/kt4bXikCN33Si8UUYflYjBMnoeyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CskyoaBInG6LVMksiIDxFBu0KygwGg9EONorNCJ99tKrO6tAWaPjuHh+dNYKJG/e1n
         crfC+APe3jWXt3p4XiFuTZ7iXWWulGRSS4d+Z8a1kMSYGS9aDYCCbZTzgfMp9Ijk7QRt
         /EoyMxO1/b2cjAROGD4NhQcHll+ualOqZww3c=
Received: by 10.210.123.2 with SMTP id v2mr10466819ebc.186.1222906220106;
        Wed, 01 Oct 2008 17:10:20 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 20sm1128524eyk.4.2008.10.01.17.10.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:10:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97287>

If use_pathinfo is enabled, href now creates links that contain paths in
the form $project/$action/oldhash:/oldname..newhash:/newname for actions
that use hash_parent etc.

If any of the filename contains two consecutive dots, it's kept as a CGI
parameter since the resulting path would otherwise be ambiguous.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 89e360f..d863ef7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -712,7 +712,8 @@ sub href (%) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-		#   - hash or hash_base:/filename
+		#   - hash_parent or hash_parent_base:/file_parent
+		#   - hash or hash_base:/file_name
 
 		# Strip any trailing / from $href, or we might get double
 		# slashes when the script is the DirectoryIndex
@@ -730,17 +731,36 @@ sub href (%) {
 			delete $params{'action'};
 		}
 
-		# Finally, we put either hash_base:/file_name or hash
+		# Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
+		# stripping nonexistent or useless pieces
+		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
+			|| $params{'hash_parent'} || $params{'hash'});
 		if (defined $params{'hash_base'}) {
-			$href .= "/".esc_url($params{'hash_base'});
-			if (defined $params{'file_name'}) {
+			if (defined $params{'hash_parent_base'}) {
+				$href .= esc_url($params{'hash_parent_base'});
+				# skip the file_parent if it's the same as the file_name
+				delete $params{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
+				if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
+					$href .= ":/".esc_url($params{'file_parent'});
+					delete $params{'file_parent'};
+				}
+				$href .= "..";
+				delete $params{'hash_parent'};
+				delete $params{'hash_parent_base'};
+			} elsif (defined $params{'hash_parent'}) {
+				$href .= esc_url($params{'hash_parent'}). "..";
+				delete $params{'hash_parent'};
+			}
+
+			$href .= esc_url($params{'hash_base'});
+			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
 				$href .= ":/".esc_url($params{'file_name'});
 				delete $params{'file_name'};
 			}
 			delete $params{'hash'};
 			delete $params{'hash_base'};
 		} elsif (defined $params{'hash'}) {
-			$href .= "/".esc_url($params{'hash'});
+			$href .= esc_url($params{'hash'});
 			delete $params{'hash'};
 		}
 	}
-- 
1.5.6.5
