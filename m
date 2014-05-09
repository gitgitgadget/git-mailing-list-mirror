From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 20/25] contrib: remove 'contacts'
Date: Thu,  8 May 2014 19:58:31 -0500
Message-ID: <1399597116-1851-21-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZLJ-0001Jc-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbaEIBLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:11:15 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:65404 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbaEIBLG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:11:06 -0400
Received: by mail-yk0-f181.google.com with SMTP id 131so2883221ykp.40
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWxAdKv+VQZETwbrxEemasMKK/rQeugDKvlNLTKqMpc=;
        b=sVeajMiBQVoOXOm+qJNlNel0g3b90N/+6YrIGEVadxfm4ZsizhKr3Pn3FhDm85vpUk
         qi4Sw1ooelJOKXqM6jsnuOVwVYnjI1m7+Ku4jkeNYi4skQoSa5CSWCwxKUiicfk1FcgD
         sCN7O5cGqSkJM/85/8w6fRHL4polekgaANg6o62wdDiprmBhFqfjcuaecngJi55SAIgD
         EZSSdBP9SCuinkd+XOmDFwaNf1O6cPkhEyCHMe2hIdVnDb+1IfBb31sCHthiV4CuUVtB
         QcEBiKivQTy02g1HIi9iyn55rp00fMVJmmIsSjb+UOSQ8NruPo0XSwW0W8hZcvb9U2Si
         mU0Q==
X-Received: by 10.236.138.136 with SMTP id a8mr10031135yhj.113.1399597865288;
        Thu, 08 May 2014 18:11:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h23sm3917937yhf.34.2014.05.08.18.11.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:11:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248487>

There are better out-of-tree tools, and this tool is not planned to move
into the core anyway.

No tests either.

