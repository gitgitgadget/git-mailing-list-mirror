From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 08/11] gitweb: Unify the way long timestamp is displayed
Date: Fri, 15 Apr 2011 16:44:02 +0200
Message-ID: <1302878645-458-9-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGW-0002G9-GF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab1DOOos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab1DOOoq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:46 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3299523wwa.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=jswElSSQ3nreQlQKYP3TI2lg0bcCXos/fPjYAkl5Wn0=;
        b=MC07M4w3p+7+sMOsSx4JwIuIbgPL5KdGnGWcWPLZDnkU/Lk0TPsycTOEHv7kXyi64Y
         N8STRvm11wzvIpep652789BknyAYBMAtJldHpmwbDATwR6YRcV5cKeaMwYGrrDvqvqoE
         F+v/dwBlJGxotd5drcKrXaambuHcOAVHuQVao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s6QWLxoEjM75Qw9izYDhNnYpEjloaNK9NDvHeGrpTH4EoZT7YqEeavrpV4x1WCcyIW
         NHhk9Zq+N5y6Ep8q85IsGoFPc7LAwO9MqSzDlulZMyZvK7oKB7xo9pcgwmghUbnrEqWd
         KkaWIQgYy5jsKqsxK3gVOrMH/Bj2iikMF8m/M=
Received: by 10.227.158.2 with SMTP id d2mr2267327wbx.65.1302878685929;
        Fri, 15 Apr 2011 07:44:45 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.44
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171604>

format_timestamp_html loses its "-localtime => 1" option, and now
always print the local time (in author/comitter/tagger local
timezone), with "atnight" warning if needed.

This means that both 'summary' and 'log' views now display localtime.
In the case of 'log' view this can be thought as an improvement, as
now one can easily see which commits in a series are made "atnight"
and should be examined closer.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from v1 version.

It was marked in previous version of this series as an RFC, because I
wasn't sure about the look of gitweb after this patch... but it grew
up on me (well, I have a few doubts about new look of 'summary' page).

 gitweb/gitweb.perl |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7329db2..67bcfe8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3939,11 +3939,9 @@ sub git_print_section {
 }
 
 sub format_timestamp_html {
-	my ($date, %opts) = @_;
+	my $date = shift;
 	my $strtime = $date->{'rfc2822'};
 
-	return $strtime unless $opts{'-localtime'};
-
 	my $localtime_format = '(%02d:%02d %s)';
 	if ($date->{'hour_local'} < 6) {
 		$localtime_format = '(<span class="atnight">%02d:%02d</span> %s)';
@@ -3965,7 +3963,7 @@ sub git_print_authorship {
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
-	      " [".format_timestamp_html(\%ad, %opts)."]".
+	      " [".format_timestamp_html(\%ad)."]".
 	      git_get_avatar($co->{'author_email'}, -pad_before => 1) .
 	      "</$tag>\n";
 }
@@ -3992,7 +3990,7 @@ sub git_print_authorship_rows {
 		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td>" .
-		      format_timestamp_html(\%wd, -localtime=>1) .
+		      format_timestamp_html(\%wd) .
 		      "</td>" .
 		      "</tr>\n";
 	}
-- 
1.7.3
