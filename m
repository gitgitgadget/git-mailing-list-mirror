From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (resend)] gitweb: Introduce common system-wide settings for convenience
Date: Mon, 25 Jul 2011 00:29:18 +0200
Message-ID: <1311546558-25766-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog9@kernel.org>,
	Drew Northup <drew.northup@maine.edu>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 00:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql7Er-0003Oz-0X
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab1GXW3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 18:29:35 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:44194 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1GXW3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 18:29:34 -0400
Received: by fxd18 with SMTP id 18so7995311fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=N0hFCywtUhNBZl40MV7vcLCvehJe9FVTkmrMw5p7AL0=;
        b=uccPhUE5DpnXiDXt2zaE7LC+Bs925PO8OOs0LO9DxL+TXH4dLkAgDGNfRyflf6KJop
         qxAEzKgWVvuDPL5P1E54LADQ0Mu75A7dyYtXxpH8Npk2l20le0bhK4ReHCVcdgo61Yca
         cfU0/I9Su2NjoEXpIJm9fbvvznM9C3M1rcJNA=
Received: by 10.223.54.90 with SMTP id p26mr5818723fag.44.1311546572696;
        Sun, 24 Jul 2011 15:29:32 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id f7sm2700059faa.32.2011.07.24.15.29.29
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 15:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177778>

Because of backward compatibility we cannot change gitweb to always
use /etc/gitweb.conf (i.e. even if gitweb_config.perl exists).  For
common system-wide settings we therefore need separate configuration
file: /etc/gitweb-common.conf.


Long description:

gitweb currently obtains configuration from the following sources:

  1. per-instance configuration file (default: gitweb_conf.perl)
  2. system-wide configuration file (default: /etc/gitweb.conf)

If per-instance configuration file exists, then system-wide
configuration is _not used at all_.  This is quite untypical and
suprising behavior.

Moreover it is different from way git itself treats /etc/git.conf.  It
reads in stuff from /etc/git.conf and then local repos can change or
override things as needed.  In fact this is quite beneficial, because
it gives site admins a simple and easy way to give an automatic hint
to a repo about things the admin would like.

On the other hand changing current behavior may lead to the situation,
where something in /etc/gitweb.conf may interfere with unintended
interaction in the local repository.  One solution would be to
_require_ to do explicit include; with read_config_file() it is now
easy, as described in gitweb/README (description introduced in this
commit).

But as J.H. noticed we cannot ask people to modify their per-instance
gitweb config file to include system-wide settings, nor we can require
them to do this.

Therefore, as proposed by Junio, for gitweb to have centralized config
elements while retaining backwards compatibility, introduce separate
common system-wide configuration file, by default /etc/gitweb-common.conf

Noticed-by: Drew Northup <drew.northup@maine.edu>
Helped-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Inspired-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was originally sent to git mailing list as

  [PATCH/RFC 2/2 (version C)] gitweb: Introduce common system-wide settings for convenience
  http://thread.gmane.org/gmane.comp.version-control.git/174424/focus=174517

in the following thread

  [PATCH 0/2] gitweb: Improve handling of configuration files

from 2011-05-26.  It looks like it was forgotten / fallen through
cracks.

...

There is a question how we should go from there.  A simple thing would
be to introduce GITWEB_CONFIG_FALLBACK or GITWEB_CONFIG_DEFAULT, or
GITWEB_CONFIG_TEMPLATE, or GITWEB_CONFIG_SKEL environment variable in
addition to existing GITWEB_CONFIG_SYSTEM.


Two following steps could be made in either order, but neither of them
is backwards compatibile.

One step would be to replace build time configuration variable
GITWEB_CONFIG_SYSTEM (in gitweb/Makefile) with GITWEB_CONFIG_DEFAULT
or similar, and rename $GITWEB_CONFIG_SYSTEM variable.

First change would break backward compatibility with (rare?)
gitweb/config.mak.  Second could break backward compatibility if one's
per-instance config file calls global (fallback) config file.


Other change would be to replace default value of GITWEB_CONFIG_SYSTEM
from /etc/gitweb.conf to e.g. /etc/gitweb_config.perl, or
/etc/skel/gitweb_config.perl, or /etc/gitweb-default.conf

This could be accompanied with renaming default value of
GITWEB_CONFIG_COMMON from /etc/gitweb-common.conf to /etc/gitweb.conf


 gitweb/INSTALL     |   13 ++++++++++++-
 gitweb/Makefile    |    2 ++
 gitweb/README      |   27 ++++++++++++++++++++++++---
 gitweb/gitweb.perl |   18 +++++++++++++++---
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index c5236fe..f5efe74 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -231,7 +231,7 @@ Gitweb config file
 See also "Runtime gitweb configuration" section in README file
 for gitweb (in gitweb/README).
 
