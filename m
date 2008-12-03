From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv2 1/2] gitweb: add patch view
Date: Wed,  3 Dec 2008 11:07:41 +0100
Message-ID: <1228298862-28191-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 11:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ofO-0002AJ-Ux
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 11:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYLCKHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 05:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYLCKHk
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 05:07:40 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:55907 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYLCKHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 05:07:39 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1464940eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 02:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0V2qzs+Lqp/FA43sWoOzsMSABlsLrjj7Ri2zD0FE/yc=;
        b=UfE0whZlix4zis83mR6tCSrN9THYclisBlFWXFVaKEplN3QX7NGvqN/+ZgFlneuk/j
         qKu85w+oGGi/WuR6fCkYpcp7a9yLJHUmYeYpWzG83F8qvX4d2ZuN6ZEsHP7T8NtoaZr7
         B0QFZft336oVYCZKLm63dKsdz4PM9lytFJbEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jX62hYlXM4T29dRY0Lhz3/dTJ0U8c8lvzJPQgJ+GgB7ZtGTVjDWA8yG1sJ4/EeA+eO
         3WvG5pebtc5FNspSljP7qiSb7c02FulyraDwZ1GROiy4ENjHwoF9su/CihaRlpKsGO4p
         alWZSRc83f6R+t9iBotUxrBzBycibh1x7QgNM=
Received: by 10.103.178.17 with SMTP id f17mr5844183mup.45.1228298857085;
        Wed, 03 Dec 2008 02:07:37 -0800 (PST)
Received: from localhost ([94.37.11.168])
        by mx.google.com with ESMTPS id 21sm11306789fkx.35.2008.12.03.02.07.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 02:07:35 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102237>

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
submission via gitweb. A hard limit (configurable, defaults to 100) is
imposed on the number of commits which will be included in a patchset,
to prevent DoS attacks on the server.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |   30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5a69a41..dbf414c 100644
--- a/Makefile
+++ b/Makefile
@@ -220,6 +220,7 @@ GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
+GITWEB_PATCH_MAX = 100
 
 export prefix bindir sharedir htmldir sysconfdir
 
@@ -1210,6 +1211,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
+	    -e 's|++GITWEB_PATCH_MAX++|$(GITWEB_PATCH_MAX)|g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2738643..10cbe93 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -87,6 +87,9 @@ our $projects_list = "++GITWEB_LIST++";
 # the width (in characters) of the projects list "Description" column
 our $projects_list_description_width = 25;
 
+# the maximum number of patches allowed in patch view
+our $patch_max = "++GITWEB_PATCH_MAX++";
+
 # default order of projects list
 # valid values are none, project, descr, owner, and age
 our $default_projects_order = "project";
@@ -503,6 +506,7 @@ our %actions = (
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
+	"patch" => \&git_patch,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5483,7 +5487,12 @@ sub git_commitdiff {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_param, $hash, "--"
 			or die_error(500, "Open git-diff-tree failed");
-
+	} elsif ($format eq 'patch') {
+		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
+			'--stdout', "-$patch_max",
+			$hash_parent ? ('-n', "$hash_parent..$hash") :
+			('--root', '-1', $hash)
+			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
 	}
@@ -5532,6 +5541,15 @@ sub git_commitdiff {
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
@@ -5553,6 +5571,11 @@ sub git_commitdiff {
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
 
@@ -5560,6 +5583,11 @@ sub git_commitdiff_plain {
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
