From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 6/9] gitweb: gravatar url cache
Date: Sat, 27 Jun 2009 14:05:02 +0200
Message-ID: <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfk-0007Dq-13
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbZF0MF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZF0MF1
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbZF0MFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:11 -0400
Received: by fg-out-1718.google.com with SMTP id e12so183147fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Hfs2uTZ07IkY/6WfAPQMoJRr9xQEmAL0Uf7g9CnJ6Bo=;
        b=WTq0mPkqw+HLLhVct2xmnOIuEMBTPN4hWpssGPnawtdcsaslkNPXZRc+EwSvzEHJI1
         v/zgXwT261W8z3K/NjtJHcHw3qNcn7E8stGRgYmHs9x8I7MXi2AJrrVVKJW+t+SwXbNb
         Rrdu6CYwuhRtxBLe/hWY32SQqu3VR2bWDHmVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lDvkOnyNxaP++eowSAfImFdjCcSO5rKgPxIePjrVlKL0Jtt+zDH1BrPyzcVM8nLJsj
         lW+DzrBoWSDgEsPAA8vq0coS/GX26+YwR3XZ/T96qdUyaEg0qsmRJdu0KAfuQoieN0eL
         oPskjqJZ5Qck4Tm7z6TGe2gN9Bm/d365EY4Zk=
Received: by 10.86.91.5 with SMTP id o5mr247857fgb.57.1246104314819;
        Sat, 27 Jun 2009 05:05:14 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id d4sm3042177fga.3.2009.06.27.05.05.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122358>

Views which contain many occurrences of the same email address (e.g.
shortlog view) benefit from not having to recalculate the MD5 of the
email address every time.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ad9ae31..de4cc63 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1515,6 +1515,27 @@ sub format_subject_html {
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
+		"http://www.gravatar.com/avatar.php?gravatar_id=" .
+			Digest::MD5::md5_hex($email) . "&amp;size=";
+	return $avatar_cache{$email} . $size;
+}
+
 # Insert an avatar for the given $email at the given $size if the feature
 # is enabled.
 sub git_get_avatar {
@@ -1524,15 +1545,18 @@ sub git_get_avatar {
 	my $size = $avatar_size{$opts{'size'}} || $avatar_size{'default'};
 	my $url = "";
 	if ($git_avatar eq 'gravatar') {
-		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
-			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
+		$url = gravatar_url($email, $size);
 	}
 	# Currently only gravatars are supported, but other forms such as
 	# picons can be added by putting an else up here and defining $url
 	# as needed. If no variant puts something in $url, we assume avatars
 	# are completely disabled/unavailable.
 	if ($url) {
-		return $pre_white . "<img width=\"$size\" class=\"avatar\" src=\"$url\" />" . $post_white;
+		return $pre_white .
+		       "<img width=\"$size\" " .
+		            "class=\"avatar\" " .
+		            "src=\"$url\" " .
+		       "/>" . $post_white;
 	} else {
 		return "";
 	}
-- 
1.6.3.rc1.192.gdbfcb
