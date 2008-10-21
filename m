From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 5/5] gitweb: generate parent..current URLs
Date: Tue, 21 Oct 2008 21:34:54 +0200
Message-ID: <1224617694-29277-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:36:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsN1m-0004hL-N2
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYJUTer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbYJUTer
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:34:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:64243 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYJUTeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:34:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2671110fkq.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l4VWKv+FaOoQtcDSB6SGhEzJogqB8DpwOSwUWKfxt5Y=;
        b=jAWp+iuW9pAgYSKWVFDarKYT8c9iOLVMh1KJLTBqPel52UdMlp0IApxZB6u1ngw3oP
         FxFoefm+l109BBaGglS5BbcHST4Vxb9eK9fOXnTcq5cvV1bLbxDAP2GWIuIRyakFZC9W
         qLGwUpcl0qKEJpteonaqL+aAHf/X3BfRoj4oY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G5oWsF7kJF599z8duQlc4ahtHygQQXG0swtICXhdIjPkGq5TYQWJv37J4eEig6MW4O
         MCp2rJsT2PNQuRS/156Q272rYnJSI3QedUp5MbAxWy9EyIBP9mVAtc99wAKSaYNbUvCW
         Rn+1BMMDAIk5oiksXWAmuJveUW18or3bgHvAA=
Received: by 10.180.246.2 with SMTP id t2mr1271323bkh.161.1224617685560;
        Tue, 21 Oct 2008 12:34:45 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id h2sm10213548fkh.11.2008.10.21.12.34.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 12:34:44 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224617694-29277-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98809>

If use_pathinfo is enabled, href now creates links that contain paths in
the form $project/$action/oldhash:/oldname..newhash:/newname for actions
that use hash_parent etc.

If any of the filename contains two consecutive dots, it's kept as a CGI
parameter since the resulting path would otherwise be ambiguous.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 59449de..9d1af7e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -766,6 +766,7 @@ sub href (%) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
+		#   - hash_parent or hash_parent_base:/file_parent
 		#   - hash or hash_base:/filename
 
 		# When the script is the root DirectoryIndex for the domain,
@@ -785,17 +786,36 @@ sub href (%) {
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
