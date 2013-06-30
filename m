From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH/RFC 1/4] contrib: add git-contacts helper
Date: Sun, 30 Jun 2013 07:08:29 -0400
Message-ID: <1372590512-21341-2-git-send-email-sunshine@sunshineco.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 30 13:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFX0-0000qR-5D
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab3F3LKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:10:42 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33859 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab3F3LKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:10:33 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so7322174iet.37
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RfQY5ThG47Fpj+Vb3TVXDJ4ESuEL1hXWkpl+NQpZ0wA=;
        b=gH81N8Vgf7Ne1kIpGZCQMZPVOT0oa8zYWvdiP/kbdFMTVubWw0Ueo9osIY6UMMwq+4
         N4zEAR4eAD4Oh5zHmuTFbgLgiSdfFWvNpn97S2yeIJBKYykxJLH8TYdBOPmSdXmzFhqY
         3TTTWADn8bToBlLF3JzlwQlkgSQnpUHS0rTOTYFvdbmWpvEDWJi0kf6sAqwtYeXoC/9y
         PZxoE7Q1jDgt0yB+IVid29sIJWHPlvK+DgLX/Bfid6TWvmV5odDxKhf2cCFdiLQxHbmV
         DaJFWNGl3fJ5au9oU6KImPTOOf/vV9+gZiuyQSmD7bHYxpGXbEiUc/rVUR+Lz9/oLb1L
         InNw==
X-Received: by 10.50.117.72 with SMTP id kc8mr10941895igb.44.1372590632519;
        Sun, 30 Jun 2013 04:10:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ir8sm7931119igb.6.2013.06.30.04.10.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 30 Jun 2013 04:10:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229270>

This script lists people that might be interested in a patch by going
back through the history for each patch hunk, and finding people that
reviewed, acknowledge, signed, or authored the code the patch is
modifying.

It does this by running git-blame incrementally on each hunk and then
parsing the commit message. After gathering all participants, it
determines each person's relevance by considering how many commits
mentioned that person compared with the total number of commits under
consideration. The final output consists only of participants who pass a
minimum threshold of participation.

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
To better support Windows, a follow-up patch may want to add
functionality similar to run_cmd_pipe() from git-add--interactive.perl.

 contrib/contacts/git-contacts | 121 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100755 contrib/contacts/git-contacts

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
new file mode 100755
index 0000000..9007bae
--- /dev/null
+++ b/contrib/contacts/git-contacts
@@ -0,0 +1,121 @@
+#!/usr/bin/perl
+
+# List people who might be interested in a patch.  Useful as the argument to
+# git-send-email --cc-cmd option, and in other situations.
+#
+# Usage: git contacts <file>
+
+use strict;
+use warnings;
+use IPC::Open2;
+
+my $since = '5-years-ago';
+my $min_percent = 10;
+my $labels_rx = qr/(?:Signed-off|Reviewed|Acked)-by/;
+my $id_rx = qr/[0-9a-f]{40}/i;
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
+		if ($line =~ /^($id_rx) commit (\d+)/o) {
+			my ($cid, $len) = ($1, $2);
+			die "expected $id but got $cid" unless $id eq $cid;
+			my $data;
+			# cat-file emits newline after data, so read len+1
+			read $reader, $data, $len + 1;
+			parse_commit($commits->{$id}, $data);
+		}
+	}
+	close $reader;
+	close $writer;
+	waitpid($pid, 0);
+	die "git-cat-file error: $?" if $?;
+}
+
+sub get_blame {
+	my ($commits, $source, $start, $len, $from) = @_;
+	$len = 1 unless defined($len);
+	return if $len == 0;
+	open my $f, '-|',
+		qw(git blame --incremental -C -C), '-L', "$start,+$len",
+		'--since', $since, "$from^", '--', $source or die;
+	while (<$f>) {
+		if (/^$id_rx/o) {
+			my $id = $&;
+			$commits->{$id} = { id => $id, contacts => {} };
+		}
+	}
+	close $f;
+}
+
+sub scan_hunks {
+	my ($commits, $id, $f) = @_;
+	my $source;
+	while (<$f>) {
+		if (/^---\s+(\S+)/) {
+			$source = substr($1, 2) unless $1 eq '/dev/null';
+		} elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
+			get_blame($commits, $source, $1, $2, $id);
+		}
+	}
+}
+
+sub commits_from_patch {
+	my ($commits, $file) = @_;
+	open my $f, '<', $file or die "read failure: $file: $!";
+	my $id;
+	while (<$f>) {
+		if (/^From ($id_rx) /o) {
+			$id = $1;
+			last;
+		}
+	}
+	scan_hunks($commits, $id, $f) if $id;
+	close $f;
+}
+
+exit 1 unless @ARGV == 1;
+
+my %commits;
+commits_from_patch(\%commits, $ARGV[0]);
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
