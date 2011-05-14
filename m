From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG does exist
Date: Sat, 14 May 2011 21:37:15 +0200
Message-ID: <201105142137.16541.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 21:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLKec-00070M-6K
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 21:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab1ENTha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 15:37:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42819 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1ENTh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 15:37:29 -0400
Received: by fxm17 with SMTP id 17so2351416fxm.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=wXsHSZVSEJFEYGl0jZ+aX/otxNJJqfmsQcRxRDo2CW4=;
        b=VNvTa8v2fracQD+MNmYFgPZ7Hhghv9ik/k3BLO6CcE+5jEbdFNogOhTDzrJYUXVwel
         n7FEv6+PIdAfda765Nqnf5/xCyN7VKJsg55CduvEjhyeOiKi+F7EOa7iEnSthJ0S4vA+
         6zY8pjMblk+oqPMnaK9StzvOXMIi1VMEYd4Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=SSUvnM3WPGhfxNBksnCUsHo50jJE7YaJNTpvxCsBd0p2gBMy9xQ9gC65GF5EHmckx7
         yhpdyJ1Y9c4nK4h5a0QfORQkefS9WGeivg+GB4j83sljtAJDHzsZtF6yYiG7vY/i6zFd
         7l4ivZZOTSlMzOfhCXtmyK2fUy0XBEIyJLqyY=
Received: by 10.223.159.134 with SMTP id j6mr1492950fax.74.1305401846167;
        Sat, 14 May 2011 12:37:26 -0700 (PDT)
Received: from [192.168.1.13] (abvm169.neoplus.adsl.tpnet.pl [83.8.210.169])
        by mx.google.com with ESMTPS id c22sm1257091fat.14.2011.05.14.12.37.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 May 2011 12:37:24 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173603>

gitweb obtains configuration from the following sources:

  1. per-instance configuration file (default: gitweb_conf.perl)
  2. system-wide configuration file (default: /etc/gitweb.conf)

If per-instance configuration file exists, then system-wide
configuration was _not used at all_.  This is quite untypical and
suprising behavior.

This commit changes gitweb behavior so that configuration in
per-instance configuration file can _override_ settings from
system-wide configuration file.

Suggested-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is the response to discussion in the

  [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
  http://thread.gmane.org/gmane.comp.version-control.git/173422

The patch to gitweb.perl itself (without the commit message) was send
as part of 

  http://thread.gmane.org/gmane.comp.version-control.git/173422/focus=173489

(embedded in body of email).

Note that changes to gitweb/README and gitweb/INSTALL were
minimalized, so the final result might not be the best... but I think
it is good enough.

 gitweb/INSTALL     |    8 +++++---
 gitweb/README      |    2 +-
 gitweb/gitweb.perl |    7 ++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 4964a67..0584919 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -98,15 +98,17 @@ Gitweb config file
 See also "Runtime gitweb configuration" section in README file
 for gitweb (in gitweb/README).
 
-- You can configure gitweb further using the gitweb configuration file;
+- You can configure gitweb further using the per-instance gitweb configuration file;
   by default this is a file named gitweb_config.perl in the same place as
   gitweb.cgi script. You can control the default place for the config file
   using the GITWEB_CONFIG build configuration variable, and you can set it
-  using the GITWEB_CONFIG environment variable. If this file does not
-  exist, gitweb looks for a system-wide configuration file, normally
+  using the GITWEB_CONFIG environment variable.
+  gitweb also looks for a system-wide configuration file, normally
   /etc/gitweb.conf. You can change the default using the
   GITWEB_CONFIG_SYSTEM build configuration variable, and override it
   through the GITWEB_CONFIG_SYSTEM environment variable.
+  Settings from per-instance configuration file override those from
+  system-wide configuration file.
 
 - The gitweb config file is a fragment of perl code. You can set variables
   using "our $variable = value"; text from "#" character until the end
diff --git a/gitweb/README b/gitweb/README
index a92bde7..334f13e 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -126,7 +126,7 @@ Runtime gitweb configuration
 
 You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
 (defaults to 'gitweb_config.perl' in the same directory as the CGI), and
-as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
+`GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf), in that order.
 The most notable thing that is not configurable at compile time are the
 optional features, stored in the '%features' variable.
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index acdc5b8..9527cd2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -637,12 +637,13 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	# die if there are errors parsing config file
+	if (-e $GITWEB_CONFIG_SYSTEM) {
+		do $GITWEB_CONFIG_SYSTEM;
+		die $@ if $@;
+	}
 	if (-e $GITWEB_CONFIG) {
 		do $GITWEB_CONFIG;
 		die $@ if $@;
-	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
-		do $GITWEB_CONFIG_SYSTEM;
-		die $@ if $@;
 	}
 }
 
-- 
1.7.5
