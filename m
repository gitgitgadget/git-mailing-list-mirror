Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5CC433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 23:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08D0206A2
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 23:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHIXGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 19:06:43 -0400
Received: from aibo.runbox.com ([91.220.196.211]:45030 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgHIXGn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 19:06:43 -0400
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1k4uOm-0004uh-Om; Mon, 10 Aug 2020 01:06:40 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k4uOc-00048e-GM; Mon, 10 Aug 2020 01:06:32 +0200
From:   Emma Brooks <me@pluvano.com>
To:     git@vger.kernel.org
Cc:     Emma Brooks <me@pluvano.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2] gitweb: map names/emails with mailmap
Date:   Sun,  9 Aug 2020 23:04:37 +0000
Message-Id: <20200809230436.2152-1-me@pluvano.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808213457.13116-1-me@pluvano.com>
References: <20200808213457.13116-1-me@pluvano.com>
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

No code changes. I just fixed a typo in the commit subject (made "map"
lower-case).

 Documentation/gitweb.conf.txt |  5 +++
 gitweb/gitweb.perl            | 81 +++++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 4 deletions(-)

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
index 0959a782ec..1ca495b8b4 100755
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
@@ -3490,6 +3496,63 @@ sub parse_tag {
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
+	open my $fd, '-|', quote_command(
+		git_cmd(), 'cat-file', 'blob', 'HEAD:.mailmap') . ' 2> /dev/null'
+		or die_error(500, 'Failed to read mailmap');
+	return \%mailmap if eof $fd;
+	foreach (split '\n', <$fd>) {
+		next if (/^#/);
+		if (/(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
+		    /(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>)/x) {
+			# New Name <new@email> <old@email>
+			# New Name <new@email> Old Name <old@email>
+			$mailmap{$3} = ();
+			($mailmap{$3}{name} = $1) =~ s/^\s+|\s+$//g;
+			$mailmap{$3}{email} = $2;
+		} elsif (/(?: <([^<>]+)>\s+ | (.+)\s+ ) (<[^<>]+>) (?:\s+\#)/x ||
+		         /(?: <([^<>]+)>\s+ | (.+)\s+ ) (<[^<>]+>)/x) {
+			# New Name <old@email>
+			# <new@email> <old@email>
+			$mailmap{$3} = ();
+			if ($1) {
+				$mailmap{$3}{email} = $1;
+			} else {
+				($mailmap{$3}{name} = $2) =~ s/^\s+|\s+$//g;
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
@@ -3517,8 +3580,13 @@ sub parse_commit_text {
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
@@ -3527,8 +3595,13 @@ sub parse_commit_text {
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
