From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 07/12] gitweb: remotes view for a single remote
Date: Fri, 24 Sep 2010 18:02:42 +0200
Message-ID: <1285344167-8518-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:04:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAlF-0006Mx-25
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab0IXQEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:04:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59033 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0IXQEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:04:00 -0400
Received: by wwd20 with SMTP id 20so27330wwd.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0s/RWgfqgLMyXdjxiQTfI1TSULbC5VJDjojF0C1RKSg=;
        b=NIUJP4gyo0Pb1VMZNYhvsW8fs/0D0yqEK1aRFFcK/H4RzgnnmpT9Gptp2KpESgyQFE
         JCh3rrGc+vfqt25CYmIgiY75raxN9FjMPfQx2NlRTI8cTT0VTiG6/U5qWPLZwcwh2qrC
         7Ms0QWs6KleE/zI+VOoKrpGMhi164xSt3WuWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XyiCLU5VVeeFZDi/eR/aICPR2fz2Wx27z+UudwJCIkKaH6yAP5p2ew5MQ0EUUumA3/
         JbCzmJNYmo0izB9q9zamNBhuo94xmD0kxakmeBwgjxSVt4qiOZMPKILJ1sSPr9GhEKeQ
         L5L/gLbHpilCuMwt+jjLG6xlousL/mF98f3Nk=
Received: by 10.216.23.78 with SMTP id u56mr9661982weu.56.1285344234232;
        Fri, 24 Sep 2010 09:03:54 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id p52sm1432850weq.20.2010.09.24.09.03.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157007>

If the hash parameter is passed to gitweb, remotes will interpret it as
the name of a remote and limit the view the the heads of that remote.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 76cf806..7c62701 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5547,13 +5547,28 @@ sub git_remotes {
 		or die_error(403, "Remote heads view is disabled");
 
 	my $head = git_get_head_hash($project);
-	git_header_html();
-	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
+	my $remote = $input_params{'hash'};
+
+	git_header_html(undef, undef, 'header_extra' => $remote);
+	git_print_page_nav('', '',  $head, undef, $head,
+		format_ref_views($remote ? '' : 'remotes'));
 	git_print_header_div('summary', $project);
 
-	my @remotelist = git_get_heads_list(undef, 'remotes');
-	if (@remotelist) {
-		git_heads_body(\@remotelist, $head);
+	if (defined $remote) {
+		# only display the heads in a given remote
+		my @headslist = map {
+			my $ref = $_ ;
+			$ref->{'name'} =~ s!^$remote/!!;
+			$ref
+		} git_get_heads_list(undef, "remotes/$remote");
+		if (@headslist) {
+			git_heads_body(\@headslist, $head);
+		}
+	} else {
+		my @remotelist = git_get_heads_list(undef, 'remotes');
+		if (@remotelist) {
+			git_heads_body(\@remotelist, $head);
+		}
 	}
 	git_footer_html();
 }
-- 
1.7.3.68.g6ec8
