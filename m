From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC 11/11] gitweb: Make JavaScript ability to adjust timezones configurable
Date: Fri, 15 Apr 2011 16:44:05 +0200
Message-ID: <1302878645-458-12-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGy-0002aV-Hp
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab1DOOo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43845 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab1DOOoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:54 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2304119wya.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=k+fdlWqq8fXUmgEP9DGtUWIBgUoPiW7itHyzC+3UBX4=;
        b=Rnm3Wzbhtr+kU4XaySQah+V4hEVlZt2sdTOQx30Jsi3Jl2iExaCf/1WKp4vyrpbRg2
         dHrAr0z5o6TeCVIPpTe/8q1Mh4Rv8fL5Ylqly5RuntGjc9POsXtpKWXNtk7eght4N3C4
         6Su2yOrU6B6vUHdb4wWvZG5cQoK96n0RhoUgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HMqjaVoz4umkYVQJr4i/MFQBt+ierU6r88Tvl86dOun5oTHtkM6iyq2TijgL+apCUt
         rli+h/7x9Odqc2Gn1c1aEjFyNYAG7fnO5lBiGGapR+2f1jKpKYaU7iBYe222SBJp8C3J
         Lo5K5OqY6+StGm+vWSjJbfz8jjoJ/cXdl7Eug=
Received: by 10.227.104.2 with SMTP id m2mr2148253wbo.35.1302878693921;
        Fri, 15 Apr 2011 07:44:53 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.51
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171609>

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
Bugs-reported-by: Kevin Cernekee <cernekee@gmail.com>

Changes from v1:
* Fixed bug in format_timestamp_html using "datetime" instead
  of $datetime_class.

 gitweb/gitweb.perl |   39 +++++++++++++++++++++++++++++++--------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b1e80ef..ac335b6 100755
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
@@ -3733,14 +3745,19 @@ sub git_footer_html {
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
-		      qq!	var tz_cookie = { name: 'gitweb_tz', expires: 14, path: '/' };\n!. # in days
-		      qq!	onloadTZSetup('local', tz_cookie, 'datetime');\n!.
-		      qq!};\n!.
+		      qq!window.onload = function () {\n!;
+		if (gitweb_check_feature('javascript-actions')) {
+			print qq!	fixLinks();\n!;
+		}
+		if ($jstimezone && $tz_cookie && $datetime_class) {
+			print qq!	var tz_cookie = { name: '$tz_cookie', expires: 14, path: '/' };\n!. # in days
+			      qq!	onloadTZSetup('$jstimezone', tz_cookie, '$datetime_class');\n!;
+		}
+		print qq!};\n!.
 		      qq!</script>\n!;
 	}
 
@@ -3946,7 +3963,13 @@ sub git_print_section {
 
 sub format_timestamp_html {
 	my $date = shift;
-	my $strtime = '<span class="datetime">'.$date->{'rfc2822'}.'</span>';
+	my $strtime = $date->{'rfc2822'};
+
+	my (undef, undef, $datetime_class) =
+		gitweb_get_feature('javascript-timezone');
+	if ($datetime_class) {
+		$strtime = qq!<span class="$datetime_class">$strtime</span>!;
+	}
 
 	my $localtime_format = '(%02d:%02d %s)';
 	if ($date->{'hour_local'} < 6) {
-- 
1.7.3
