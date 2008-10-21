From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 2/5] gitweb: generate project/action/hash URLs
Date: Tue, 21 Oct 2008 21:34:51 +0200
Message-ID: <1224617694-29277-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:36:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsN1k-0004hL-DK
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbYJUTeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbYJUTeg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:34:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:6888 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYJUTee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:34:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so43301fgg.17
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oTRrMGUjWAuNWWjc8++Br/ck7QdvWlzkET472Y75gRo=;
        b=V/oH4sfpn0j0S6CCpiknTXZDKeIlcKoBaQaoRydA6EeDZ3Pf3Iv/NsD4oO+5LuzpBw
         /DAQ1WbTTePy8b7xpeE2GWGMKQSaNQ+HwSHG/2Gxby7ArybkCaZaGRhZubFF1FD2vvlK
         O8XZpBi7Osmp736N5rQ9yKzMmt0TTQl4ZfkEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SlNVrOW8V1nVXIS1JXeMxVhN83WuUK3CzAI6wXj0YtpdEST1OBddlsWYfHwDXl7w9s
         FGVbVLxJ8N218IJx9yoGflkVMdtkdjcN1lOEC9fVLJ1d1bcpHxXwgKyP4Gi4Hc2LGtD0
         jLthKodc1SgBxJeoATurKOuzgBwAxXTQvJtKI=
Received: by 10.181.59.6 with SMTP id m6mr3058220bkk.20.1224617673429;
        Tue, 21 Oct 2008 12:34:33 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 28sm17418025fkx.1.2008.10.21.12.34.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 12:34:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224617694-29277-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98810>

When generating path info URLs, reduce the number of CGI parameters by
embedding action and hash_parent:filename or hash in the path.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f847bb..27587aa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -731,14 +731,41 @@ sub href (%) {
 
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
-		# use PATH_INFO for project name
+		# try to put as many parameters as possible in PATH_INFO:
+		#   - project name
+		#   - action
+		#   - hash or hash_base:filename
+
+		# When the script is the root DirectoryIndex for the domain,
+		# $href here would be something like http://gitweb.example.com/
+		# Thus, we strip any trailing / from $href, to spare us double
+		# slashes in the final URL
+		$href =~ s,/$,,;
+
+		# Then add the project name, if present
 		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
 		delete $params{'project'};
 
-		# Summary just uses the project path URL
-		if (defined $params{'action'} && $params{'action'} eq 'summary') {
+		# Summary just uses the project path URL, any other action is
+		# added to the URL
+		if (defined $params{'action'}) {
+			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
 			delete $params{'action'};
 		}
+
+		# Finally, we put either hash_base:file_name or hash
+		if (defined $params{'hash_base'}) {
+			$href .= "/".esc_url($params{'hash_base'});
+			if (defined $params{'file_name'}) {
+				$href .= ":".esc_url($params{'file_name'});
+				delete $params{'file_name'};
+			}
+			delete $params{'hash'};
+			delete $params{'hash_base'};
+		} elsif (defined $params{'hash'}) {
+			$href .= "/".esc_url($params{'hash'});
+			delete $params{'hash'};
+		}
 	}
 
 	# now encode the parameters explicitly
-- 
1.5.6.5
