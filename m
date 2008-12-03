From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv3 1/2] gitweb: add patch view
Date: Wed,  3 Dec 2008 23:59:47 +0100
Message-ID: <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 00:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80iO-00078W-NL
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbYLCW7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYLCW7r
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:59:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:62936 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYLCW7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:59:46 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3564554ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=96UKQf35tKHamlpPQxKVxOjbbsv0KhV8PYd3yBJkj1w=;
        b=NBWRUUx5Wx1D1ffeVmFul+9WO6rSpdPi77s/pr09JSoy1xPWiMmcm4srsy2GhwDro6
         U7whDw177fUp9/jMEczA6uWSjkEDhPYeZ4yQQs5s2Ly8LyaDO7YIPaAP5ETGoZxNHkpl
         6HuvAuLK7Vh1hcdglDOjDf68l2fG67oP5DQl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TPlCqJQjENIDd1jwq/0+Ft1ynODGCu+d1x8n/UVACBKviWBq9XaucnEhK5gifGWokr
         bBHBTBVUm6z3hf+CxyoQTLDH99rvqWE4YWDNGiIcH8Uaz/ckmqknF1ZYlHiz33K2SCe7
         0uYT31eTrWP6U69rp0fl4X9VaR0SMf4Y2sQUk=
Received: by 10.103.161.16 with SMTP id n16mr6517928muo.79.1228345170632;
        Wed, 03 Dec 2008 14:59:30 -0800 (PST)
Received: from localhost ([94.37.11.168])
        by mx.google.com with ESMTPS id 12sm13039204fks.20.2008.12.03.14.59.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 14:59:29 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102300>

The manually-built email format in commitdiff_plain output is not
appropriate for feeding git-am, because of two limitations:
 * when a range of commits is specified, commitdiff_plain publishes a
   single patch with the message from the first commit, instead of a
   patchset,
 * in either case, the patch summary is replicated both as email subject
   and as first line of the email itself, resulting in a doubled summary
   if the output is fed to git-am.

We thus create a new view that can be fed to git-am directly by exposing
the output of git format-patch directly. This allows patch exchange and
submission via gitweb.

A configurable limit is imposed on the number of commits which will be
included in a patchset, to prevent DoS attacks on the server. Setting
the limit to 0 will disable the patch view, setting it to a negative
number will remove the limit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2738643..c9abfcf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -329,6 +329,13 @@ our %feature = (
 	'ctags' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# The maximum number of patches in a patchset generated in patch
+	# view. Set this to 0 or undef to disable patch view, or to a
+	# negative number to remove any limit.
+	'patches' => {
+		'override' => 1,
+		'default' => [16]},
 );
 
 sub gitweb_get_feature {
@@ -503,6 +510,7 @@ our %actions = (
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
+	"patch" => \&git_patch,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5386,6 +5394,12 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+
+	my $patch_max = gitweb_check_feature('patches');
+	if ($format eq 'patch') {
+		die_error(403, "Patch view not allowed") unless $patch_max;
+	}
+
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
@@ -5396,6 +5410,7 @@ sub git_commitdiff {
 	}
 	# we need to prepare $formats_nav before almost any parameter munging
 	my $formats_nav;
+
 	if ($format eq 'html') {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
@@ -5483,7 +5498,12 @@ sub git_commitdiff {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_param, $hash, "--"
 			or die_error(500, "Open git-diff-tree failed");
-
+	} elsif ($format eq 'patch') {
+		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
+			'--stdout', $patch_max > 0 ? "-$patch_max" : (),
+			$hash_parent ? ('-n', "$hash_parent..$hash") :
+			('--root', '-1', $hash)
+			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
 	}
@@ -5532,6 +5552,15 @@ sub git_commitdiff {
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
+		# TODO add X-Git-Tag/X-Git-Url headers in a sensible way
 	}
 
 	# write patch
@@ -5553,6 +5582,11 @@ sub git_commitdiff {
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
 
@@ -5560,6 +5594,11 @@ sub git_commitdiff_plain {
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