Cc: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/contacts/git-contacts     | 203 --------------------------------------
 contrib/contacts/git-contacts.txt |  94 ------------------
 2 files changed, 297 deletions(-)
 delete mode 100755 contrib/contacts/git-contacts
 delete mode 100644 contrib/contacts/git-contacts.txt

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
deleted file mode 100755
index dbe2abf..0000000
--- a/contrib/contacts/git-contacts
+++ /dev/null
@@ -1,203 +0,0 @@
-#!/usr/bin/perl
-
-# List people who might be interested in a patch.  Useful as the argument to
-# git-send-email --cc-cmd option, and in other situations.
-#
-# Usage: git contacts <file | rev-list option> ...
-
-use strict;
-use warnings;
-use IPC::Open2;
-
-my $since = '5-years-ago';
-my $min_percent = 10;
-my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
-my %seen;
-
-sub format_contact {
-	my ($name, $email) = @_;
-	return "$name <$email>";
-}
-
-sub parse_commit {
-	my ($commit, $data) = @_;
-	my $contacts = $commit->{contacts};
-	my $inbody = 0;
-	for (split(/^/m, $data)) {
-		if (not $inbody) {
-			if (/^author ([^<>]+) <(\S+)> .+$/) {
-				$contacts->{format_contact($1, $2)} = 1;
-			} elsif (/^$/) {
-				$inbody = 1;
-			}
-		} elsif (/^$labels_rx:\s+([^<>]+)\s+<(\S+?)>$/o) {
-			$contacts->{format_contact($1, $2)} = 1;
-		}
-	}
-}
-
-sub import_commits {
-	my ($commits) = @_;
-	return unless %$commits;
-	my $pid = open2 my $reader, my $writer, qw(git cat-file --batch);
-	for my $id (keys(%$commits)) {
-		print $writer "$id\n";
-		my $line = <$reader>;
-		if ($line =~ /^([0-9a-f]{40}) commit (\d+)/) {
-			my ($cid, $len) = ($1, $2);
-			die "expected $id but got $cid\n" unless $id eq $cid;
-			my $data;
-			# cat-file emits newline after data, so read len+1
-			read $reader, $data, $len + 1;
-			parse_commit($commits->{$id}, $data);
-		}
-	}
-	close $reader;
-	close $writer;
-	waitpid($pid, 0);
-	die "git-cat-file error: $?\n" if $?;
-}
-
-sub get_blame {
-	my ($commits, $source, $from, $ranges) = @_;
-	return unless @$ranges;
-	open my $f, '-|',
-		qw(git blame --porcelain -C),
-		map({"-L$_->[0],+$_->[1]"} @$ranges),
-		'--since', $since, "$from^", '--', $source or die;
-	while (<$f>) {
-		if (/^([0-9a-f]{40}) \d+ \d+ \d+$/) {
-			my $id = $1;
-			$commits->{$id} = { id => $id, contacts => {} }
-				unless $seen{$id};
-			$seen{$id} = 1;
-		}
-	}
-	close $f;
-}
-
-sub blame_sources {
-	my ($sources, $commits) = @_;
-	for my $s (keys %$sources) {
-		for my $id (keys %{$sources->{$s}}) {
-			get_blame($commits, $s, $id, $sources->{$s}{$id});
-		}
-	}
-}
-
-sub scan_patches {
-	my ($sources, $id, $f) = @_;
-	my $source;
-	while (<$f>) {
-		if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
-			$id = $1;
-			$seen{$id} = 1;
-		}
-		next unless $id;
-		if (m{^--- (?:a/(.+)|/dev/null)$}) {
-			$source = $1;
-		} elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
-			my $len = defined($2) ? $2 : 1;
-			push @{$sources->{$source}{$id}}, [$1, $len] if $len;
-		}
-	}
-}
-
-sub scan_patch_file {
-	my ($commits, $file) = @_;
-	open my $f, '<', $file or die "read failure: $file: $!\n";
-	scan_patches($commits, undef, $f);
-	close $f;
-}
-
-sub parse_rev_args {
-	my @args = @_;
-	open my $f, '-|',
-		qw(git rev-parse --revs-only --default HEAD --symbolic), @args
-		or die;
-	my @revs;
-	while (<$f>) {
-		chomp;
-		push @revs, $_;
-	}
-	close $f;
-	return @revs if scalar(@revs) != 1;
-	return "^$revs[0]", 'HEAD' unless $revs[0] =~ /^-/;
-	return $revs[0], 'HEAD';
-}
-
-sub scan_rev_args {
-	my ($commits, $args) = @_;
-	my @revs = parse_rev_args(@$args);
-	open my $f, '-|', qw(git rev-list --reverse), @revs or die;
-	while (<$f>) {
-		chomp;
-		my $id = $_;
-		$seen{$id} = 1;
-		open my $g, '-|', qw(git show -C --oneline), $id or die;
-		scan_patches($commits, $id, $g);
-		close $g;
-	}
-	close $f;
-}
-
-sub mailmap_contacts {
-	my ($contacts) = @_;
-	my %mapped;
-	my $pid = open2 my $reader, my $writer, qw(git check-mailmap --stdin);
-	for my $contact (keys(%$contacts)) {
-		print $writer "$contact\n";
-		my $canonical = <$reader>;
-		chomp $canonical;
-		$mapped{$canonical} += $contacts->{$contact};
-	}
-	close $reader;
-	close $writer;
-	waitpid($pid, 0);
-	die "git-check-mailmap error: $?\n" if $?;
-	return \%mapped;
-}
-
-if (!@ARGV) {
-	die "No input revisions or patch files\n";
-}
-
-my (@files, @rev_args);
-for (@ARGV) {
-	if (-e) {
-		push @files, $_;
-	} else {
-		push @rev_args, $_;
-	}
-}
-
-my %sources;
-for (@files) {
-	scan_patch_file(\%sources, $_);
-}
-if (@rev_args) {
-	scan_rev_args(\%sources, \@rev_args)
-}
-
-my $toplevel = `git rev-parse --show-toplevel`;
-chomp $toplevel;
-chdir($toplevel) or die "chdir failure: $toplevel: $!\n";
-
-my %commits;
-blame_sources(\%sources, \%commits);
-import_commits(\%commits);
-
-my $contacts = {};
-for my $commit (values %commits) {
-	for my $contact (keys %{$commit->{contacts}}) {
-		$contacts->{$contact}++;
-	}
-}
-$contacts = mailmap_contacts($contacts);
-
-my $ncommits = scalar(keys %commits);
-for my $contact (keys %$contacts) {
-	my $percent = $contacts->{$contact} * 100 / $ncommits;
-	next if $percent < $min_percent;
-	print "$contact\n";
-}
diff --git a/contrib/contacts/git-contacts.txt b/contrib/contacts/git-contacts.txt
deleted file mode 100644
index dd914d1..0000000
--- a/contrib/contacts/git-contacts.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-git-contacts(1)
-===============
-
-NAME
-----
-git-contacts - List people who might be interested in a set of changes
-
-
-SYNOPSIS
---------
-[verse]
-'git contacts' (<patch>|<range>|<rev>)...
-
-
-DESCRIPTION
------------
-
-Given a set of changes, specified as patch files or revisions, determine people
-who might be interested in those changes.  This is done by consulting the
-history of each patch or revision hunk to find people mentioned by commits
-which touched the lines of files under consideration.
-
-Input consists of one or more patch files or revision arguments.  A revision
-argument can be a range or a single `<rev>` which is interpreted as
-`<rev>..HEAD`, thus the same revision arguments are accepted as for
-linkgit:git-format-patch[1]. Patch files and revision arguments can be combined
-in the same invocation.
-
-This command can be useful for determining the list of people with whom to
-discuss proposed changes, or for finding the list of recipients to Cc: when
-submitting a patch series via `git send-email`. For the latter case, `git
-contacts` can be used as the argument to `git send-email`'s `--cc-cmd` option.
-
-
-DISCUSSION
-----------
-
-`git blame` is invoked for each hunk in a patch file or revision.  For each
-commit mentioned by `git blame`, the commit message is consulted for people who
-authored, reviewed, signed, acknowledged, or were Cc:'d.  Once the list of
-participants is known, each person's relevance is computed by considering how
-many commits mentioned that person compared with the total number of commits
-under consideration.  The final output consists only of participants who exceed
-a minimum threshold of participation.
-
-
-OUTPUT
-------
-
-For each person of interest, a single line is output, terminated by a newline.
-If the person's name is known, ``Name $$<user@host>$$'' is printed; otherwise
-only ``$$<user@host>$$'' is printed.
-
-
-EXAMPLES
---------
-
-* Consult patch files:
-+
-------------
-$ git contacts feature/*.patch
-------------
-
-* Revision range:
-+
-------------
-$ git contacts R1..R2
-------------
-
-* From a single revision to `HEAD`:
-+
-------------
-$ git contacts origin
-------------
-
-* Helper for `git send-email`:
-+
-------------
-$ git send-email --cc-cmd='git contacts' feature/*.patch
-------------
-
-
-LIMITATIONS
------------
-
-Several conditions controlling a person's significance are currently
-hard-coded, such as minimum participation level (10%), blame date-limiting (5
-years), and `-C` level for detecting moved and copied lines (a single `-C`). In
-the future, these conditions may become configurable.
-
-
-GIT
----
-Part of the linkgit:git[1] suite
-- 
1.9.2+fc1.27.gbce2056
