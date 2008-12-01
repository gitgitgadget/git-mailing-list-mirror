From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix handling of non-ASCII characters in inserted HTML
	files
Date: Mon, 01 Dec 2008 19:01:42 +0100
Message-ID: <20081201175741.11133.82393.stgit@localhost.localdomain>
References: <200811171140.45884.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Tatsuki Sugiura <sugi@nemui.org>,
	Gerrit Pape <pape@smarden.org>, Recai Oktas <roktas@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 19:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7D76-0004cz-Ok
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 19:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYLASB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 13:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYLASB7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 13:01:59 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:15111 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYLASB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 13:01:58 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1685251tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=u5bQA76PSp4O7rjZKPk/KexG7O4NWVaoRSQXIUou3xc=;
        b=l4VEGst9z+RcNAT6kv90gw/4l+Q+ju2P3No3I3sOT/dYvmqpgw1GQTx78r7VMkLbp3
         HLee78ZsbKlmiNZ64+EA46y0N7qP3l5/Obg/i+/CVG0Y7VugQPPz/QEVIjKgV/4kzUVn
         2LmMFNrWZm2GimLpczIYMWwlrcUmpFRE0fZGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=gqRJCC180ghK/oSpua46srlbKM6xF4aO3ZOZWnclDA2qYwQoNIBLbPoQpc6GdP787c
         WnYchUgA4BffH3/Onow70FV27rErMF1+osr19cZnF1zN2X3EqB8KvO8NUN5yH2Wf0DzZ
         VD8uOo/wlIsCv4DaKmilrJl5UWNz9qX2rHdPs=
Received: by 10.110.33.15 with SMTP id g15mr16814128tig.32.1228154516518;
        Mon, 01 Dec 2008 10:01:56 -0800 (PST)
Received: from localhost.localdomain (abvo94.neoplus.adsl.tpnet.pl [83.8.212.94])
        by mx.google.com with ESMTPS id u8sm1889140tia.8.2008.12.01.10.01.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 10:01:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB1I1hhK011191;
	Mon, 1 Dec 2008 19:01:44 +0100
In-Reply-To: <200811171140.45884.jnareb@gmail.com>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102072>

Use new insert_file() subroutine to insert HTML chunks from external
files: $site_header, $home_text (by default indextext.html),
$site_footer, and $projectroot/$project/REAME.html.

All non-ASCII chars of those files will be broken by Perl IO layer
without decoding to utf8, so insert_file() does to_utf8() on each
printed line; alternate solution would be to open those files with
"binmode $fh, ':utf8'", or even all files with "use open qw(:std :utf8)".

Note that inserting README.html lost one of checks for simplicity.

Noticed-by: Tatsuki Sugiura <sugi@nemui.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is more complete solution that the one provided by Tatsuki Sugiura
in original patch

  [PATCH] gitweb: fix encode handling for site_{header,footer}
  Msg-Id: <87vdumbxgc.wl@vaj-k-334-sugi.local.valinux.co.jp>
  http://thread.gmane.org/gmane.comp.version-control.git/101199

but it is in principle the same solution.

I think this one as it is a bugfix should go in git 1.6.1

 gitweb/gitweb.perl |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..82262a3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2740,6 +2740,15 @@ sub get_file_owner {
 	return to_utf8($owner);
 }
 
+# assume that file exists
+sub insert_file {
+	my $filename = shift;
+
+	open my $fd, '<', $filename;
+	print map(to_utf8, <$fd>);
+	close $fd;
+}
+
 ## ......................................................................
 ## mimetype related functions
 
@@ -2928,9 +2937,7 @@ EOF
 	      "<body>\n";
 
 	if (-f $site_header) {
-		open (my $fd, $site_header);
-		print <$fd>;
-		close $fd;
+		insert_file($site_header);
 	}
 
 	print "<div class=\"page_header\">\n" .
@@ -3017,9 +3024,7 @@ sub git_footer_html {
 	print "</div>\n"; # class="page_footer"
 
 	if (-f $site_footer) {
-		open (my $fd, $site_footer);
-		print <$fd>;
-		close $fd;
+		insert_file($site_footer);
 	}
 
 	print "</body>\n" .
@@ -4358,9 +4363,7 @@ sub git_project_list {
 	git_header_html();
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
-		open (my $fd, $home_text);
-		print <$fd>;
-		close $fd;
+		insert_file($home_text);
 		print "</div>\n";
 	}
 	print $cgi->startform(-method => "get") .
@@ -4472,13 +4475,11 @@ sub git_summary {
 	print "</table>\n";
 
 	if (-s "$projectroot/$project/README.html") {
-		if (open my $fd, "$projectroot/$project/README.html") {
-			print "<div class=\"title\">readme</div>\n" .
-			      "<div class=\"readme\">\n";
-			print $_ while (<$fd>);
-			print "\n</div>\n"; # class="readme"
-			close $fd;
-		}
+		print "<div class=\"title\">readme</div>\n" .
+		      "<div class=\"readme\">\n";
+		insert_file("$projectroot/$project/README.html");
+		print "\n</div>\n"; # class="readme"
+		close $fd;
 	}
 
 	# we need to request one more than 16 (0..15) to check if
