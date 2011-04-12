From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 11/11] gitweb: Make JavaScript ability to adjust timezones configurable
Date: Tue, 12 Apr 2011 15:25:37 +0200
Message-ID: <201104121525.37663.jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com> <BANLkTik9D6++P1rg+VbvKj9oTFhRYNmrpQ@mail.gmail.com> <201104121444.20633.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:26:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9dbu-0004fl-Sa
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 15:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab1DLN0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 09:26:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42196 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1DLN0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 09:26:08 -0400
Received: by bwz15 with SMTP id 15so5357427bwz.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=k+fdlWqq8fXUmgEP9DGtUWIBgUoPiW7itHyzC+3UBX4=;
        b=MCDxK6rrOzNmyfdDM1bb1+HPGKFPYz9vvDUfN+GrvRM/l+sI11tkhBk0xwBWwCUUlP
         35vcJN4UKspf8knsKxC77GFuCVmOCiSpebRjapizd3XthBbC730UqGiaRRBZ9XnGK0pr
         3Z4PIr9hOo7O0/wBzVNBuGfWeWikma44Sqa8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H4uvv24DXq7ZSCaXWEFp9wsUt1HJrL3PkTw61pTXV0wQGBbwlvc4pNX8nW5ehQ03qr
         NzM+Nb0T1ePBBxROid4AO0saDY15NBGCf5dKjFg5qSk2xKharkfe/3xnP4JCvyRnwbyL
         03ieMTdX7UBv13Q0OMWjXYIKafZCM6vAP0Y2Q=
Received: by 10.204.127.88 with SMTP id f24mr186781bks.54.1302614766876;
        Tue, 12 Apr 2011 06:26:06 -0700 (PDT)
Received: from [192.168.1.13] (abvr44.neoplus.adsl.tpnet.pl [83.8.215.44])
        by mx.google.com with ESMTPS id v21sm3859967bkt.23.2011.04.12.06.26.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2011 06:26:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201104121444.20633.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171391>

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