-- You can configure gitweb further using the gitweb configuration file;
+- You can configure gitweb further using the per-instance gitweb configuration file;
   by default this is a file named gitweb_config.perl in the same place as
   gitweb.cgi script. You can control the default place for the config file
   using the GITWEB_CONFIG build configuration variable, and you can set it
@@ -241,6 +241,17 @@ for gitweb (in gitweb/README).
   GITWEB_CONFIG_SYSTEM build configuration variable, and override it
   through the GITWEB_CONFIG_SYSTEM environment variable.
 
+  Note that if per-instance configuration file exists, then system-wide
+  configuration is _not used at all_.  This is quite untypical and suprising
+  behavior.  On the other hand changing current behavior would break backwards
+  compatibility and can lead to unexpected changes in gitweb behavior.
+  Therefore gitweb also looks for common system-wide configuration file,
+  normally /etc/gitweb-common.conf (set during build time using build time
+  configuration variable GITWEB_CONFIG_COMMON, set it at runtime using
+  environment variable with the same name).  Settings from per-instance or
+  system-wide configuration file override those from common system-wide
+  configuration file.
+
 - The gitweb config file is a fragment of perl code. You can set variables
   using "our $variable = value"; text from "#" character until the end
   of a line is ignored. See perlsyn(1) for details.
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 5d20515..1c85b5f 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -20,6 +20,7 @@ INSTALL ?= install
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
+GITWEB_CONFIG_COMMON = /etc/gitweb-common.conf
 GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
@@ -129,6 +130,7 @@ GITWEB_REPLACE = \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
 	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
+	-e 's|++GITWEB_CONFIG_COMMON++|$(GITWEB_CONFIG_COMMON)|g' \
 	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
 	-e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	-e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
diff --git a/gitweb/README b/gitweb/README
index a4cfcb4..a998820 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -10,9 +10,30 @@ From the git version 1.4.0 gitweb is bundled with git.
 Runtime gitweb configuration
 ----------------------------
 
-You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
-(defaults to 'gitweb_config.perl' in the same directory as the CGI), and
-as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
+Gitweb obtains configuration data from the following sources in the
+following order:
+
+1. built-in values (some set during build stage),
+2. common system-wide configuration file (`GITWEB_CONFIG_COMMON`,
+   defaults to '/etc/gitweb-common.conf'),
+3. either per-instance configuration file (`GITWEB_CONFIG`, defaults to
+   'gitweb_config.perl' in the same directory as the installed gitweb),
+   or if it does not exists then system-wide configuration file
+   (`GITWEB_CONFIG_SYSTEM`, defaults to '/etc/gitweb.conf').
+
+Values obtained in later configuration files override values obtained earlier
+in above sequence.
+
+You can read defaults in system-wide GITWEB_CONFIG_SYSTEM from GITWEB_CONFIG
+by adding
+
+  read_config_file($GITWEB_CONFIG_SYSTEM);
+
+at very beginning of per-instance GITWEB_CONFIG file.  In this case
+settings in said per-instance file will override settings from
+system-wide configuration file.  Note that read_config_file checks
+itself that the $GITWEB_CONFIG_SYSTEM file exists.
+
 The most notable thing that is not configurable at compile time are the
 optional features, stored in the '%features' variable.
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dab89f2..1070805 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -665,13 +665,25 @@ sub read_config_file {
 	return;
 }
 
-our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
+our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON);
 sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
+	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "++GITWEB_CONFIG_COMMON++";
 
-	# use first config file that exists
-	read_config_file($GITWEB_CONFIG) or
+	# Protect agains duplications of file names, to not read config twice.
+	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
+	# there possibility of duplication of filename there doesn't matter.
+	$GITWEB_CONFIG = ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COMMON);
+	$GITWEB_CONFIG_SYSTEM = "" if ($GITWEB_CONFIG_SYSTEM eq $GITWEB_CONFIG_COMMON);
+
+	# Common system-wide settings for convenience.
+	# Those settings can be ovverriden by GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM.
+	read_config_file($GITWEB_CONFIG_COMMON);
+
+	# Use first config file that exists.  This means use the per-instance
+	# GITWEB_CONFIG if exists, otherwise use GITWEB_SYSTEM_CONFIG.
+	read_config_file($GITWEB_CONFIG) and return;
 	read_config_file($GITWEB_CONFIG_SYSTEM);
 }
 
-- 
1.7.5
