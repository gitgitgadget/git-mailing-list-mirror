From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Thu,  4 Feb 2010 17:18:58 +0100
Message-ID: <1265300338-25021-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 17:20:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4Qr-0007i3-6u
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933249Ab0BDQTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:19:25 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:52470 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab0BDQTW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:19:22 -0500
Received: by ywh27 with SMTP id 27so2422187ywh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N24IaYkD0pu3vv39MQOg2eG2Vsqfh0zpptrZItayZy0=;
        b=HhPwimOfDG3KRyOt3BcgsjVK7L6Bc5qvJBfcWyktDrgl//D5S9DQwbQy1oPFjzNEGZ
         e92Ofx22hbafOtSIU5kK/YfZ8j8yrxO7CVGgVhIk8zNIsCYM58olOESWnIWfcPTKEgX5
         0pb4D4HSdmYz5JcvzI7Meqh0CuGw6fXWJgt7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H/Phct8D/sftnWhpdfKAuwLqmryJ0P/JUaGzTkafRPshPR/6nXY/7Notbt/XqV9HDH
         8vb4h2DtazrhBVSKg5DMiLywbpcf2PxFxMz2m7/x/CA2e9EbPIRTqiOyLh+hpJfnRkB9
         BPoEDDx47k9bJVLCC+BGZlDXEws6G3oY0590Y=
Received: by 10.102.204.2 with SMTP id b2mr801495mug.80.1265300361140;
        Thu, 04 Feb 2010 08:19:21 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id u9sm1686672muf.18.2010.02.04.08.19.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 08:19:19 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.193.ge8618
In-Reply-To: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138974>

The notes are shown side-by-side along the bottom of the commit message.
---
 gitweb/gitweb.css  |   11 +++++++++++
 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 81d66d3..10acab4 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -145,6 +145,7 @@ div.list_head {
 	border: solid #d9d8d1;
 	border-width: 1px 0px 0px;
 	font-style: italic;
+	clear: both;
 }
 
 .author_date, .author {
@@ -612,3 +613,13 @@ div.notes div.note {
 	border:1px solid #c9bb83;
 	padding:4px;margin:0;
 }
+
+
+div.page_body div.notes {
+	max-width:100%;
+	float:none;
+}
+
+div.page_body div.notes div.note {
+	float:left;
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0d0877e..0d03026 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2837,12 +2837,31 @@ sub parse_commit {
 	%co = parse_commit_text(<$fd>, 1);
 	close $fd;
 
+	my %notes = ();
+	foreach my $note_ref (get_note_refs()) {
+		my $obj = "$note_ref:$co{'id'}";
+		if (open my $fd, '-|', git_cmd(), 'rev-parse',
+			'--verify', '-q', $obj) {
+			my $exists = <$fd>;
+			close $fd;
+			if (defined $exists) {
+				if (open $fd, '-|', git_cmd(), 'show', $obj) {
+					$notes{$note_ref} = scalar <$fd>;
+					close $fd;
+				}
+			}
+		}
+	}
+	$co{'notes'} = \%notes;
+
 	return %co;
 }
 
 # return all refs matching refs/notes/<globspecs> where the globspecs
 # are taken from the notes feature content.
 sub get_note_refs {
+	local $/ = "";
+
 	my @globs = gitweb_get_feature('notes');
 	my @note_refs = ();
 	foreach my $glob (@globs) {
@@ -5875,6 +5894,7 @@ sub git_commit {
 
 	print "<div class=\"page_body\">\n";
 	git_print_log($co{'comment'});
+	print format_notes_html($co{'notes'}, 'div');
 	print "</div>\n";
 
 	git_difftree_body(\@difftree, $hash, @$parents);
@@ -6230,6 +6250,7 @@ sub git_commitdiff {
 			git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
 			print "</div>\n"; # class="log"
 		}
+		print format_notes_html($co{'notes'}, 'div');
 
 	} elsif ($format eq 'plain') {
 		my $refs = git_get_references("tags");
-- 
1.7.0.rc1.193.ge8618
