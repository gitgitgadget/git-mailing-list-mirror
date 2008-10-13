From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 5/5] gitweb: generate parent..current URLs
Date: Mon, 13 Oct 2008 12:19:25 +0200
Message-ID: <1223893165-26022-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 12:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpKYg-0003xi-4k
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762578AbYJMKTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763775AbYJMKTh
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:19:37 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:25739 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763412AbYJMKTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:19:35 -0400
Received: by ey-out-2122.google.com with SMTP id 6so551093eyi.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uzooIaX0+pvNwPHwmOey20CNckSt2eZYipoak8J5sKc=;
        b=pmnr4x5kuvbGFwZ5/MR0SOheAof0pcydRPJzNFm99MubKvCakdXg501/MyEK9oW5Cf
         v8fxDxXs+0ZQIOCqa19yqKLQBeBJbKjng0UOrLRewX/EIKIyVOm8fGM0MmFZqie77n4U
         8jVLuZbFasqCuD0KTV8G5D5RbfJEVCjOXdXps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JKrI0wbJCM1degBoG09p8kxRYdbrF7+JNAJEL4UL4dfWh4kMg2j8fgtfXXUluxzFO+
         4J4yKV5HMNEFip+4rDCKrN+x708BffzXEnKZ3doL54hhc0N0NAKRiWq0rSP1ynkQGGdJ
         yvdR9qqkkhp3pSN1zkd7/73MfuO0StIuFBp/I=
Received: by 10.210.142.6 with SMTP id p6mr5260100ebd.100.1223893172678;
        Mon, 13 Oct 2008 03:19:32 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id 7sm9550064eyb.1.2008.10.13.03.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 03:19:31 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1223893165-26022-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98107>

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
