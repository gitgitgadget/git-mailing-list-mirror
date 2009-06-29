From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 5/7] gitweb: gravatar url cache
Date: Tue, 30 Jun 2009 00:00:52 +0200
Message-ID: <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOv1-0005Hd-Oc
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620AbZF2WBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758577AbZF2WBA
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:01:00 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55743 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758266AbZF2WA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:59 -0400
Received: by fxm18 with SMTP id 18so1264521fxm.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2Ijid8cJBQCtAKEHYZ64kgrA0CNjMIWmRlHgDoJi/PQ=;
        b=ZDmQpNyHeWD3vObby9HP0h3OGdAtgIB9Sv9rxy6yUhBpAAQSR5brHloy+6/RaGzvpY
         ehDlfWtNW3Pz7JLFqltQH4MwVeECL+9Psj9maLao6e6EroXJ8GBTI2W7vesBRf7e2gRo
         QnN8bnwVPau2xtUCThfLPXj3j5S9lKI3EqtJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kycH/wUtySh2TQeEbdDy1GJXiZhgBNCOXPGcIBI6wqrT0OCzgOCepm5radzMDWvb+q
         0ClOsanW+kNOcNtlh35GgR9kCc7eVeD98cBmW3smAB/SSzzX1Is7kcird1SoJzk4y+l8
         bx2U8CPM4QYluJvYF/XuSunFewc9roU5KZHm8=
Received: by 10.204.63.208 with SMTP id c16mr7573375bki.131.1246312860254;
        Mon, 29 Jun 2009 15:01:00 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id g28sm10440890fkg.45.2009.06.29.15.00.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:00:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122470>

Views which contain many occurrences of the same email address (e.g.
shortlog view) benefit from not having to recalculate the MD5 of the
email address every time.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 92695a3..4d7e4ff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1512,6 +1512,27 @@ sub format_subject_html {
 	}
 }
 
+# Rather than recomputing the url for an email multiple times, we cache it
+# after the first hit. This gives a visible benefit in views where the avatar
+# for the same email is used repeatedly (e.g. shortlog).
+# The cache is shared by all avatar engines (currently gravatar only), which
+# are free to use it as preferred. Since only one avatar engine is used for any
+# given page, there's no risk for cache conflicts.
+our %avatar_cache = ();
+
+# Compute the gravatar url for a given email, if it's not in the cache already.
+# Gravatar stores only the part of the URL before the size, since that's the
+# one computationally more expensive. This also allows reuse of the cache for
+# different sizes (for this particular engine).
+sub gravatar_url {
+	my $email = lc shift;
+	my $size = shift;
+	$avatar_cache{$email} ||=
+		"http://www.gravatar.com/avatar/" .
+			Digest::MD5::md5_hex($email) . "?s=";
+	return $avatar_cache{$email} . $size;
+}
+
 # Insert an avatar for the given $email at the given $size if the feature
 # is enabled.
 sub git_get_avatar {
@@ -1522,8 +1543,7 @@ sub git_get_avatar {
 	my $size = $avatar_size{$opts{-size}} || $avatar_size{'default'};
 	my $url = "";
 	if ($git_avatar eq 'gravatar') {
-		$url = "http://www.gravatar.com/avatar/" .
-			Digest::MD5::md5_hex(lc $email) . "?s=$size";
+		$url = gravatar_url($email, $size);
 	}
 	# Currently only gravatars are supported, but other forms such as
 	# picons can be added by putting an else up here and defining $url
-- 
1.6.3.rc1.192.gdbfcb
