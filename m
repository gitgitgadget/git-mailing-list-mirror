From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 1/4] gitweb: add patch view
Date: Thu, 18 Dec 2008 08:13:16 +0100
Message-ID: <1229584399-23879-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1229584399-23879-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 08:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDD5l-0007I7-IN
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 08:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYLRHNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 02:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYLRHNX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 02:13:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:15163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbYLRHNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 02:13:22 -0500
Received: by fg-out-1718.google.com with SMTP id 19so119795fgg.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 23:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eLn/j8pSHTeFqUPIsT2nH7XDFoLFk9TRf0yMmT8DnDo=;
        b=b1bEyePE49MFxn3eoxnssAn2RKeMRcHt1oIw4Y4+BDwOAzne9o94v6Zatpo/Q+vnN7
         GVTCFtBoBupJo0ACKUKQotmykhM9i6WR6I5anYwV6EJd1weZCGwN+tdEZphDrP0mxOx+
         4HSIWaMNWvw3qidNYiJXbu3yOyeTKANGYAK3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mSJ1kmRUKl+WBNyQCfHG8Bfmu1enKNmD4ecD/C2HuAacSIG/RCHf+uF3I5RurHOa3g
         5tXPja0QaAMMx+JxajBfW0FVIhQxLy7iYhgYsrs9Msz8dNL4akxXk5pj3Oxm8hsRWK50
         VGBSXk5J3RjVUz9G5zJu3S0UotqyiJDY3syq0=
Received: by 10.86.80.17 with SMTP id d17mr944506fgb.14.1229584401182;
        Wed, 17 Dec 2008 23:13:21 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id l12sm3509197fgb.14.2008.12.17.23.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Dec 2008 23:13:20 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229584399-23879-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103438>

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

A configurable upper limit defaulting to 16 is imposed on the number of
commits which will be included in a patchset, to prevent DoS attacks on
the server. Setting the limit to 0 will disable the patch view, setting
it to a negative number will remove the limit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6eb370d..1006dfe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -330,6 +330,21 @@ our %feature = (
 	'ctags' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# The maximum number of patches in a patchset generated in patch
+	# view. Set this to 0 or undef to disable patch view, or to a
+	# negative number to remove any limit.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'patches'}{'default'} = [0];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'patches'}{'override'} = 1;
+	# and in project config gitweb.patches = 0|n;
+	# where n is the maximum number of patches allowed in a patchset.
+	'patches' => {
+		'sub' => \&feature_patches,
+		'override' => 0,
+		'default' => [16]},
 );
 
 sub gitweb_get_feature {
@@ -411,6 +426,16 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+sub feature_patches {
+	my @val = (git_get_project_config('patches', '--int'));
+
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
@@ -504,6 +529,7 @@ our %actions = (
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
+	"patch" => \&git_patch,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5387,6 +5413,13 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+
+	my $patch_max;
+	if ($format eq 'patch') {
+		($patch_max) = gitweb_get_feature('patches');
+		die_error(403, "Patch view not allowed") unless $patch_max;
+	}
+
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
@@ -5484,7 +5517,23 @@ sub git_commitdiff {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_param, $hash, "--"
 			or die_error(500, "Open git-diff-tree failed");
-
+	} elsif ($format eq 'patch') {
+		# For commit ranges, we limit the output to the number of
+		# patches specified in the 'patches' feature.
+		# For single commits, we limit the output to a single patch,
+		# diverging from the git-format-patch default.
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
@@ -5533,6 +5582,14 @@ sub git_commitdiff {
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
@@ -5554,6 +5611,11 @@ sub git_commitdiff {
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
 
@@ -5561,6 +5623,11 @@ sub git_commitdiff_plain {
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
