X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Allow PNG, GIF, JPEG images to be displayed in "blob" view
Date: Mon,  4 Dec 2006 23:47:22 +0100
Message-ID: <11652724422874-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Mon, 4 Dec 2006 22:45:38 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=H85JNdnOZdXYu0it8UXmAYKqmzoyEL3Nf9hMU+mU+qjOIR4NtHgvFFVi7RVnWnU2PsLITlbEzEnA0+w77zxp2rvmxbFlEBm9Rm+gwG19kor58PDqMsoJDElzD8fE36Ou6rBp/SFACMLbi8X+V07Es1bzJHLQQ9FdPCixeWJBXag=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33264>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrMZ0-0004Zy-P9 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 23:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759741AbWLDWpY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 17:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759764AbWLDWpY
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 17:45:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:38510 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759741AbWLDWpW (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 17:45:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3148998uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 14:45:20 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr660770ugh.1165272320204; Mon, 04
 Dec 2006 14:45:20 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 29sm28235064uga.2006.12.04.14.45.19; Mon, 04 Dec 2006 14:45:19 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kB4MlOhS026655; Mon, 4 Dec 2006 23:47:24 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kB4MlM4O026654; Mon, 4 Dec 2006 23:47:22 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Allow images in one of web formats (PNG, GIF, JPEG) - actually files
with mimetype of image/png, image/git, image/jpeg - to be displayed in
"blob" view using <img /> element, instead of using "blob_plain" view
for them, like for all other files except also text/* mimetype files.

This makes possible to easily go to file history, to HEAD version of
the file, to appropriate commit etc; all of those are not available
in "blob_plain" (raw) view.

Only text files can have "blame" view link in the formats part of
navbar.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
What other files can be embedded in the page? What other files can
be displayed line by line safely?

 gitweb/gitweb.perl |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3c1b75d..d1d22ae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3304,10 +3304,13 @@ sub git_blob {
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
-	if ($mimetype !~ m/^text\//) {
+	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)!) {
 		close $fd;
 		return git_blob_plain($mimetype);
 	}
+	# we can have blame only for text/* mimetype
+	$have_blame &&= ($mimetype =~ m!^text/!);
+
 	git_header_html(undef, $expires);
 	my $formats_nav = '';
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
@@ -3344,13 +3347,24 @@ sub git_blob {
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n";
-	my $nr;
-	while (my $line = <$fd>) {
-		chomp $line;
-		$nr++;
-		$line = untabify($line);
-		printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
-		       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
+	if ($mimetype =~ m!^text/!) {
+		my $nr;
+		while (my $line = <$fd>) {
+			chomp $line;
+			$nr++;
+			$line = untabify($line);
+			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
+			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
+		}
+	} elsif ($mimetype =~ m!^image/!) {
+		print qq!<img type="$mimetype"!;
+		if ($file_name) {
+			print qq! alt="$file_name" title="$file_name"!;
+		}
+		print qq! src="! .
+		      href(action=>"blob_plain", hash=>$hash,
+		           hash_base=>$hash_base, file_name=>$file_name) .
+		      qq!" />\n!;
 	}
 	close $fd
 		or print "Reading blob failed.\n";
-- 
1.4.4.1
