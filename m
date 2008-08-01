From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] gitweb: use_pathinfo creates parent..current paths
Date: Sat,  2 Aug 2008 00:17:11 +0200
Message-ID: <1217629031-14894-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1217622913-9747-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1217629031-14894-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 00:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2wx-0005An-SN
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbYHAWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYHAWRG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:17:06 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:9966 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbYHAWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 18:17:04 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1044349fkq.5
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=L++epfHKUebSZJEUv/fMYemC0uVjZVZ6+kY2cWJIScM=;
        b=EjIGV1CuMMsdB7xkpBtDW2WALI/KdNwLiEV8i+hZad0oNfe1m9VpSVr81QxB/uVN25
         Tj70Z9guLa83lYUujt0AvkdmE3VRFEEH77qSg0LxdvCsoSnD6ND/6o6ApxJM3fTsYW9b
         +dM0koPt3CJnlPjBbIzTFNPHzTsecrBQUiKJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RE5XL3vF+35G3KSrWmDPgab288IaIaGNBHLytghOTE+jir3enLZVGXG6MHJ/+vPX9x
         QTu08zYaC30fjLX2CcTQbyvmh7jq9RN2qAelErAEEdxOthIUOC43J8zmbRFbw/3Q7KYe
         iUb/egG9lyFHZFmA/Q/5OCCmENlGVWJHr68PY=
Received: by 10.181.25.18 with SMTP id c18mr4251465bkj.8.1217629022166;
        Fri, 01 Aug 2008 15:17:02 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id 35sm1512998fkt.12.2008.08.01.15.16.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 15:17:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1217629031-14894-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91110>

If use_pathinfo is enabled, href now creates links that contain paths in
the form $project/$action/oldhash:/oldname..newhash:/newname for actions
that use hash_parent etc.
---
 gitweb/gitweb.perl |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8364b71..e89e1a1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -703,9 +703,29 @@ sub href (%) {
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
@@ -715,7 +735,7 @@ sub href (%) {
 			}
 			delete $params{'hash_base'};
 		} elsif (defined $params{'hash'}) {
-			$href .= "/".esc_url($params{'hash'});
+			$href .= esc_url($params{'hash'});
 			delete $params{'hash'};
 		}
 	}
-- 
1.5.6.3
