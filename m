From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 10/13] gitweb: Unify the way long timestamp is displayed
Date: Thu, 28 Apr 2011 21:04:08 +0200
Message-ID: <1304017451-12283-11-git-send-email-jnareb@gmail.com>
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
	id 1QFWWb-0003Nk-Jn
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933437Ab1D1TFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:05:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933421Ab1D1TE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:56 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=mGiPHVGCMu3JkEvbS5cob9wk+NFgCP8VVp1+jdt3C8E=;
        b=XhDpVj19Sczyzfl1w2Gb6Qq1zr9Z3gmB7UHMQFWzNuylpgRfXJ5328ckPpm3FehKPn
         OBSJQWGbkGyYhjLz5YG7pTQwgqzxBnEJkdJ0BynH3xckSZ/IRIT0lucbxDCEJb0FmG/w
         h90Y51XXWNDs//6a7QdfEIWc1V//4A3llJK4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OYJKBZhG2aU+PDNZXAiZNHSrCmryjFQjo196pFwmutSmOoOA77tKFLzTMD36NQ1+2c
         EVQk1oYzs1RsKGDyUtas3SdFKKaztxeE/N9Rou78KsQh1JJPFgPU7HBGt+SCXlJlKY7p
         VR4dV4nG5WD13xgV0nKXlLAYmHk26QdZrd4Ao=
Received: by 10.216.22.79 with SMTP id s57mr7617457wes.94.1304017495802;
        Thu, 28 Apr 2011 12:04:55 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.54
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172391>

format_timestamp_html loses its "-localtime => 1" option, and now
always print the local time (in author/comitter/tagger local
timezone), with "atnight" warning if needed.

This means that both 'summary' and 'log' views now display localtime.
In the case of 'log' view this can be thought as an improvement, as
now one can easily see which commits in a series are made "atnight"
and should be examined closer.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series.

It is not really necessary (at least not as part of this series),
though dropping it from series would probably require resolving
trivial spurious textual conflicts.  On the other hand it is natural
enhancement to previous patch, and could have been squashed with it,
if I didn't want the previous patch to be pure refactoring, without
changing gitweb output.

It was marked as an RFC in first version of this series, because I was
not quite satisfied with the way 'log' view looks like after this
change, but it grew up on me (well, I have a few doubts about new look
of 'summary' page).

This patch has of course no equivalent in original J.H. patch.

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
