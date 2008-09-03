From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: use_pathinfo creates parent..current paths
Date: Wed,  3 Sep 2008 11:57:18 +0200
Message-ID: <1220435839-29360-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kap8R-0000SL-AM
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYICJ5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbYICJ5k
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:57:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13977 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbYICJ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:57:37 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1366057eyi.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hlBV72jsFU6m4PjlT5xLB3h0c5GWQ4F8cIwaMjeDrLk=;
        b=YcTIZvvB+oA1pkKrRfYqRmC2ztYSuL8JY/yr5XoTtgAFKhi5tpRf0Vnr/uLWj3NvSi
         /YJJ/KHCmfCn5XcJo0ZghDrhxJNabCxJL4ilRkzJG3fst0v3jeHTOZCudAhGMGRc2D/x
         qTCcUVHFiMLUwOuFLZofQA5eeI4GOSwGM5J7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x8pOeyWGn8/lRKRUu3wGy0ZXj5OhMM/8N3c7r5XgEbd6tXgPIoL1fbEKhLwWmXWhXA
         +tWHPDdvZk4klrQwQxtYfM+2MEkysoAfcl7XrJQL/HM7geOx4eoJ8SLSfoRtssZy9ThF
         6fVpgblkMUTWApg/IW3L1yHi+81ZcNTVw+mIc=
Received: by 10.210.71.13 with SMTP id t13mr9820750eba.112.1220435857032;
        Wed, 03 Sep 2008 02:57:37 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id 1sm7202226nfv.18.2008.09.03.02.57.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:57:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1220435839-29360-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94778>

If use_pathinfo is enabled, href now creates links that contain paths in
the form $project/$action/oldhash:/oldname..newhash:/newname for actions
that use hash_parent etc.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d21624..573b416 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -682,9 +682,29 @@ sub href (%) {
 			delete $params{'action'};
 		}
 
-		# next, we put either hash_base:file_name or hash
+		# next, we put hash_parent_base:/file_parent..hash_base:/file_name, stripping nonexistent or useless pieces
+		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'} || $params{'hash_parent'} || $params{'hash'});
 		if (defined $params{'hash_base'}) {
-			$href .= "/".esc_url($params{'hash_base'});
+			if (defined $params{'hash_parent_base'}) {
+				$href .= esc_url($params{'hash_parent_base'});
+				if (defined $params{'file_parent'}) {
+					$href .= ":/".esc_url($params{'file_parent'}) unless $params{'file_parent'} eq $params{'file_name'};
+					delete $params{'hash_parent'} if $params{'hash_parent'} eq git_get_hash_by_path($params{'hash_parent_base'},$params{'file_parent'});
+					delete $params{'file_parent'};
+				} else {
+					delete $params{'hash_parent'} if $params{'hash_parent'} eq $params{'hash_parent_base'};
+					if ($params{'file_name'}) {
+						delete $params{'hash_parent'} if $params{'hash_parent'} eq git_get_hash_by_path($params{'hash_parent_base'},$params{'file_name'});
+					}
+				}
+				$href .= "..";
+				delete $params{'hash_parent_base'};
+			} elsif (defined $params{'hash_parent'}) {
+				$href .= esc_url($params{'hash_parent'}). "..";
+				delete $params{'hash_parent'};
+			}
+
+			$href .= esc_url($params{'hash_base'});
 			if (defined $params{'file_name'}) {
 				$href .= ":/".esc_url($params{'file_name'});
 				delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
@@ -694,7 +714,7 @@ sub href (%) {
 			}
 			delete $params{'hash_base'};
 		} elsif (defined $params{'hash'}) {
-			$href .= "/".esc_url($params{'hash'});
+			$href .= esc_url($params{'hash'});
 			delete $params{'hash'};
 		}
 	}
-- 
1.5.6.5
