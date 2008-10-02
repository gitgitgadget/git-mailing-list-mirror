From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: generate project/action/hash URLs
Date: Thu,  2 Oct 2008 02:10:31 +0200
Message-ID: <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnJ-00017h-F6
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYJBAKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbYJBAKO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48915 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYJBAKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:10:09 -0400
Received: by nf-out-0910.google.com with SMTP id d3so341125nfc.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xxFGEx0S9669VqDw4SmL17E9bOtO1BAXe4fFjMO5R1o=;
        b=Zu2QJtaeLNoMpe8EqeRbpT5N6f9SQMJFc4sAXgxHF2JF4gvq7or8NDC2tkmgonPO4L
         9/d/KdS4GfAxT3wWrxwfl1crDxPUwDU94x+JcXjoJ4txOKRLCia6bj6fWgkp6yYH2cLJ
         715YbnCwkIyEY/veenBmI30jiUg2NG8ou8kKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IuEg6qy5FKpboyGF7r46xHW2zUJqPm7ihgeOHncxHuViKRlsvxODM/GR3WKqVJgHFN
         cN1xDxrsxOMh7MGuR9CuXo0jhGjFfG709MbmZqB2m2KVF8ILJ/CtozxcQbFe12cfNgyR
         G97Om/ydrOisKEqlmUuN8BQQEaM8Bk9DkDxZk=
Received: by 10.210.25.19 with SMTP id 19mr10484976eby.134.1222906209142;
        Wed, 01 Oct 2008 17:10:09 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 3sm1113952eyj.3.2008.10.01.17.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:10:08 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97286>

When generating path info URLs, reduce the number of CGI parameters by
embedding action and hash_parent:filename or hash in the path.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec4326f..2c380ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -687,14 +687,40 @@ sub href (%) {
 
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
