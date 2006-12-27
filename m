From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/6] gitweb: Separate HTTP header output
Date: Wed, 27 Dec 2006 23:57:56 +0100
Message-ID: <200612272357.56532.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzikJ-0002Eb-Ce
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWL1ADk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWL1ADk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:55827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbWL1ADj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021262uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KbBjuU6habLT0ZhoJ3sHW20XYiipYlCVopQqLPS8sJbYi/EBaBo5WM2EelZdjqwm2EzWU1Ap28SEtjkp+2v7Jd+gZijp53PcQr626tUzDsZNC4++NP60hagNlvZ8CI83EYnv6fOKFU8YOXtsCrjPBVf5gvqavk4w3+YNQeaBH4M=
Received: by 10.66.248.5 with SMTP id v5mr19248271ugh.1167264217665;
        Wed, 27 Dec 2006 16:03:37 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.37;
        Wed, 27 Dec 2006 16:03:37 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612272355.31923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35488>

Separate output (writing) of HTTP headers into http_header subroutine,
to centralize setting HTTP header for further mod_perl specific tweaks
(to be able to run gitweb without PerlOptions +ParseHeaders, which
would speed gitweb some), and checking for HEAD request.

Always return just after HTTP header is sent when asking only about
headers (HTTP request method 'HEAD'); first appeared in git_rss.

While at it uniquify style of http_header(...) calls, formerly
"print $cgi->header(...)", and remove default HTTP status, '200 OK'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This one is fairly generic, and if considered worthy, I think
can be accepted without much ado.

Perhaps the cleanup part of it should be split into separate patch?

 gitweb/gitweb.perl |   40 +++++++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 65fcdb0..aaee217 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1678,7 +1678,17 @@ sub blob_mimetype {
 }
 
 ## ======================================================================
-## functions printing HTML: header, footer, error page
+## functions printing HTTP or HTML: header, footer, error page
+
+sub http_header {
+	my @header = @_;
+
+	print $cgi->header(@header);
+
+	# Optimization: skip generating the body if client asks only
+	# for HTTP header (e.g. cache validation).
+	return if ($cgi->request_method() eq 'HEAD');
+}
 
 sub git_header_html {
 	my $status = shift || "200 OK";
@@ -1709,8 +1719,11 @@ sub git_header_html {
 	} else {
 		$content_type = 'text/html';
 	}
-	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
-	                   -status=> $status, -expires => $expires);
+	http_header(
+		-type => $content_type,
+		-charset => 'utf-8',
+		-status => $status,
+		-expires => $expires);
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
@@ -2983,7 +2996,7 @@ sub git_forks {
 sub git_project_index {
 	my @projects = git_get_projects_list($project);
 
-	print $cgi->header(
+	http_header(
 		-type => 'text/plain',
 		-charset => 'utf-8',
 		-content_disposition => 'inline; filename="index.aux"');
@@ -3375,7 +3388,7 @@ sub git_blob_plain {
 		$save_as .= '.txt';
 	}
 
-	print $cgi->header(
+	http_header(
 		-type => "$type",
 		-expires=>$expires,
 		-content_disposition => 'inline; filename="' . "$save_as" . '"');
@@ -3591,10 +3604,9 @@ sub git_snapshot {
 
 	my $filename = basename($project) . "-$hash.tar.$suffix";
 
-	print $cgi->header(
+	http_header(
 		-type => "application/$ctype",
-		-content_disposition => 'inline; filename="' . "$filename" . '"',
-		-status => '200 OK');
+		-content_disposition => 'inline; filename="' . "$filename" . '"');
 
 	my $git = git_cmd_str();
 	my $name = $project;
@@ -3979,7 +3991,7 @@ sub git_blobdiff {
 		}
 
 	} elsif ($format eq 'plain') {
-		print $cgi->header(
+		http_header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
@@ -4128,7 +4140,7 @@ sub git_commitdiff {
 		my $tagname = git_get_rev_name_tags($hash);
 		my $filename = basename($project) . "-$hash.patch";
 
-		print $cgi->header(
+		http_header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
@@ -4465,12 +4477,12 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
 		%latest_date   = parse_date($latest_commit{'author_epoch'});
-		print $cgi->header(
+		http_header(
 			-type => $content_type,
 			-charset => 'utf-8',
 			-last_modified => $latest_date{'rfc2822'});
 	} else {
-		print $cgi->header(
+		http_header(
 			-type => $content_type,
 			-charset => 'utf-8');
 	}
@@ -4670,7 +4682,9 @@ sub git_atom {
 sub git_opml {
 	my @list = git_get_projects_list();
 
-	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
+	http_header(
+		-type => 'text/xml',
+		-charset => 'utf-8');
 	print <<XML;
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
-- 
1.4.4.3
