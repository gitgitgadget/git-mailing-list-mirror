From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 4/6] gitweb: use_pathinfo creates parent..current paths
Date: Sun, 21 Sep 2008 22:57:41 +0200
Message-ID: <1222030663-22540-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW16-0002jI-Ny
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYIUU5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYIUU5n
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:43 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:40517 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYIUU5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:42 -0400
Received: by ik-out-1112.google.com with SMTP id c30so674164ika.5
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vKwl26Fs/EAOmvR0J8sOSq5s0Lc71I0GrvlSCJtRspo=;
        b=Bk7FhkM3/R/O3RciGMXPj88s2QDt3idtqyJoJe5F0R6pspySUc+m2atx5yY+tQllB9
         58BCo20PGyXS5BCVt2s9y/qDA5G7LBJnThnMF+YKeKsXGl505HY7bSs6yu0Rck6/HlVg
         wQdYndnSBLi8+rHwaYHH6i7AB76UKgQZl8fWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jmHll9n3xo+P9JbJIdQZcVrJUP0Lvs+Ofh7iunNO2T5ZrZBnwbH1+FhIHntXIbZHCe
         1CAeio97tlN/R+ItF+s+WRDfu69g9O8L6esOp9PgWMhLkW04LR+UgI6G2YcMNvz1Kt++
         K89jb88sD+Bh5XKsnT8NPdphda3FSvL//qI0M=
Received: by 10.210.92.11 with SMTP id p11mr3788547ebb.175.1222030660934;
        Sun, 21 Sep 2008 13:57:40 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 20sm6356335eyc.9.2008.09.21.13.57.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222030663-22540-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96437>

If use_pathinfo is enabled, href now creates links that contain paths in
the form $project/$action/oldhash:/oldname..newhash:/newname for actions
that use hash_parent etc, unless oldname contains two consecutive dots, since
this would cause ambiguity when parsing the resulting path.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9868bf4..0dd2526 100755
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
+				if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
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
-			if (defined $params{'file_name'}) {
+			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
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
