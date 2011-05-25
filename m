From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 2/2 (version B)] gitweb: Use /etc/gitweb.conf even if gitweb_conf.perl exist
Date: Wed, 25 May 2011 18:35:28 +0200
Message-ID: <1306341328-11108-4-git-send-email-jnareb@gmail.com>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 18:36:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPH47-00035v-SV
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab1EYQfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 12:35:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab1EYQft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:35:49 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so5498279fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=J3UXS8DeCY+rE71841eF6ytYsTlp82K9DIjrhuZuOks=;
        b=oh6L+fO8ueGNEai+d59Ihmkk2CKIvGu4sZKI/7arKPPPkS8/Setvw+vbyMtyEv2gLC
         k24vvRO6EvSBXT6YK0JgeFPwWrWZ3Q57diFj6MlHbDYVKEzeUsfvk9EaHvCDCxSY+knH
         neeeA54zCP81z5vCd1d8zxKriUNTI2OdCmco4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RmOiXxMeK6BtTazvDUsDY/tcMdw9W441wZvkdMeFFwnp73vod8VpPyJVb8VZFRPsh1
         UFzMJP1pGkA1J+JFN/9aMh088nEwe1ysWTWKoNQof3TEABg7bwWOFFWkRiAiI1Bha3PW
         A7JjCnHNzXq93tWFhbMwVLBrtKw2J9RHiwykA=
Received: by 10.223.164.130 with SMTP id e2mr5162723fay.148.1306341348810;
        Wed, 25 May 2011 09:35:48 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id i6sm295066faa.10.2011.05.25.09.35.47
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 09:35:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
In-Reply-To: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174425>

gitweb obtains configuration from the following sources:

  1. per-instance configuration file (default: gitweb_conf.perl)
  2. system-wide configuration file (default: /etc/gitweb.conf)

If per-instance configuration file exists, then system-wide
configuration is _not used at all_.  This is quite untypical and
suprising behavior.

This commit changes gitweb behavior so that configuration in
per-instance configuration file can _override_ settings from
system-wide configuration file.

Note that strictly speaking it is backwards incompatibile change.
Check your resulting gitweb configuration, please.

Suggested-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This commit is _*functionally*_ unchanged from previous version

  [PATCHv2] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG does exist
  http://thread.gmane.org/gmane.comp.version-control.git/173603/focus=173720

but it uses read_config_file() subroutine introduced in first patch.
This IMVHO makes gitweb code more clear.


This commit should be thought as exclusive to

  [PATCH 2/2 (version A)] gitweb: Mention read_config_file in gitweb/README

We have to choose one or the other.


 gitweb/INSTALL     |    8 +++++---
 gitweb/README      |    2 +-
 gitweb/gitweb.perl |    5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

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
index ce92d67..e4b0932 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -656,9 +656,10 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 
-	# use first config file that exists
-	read_config_file($GITWEB_CONFIG) or
+	# let settings in second override ones in first
 	read_config_file($GITWEB_CONFIG_SYSTEM);
+	read_config_file($GITWEB_CONFIG)
+		if ($GITWEB_CONFIG ne $GITWEB_CONFIG_SYSTEM);
 }
 
 # Get loadavg of system, to compare against $maxload.
-- 
1.7.5
