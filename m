From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/4] gitweb: show notes in log
Date: Thu,  4 Feb 2010 17:18:57 +0100
Message-ID: <1265300338-25021-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 17:19:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4Qq-0007i3-7T
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241Ab0BDQTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:19:19 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33285 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab0BDQTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:19:18 -0500
Received: by mail-bw0-f219.google.com with SMTP id 19so469633bwz.28
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8L1SyprSE1OnIJ7NPHTiB+q5WAIyjxC8NTykvlmWlc0=;
        b=eqnZh7DZ34DpiLb+61wbVYXU6SPTNG+uT9VzzGGqcivTPKwO7+0PC6tZNa0sTMF28E
         gvmukjwQjN2aPhQuZ1cfQbbGRHuCPCdtGo76VuO5D4my78n68kKzD+KIwD0fMlq/nO0y
         ovqJBrOql2+yzVUY1e7Oy3fiF6tGYH09ZVY+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=we8pNKFO8cwXGxUK6KTn5wa39N/n6ls8uGbD12r0BziqDjrjoSmJrxNzrfAImNWB/u
         L4Kud6ntJZxCaZ51pKm5XEQn3vbYm+arBRFeohLKbwP55rRqG6NhYIDoFpEc6rrA8Crx
         zWdr0jPt6BmP2uwHugYaSBuSCuipzWx80IpZc=
Received: by 10.204.151.91 with SMTP id b27mr786168bkw.110.1265300357720;
        Thu, 04 Feb 2010 08:19:17 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 16sm149925bwz.3.2010.02.04.08.19.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 08:19:16 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.193.ge8618
In-Reply-To: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138973>

The notes are shown in full to the left of the log message.
---
 gitweb/gitweb.css  |   11 +++++++++++
 gitweb/gitweb.perl |   11 +++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 7d1836b..81d66d3 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -601,3 +601,14 @@ span.notes span.note-container:hover span.note {
 	z-index:10;
 	overflow:visible;
 }
+
+div.notes {
+	max-width:150px;
+	float:left;
+}
+
+div.notes div.note {
+	background-color:#ffffad;
+	border:1px solid #c9bb83;
+	padding:4px;margin:0;
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1701ed1..0d0877e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1631,6 +1631,7 @@ sub format_subject_html {
 # display notes next to a commit
 sub format_notes_html {
 	my %notes = %{$_[0]};
+	my $tag = $_[1] || 'span' ;
 	my $ret = "";
 	while (my ($ref, $text) = each %notes) {
 		# remove 'refs/notes/' and an optional final s
@@ -1639,15 +1640,15 @@ sub format_notes_html {
 
 		# double markup is needed to allow pure CSS cross-browser 'popup'
 		# of the note
-		$ret .= "<span title='$ref' class='note-container $ref'>";
-		$ret .= "<span title='$ref' class='note $ref'>";
+		$ret .= "<$tag title='$ref' class='note-container $ref'>";
+		$ret .= "<$tag title='$ref' class='note $ref'>";
 		foreach my $line (split /\n/, $text) {
 			$ret .= esc_html($line) . "<br/>";
 		}
-		$ret .= "</span></span>";
+		$ret .= "</$tag></$tag>";
 	}
 	if ($ret) {
-		return "<span class='notes'>$ret</span>";
+		return "<$tag class='notes'>$ret</$tag>";
 	} else {
 		return $ret;
 	}
@@ -4581,6 +4582,7 @@ sub git_log_body {
 		next if !%co;
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
+		my $notes = format_notes_html($co{'notes'}, 'div');
 		my %ad = parse_date($co{'author_epoch'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
@@ -4598,6 +4600,7 @@ sub git_log_body {
 		      git_print_authorship(\%co, -tag => 'span');
 		      print "<br/>\n</div>\n";
 
+		print "$notes\n";
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
 		print "</div>\n";
-- 
1.7.0.rc1.193.ge8618
