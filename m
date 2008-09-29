From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: generate parent..current URLs
Date: Mon, 29 Sep 2008 17:26:57 +0200
Message-ID: <1222702017-4496-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222702017-4496-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222702017-4496-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222702017-4496-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222702017-4496-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 17:28:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKfT-0003ZN-Po
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYI2P0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYI2P0x
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:26:53 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:41049 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYI2P0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:26:52 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1774491muf.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OW7JT+VSrpsP7NBK5hQP0xJW8VDUfgXxhQmINNsIVaM=;
        b=cd7Zf1X06MLWj4CgR0jXyZMaQYqYB+/mATUFbLreqoBeQ/sH3qD83hHKkLZIXykzs2
         Z/jyak4G6L0OYhU4MJOO+SooR9AN0/InYcfQHEpBhbBYMvDR18hGhJy6ICjam8JJ1LDm
         p62iWRiE2lnPH2EDCQJRwsZlAdjn4rjO09wH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jy+tjtpy/CqdAGSvxExtbWhtrqEPZik43lqx/9dCqFA6WjdA5QJni7B8HukDD00I01
         ZciP+V2DDlNfKbmNHMcn8auciDcF0s9HTunqhVbSWZnZAVVPCojnr1zx+9EKfKmEQEZK
         KHPq7KgMBzLf/IIQ5RDHIMI+mxPp8s//Ht2/Q=
Received: by 10.180.213.14 with SMTP id l14mr2401298bkg.55.1222702009080;
        Mon, 29 Sep 2008 08:26:49 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 28sm359874fkx.1.2008.09.29.08.26.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 08:26:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222702017-4496-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97025>

If use_pathinfo is enabled, href now creates links that contain paths in
the form $project/$action/oldhash:/oldname..newhash:/newname for actions
that use hash_parent etc.

If any of the filename contains two consecutive dots, it's kept as a CGI
parameter since the resulting path would otherwise be ambiguous.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7b4f2d3..4fa4364 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -700,17 +700,36 @@ sub href (%) {
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
