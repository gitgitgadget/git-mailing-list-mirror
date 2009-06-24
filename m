From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5bis 3/3] gitweb: gravatar url cache
Date: Thu, 25 Jun 2009 01:41:24 +0200
Message-ID: <1245886884-5730-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0906241631h6ad03867i796b658abc425896@mail.gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 01:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJc5x-0006qZ-8b
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 01:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbZFXXl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZFXXl0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 19:41:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16709 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZFXXl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 19:41:26 -0400
Received: by fg-out-1718.google.com with SMTP id e21so166391fga.17
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=poyXIvB835xgzLigeYQJpasBLlxpY1qWq8vPP8mkm9o=;
        b=pih6Tv9grfYqHE1rKqWWPQcUhFg4sLETVte0fZpvdYdWLRVXWmMaZE5t34aI2uP35k
         KYrUI6fOHDedf39wL9bsuAIrETKpiIS8A35+GLYOMoJN4PQZKPyeTh8xTtSkFb/QKdFB
         TRzPJg7DHKGKOZ7bVqcoCn8DTjZoxiSHcGjlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kfHZhlaWz1m3VyHvFsfM+QkPI3XlnR39qidWRcCypkbHvGvDuVnXrcA/Us0zlzWOVD
         G6K7QXwHYIl1s02PT/QWvaYttSIqsFGhi7Y3FFzSlg3DOShueweoom5sdzeDVZe6i79X
         LBPZZ1vDMxyazqE5FTnaX6nh8MNtJhXYDLJhs=
Received: by 10.86.49.13 with SMTP id w13mr1942957fgw.31.1245886888132;
        Wed, 24 Jun 2009 16:41:28 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id l12sm1296037fgb.14.2009.06.24.16.41.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 16:41:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <cb7bb73a0906241631h6ad03867i796b658abc425896@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122169>

Views which contain many occurrences of the same email address (e.g.
shortlog view) benefit from not having to recalculate the MD5 of the
email address every time.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6e807fe..6771a9d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3249,6 +3249,27 @@ sub git_print_header_div {
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
@@ -3258,8 +3279,7 @@ sub git_get_avatar {
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
