From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv3 3/3] gitweb: embed snapshot format parameter in PATH_INFO
Date: Sun,  2 Nov 2008 10:21:39 +0100
Message-ID: <1225617699-30004-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1225617699-30004-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1225617699-30004-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1225617699-30004-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:22:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZA9-0002pv-Be
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbYKBJVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYKBJU7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:20:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:11631 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbYKBJUz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:20:55 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1532305ugf.37
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 01:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lwVAGWIruUgZ0KvDg/6Lz0sw5gSZrsQBu0mLY5kK+IU=;
        b=YRvg9ajeXdpjsjGL4K3FyctTXp2aWhZVgx1Su4RkHDPvYW3tQpIjYMG0XEQGet76lN
         kdlDIzYlvkSZBTgM8QgenlUl1+rGhBuTLLMNjH5woX89esJ9nWZ/uY4qJ0Aa0Q+dqNA6
         12GUqBt/FvNJB4zWlpo0QIpTKms00WfU3NLto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FyTjSn8FU5ydxCEiw6tw4ZzM7k6T6MHEO7xwik6q7lKmByxs4X6Scxl5bI4q/xAbW+
         mwbP5liWKkFq0yYYnSoTXuEWtbOXVaG5ow+ivty9xE5I722kdnOn09lrBJvQBewlnnxj
         hdgLDdluPohk7Ug1LuD9l8FCkKzq36R+3vK9A=
Received: by 10.67.123.8 with SMTP id a8mr1215310ugn.42.1225617654895;
        Sun, 02 Nov 2008 01:20:54 -0800 (PST)
Received: from localhost ([94.37.26.217])
        by mx.google.com with ESMTPS id i30sm7596539ugd.30.2008.11.02.01.20.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 01:20:54 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225617699-30004-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99827>

When PATH_INFO is active, get rid of the sf CGI parameter by embedding
the snapshot format information in the PATH_INFO URL, in the form of an
appropriate extension.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0a41be5..d2484ab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -810,6 +810,7 @@ sub href (%) {
 		#   - action
 		#   - hash_parent or hash_parent_base:/file_parent
 		#   - hash or hash_base:/filename
+		#   - the snapshot_format as an appropriate suffix
 
 		# When the script is the root DirectoryIndex for the domain,
 		# $href here would be something like http://gitweb.example.com/
@@ -821,6 +822,10 @@ sub href (%) {
 		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
 		delete $params{'project'};
 
+		# since we destructively absorb parameters, we keep this
+		# boolean that remembers if we're handling a snapshot
+		my $is_snapshot = $params{'action'} eq 'snapshot';
+
 		# Summary just uses the project path URL, any other action is
 		# added to the URL
 		if (defined $params{'action'}) {
@@ -860,6 +865,18 @@ sub href (%) {
 			$href .= esc_url($params{'hash'});
 			delete $params{'hash'};
 		}
+
+		# If the action was a snapshot, we can absorb the
+		# snapshot_format parameter too
+		if ($is_snapshot) {
+			my $fmt = $params{'snapshot_format'};
+			# snapshot_format should always be defined when href()
+			# is called, but just in case some code forgets, we
+			# fall back to the default
+			$fmt ||= $snapshot_fmts[0];
+			$href .= $known_snapshot_formats{$fmt}{'suffix'};
+			delete $params{'snapshot_format'};
+		}
 	}
 
 	# now encode the parameters explicitly
-- 
1.5.6.5
