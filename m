From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: generate project/action/hash URLs
Date: Mon, 29 Sep 2008 17:26:55 +0200
Message-ID: <1222702017-4496-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222702017-4496-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222702017-4496-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 17:28:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKfD-0003R0-5u
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYI2P0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYI2P0l
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:26:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:24426 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbYI2P0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:26:40 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2083573fkq.5
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wfLsDAdAlfstM32FrysiNc6Tyd6cCvqCkQO2ogZbTR0=;
        b=oi8rzJrmtwlKjyqujKcmMTTDUObGcQBBOhu0/F8muMi/wiLZMaCqyRFMv8AsVUmmVE
         +VAFhE79yZyDYlSbna/Oh2TtmZcV7w+2BQTCAX2M29dXA3fH8IKMJEjvIR7v7IpZqrrx
         aqETRR8sQ38rEqw9q5gLI0q1jo6mFDhIyuIhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NvHhoNt1SbwYHpvb8qpJokFoAvMlgevKmZedkH9M2CvR6xwynIYSdG6+Y30kLcOPVM
         jldCCUpy8HtPSNxIZaSF6SESOGdnfwa6RMHWVoYVYxBZppZPs0rfsMmVD00/c55gVsK5
         FuGgCVy76xoFo/NfGAVWzuAqsD5v+AZI1/PBw=
Received: by 10.181.5.1 with SMTP id h1mr2448660bki.7.1222701998301;
        Mon, 29 Sep 2008 08:26:38 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 28sm358983fkx.1.2008.09.29.08.26.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 08:26:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222702017-4496-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97024>

When generating path info URLs, reduce the number of CGI parameters by
embedding action and hash_parent:filename or hash in the path.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a3076bd..75d4178 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -657,14 +657,40 @@ sub href (%) {
 
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
-		# use PATH_INFO for project name
+		# try to put as many parameters as possible in PATH_INFO:
+		#   - project name
+		#   - action
+		#   - hash or hash_base:filename
+
+		# Strip any trailing / from $href, or we might get double
+		# slashes when the script is the DirectoryIndex
+		#
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
+		# Finally, we put either hash_base:/file_name or hash
+		if (defined $params{'hash_base'}) {
+			$href .= "/".esc_url($params{'hash_base'});
+			if (defined $params{'file_name'}) {
+				$href .= ":/".esc_url($params{'file_name'});
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
