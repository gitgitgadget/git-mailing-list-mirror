From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 2/5] gitweb: generate project/action/hash URLs
Date: Thu, 16 Oct 2008 22:27:08 +0200
Message-ID: <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:28:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZSL-0000ID-Dx
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbYJPU1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbYJPU1G
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:27:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17896 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYJPU1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:27:05 -0400
Received: by nf-out-0910.google.com with SMTP id d3so137749nfc.21
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vyGcebr8AnfkLASO2YvHey1nu6QlcO0wrmnmMDbiwT8=;
        b=E99m6lekd+x11G43nsf4Gn8qC7Ga+VlgENpG381WSwdRVoJ6gqJ1CgUax3MQF7/cDF
         xeCKQ6n641Cbg/g4ASByzp6vaCLdretNXsic9v9bbDlM8QbFckDCMJlKB+lUpe8IT24Z
         f5CmxyBN20+W2Es36IJM0S5DvjWWt1Q2hDcq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TibZQ6XC+aeQ9CKFnuvSekluesd/ip7VduNKwjo6BWgBQrIM87rqV66DL+s6nHhOh5
         hF83kPfvpQeeCrq10MEM3+pNMbN/xRjVhKZHSE9uDGDNDHplFxIIuzeHfb1zx+a99Ns3
         OnfrMRZ3YAy8STH5X/o4qhd1o1faAqFrQaBas=
Received: by 10.210.127.13 with SMTP id z13mr3448195ebc.39.1224188821765;
        Thu, 16 Oct 2008 13:27:01 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 3sm2504578eyj.3.2008.10.16.13.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:27:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98417>

When generating path info URLs, reduce the number of CGI parameters by
embedding action and hash_parent:filename or hash in the path.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6d0dc26..5337d40 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -724,14 +724,41 @@ sub href (%) {
 
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
