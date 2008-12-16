From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 2/3] gitweb: add patches view
Date: Tue, 16 Dec 2008 11:11:29 +0100
Message-ID: <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1229422290-6213-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 11:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCWvW-0001zn-Ah
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 11:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbYLPKLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 05:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYLPKLl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 05:11:41 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46170 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYLPKLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 05:11:40 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so3470952bwz.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 02:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2SPoFJUphsYtHGd2grRTQWeMw9pyow20+pbA1gVa0us=;
        b=ROlLsQKPmLEQ123OImGmxFRAFpYwDs1b+vAy0htmnyJ2la0XT8Kg6tINL4qVZn7RoB
         Tjd28bW7z7qBW0csSpP6iLMANcANaAJxXFOD8IdTsUT3Q8HBfk9uzl7I6paSUxGBLTHk
         V8yudl3u5az+DFcia26GmTjzHzxJhPfGZdVCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jHA1ZcQfSXYc+zCjIqDviJeghkcAwa8P73liplcB/OQumoON/vOQ660NwppX2KqBMi
         mrfyHEEk+qC9gE7Uf/Rx3jvxLQoYjPiPlPecKMYkzvh5bS2mIOVvOWz2erKxkk82gtcT
         OLslHfRp7vy5MD1aQRqI6dmPxFrGfOMXs0MPg=
Received: by 10.223.126.145 with SMTP id c17mr7669334fas.102.1229422298731;
        Tue, 16 Dec 2008 02:11:38 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id p9sm1492901fkb.34.2008.12.16.02.11.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Dec 2008 02:11:37 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229422290-6213-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103266>

The only difference between patch and patches view is in the treatement
of single commits: the former only displays a single patch, whereas the
latter displays a patchset leading to the specified commit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1006dfe..e7a6477 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -530,6 +530,7 @@ our %actions = (
 	"history" => \&git_history,
 	"log" => \&git_log,
 	"patch" => \&git_patch,
+	"patches" => \&git_patches,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5413,6 +5414,7 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+	my %params = @_;
 
 	my $patch_max;
 	if ($format eq 'patch') {
@@ -5529,7 +5531,15 @@ sub git_commitdiff {
 			}
 			push @commit_spec, '-n', "$hash_parent..$hash";
 		} else {
-			push @commit_spec, '-1', '--root', $hash;
+			if ($params{-single}) {
+				push @commit_spec, '-1';
+			} else {
+				if ($patch_max > 0) {
+					push @commit_spec, "-$patch_max";
+				}
+				push @commit_spec, "-n";
+			}
+			push @commit_spec, '--root', $hash;
 		}
 		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
 			'--stdout', @commit_spec
@@ -5625,6 +5635,10 @@ sub git_commitdiff_plain {
 
 # format-patch-style patches
 sub git_patch {
+	git_commitdiff('patch', -single=> 1);
+}
+
+sub git_patches {
 	git_commitdiff('patch');
 }
 
-- 
1.5.6.5
