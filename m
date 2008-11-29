From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] gitweb: add patch view
Date: Sat, 29 Nov 2008 14:41:10 +0100
Message-ID: <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 14:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Q5e-0003L3-HM
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 14:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbYK2NlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 08:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbYK2NlD
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 08:41:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:8821 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYK2NlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 08:41:00 -0500
Received: by nf-out-0910.google.com with SMTP id d3so951066nfc.21
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XodNtRqJbrUC8mLEeH9v+P8Gi+OL/CgATYf5gsxPs04=;
        b=Z4MnlyAyyvE26i3SNVR5sEHZ9un/dpgUuywU7Cj8Eds9mTa9GypbEVpdh9yChL8+N0
         HJT2L0I8C7HUb7TMKY29NmwfaJpvzxn0dJUFFZicpkiSfrhCWMmv8adcVMGNT5HB53q9
         lX497EN4Vrsgx2vEfjUEgXvq5VgqkfsE3gJmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WCzxJ3yFuvjqXs/AGPIk9OeAD049YSljF0bmfuL7VVM5EpqBsMOpH/lTkMIA8lzjW4
         DM4dkjeNb+qjxpOieCdLXwz/mpxtGpXGm0MOAhuVv1CBFecPClO8A6KbnGNKU2RwjP1V
         NC8jT6H0Xa6J6K7unRtMEli7EoRHJHGTGp6po=
Received: by 10.103.218.19 with SMTP id v19mr3617650muq.46.1227966058367;
        Sat, 29 Nov 2008 05:40:58 -0800 (PST)
Received: from localhost ([78.13.52.113])
        by mx.google.com with ESMTPS id j10sm4097096mue.33.2008.11.29.05.40.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 05:40:57 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101912>

Trying to use 'commitdiff_plain' output as input to git am results in
some annoying results such as doubled subject lines. We thus offer a new
'patch' view that exposes format-patch output directly. This makes it
easier to offer patches by linking to gitweb repositories.
---
 gitweb/gitweb.perl |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..befe6b6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -485,6 +485,7 @@ our %actions = (
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
+	"patch" => \&git_patch,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5465,7 +5466,11 @@ sub git_commitdiff {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_param, $hash, "--"
 			or die_error(500, "Open git-diff-tree failed");
-
+	} elsif ($format eq 'patch') {
+		open $fd, "-|", git_cmd(), "format-patch", '--stdout',
+			$hash_parent ? "$hash_parent..$hash" :
+			('--root', '-1', $hash)
+			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
 	}
@@ -5514,6 +5519,14 @@ sub git_commitdiff {
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
@@ -5535,6 +5548,11 @@ sub git_commitdiff {
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
 
@@ -5542,6 +5560,11 @@ sub git_commitdiff_plain {
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
