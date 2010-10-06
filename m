From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5/RFC 17/17] gitweb: Add startup delay to activity indicator for cache
Date: Thu,  7 Oct 2010 00:02:02 +0200
Message-ID: <1286402526-13143-18-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5r-0002Gb-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255Ab0JFWDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231Ab0JFWDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:05 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49472bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U0qUbR4OA3eRJB8uSnDqDlnRppqZunbCA7Z/oPnmvBs=;
        b=U/Mq4VhqnQhYwmaU6BDZfQnYaYY5UtO0EAPzQv3OB+suP1vIGTwdCox2+d9essqHLZ
         KyKfWFAuh6QJT5PG7XYhokFw9qxSyG4nCS0RzqYIcLzUyEfIoiRo0dEI7BGcOzFLw5Ny
         PX0js2CVMbB689WeSzS9Durqu212Qx+REQtJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nV31PQDt7Z89fZs6/JmBMHlwrFZOMU34KNT1AOhw0Dgk+1V8JBCCUI9TFQyx5WOug2
         M8RCWiPkjsq7sRCqPC6JAwlh3wIzEGVP2agpH0dMfyF5p4YoRGrvez3tWxDiypUS1cG0
         k95nkSWEmA5cQvP8dSLFAnCdR8fI099kRgkgk=
Received: by 10.204.66.79 with SMTP id m15mr10368757bki.82.1286402584982;
        Wed, 06 Oct 2010 15:03:04 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.03.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:03:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158327>

This adds support for [optional] startup delay to git_generating_data_html()
subroutine, which is used to provide "Generating..." page as activity
indicator when waiting for page to be generated if caching.  If the data
(page contents) gets generated within $generating_options{'staryp_delay'}
seconds, the "Generating..." page won't get displayed.

This feature was created in response to complaint by Petr 'Pasky' Baudis'
about "Generating..." feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No changes since v4 (previous version).

This patch doesn't have equivalent in J.H. patch, and is rather
extension of idea of progress indicator for (re)generating [cache]
data.  It was inspired by comment by Petr 'Pasky' Baudis on #git IRC
channel that one doesn't want to have "Generating..." page to be shown
only to immediately vanish.

 gitweb/gitweb.perl |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 07fa825..fee8739 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -354,6 +354,9 @@ our %cache_options = (
 # (which means that $cache_options{'generating_info'} is set to coderef);
 # override them with $GITWEB_CONFIG as necessary.
 our %generating_options = (
+	# The delay before displaying "Generating..." page, in seconds.  It is
+	# intended for "Generating..." page to be shown only when really needed.
+	'startup_delay' => 1,
 	# The time between generating new piece of output to prevent from
 	# redirection before data is ready, i.e. time between printing each
 	# dot in activity indicator / progress info, in seconds.
@@ -3570,6 +3573,23 @@ sub git_generating_data_html {
 		return;
 	}
 
+	# Initial delay
+	if ($generating_options{'startup_delay'} > 0) {
+		eval {
+			local $SIG{ALRM} = sub { die "alarm clock restart\n" }; # NB: \n required
+			alarm $generating_options{'startup_delay'};
+			flock($lock_fh, LOCK_SH); # blocking readers lock
+			alarm 0;
+		};
+		if ($@) {
+			# propagate unexpected errors
+			die $@ if $@ !~ /alarm clock restart/;
+		} else {
+			# we got response within 'startup_delay' timeout
+			return;
+		}
+	}
+
 	my $title = "[Generating...] " . get_page_title();
 	# TODO: the following line of code duplicates the one
 	# in git_header_html, and it should probably be refactored.
-- 
1.7.3
