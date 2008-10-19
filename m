From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv2 7/8] gitweb: embed snapshot format parameter in PATH_INFO
Date: Sun, 19 Oct 2008 16:24:29 +0200
Message-ID: <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 05:51:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrZDo-00062W-EK
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 16:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbYJSOYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 10:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYJSOYN
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 10:24:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:46624 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYJSOYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 10:24:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1478177fkq.5
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6dlTcleSX7Eh0yWXZn9aMhDZ/i/itYmlUFwfFhe8I6c=;
        b=H7qBlHuMHUmFqbYQH+Jf1JebLcAWb0U0gVNacgMBIFFzJBkNF1aPzYf4GhJqhWnsYg
         OpEBwDxTU1kUxpb6xk1gTFeuZlCuX9UFNjiHSrM2xos3nV/YcRrIu2V6SH6zCVbg8mVY
         89uu55GsC8Km0ip06kiOo9SWIMNbk7atyVNKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NCvsboHpvbhKjjUSK4aPTnMWFNPccGZQhskvaeUYpDbjHqKaKSKbhA+qYZ8prfY8Q3
         pctjgqzdFT8d30t0ClwpX52Huwaeye4x3U7dGWZ/w9G/+gIuiHmqr0XSH2TCo3Jf24G/
         fVsajAz+IjgVdsU5tqM9ZHFxe9jcVLeBHGv7Y=
Received: by 10.181.48.4 with SMTP id a4mr2307642bkk.6.1224426250711;
        Sun, 19 Oct 2008 07:24:10 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id h2sm6227505fkh.11.2008.10.19.07.24.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 07:24:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98607>

When PATH_INFO is active, get rid of the sf CGI parameter by embedding
the snapshot format information in the PATH_INFO URL, in the form of an
appropriate extension.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e9e9e60..5fd5a1f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -795,6 +795,7 @@ sub href (%) {
 		#   - action
 		#   - hash_parent or hash_parent_base:/file_parent
 		#   - hash or hash_base:/file_name
+		#   - the snapshot_format as an appropriate suffix
 
 		# When the script is the root DirectoryIndex for the domain,
 		# $href here would be something like http://gitweb.example.com/
@@ -806,6 +807,10 @@ sub href (%) {
 		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
 		delete $params{'project'};
 
+		# since we destructively absorb parameters, we keep this
+		# boolean that remembers if we're handling a snapshot
+		my $is_snapshot = $params{'action'} eq 'snapshot';
+
 		# Summary just uses the project path URL, any other action is
 		# added to the URL
 		if (defined $params{'action'}) {
@@ -845,6 +850,22 @@ sub href (%) {
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
+			if (!$fmt) {
+				my @snapshot_fmts = gitweb_check_feature('snapshot');
+				@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
+				$fmt = $snapshot_fmts[0];
+			}
+			$href .= $known_snapshot_formats{$fmt}{'suffix'};
+			delete $params{'snapshot_format'};
+		}
 	}
 
 	# now encode the parameters explicitly
-- 
1.5.6.5
