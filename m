From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 3/7] gitweb: use git_print_authorship_rows in 'tag' view too
Date: Tue, 30 Jun 2009 00:00:50 +0200
Message-ID: <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOv0-0005Hd-VT
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378AbZF2WA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbZF2WAz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:00:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53425 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbZF2WAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:52 -0400
Received: by fxm18 with SMTP id 18so1264489fxm.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kATcPQQmPgQMOtHi/C4/P7jBJdXkajOmVf1RKStW6UI=;
        b=tkr79Odqgd/FmAN+4Rdcv7KrC+7ZIZEp7hUBzBiDyPEUbYrL2Go21kzUMP1ILYpzAU
         ya429muL50rsy8/XOvV6qdtTbSHIUqyc+s2dAGlCzIrfYOYPG8d5YnJOzKUOKqxV7agv
         jnSSSmqU+5Iupa+7b8iwZVVT7cJfsdVBM1OI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dA+tXwfPsHDZGeC50vU/7rdxlaZ0f0T8LV3rNjroDmxI9MMrUBTPp9XbSbA7Lk1Yf6
         b7tdPK8vUlejMH4kmFfpVvojK/Qipr39/S2oISvatWvSuWQ5OvT/msrDZJ+cUzDcVTgG
         7MHEwbSuWPfBiQTrwQuT/XTrbKNKRi2mODga0=
Received: by 10.204.103.209 with SMTP id l17mr7655431bko.152.1246312854689;
        Mon, 29 Jun 2009 15:00:54 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id c28sm12356746fka.49.2009.06.29.15.00.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:00:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122471>

parse_tag must be adapted to use the hash keys expected by
git_print_authorship_rows. This is not a problem since git_tag is the
only user of this sub.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9a8d775..a393ac6 100755
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
@@ -4620,11 +4626,7 @@ sub git_tag {
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
