From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 3/4] gitweb: add patches view
Date: Thu, 18 Dec 2008 08:13:18 +0100
Message-ID: <1229584399-23879-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1229584399-23879-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1229584399-23879-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1229584399-23879-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 08:15:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDD66-0007LV-PH
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 08:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbYLRHNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 02:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbYLRHN3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 02:13:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:15163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbYLRHN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 02:13:27 -0500
Received: by fg-out-1718.google.com with SMTP id 19so119795fgg.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 23:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QtpuifmEgihP2MTuRTqT1OAZcOBue0AcJKTTKp3Q/Vc=;
        b=AF9qjWSs594/irNGXyHpA8RHxWFc0suXQ7z3aV7gjZT/ZdlPFVgGN8LLBR/FB6sO/V
         o8kFZ6E1L4agIVnRJel8hrKfTC2w1Bz47vf8lLCGqnWxkFD0hqOzaE9c1YORaMIqlL/D
         6AUjOfsLqowdsgbJzVtL4dxGTXSyN/SCnw89E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aMjszo7i6gmGLTJ3EBhIRxvrjMg8WSIo0iUNU/EFx01YSCgrrAACL9ZtmrYF900a/I
         I8iqKm8z55l/HY+qi/kscKN38j/HGrdk+lIld3D3yAmkaTImQy3M2mLPrdCl0V6F0ju+
         aan22ydCmarqXahgVTTAZ35HFOuombWzP9NYU=
Received: by 10.86.3.4 with SMTP id 4mr930728fgc.44.1229584405887;
        Wed, 17 Dec 2008 23:13:25 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id d4sm4162907fga.41.2008.12.17.23.13.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Dec 2008 23:13:25 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229584399-23879-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103440>

The only difference between patch and patches view is in the treatement
of single commits: the former only displays a single patch, whereas the
latter displays a patchset leading to the specified commit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 18d43e7..78aaebe 100755
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
@@ -5530,7 +5531,15 @@ sub git_commitdiff {
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
@@ -5626,6 +5635,10 @@ sub git_commitdiff_plain {
 
 # format-patch-style patches
 sub git_patch {
+	git_commitdiff(-format => 'patch', -single=> 1);
+}
+
+sub git_patches {
 	git_commitdiff(-format => 'patch');
 }
 
-- 
1.5.6.5
