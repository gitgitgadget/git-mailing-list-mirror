From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] contrib: add git-contacts helper
Date: Wed,  3 Jul 2013 16:59:40 -0400
Message-ID: <1372885182-5512-2-git-send-email-sunshine@sunshineco.com>
References: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 23:00:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUAG-000062-1M
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933362Ab3GCVAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:00:25 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:54251 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab3GCVAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:00:23 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so731334obb.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EvnGhuJ2VFc4Q+mXysMZTP1NyggfqjFD6V9P0o1nQg8=;
        b=LgfH4m4oajWmX7QmVww+f+BsoDcdEOQpIXsVWC7lQsmP/0ejkLbLzT5OIPC3QlAatX
         LwtSaL38Z+63QUd+2Q3c/wvOcOioZBVRpWwzu7bqNwke9R54BrXsOo5mfT1BiWAn5RGS
         N61KzXkIsT5+eyoFlE7BZRNNwKBpdIvXpl8tB0A7xxw09Gv6JkN44Zl6NPUlbSzSfNmv
         SWM8zq1V80+0Y3Mcax/jkyR78b33fDrw3wgZRD/p8cXna8cKRy6PLHolX0KPU2Q5IQcA
         WmZhwsDGfWDUS5PVAIXI9gkSsW/3sG6BzB+br7aYMG3R78wOO9o9oLCKRhw+uCIb/av6
         k4jg==
X-Received: by 10.182.129.129 with SMTP id nw1mr2660676obb.100.1372885222870;
        Wed, 03 Jul 2013 14:00:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm14400579oeb.8.2013.07.03.14.00.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 14:00:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229530>

This script lists people that might be interested in a patch by going
back through the history for each patch hunk, and finding people that
reviewed, acknowledge, signed, authored, or were Cc:'d on the code the
patch is modifying.

It does this by running git-blame incrementally on each hunk and then
parsing the commit message. After gathering all participants, it
determines each person's relevance by considering how many commits
mentioned that person compared with the total number of commits under
consideration. The final output consists only of participants who pass a
minimum threshold of participation.

Several conditions controlling a person's significance are currently
hard-coded, such as minimum participation level, blame date-limiting,
and -C level for detecting moved and copied lines. In the future, these
conditions may become configurable.

For example:

  % git contacts 0001-remote-hg-trivial-cleanups.patch
  Felipe Contreras <felipe.contreras@gmail.com>
  Jeff King <peff@peff.net>
  Max Horn <max@quendi.de>
  Junio C Hamano <gitster@pobox.com>

Thus, it can be invoked as git-send-email's --cc-cmd option, among other
possible uses.

This is a Perl rewrite of Felipe Contreras' git-related patch series[1]
written in Ruby.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226065/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 127 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100755 contrib/contacts/git-contacts

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
new file mode 100755
index 0000000..6e9ab45
--- /dev/null
+++ b/contrib/contacts/git-contacts
@@ -0,0 +1,127 @@
+#!/usr/bin/perl
+
+# List people who might be interested in a patch.  Useful as the argument to
+# git-send-email --cc-cmd option, and in other situations.
+#
+# Usage: git contacts <file> ...
+
+use strict;
+use warnings;
+use IPC::Open2;
+
+my $since = '5-years-ago';
+my $min_percent = 10;
+my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
+my %seen;
+
+sub format_contact {
+	my ($name, $email) = @_;
+	return "$name <$email>";
+}
+
+sub parse_commit {
+	my ($commit, $data) = @_;
+	my $contacts = $commit->{contacts};
+	my $inbody = 0;
+	for (split(/^/m, $data)) {
+		if (not $inbody) {
+			if (/^author ([^<>]+) <(\S+)> .+$/) {
+				$contacts->{format_contact($1, $2)} = 1;
+			} elsif (/^$/) {
+				$inbody = 1;
+			}
+		} elsif (/^$labels_rx:\s+([^<>]+)\s+<(\S+?)>$/o) {
+			$contacts->{format_contact($1, $2)} = 1;
+		}
+	}
+}
+
+sub import_commits {
+	my ($commits) = @_;
+	return unless %$commits;
+	my $pid = open2 my $reader, my $writer, qw(git cat-file --batch);
+	for my $id (keys(%$commits)) {
+		print $writer "$id\n";
+		my $line = <$reader>;
+		if ($line =~ /^([0-9a-f]{40}) commit (\d+)/) {
+			my ($cid, $len) = ($1, $2);
+			die "expected $id but got $cid\n" unless $id eq $cid;
+			my $data;
+			# cat-file emits newline after data, so read len+1
+			read $reader, $data, $len + 1;
+			parse_commit($commits->{$id}, $data);
+		}
+	}
+	close $reader;
+	close $writer;
+	waitpid($pid, 0);
+	die "git-cat-file error: $?\n" if $?;
+}
+
+sub get_blame {
+	my ($commits, $source, $start, $len, $from) = @_;
+	$len = 1 unless defined($len);
+	return if $len == 0;
+	open my $f, '-|',
+		qw(git blame --porcelain -C), '-L', "$start,+$len",
+		'--since', $since, "$from^", '--', $source or die;
+	while (<$f>) {
+		if (/^([0-9a-f]{40}) \d+ \d+ \d+$/) {
+			my $id = $1;
+			$commits->{$id} = { id => $id, contacts => {} }
+				unless $seen{$id};
+			$seen{$id} = 1;
+		}
+	}
+	close $f;
+}
+
+sub scan_patches {
+	my ($commits, $f) = @_;
+	my ($id, $source);
+	while (<$f>) {
+		if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
+			$id = $1;
+			$seen{$id} = 1;
+		}
+		next unless $id;
+		if (m{^--- (?:a/(.+)|/dev/null)$}) {
+			$source = $1;
+		} elsif (/^--- /) {
+			die "Cannot parse hunk source: $_\n";
+		} elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
+			get_blame($commits, $source, $1, $2, $id);
+		}
+	}
+}
+
+sub scan_patch_file {
+	my ($commits, $file) = @_;
+	open my $f, '<', $file or die "read failure: $file: $!\n";
+	scan_patches($commits, $f);
+	close $f;
+}
+
+if (!@ARGV) {
+	die "No input patch files\n";
+}
+
+my %commits;
+for (@ARGV) {
+	scan_patch_file(\%commits, $_);
+}
+import_commits(\%commits);
+
+my %count_per_person;
+for my $commit (values %commits) {
+	for my $contact (keys %{$commit->{contacts}}) {
+		$count_per_person{$contact}++;
+	}
+}
+
+my $ncommits = scalar(keys %commits);
+for my $contact (keys %count_per_person) {
+	my $percent = $count_per_person{$contact} * 100 / $ncommits;
+	next if $percent < $min_percent;
+	print "$contact\n";
+}
-- 
1.8.3.2
