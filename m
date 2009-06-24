From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 3/3] gitweb: gravatar url cache
Date: Wed, 24 Jun 2009 23:16:23 +0200
Message-ID: <1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 23:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJZqh-0000oY-Oy
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbZFXVQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZFXVQj
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:16:39 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46512 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbZFXVQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:16:35 -0400
Received: by mail-fx0-f213.google.com with SMTP id 9so1056667fxm.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Cz33ly/nUMcMdlQeJD3fd8ADTxfO7UV3qc5SxkJKjys=;
        b=uLK6RRwfOD2OmdpWRDUydIecYDT/EiNYQhxm5RN11FZALPbrQq68tZq4vh8SITJThr
         T2pmnuAB6xGB94c8BoABcp7wmQIWKq0+aTBnW1Tt8zjAHpw5mXKAwvWw/vD8EcNv3iA1
         oW9Pw4+RE4tJynFvRwFhomfniIFsU4DFbkMKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FZeluLc+VuJ6r5JPXd/4SMEd72/CegFDUV0y3+faTNZHuGqKHv7XVJqR2YrYfO0eKQ
         H4eNGwdpI5YShI41eqa4XRn+eWow2d4DPUXnS6HMC3PtOOy1jfS5GLeVHtLuTyG8XoH7
         GMu3BTX1Ml2TkfyIIdZT+bZa3n7+0vmS4Tb7c=
Received: by 10.103.181.2 with SMTP id i2mr1053555mup.20.1245878198434;
        Wed, 24 Jun 2009 14:16:38 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 23sm7400361mun.16.2009.06.24.14.16.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 14:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122158>

Views which contain many occurrences of the same email address (e.g.
shortlog view) benefit from not having to recalculate the MD5 of the
email address every time.
---
 gitweb/gitweb.perl |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6e807fe..10ca0fe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3249,6 +3249,17 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+our %gravatar_url_cache = ();
+
+sub gravatar_url {
+	my $email = lc shift;
+	my $size = shift;
+	$gravatar_url_cache{$email} ||=
+		"http://www.gravatar.com/avatar.php?gravatar_id=" .
+			Digest::MD5::md5_hex($email) . "&amp;size=";
+	return $gravatar_url_cache{$email} . $size;
+}
+
 # Insert an avatar for the given $email at the given $size if the feature
 # is enabled.
 sub git_get_avatar {
@@ -3258,8 +3269,7 @@ sub git_get_avatar {
 	my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
 	my $url = "";
 	if ($git_gravatar_enabled) {
-		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
-			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
+		$url = gravatar_url($email, $size);
 	}
 	# Currently only gravatars are supported, but other forms such as
 	# picons can be added by putting an else up here and defining $url
-- 
1.6.3.rc1.192.gdbfcb
