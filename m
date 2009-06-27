From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 3/9] gitweb: use git_print_authorship_rows in 'tag' view too
Date: Sat, 27 Jun 2009 14:04:59 +0200
Message-ID: <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfh-0007Dq-JF
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZF0MFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbZF0MFT
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbZF0MFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:04 -0400
Received: by fg-out-1718.google.com with SMTP id e21so627857fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kHXLnXtx8Z0TAcTUTJailKsZwQXaVOhnEZ+QSj9Pee0=;
        b=AhrNLkM9QXR77HThQTAouf7E362olEIS4AdK4i9xDHG0VgY5RiW0TRzHtP9EPFXEoo
         N9ECP6SKycaKN7QoSbLPKoGMBpB3pNkzZnIwSEM9vzHppb+iD760COdgX/isc7VOoI3i
         7dHQawrqCfTXnhea91otXCcL6JPd5toFmfp4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AYnBLh43z1bMT47HtNADF68Y2SsWPm2PsAbsn3mqb8MoXlg5uCWyijcm3oudslewHu
         itx1Ev9YbdOheCw8T2RkjCt8VxJX7DDWGG8xccN8g5g9GqqsGqNdMfX3Zmdugq/oJyV2
         K/tMtJdCA1+Jhu6083HCJ5pA1xNS2JwWWsen0=
Received: by 10.86.30.19 with SMTP id d19mr4523803fgd.70.1246104307725;
        Sat, 27 Jun 2009 05:05:07 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id e20sm2138178fga.10.2009.06.27.05.05.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122355>

parse_tag has to be adapted to use the hash keys expected by
git_print_authorship_rows, which is not a problem since git_tag
is the only user of this sub.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0d8005d..7183ad2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2409,8 +2409,14 @@ sub parse_tag {
 			$tag{'name'} = $1;
 		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
 			$tag{'author'} = $1;
-			$tag{'epoch'} = $2;
-			$tag{'tz'} = $3;
+			$tag{'author_epoch'} = $2;
+			$tag{'author_tz'} = $3;
+			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
+				$tag{'author_name'}  = $1;
+				$tag{'author_email'} = $2;
+			} else {
+				$tag{'author_name'} = $tag{'author'};
+			}
 		} elsif ($line =~ m/--BEGIN/) {
 			push @comment, $line;
 			last;
@@ -4623,11 +4629,7 @@ sub git_tag {
 	                                      $tag{'type'}) . "</td>\n" .
 	      "</tr>\n";
 	if (defined($tag{'author'})) {
-		my %ad = parse_date($tag{'epoch'}, $tag{'tz'});
-		print "<tr><td>author</td><td>" . esc_html($tag{'author'}) . "</td></tr>\n";
-		print "<tr><td></td><td>" . $ad{'rfc2822'} .
-			sprintf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'}) .
-			"</td></tr>\n";
+		git_print_authorship_rows(\%tag, 'author');
 	}
 	print "</table>\n\n" .
 	      "</div>\n";
-- 
1.6.3.rc1.192.gdbfcb
