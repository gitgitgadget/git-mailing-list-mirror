From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/4] gitweb: notes feature
Date: Thu,  4 Feb 2010 17:18:55 +0100
Message-ID: <1265300338-25021-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 17:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4QK-00070M-Ar
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213Ab0BDQTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:19:13 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:58585 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758266Ab0BDQTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:19:12 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so2728254fxm.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=grqys+uHmOMg5iXSSzpyEtS8S1I1JHGvAkrewRrdrZ8=;
        b=wLSqT6fjtV4GXYRV1/iM3nOtBCbAPOZ7F30Fd6OYcOVjQE+HY5fWua7kz1wkFUxoFq
         An+0vLUwGUVFNPbNhpewSvogh4Qt9s00z4AfOB3AWYm2YldfDwd2Fo4Bbyxmqs5gu0f9
         K9izpR7DOOZ3DM1w8Mw7E5dmI7uLa9VIIyCXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I88oDB/xPm+rYLj5E9sQdrbvrfUumQSxovKmBi9IVcypyGnUUBdtleJvLRSD9LzbPY
         aSRwEtJ9eoqVq6wGf/pnpUeXGc6VLir6WCnwWQe5Rsq/hWuU69rjvHzU0tONrQpXWjNL
         yZ+QOHuhWAe0s/ZaseavVpMYH298YC3ukww9w=
Received: by 10.223.143.70 with SMTP id t6mr1360794fau.101.1265300351389;
        Thu, 04 Feb 2010 08:19:11 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 16sm140530fxm.0.2010.02.04.08.19.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 08:19:09 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.193.ge8618
In-Reply-To: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138971>

Introduce support for notes by collecting them when creating commit
lists. The list of noterefs to look into is configurable, and can be a(n
array of) refspec(s), which will be looked for in the refs/notes
namespace.

The feature is disabled by default because it's presently not very
efficient (one extra git call per configured refspec, plus two extra git
calls per commit per noteref).
---
 gitweb/gitweb.perl |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d0c3ff2..9ba5815 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -411,6 +411,22 @@ our %feature = (
 		'override' => 0,
 		'default' => [16]},
 
+	# Notes support. When this feature is enabled, the presence of notes
+	# for any commit is signaled, and the note content is made available
+	# in a way appropriate for the current view.
+	# Set this to '*' to enable all notes namespace, or to a shell-glob
+	# specification to enable specific namespaces only.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'notes'}{'default'} = ['*'];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'notes'}{'override'} = 1;
+	# and in project config gitweb.notes = namespace;
+	'notes' => {
+		'sub' => \&feature_notes,
+		'override' => 0,
+		'default' => []},
+
 	# Avatar support. When this feature is enabled, views such as
 	# shortlog or commit will display an avatar associated with
 	# the email of the committer(s) and/or author(s).
@@ -513,6 +529,16 @@ sub feature_patches {
 	return ($_[0]);
 }
 
+sub feature_notes {
+	my @val = (git_get_project_config('notes'));
+
+	if (@val) {
+		return @val;
+	}
+
+	return @_;
+}
+
 sub feature_avatar {
 	my @val = (git_get_project_config('avatar'));
 
@@ -2786,10 +2812,30 @@ sub parse_commit {
 	return %co;
 }
 
+# return all refs matching refs/notes/<globspecs> where the globspecs
+# are taken from the notes feature content.
+sub get_note_refs {
+	my @globs = gitweb_get_feature('notes');
+	my @note_refs = ();
+	foreach my $glob (@globs) {
+		if (open my $fd, '-|', git_cmd(), 'for-each-ref',
+		    '--format=%(refname)', "refs/notes/$glob") {
+			while (<$fd>) {
+				chomp;
+				push @note_refs, $_ if $_;
+			}
+			close $fd;
+		}
+	}
+	return @note_refs;
+}
+
 sub parse_commits {
 	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
 	my @cos;
 
+	my @note_refs = get_note_refs();
+
 	$maxcount ||= 1;
 	$skip ||= 0;
 
@@ -2807,6 +2853,22 @@ sub parse_commits {
 		or die_error(500, "Open git-rev-list failed");
 	while (my $line = <$fd>) {
 		my %co = parse_commit_text($line);
+		my %notes = () ;
+		foreach my $note_ref (@note_refs) {
+			my $obj = "$note_ref:$co{'id'}";
+			if (open my $fd, '-|', git_cmd(), 'rev-parse',
+				'--verify', '-q', $obj) {
+				my $exists = <$fd>;
+				close $fd;
+				if (defined $exists) {
+					if (open $fd, '-|', git_cmd(), 'show', $obj) {
+						$notes{$note_ref} = scalar <$fd>;
+						close $fd;
+					}
+				}
+			}
+		}
+		$co{'notes'} = \%notes;
 		push @cos, \%co;
 	}
 	close $fd;
-- 
1.7.0.rc1.193.ge8618
