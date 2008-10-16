From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 5/5] gitweb: generate parent..current URLs
Date: Thu, 16 Oct 2008 22:27:11 +0200
Message-ID: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZSN-0000ID-Ow
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbYJPU1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbYJPU1R
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:27:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:37054 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbYJPU1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:27:14 -0400
Received: by ey-out-2122.google.com with SMTP id 6so78327eyi.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uzooIaX0+pvNwPHwmOey20CNckSt2eZYipoak8J5sKc=;
        b=SDEC/ZABMPD3ErarhEut3uL0j0sQnllSM6IoETqLj1ZVgNQTzfUY0otfNe7KLW52n1
         FmWyR8t5NnnBAxmvsmlta0EqT+dOZaS3bGeE38m5B4E5vyCA8L4zHQ5tSfte3EBnNuJC
         u55icClaBqCzl1avnYY325V8HdLgXQmI1AWr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j57ugPVM+qvbBqrxMq2Zl3RQb2ishbtVLWMz1e4SRVM2hsIyOq87K6yCRCvB/IbZfH
         lN703pWas/1QkEbZCIVS6pM2zY+0Mmx9EneUGih6TWLfu83KVkcsnJRjEDokpUoUE9WI
         HLd1Nw4YRdC/f+l99vqlGtQ6iUEaau5QMsoqA=
Received: by 10.210.45.14 with SMTP id s14mr3392694ebs.172.1224188833339;
        Thu, 16 Oct 2008 13:27:13 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 5sm2574629eyf.8.2008.10.16.13.27.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:27:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98416>

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
index 1a7b0b9..f4642e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -759,7 +759,8 @@ sub href (%) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-		#   - hash or hash_base:/filename
+		#   - hash_parent or hash_parent_base:/file_parent
+		#   - hash or hash_base:/file_name
 
 		# When the script is the root DirectoryIndex for the domain,
 		# $href here would be something like http://gitweb.example.com/
@@ -778,17 +779,36 @@ sub href (%) {
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
