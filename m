From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 5/8] gitweb: gravatar url cache
Date: Thu, 25 Jun 2009 12:43:04 +0200
Message-ID: <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQx-0008IK-Al
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbZFYKn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbZFYKn0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:26 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47512 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211AbZFYKnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:18 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so1301579bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sHnOGuHoP2WlwJZNSbTY7lcDynCFZ+st8dEVfjySrQw=;
        b=V6zNMQkNpHnl3z7jXvcRfVWBXUcXDuWoKG8OcyWZQbAXK0XKhTisgNzDezp0a7LIlT
         N+19eSFypsaDKi+9R5Fu4UECsVgci0LvO+dE3XNSvStUrB7eAq096Zwlr8mVve/tk26C
         24t5WzuQUd9H+F9IBnK9wcb2TUNzL6kcODtS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pGXysoH+N+pO3qXmUD3MPSMpwtr/Iqd76yufP93e+Pm1iFNQpA9Vbg4PihCfEGEyHc
         Eens9scy13VCEGw5yrDhQXNkF4Q/INmsF+hmZqpYioyH6BFjYJdzG7lYN0yHAUfiNYmk
         6zhH42Fy6MpJUu+AmLjytPWKM81yQ14jbpiTQ=
Received: by 10.204.52.135 with SMTP id i7mr2351806bkg.154.1245926600736;
        Thu, 25 Jun 2009 03:43:20 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 9sm3190840fks.28.2009.06.25.03.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122196>

Views which contain many occurrences of the same email address (e.g.
shortlog view) benefit from not having to recalculate the MD5 of the
email address every time.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f2e0cfe..d3bc849 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3257,6 +3257,27 @@ sub git_print_header_div {
 	      "\n</div>\n";
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
@@ -3266,8 +3287,7 @@ sub git_get_avatar {
 	my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
 	my $url = "";
 	if ($git_avatar eq 'gravatar') {
-		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
-			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
+		$url = gravatar_url($email, $size);
 	}
 	# Currently only gravatars are supported, but other forms such as
 	# picons can be added by putting an else up here and defining $url
-- 
1.6.3.rc1.192.gdbfcb
