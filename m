From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 13/13] gitweb: Make JavaScript ability to adjust timezones configurable
Date: Thu, 28 Apr 2011 21:04:11 +0200
Message-ID: <1304017451-12283-14-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWb-0003Nk-1X
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933433Ab1D1TFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:05:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38748 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933429Ab1D1TFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:05:03 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2330897wya.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=NIDdAWiQSTVEDpBLnnGNQRGZGl/tWY3aNRvfqt+1MPQ=;
        b=V1r9yelDrq9wMJ1CFzL1yBI6bmtnTRBDmsp53/xEM2XK5rbow3MiYFEZJX+BGFGBYH
         oO1VFYTxJW1whIf02OJS/SmX4yJwsbwKXhAog93OMedltxznGj82ZhXy69DWsG7QIllZ
         TU7uIVkLoNo1DO0LID0PulyFN9mMkUhrP+t5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K9eyNvUfkBKoA5he+KJ9DFIbhaIw0tnICA4FgOzLswovKP9PxzfwPJnIZsufHWb2U6
         k08roAdMSKtCIwuYcd9Bh05uAtAgwjAVhAOwHEJ5u6t//Hs1JMNtU+wUd8W7PgjjoGcn
         UoqjBORPayxhyxfw9uESulZIb17TX26uGeTg0=
Received: by 10.227.201.8 with SMTP id ey8mr3869261wbb.200.1304017501852;
        Thu, 28 Apr 2011 12:05:01 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.05.00
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:05:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172389>

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
Helped-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from v2 version (from previous version of
series).

Original patch by J.H. had strictly speaking only $jslocaltime
(default timezone) configurable, though cookie name was stored in
global variable (set in gitweb/static/js/common-defs.js).

This patch uses standard %feature, and is a bit more configurable.

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
