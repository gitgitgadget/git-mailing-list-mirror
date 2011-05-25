From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Refactor reading and parsing config file into read_config_file
Date: Wed, 25 May 2011 18:35:26 +0200
Message-ID: <1306341328-11108-2-git-send-email-jnareb@gmail.com>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 18:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPH3o-0002q9-Am
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563Ab1EYQfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 12:35:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab1EYQfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:35:45 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so5498279fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0di4dJoR/EsNXudFmvRHTl/GCKXX4F5RODaUVhOUTlU=;
        b=ucsSaElK20drgm8pFJXzD6SikME5Y0PUZltIKQeRv4lPtIM7tXW2NxBWpNf7brhkiY
         HAcsxWiBPOaU+f5Bv13nP1FMkRuhPuNWm3UyoA7oG5o4E0KhiWutuO9E2YIFTrg9FLLG
         CQIQY4gKhBNIBs7jtH+1KDJ1Esjyknh9tHqkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gDXfhhLxDI1IB5QEA2jgxjm+XHN9eO6MAPw/KLsl7hoN0gX8ju7eh+Rr6goCw0DT3G
         yuwWaXZOo2P2lRQF+SZSTbmhgdNCSeIwsNT9NKLtEzd3kYVukVzfQKFp5BZ2KxQmILNo
         r++T2TAGbhiN151WIX+dNGtZ/Td2U+qmnnT+U=
Received: by 10.223.73.133 with SMTP id q5mr1546789faj.127.1306341345216;
        Wed, 25 May 2011 09:35:45 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id i6sm295066faa.10.2011.05.25.09.35.43
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 09:35:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
In-Reply-To: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174422>

Beside being obvious reduction of duplicated code, this is enables us
to easily call site-wide config file in per-installation config file.

The actual update to documentation is left for next commit, because of
possible exclusive alternative (possible other next commit) of always
reading system-wide config file and relying on per-instalation config
file overriding system-wide defaults.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I think it makes code more clear, both version A xor B ;-)

 gitweb/gitweb.perl |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4ede13..ce92d67 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -635,18 +635,30 @@ sub filter_snapshot_fmts {
 # if it is true then gitweb config would be run for each request.
 our $per_request_config = 1;
 
+# read and parse gitweb config file given by its parameter.
+# returns true on success, false on recoverable error, allowing
+# to chain this subroutine, using first file that exists.
+# dies on errors during parsing config file, as it is unrecoverable.
+sub read_config_file {
+	my $filename = shift;
+	return unless defined $filename;
+	# die if there are errors parsing config file
+	if (-e $filename) {
+		do $filename;
+		die $@ if $@;
+		return 1;
+	}
+	return;
+}
+
 our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
 sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
-	# die if there are errors parsing config file
-	if (-e $GITWEB_CONFIG) {
-		do $GITWEB_CONFIG;
-		die $@ if $@;
-	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
-		do $GITWEB_CONFIG_SYSTEM;
-		die $@ if $@;
-	}
+
+	# use first config file that exists
+	read_config_file($GITWEB_CONFIG) or
+	read_config_file($GITWEB_CONFIG_SYSTEM);
 }
 
 # Get loadavg of system, to compare against $maxload.
-- 
1.7.5
