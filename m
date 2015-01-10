From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Git::SVN: handle missing ref_id case correctly
Date: Sat, 10 Jan 2015 09:35:10 -0500
Message-ID: <1420900510-78522-1-git-send-email-artagnon@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:36:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9x8Z-0007VU-Kd
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 15:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbbAJOfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 09:35:30 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34550 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbbAJOf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 09:35:29 -0500
Received: by mail-qg0-f53.google.com with SMTP id l89so12736958qgf.12
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TppcNmsMwN/nzthL8wsCqwMX0H+QymZWtwnm1hB4ZaU=;
        b=GWdm2IolNHYXmhRGQqnsiyGfW9vrGlDWn0hHkqwYpPRCZ6Ide9U+EuS7m8Sd7BCAaE
         oiSQMYTAtXW8tUrnVVcbjrXBepdC6pGNq3+/xCeWYPXw/wUE5PlRKHjCDKNR1bOtjNpG
         sExIeJGiTsS9AKgDf/2S2ADCDINadzrX5E/Z3sZ/1v4InKVxUhT3aF3YfUK21XU8g2zK
         PT7XTbdM4e+XDSwFt78u6fxqDobMIEUqLIk0EzLx+T0FjSy6uoftmUVhB2egMlIfCMh5
         Y+P7qwxWRcM0La83G8uojZ/lVkH+TIH4b0yxPCahadbn7wbIvJ67IWCFUGbSOuSQYklf
         Q/Fg==
X-Received: by 10.140.108.9 with SMTP id i9mr33512696qgf.73.1420900528626;
        Sat, 10 Jan 2015 06:35:28 -0800 (PST)
Received: from localhost.localdomain (cpe-66-65-144-82.nyc.res.rr.com. [66.65.144.82])
        by mx.google.com with ESMTPSA id c63sm9783611qgf.47.2015.01.10.06.35.26
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jan 2015 06:35:28 -0800 (PST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262262>

$ENV{GIT_SVN_ID} will return a string, so check it with defined. Also,
ref_id should not match "refs/remotes/".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 perl/Git/SVN.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index d9a52a5..06ff216 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -40,7 +40,7 @@ BEGIN {
 our $_follow_parent  = 1;
 our $_minimize_url   = 'unset';
 our $default_repo_id = 'svn';
-our $default_ref_id  = $ENV{GIT_SVN_ID} || 'git-svn';
+our $default_ref_id  = defined $ENV{GIT_SVN_ID} ? $ENV{GIT_SVN_ID} : 'git-svn';
 
 my ($_gc_nr, $_gc_period);
 
@@ -2365,7 +2365,7 @@ sub _new {
 
 	# Older repos imported by us used $GIT_DIR/svn/foo instead of
 	# $GIT_DIR/svn/refs/remotes/foo when tracking refs/remotes/foo
-	if ($ref_id =~ m{^refs/remotes/(.*)}) {
+	if ($ref_id =~ m{^refs/remotes/(.+)}) {
 		my $old_dir = "$ENV{GIT_DIR}/svn/$1";
 		if (-d $old_dir && ! -d $dir) {
 			$dir = $old_dir;
-- 
2.2.1
