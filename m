From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Include links to feeds in HTML header only for '200
	OK' response
Date: Sat, 18 Dec 2010 21:02:13 +0100
Message-ID: <20101218195848.16201.67691.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 21:03:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU2zc-0004Zw-8c
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab0LRUCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:02:55 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:44464 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab0LRUCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:02:54 -0500
Received: by fxm18 with SMTP id 18so1822827fxm.2
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 12:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hn/9oiOMTuAipTo0R1/0B8cjOzak5vc58ExLFnny0EE=;
        b=G1UbxVlEl49JE5bZo3c4zDPWKmaBFnvLKgPXSkyifjo5NO5O0D8POjkqT2BCjmiblb
         8/jQuvD+BYB35mmjhNzKILocuTK2bKgaF4qJ5u9zkUT929c5SLESaCcmROvBk6VL+KKL
         M02uv8mKuFz6AZKmoRynfwvuoCCPTfoYwN9aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=gv0zTDQGn7IpLHMpaB3ODai/0XvCzvPID4/DSqUG69pOCA02ZVYP1YHkGMG0iE8wX4
         Rr5dIwQDsDwcAmZSghjOpmoG6Qum1thQv1fT4EGQ5ojBDq5Kn6214TopqtH1huoW95aA
         zLzriny21/VAjPQg3SCyOylrWyWueDa4IwOWI=
Received: by 10.223.70.136 with SMTP id d8mr2815143faj.3.1292702572770;
        Sat, 18 Dec 2010 12:02:52 -0800 (PST)
Received: from localhost.localdomain (abrz118.neoplus.adsl.tpnet.pl [83.8.119.118])
        by mx.google.com with ESMTPS id y14sm446235fak.42.2010.12.18.12.02.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 12:02:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBIK2DMT016273;
	Sat, 18 Dec 2010 21:02:20 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163926>

To do that, generating "<link />"s to feeds were refactored into
print_feed_meta() subroutine, to keep nesting (indent) level in
git_header_html() low.  This has also the advantage of making code
more clear.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   89 +++++++++++++++++++++++++++-------------------------
 1 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d521c93..d965cda 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3479,6 +3479,51 @@ sub get_page_title {
 	return $title;
 }
 
+sub print_feed_meta {
+	if (defined $project) {
+		my %href_params = get_feed_info();
+		if (!exists $href_params{'-title'}) {
+			$href_params{'-title'} = 'log';
+		}
+
+		foreach my $format qw(RSS Atom) {
+			my $type = lc($format);
+			my %link_attr = (
+				'-rel' => 'alternate',
+				'-title' => esc_attr("$project - $href_params{'-title'} - $format feed"),
+				'-type' => "application/$type+xml"
+			);
+
+			$href_params{'action'} = $type;
+			$link_attr{'-href'} = href(%href_params);
+			print "<link ".
+			      "rel=\"$link_attr{'-rel'}\" ".
+			      "title=\"$link_attr{'-title'}\" ".
+			      "href=\"$link_attr{'-href'}\" ".
+			      "type=\"$link_attr{'-type'}\" ".
+			      "/>\n";
+
+			$href_params{'extra_options'} = '--no-merges';
+			$link_attr{'-href'} = href(%href_params);
+			$link_attr{'-title'} .= ' (no merges)';
+			print "<link ".
+			      "rel=\"$link_attr{'-rel'}\" ".
+			      "title=\"$link_attr{'-title'}\" ".
+			      "href=\"$link_attr{'-href'}\" ".
+			      "type=\"$link_attr{'-type'}\" ".
+			      "/>\n";
+		}
+
+	} else {
+		printf('<link rel="alternate" title="%s projects list" '.
+		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
+		       esc_attr($site_name), href(project=>undef, action=>"project_index"));
+		printf('<link rel="alternate" title="%s projects feeds" '.
+		       'href="%s" type="text/x-opml" />'."\n",
+		       esc_attr($site_name), href(project=>undef, action=>"opml"));
+	}
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
@@ -3528,48 +3573,8 @@ EOF
 			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
 		}
 	}
-	if (defined $project) {
-		my %href_params = get_feed_info();
-		if (!exists $href_params{'-title'}) {
-			$href_params{'-title'} = 'log';
-		}
-
-		foreach my $format qw(RSS Atom) {
-			my $type = lc($format);
-			my %link_attr = (
-				'-rel' => 'alternate',
-				'-title' => esc_attr("$project - $href_params{'-title'} - $format feed"),
-				'-type' => "application/$type+xml"
-			);
-
-			$href_params{'action'} = $type;
-			$link_attr{'-href'} = href(%href_params);
-			print "<link ".
-			      "rel=\"$link_attr{'-rel'}\" ".
-			      "title=\"$link_attr{'-title'}\" ".
-			      "href=\"$link_attr{'-href'}\" ".
-			      "type=\"$link_attr{'-type'}\" ".
-			      "/>\n";
-
-			$href_params{'extra_options'} = '--no-merges';
-			$link_attr{'-href'} = href(%href_params);
-			$link_attr{'-title'} .= ' (no merges)';
-			print "<link ".
-			      "rel=\"$link_attr{'-rel'}\" ".
-			      "title=\"$link_attr{'-title'}\" ".
-			      "href=\"$link_attr{'-href'}\" ".
-			      "type=\"$link_attr{'-type'}\" ".
-			      "/>\n";
-		}
-
-	} else {
-		printf('<link rel="alternate" title="%s projects list" '.
-		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
-		       esc_attr($site_name), href(project=>undef, action=>"project_index"));
-		printf('<link rel="alternate" title="%s projects feeds" '.
-		       'href="%s" type="text/x-opml" />'."\n",
-		       esc_attr($site_name), href(project=>undef, action=>"opml"));
-	}
+	print_feed_meta()
+		if ($status eq '200 OK');
 	if (defined $favicon) {
 		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
 	}
