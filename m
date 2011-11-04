From: Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: [PATCHv2] Add options to specify snapshot file name, prefix
Date: Thu,  3 Nov 2011 20:53:19 -0400
Message-ID: <1320367999-24435-1-git-send-email-dermoth@aei.ca>
References: <1320302318-28315-1-git-send-email-dermoth@aei.ca>
Cc: Thomas Guyot-Sionnest <dermoth@aei.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 01:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM82H-0006ok-Bx
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 01:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab1KDAx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 20:53:28 -0400
Received: from mail001.aei.ca ([206.123.6.130]:38171 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1KDAx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 20:53:28 -0400
Received: (qmail 31178 invoked by uid 89); 4 Nov 2011 00:53:27 -0000
Received: by simscan 1.2.0 ppid: 31175, pid: 31176, t: 0.0021s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 4 Nov 2011 00:53:27 -0000
Received: (qmail 17291 invoked by uid 89); 4 Nov 2011 00:53:27 -0000
Received: by simscan 1.2.0 ppid: 17274, pid: 17275, t: 0.6325s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.1/m: spam: 3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from ppp-55-39.mtl.contact.net (HELO localhost) (216.221.55.39)
  by mail.aei.ca with SMTP; 4 Nov 2011 00:53:26 -0000
Received: by localhost (Postfix, from userid 1000)
	id 5A3862D411A; Thu,  3 Nov 2011 20:53:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320302318-28315-1-git-send-email-dermoth@aei.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184754>

commit b629275 implemented "smart" snapshot names and prefixes. I have
scripts that used to rely on the old behaviour which allowed in some
cases to have fixed prefix, and would require modifications to work with
newer Gitweb.

This patch adds two parameters for overriding the snapshot name and
prefix, sn and sp respectively. For example, to get a snapshot
named "myproject.[suffix]" with no prefix one can add this query string:
  ?sn=myproject;sp=

Signed-off-by: Thomas Guyot-Sionnest <dermoth@aei.ca>
---
 gitweb/gitweb.perl |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..9c91f01 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -756,6 +756,8 @@ our @cgi_param_mapping = (
 	searchtext => "s",
 	searchtype => "st",
 	snapshot_format => "sf",
+	snapshot_name => "sn",
+	snapshot_prefix => "sp",
 	extra_options => "opt",
 	search_use_regexp => "sr",
 	ctag => "by_tag",
@@ -6684,11 +6686,19 @@ sub git_snapshot {
 	}
 
 	my ($name, $prefix) = snapshot_name($project, $hash);
+	if (defined($input_params{'snapshot_name'})) {
+		$name = $input_params{'snapshot_name'};
+	}
+	if (defined($input_params{'snapshot_prefix'})) {
+		$prefix = $input_params{'snapshot_prefix'};
+	} else {
+		$prefix .= '/';
+	}
 	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
 	my $cmd = quote_command(
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
-		"--prefix=$prefix/", $hash);
+		"--prefix=$prefix", $hash);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
-- 
1.7.7.1
