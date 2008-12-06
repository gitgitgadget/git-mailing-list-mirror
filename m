From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv4 1/3] gitweb: add patch view
Date: Sat,  6 Dec 2008 16:02:33 +0100
Message-ID: <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 16:04:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8yhC-0001tF-Ea
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 16:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYLFPCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 10:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755964AbYLFPCP
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 10:02:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:17295 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbYLFPCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 10:02:14 -0500
Received: by nf-out-0910.google.com with SMTP id d3so217525nfc.21
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 07:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GuWbC2O47R478Aty0iGnlDH4JUvMTeBCT5igqBMRPjQ=;
        b=Z9mh0Z2ArFBH7ONlDZgdo55OkVn1fE6HRHxZGyVnYB3AhW8fEE2VBvKxulGc56npPA
         g/wdYvakDbxtB6LOuIZ1saPORNkOodMDl3X+UcIqUY311FcVP5twzZ4kd93JueHnkE8B
         zd8oE1rIYjUZoYD1hOltsSoZXO39ARmtNdRE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Xm0w+maADyn4ACOXfWKRwShDOUYVuq5Q4hkmMrWuSla++BsROxCt5wKHzijPwhpz6t
         3a+peCjNtJ5lwe1Ii+hziPoGmHPgtK2YHz8cNKNna/xNDXdYuXpWqIGyKu6KAteDKKn9
         V3zn7i0QZTon1VM7bijuNhyMb8ulKYsShzJ58=
Received: by 10.210.125.13 with SMTP id x13mr1300309ebc.198.1228575732149;
        Sat, 06 Dec 2008 07:02:12 -0800 (PST)
Received: from localhost ([78.13.53.163])
        by mx.google.com with ESMTPS id h1sm1697132nfh.3.2008.12.06.07.02.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 07:02:11 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102462>

The output of commitdiff_plain is not intended for git-am:
 * when given a range of commits, commitdiff_plain publishes a single
   patch with the message from the first commit, instead of a patchset
 * the hand-built email format replicates the commit summary both as
   email subject and as first line of the email itself, resulting in
   a duplication if the output is used with git-am.

We thus create a new view that can be fed to git-am directly, allowing
patch exchange via gitweb. The new view exposes the output of git
format-patch directly, limiting it to a single patch in the case of a
single commit.

A configurable upper limit is imposed on the number of commits which
will be included in a patchset, to prevent DoS attacks on the server.
Setting the limit to 0 will disable the patch view, setting it to a
negative number will remove the limit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 95988fb..71d5af4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -329,6 +329,14 @@ our %feature = (
 	'ctags' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# The maximum number of patches in a patchset generated in patch
+	# view. Set this to 0 or undef to disable patch view, or to a
+	# negative number to remove any limit.
+	'patches' => {
+		'sub' => \&feature_patches,
+		'override' => 0,
+		'default' => [16]},
 );
 
 sub gitweb_get_feature {
@@ -410,6 +418,19 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+sub feature_patches {
+	my @val = (git_get_project_config('patches', '--int'));
+
+	# if @val is empty, the config is not (properly)
+	# overriding the feature, so we return the default,
+	# otherwise we pick the override
+	if (@val) {
+		return @val;
+	}
+
+	return ($_[0]);
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -503,6 +524,7 @@ our %actions = (
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
+	"patch" => \&git_patch,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5386,6 +5408,13 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+
+	my $patch_max;
+	if ($format eq 'patch') {
+		$patch_max = gitweb_check_feature('patches');
+		die_error(403, "Patch view not allowed") unless $patch_max;
+	}
+
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
@@ -5483,7 +5512,23 @@ sub git_commitdiff {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_param, $hash, "--"
 			or die_error(500, "Open git-diff-tree failed");
-
+	} elsif ($format eq 'patch') {
+		# For commit ranges, we limit the output to the number of
+		# patches specified in the 'patches' feature.
+		# For single commits, we limit the output to a single patch,
+		# diverging from the git format-patch default.
+		my @commit_spec = ();
+		if ($hash_parent) {
+			if ($patch_max > 0) {
+				push @commit_spec, "-$patch_max";
+			}
+			push @commit_spec, '-n', "$hash_parent..$hash";
+		} else {
+			push @commit_spec, '-1', '--root', $hash;
+		}
+		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
+			'--stdout', @commit_spec
+			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
 	}
@@ -5532,6 +5577,14 @@ sub git_commitdiff {
 			print to_utf8($line) . "\n";
 		}
 		print "---\n\n";
+	} elsif ($format eq 'patch') {
+		my $filename = basename($project) . "-$hash.patch";
+
+		print $cgi->header(
+			-type => 'text/plain',
+			-charset => 'utf-8',
+			-expires => $expires,
+			-content_disposition => 'inline; filename="' . "$filename" . '"');
 	}
 
 	# write patch
@@ -5553,6 +5606,11 @@ sub git_commitdiff {
 		print <$fd>;
 		close $fd
 			or print "Reading git-diff-tree failed\n";
+	} elsif ($format eq 'patch') {
+		local $/ = undef;
+		print <$fd>;
+		close $fd
+			or print "Reading git-format-patch failed\n";
 	}
 }
 
@@ -5560,6 +5618,11 @@ sub git_commitdiff_plain {
 	git_commitdiff('plain');
 }
 
+# format-patch-style patches
+sub git_patch {
+	git_commitdiff('patch');
+}
+
 sub git_history {
 	if (!defined $hash_base) {
 		$hash_base = git_get_head_hash($project);
-- 
1.5.6.5
