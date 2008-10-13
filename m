From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 2/5] gitweb: generate project/action/hash URLs
Date: Mon, 13 Oct 2008 12:19:22 +0200
Message-ID: <1223893165-26022-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 12:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpKXZ-0003aN-UA
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762610AbYJMKTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755815AbYJMKT3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:19:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:6305 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762470AbYJMKTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:19:24 -0400
Received: by nf-out-0910.google.com with SMTP id d3so667763nfc.21
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vyGcebr8AnfkLASO2YvHey1nu6QlcO0wrmnmMDbiwT8=;
        b=YnKRA1EWbWOXig6nOqt6CdXfpDJKbz4droFcVnq0hNnV7EvExBceNOeFbygPcAq86M
         VY26FA4CRDL5dsKZCQwFxceUrpyk2DbwizdwAOdULBE1+dl3JFeTvo1bcPn44DvUNa3Y
         WvYhuPv+tk++0Tn+KcmxpVxQYcT84NN2kABXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sj6ZFagaBzbLkfCtpg6nk9FFmkdz6b6G5GYRmWVXmgCSmHNBfFhLPX2gKXIcg/Eaba
         UKZPQ68UcEwzOGBEfW4gldtPuiFTXMyCtC84qGEYx2gfW9EEIFcw4e5ivNqs7Wf1A3/r
         TeWUaKy/UOEuAqxE7ApdCOHb15yL289zmvf0o=
Received: by 10.210.58.13 with SMTP id g13mr5259163eba.60.1223893162329;
        Mon, 13 Oct 2008 03:19:22 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id 7sm9563211eyg.0.2008.10.13.03.19.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 03:19:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1223893165-26022-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98104>

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
