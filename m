From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 11/11] gitweb: Make JavaScript ability to adjust timezones configurable
Date: Sun, 10 Apr 2011 00:49:26 +0200
Message-ID: <1302389366-21515-12-git-send-email-jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gzA-0005HA-4V
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab1DIWuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:50:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60231 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1DIWuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:50:06 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2942671fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=YtfKLQFuMUp3x7x9wDDjAOtuhwBiotXBjfISA1DwiOE=;
        b=DokLimIlVfwKg64pmCM5kK6hAbnWOqrsFjqZE7xokgUMIU0mQBPuAbt9x88QIGkDzo
         WbRPSPS0fwKDajUNylLYI+PT6rU1CXzxdJpN/pVqmXolXBdClGdM4Y2zy0J4Ub5MB9GM
         jyf33zQFQmWJNXfQolhriyuoja/tUAGGCaG08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MKTMaZoDJjx1qy/VA9AvUgMbnxA/VxJU8c0zj1BN/DATHXmYMsmI0f8sP2BgMvJzYm
         gkkknxYP96j1rhqkulvGsE9cxzZWPZuNaGXZ1qGWTtqeHBiUNcmmWgMEktlSpoIMgspP
         /cVHtrL6hscCckhvZbk8dVpHjl52dIxUaxvVs=
Received: by 10.223.58.80 with SMTP id f16mr795134fah.148.1302389406031;
        Sat, 09 Apr 2011 15:50:06 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.50.04
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:50:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171219>

Configure JavaScript-based ability to select common timezone for git
dates via %feature mechanism, namely 'javascript-timezone' feature.

The following settings are configurable:
* default timezone (defaults to 'local' i.e. browser timezone);
  this also can function as a way to disable this ability,
  by setting it to false-ish value (undef or '')
* name of cookie to store user's choice of timezone
* class name to mark dates


NOTE: This is a bit of abuse of %feature system, which can store only
sequence of values, rather than dictionary (hash); usually but not
always only a single value is used.

Based-on-code-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Original patch by J.H. had strictly speaking only $jslocaltime
(default timezone) configurable, though cookie name was stored in
global variable (set in gitweb/static/js/common-defs.js).

But do we really need full flexibility...?

 gitweb/gitweb.perl |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6651946..b80f2e0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -480,6 +480,18 @@ our %feature = (
 		'override' => 0,
 		'default' => [0]},
 
+	# Enable and configure ability to change common timezone for dates
+	# in gitweb output via JavaScript.  Enabled by default.
+	# Project specific override is not supported.
+	'javascript-timezone' => {
+		'override' => 0,
+		'default' => [
+			'local',     # default timezone: 'utc', 'local', or '(-|+)HHMM' format,
+			             # or undef to turn off this feature
+			'gitweb_tz', # name of cookie where to store selected timezone
+			'datetime',  # CSS class used to mark up dates for manipulation
+		]},
+
 	# Syntax highlighting support. This is based on Daniel Svensson's
 	# and Sham Chukoury's work in gitweb-xmms2.git.
 	# It requires the 'highlight' program present in $PATH,
@@ -3733,13 +3745,18 @@ sub git_footer_html {
 		      qq!           "!. href() .qq!");\n!.
 		      qq!</script>\n!;
 	} else {
+		my ($jstimezone, $tz_cookie, $datetime_class) =
+			gitweb_get_feature('javascript-timezone');
+
 		print qq!<script type="text/javascript">\n!.
-		      qq!window.onload = function () {\n!.
-		      (gitweb_check_feature('javascript-actions') ?
-		      qq!	fixLinks();\n! : '').
-		      # last parameter to onloadTZSetup must be CSS class used by format_timestamp_html
-		      qq!	onloadTZSetup('local', 'gitweb_tz', 'datetime');\n!.
-		      qq!};\n!.
+		      qq!window.onload = function () {\n!;
+		if (gitweb_check_feature('javascript-actions')) {
+			print qq!	fixLinks();\n!;
+		}
+		if ($jstimezone && $tz_cookie && $datetime_class) {
+			print qq!	onloadTZSetup('$jstimezone', '$tz_cookie', '$datetime_class');\n!;
+		}
+		print qq!};\n!.
 		      qq!</script>\n!;
 	}
 
@@ -3945,7 +3962,13 @@ sub git_print_section {
 
 sub format_timestamp_html {
 	my $date = shift;
-	my $strtime = '<span class="datetime">'.$date->{'rfc2822'}.'</span>';
+	my $strtime = $date->{'rfc2822'};
+
+	my (undef, undef, $datetime_class) =
+		gitweb_get_feature('javascript-timezone');
+	if ($datetime_class) {
+		$strtime = qq!<span class="datetime">$strtime</span>!;
+	}
 
 	my $localtime_format = '(%02d:%02d %s)';
 	if ($date->{'hour_local'} < 6) {
-- 
1.7.3
