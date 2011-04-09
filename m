From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 08/11] gitweb: Unify the way long timestamp is displayed
Date: Sun, 10 Apr 2011 00:49:23 +0200
Message-ID: <1302389366-21515-9-git-send-email-jnareb@gmail.com>
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
	id 1Q8gz8-0005HA-Rv
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab1DIWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:50:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40519 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab1DIWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:50:00 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2942648fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Dll0ZnK3ZoH/YSRA2b6bhEW87Lhw5WJhvs70gEZQStM=;
        b=Yc/fCTeqWEDJhY6Q/4AfJ+ZGJdcgh0ytlMZCKza0LjYtCXCgKgFbNbM1ychVogk+z6
         e9yzc2b4dPas4+pAoSGQ0ixIxxYq0m4ODPT3Vau7d+zQ7TdvVUS5Shi8USp98yvphF2z
         89NMBoC62Ht2aLRhAdA/iHdeTAL5Lyt63q8WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gdW7QkNvsdWp3yoHBvyp/OatzsgTTylSIkVB+V0SUDKhou95tMRL0MqIWtNT+jA4nX
         96VF42IPzyE5DtAAuGQUSDKhPHsQTTsAphpLSVW0jRyNy7sR4ukOZK1Q/gaS0EvfwRqz
         JFWQ1Nkt3sw6sJ8fGjL9Q5mnCJo2wtsccH5Yc=
Received: by 10.223.27.7 with SMTP id g7mr1571529fac.62.1302389400074;
        Sat, 09 Apr 2011 15:50:00 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.49.58
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:49:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171218>

format_timestamp_html loses its "-localtime => 1" option, and now
always print the local time (in author/comitter/tagger local
timezone), with "atnight" warning if needed.

This means that both 'summary' and 'log' views now display localtime.
In the case of 'log' view this can be thought as an improvement, as
now one can easily see which commits in a series are made "atnight"
and should be examined closer.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Not really necessary, though dropping it from series would probably
require resolving trivial spurious textual conflicts.

It is marked as an RFC because I am not quite satisfied with the way
'log' view looks like after this change, though OTOH this change is an
improvement for 'log' view...

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
