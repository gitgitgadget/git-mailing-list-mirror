Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A781AC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 04:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CF52074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 04:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgG3EgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:36:25 -0400
Received: from aibo.runbox.com ([91.220.196.211]:42938 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgG3EgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 00:36:25 -0400
X-Greylist: delayed 1416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2020 00:36:23 EDT
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1k0zvx-00023y-Gu
        for git@vger.kernel.org; Thu, 30 Jul 2020 06:12:45 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k0zvt-00045b-JL; Thu, 30 Jul 2020 06:12:44 +0200
From:   Emma Brooks <me@pluvano.com>
To:     git@vger.kernel.org
Cc:     Emma Brooks <me@pluvano.com>
Subject: [RFC PATCH] gitweb: Map names/emails with mailmap
Date:   Thu, 30 Jul 2020 04:12:17 +0000
Message-Id: <20200730041217.6893-1-me@pluvano.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to map names and emails to their canonical forms via a
.mailmap file. This is enabled by default, consistent with the behavior
of Git itself.

Signed-off-by: Emma Brooks <me@pluvano.com>
---

This works, but needs some polish. The read_mailmap code is not
particularly clever.

 Documentation/gitweb.conf.txt |  5 +++
 gitweb/gitweb.perl            | 79 +++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7963a79ba9..2d7551a6a5 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -751,6 +751,11 @@ default font sizes or lineheights are changed (e.g. via adding extra
 CSS stylesheet in `@stylesheets`), it may be appropriate to change
 these values.
 
+mailmap::
+	Use mailmap to find the canonical name/email for
+	committers/authors (see linkgit:git-shortlog[1]). Enabled by
+	default.
+
 highlight::
 	Server-side syntax highlight support in "blob" view.  It requires
 	`$highlight_bin` program to be available (see the description of
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a782ec..00256704a7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -505,6 +505,12 @@ sub evaluate_uri {
 		'override' => 0,
 		'default' => ['']},
 
+	# Enable reading mailmap to determine canonical author
+	# information. Enabled by default.
+	'mailmap' => {
+		'override' => 0,
+		'default' => [1]},
+
 	# Enable displaying how much time and how many git commands
 	# it took to generate and display page.  Disabled by default.
 	# Project specific override is not supported.
@@ -3490,6 +3496,61 @@ sub parse_tag {
 	return %tag
 }
 
+# Contents of mailmap stored as a referance to a hash with keys in the format
+# of "name <email>" or "<email>", and values that are hashes containing a
+# replacement "name" and/or "email". If set (even if empty) the mailmap has
+# already been read.
+my $mailmap;
+
+sub read_mailmap {
+	my %mailmap = ();
+	open my $fd, '-|', git_cmd(), 'cat-file', 'blob', 'HEAD:.mailmap'
+		or die_error(500, 'Failed to read mailmap');
+	foreach (split '\n', <$fd>) {
+		next if (/^#/);
+		if (/(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
+		    /(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>)/x) {
+			# New Name <new@email> <old@email>
+			# New Name <new@email> Old Name <old@email>
+			$mailmap{$3} = ();
+			$mailmap{$3}{name} = $1;
+			$mailmap{$3}{email} = $2;
+		} elsif (/(?: <([^<>]+)>\s+ | (.+)\s+ ) (<[^<>]+>) (?:\s+\#)/x ||
+		         /(?: <([^<>]+)>\s+ | (.+)\s+ ) (<[^<>]+>)/x) {
+			# New Name <old@email>
+			# <new@email> <old@email>
+			$mailmap{$3} = ();
+			if ($1) {
+				$mailmap{$3}{email} = $1;
+			} else {
+				$mailmap{$3}{name} = $2;
+			}
+		}
+	}
+	return \%mailmap;
+}
+
+# Map author name and email based on mailmap. A more specific match
+# ("name <email>") is preferred to a less specific one ("<email>").
+sub map_author {
+	my $name = shift;
+	my $email = shift;
+
+	if (!$mailmap) {
+		$mailmap = read_mailmap;
+	}
+
+	if ($mailmap->{"$name <$email>"}) {
+		$name = $mailmap->{"$name <$email>"}{name} || $name;
+		$email = $mailmap->{"$name <$email>"}{email} || $email;
+	} elsif ($mailmap->{"<$email>"}) {
+		$name = $mailmap->{"<$email>"}{name} || $name;
+		$email = $mailmap->{"<$email>"}{email} || $email;
+	}
+
+	return ($name, $email);
+}
+
 sub parse_commit_text {
 	my ($commit_text, $withparents) = @_;
 	my @commit_lines = split '\n', $commit_text;
@@ -3517,8 +3578,13 @@ sub parse_commit_text {
 			$co{'author_epoch'} = $2;
 			$co{'author_tz'} = $3;
 			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
-				$co{'author_name'}  = $1;
-				$co{'author_email'} = $2;
+				my ($name, $email) = @_;
+				if (gitweb_check_feature('mailmap')) {
+					($name, $email) = map_author($1, $2);
+					$co{'author'} = "$name <$email>";
+				}
+				$co{'author_name'}  = $name;
+				$co{'author_email'} = $email;
 			} else {
 				$co{'author_name'} = $co{'author'};
 			}
@@ -3527,8 +3593,13 @@ sub parse_commit_text {
 			$co{'committer_epoch'} = $2;
 			$co{'committer_tz'} = $3;
 			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
-				$co{'committer_name'}  = $1;
-				$co{'committer_email'} = $2;
+				my ($name, $email) = @_;
+				if (gitweb_check_feature('mailmap')) {
+					($name, $email) = map_author($1, $2);
+					$co{'committer'} = "$name <$email>";
+				}
+				$co{'committer_name'}  = $name;
+				$co{'committer_email'} = $email;
 			} else {
 				$co{'committer_name'} = $co{'committer'};
 			}
