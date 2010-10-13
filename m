From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Fix bug in evaluate_path_info
Date: Wed, 13 Oct 2010 13:33:48 +0200
Message-ID: <20101013112738.9292.46672.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eli Barzilay <eli@barzilay.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 13:34:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5zbT-0006Ii-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 13:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab0JMLe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 07:34:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57158 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0JMLe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 07:34:26 -0400
Received: by bwz15 with SMTP id 15so3093409bwz.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=VcbeOOjpOs643CTJcLT4Uoa6E1UiE1S61tyjw3gRIfI=;
        b=nuCLiZY5aB/gARXGNUfIxmvsMNfdnYzN16HYjaurWpg+CUxTximUDTYaXeKa8vVSe5
         VzWhg86aMaP3707U1LzU9oetUVkXHrmJiMK63oIq1P8re6/tk8i6Mkppr3erOtAEDSWM
         V7Fj3xXo9UtYryOZNwDb+Dbi8XZYxbNmsRPvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=b/1pp2v5hHLNMIso+nJEZdrQZ2gvmU6YO+KncjV7mkNxkRemWmHDK3k9+zcnYH1b0S
         3ztHPB1c4OkvY7FDm/kqiLnW7RsNdCIpVub2BdAUn+EayddLfWaS005shKcoEWxgnJeR
         qs1zvhSRQwMqA1owRyEIT8/6RGWFykbwJTS+M=
Received: by 10.204.73.13 with SMTP id o13mr7364591bkj.173.1286969664971;
        Wed, 13 Oct 2010 04:34:24 -0700 (PDT)
Received: from localhost.localdomain (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id g12sm8489912bkb.14.2010.10.13.04.34.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 04:34:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9DBXmHH009417;
	Wed, 13 Oct 2010 13:34:01 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158928>

There was bug in parsing "project/:/file" and "project/:/" path_info
URLs, with implicit HEAD as 'hash_base'.

For such URLs the refname is empty, and before this fix regexp for
parsing path_info fragment assumed that it is always non-empty.

Refname cannot contain ':', as per 'git check-ref-format'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was detected by t9500-gitweb-standalone-no-errors test script,
but only after applying second patch in this series.

Unfortunately it is not easy to detect that gitweb generated correct
view; t9500 script only checks if Perl doesn't show any errors or
warnings.  That is why I have not added test for this issue (yet).

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 15b5bb9..9116a0e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -780,10 +780,10 @@ sub evaluate_path_info {
 		'history',
 	);
 
-	# we want to catch
+	# we want to catch, among others
 	# [$hash_parent_base[:$file_parent]..]$hash_parent[:$file_name]
 	my ($parentrefname, $parentpathname, $refname, $pathname) =
-		($path_info =~ /^(?:(.+?)(?::(.+))?\.\.)?(.+?)(?::(.+))?$/);
+		($path_info =~ /^(?:(.+?)(?::(.+))?\.\.)?([^:]+?)?(?::(.+))?$/);
 
 	# first, analyze the 'current' part
 	if (defined $pathname) {
