From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Move call to evaluate_git_version after
	evaluate_gitweb_config
Date: Sun, 26 Sep 2010 13:34:56 +0200
Message-ID: <20100926113431.28918.53550.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 13:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzpVs-0004uq-PI
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 13:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab0IZLfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 07:35:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56169 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482Ab0IZLfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 07:35:16 -0400
Received: by fxm3 with SMTP id 3so1371592fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=OW2lOgbaWJog7CpiDF1B0zpz+j6xFbZfZ0cOkqP+Ros=;
        b=AfBaLHjVSV1ILAoqFrywnFMORqPH+YhObT2guwHSFqcTGbLLHSWFKWXqAqWwztu75i
         UyFsB0LtwLOlGP0+qoizdSksvP4GmvTIIzLm6rMJnVosxN1khQA2CGEogEyRaN6qwy0H
         mLfRLH37IpEuiq53EMOoN2Cz4muL0x+sGnVVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=VzZwo4fupJqPp+2p37fFRNFdzOQPXkuyK4byN7raA7y3qUTd1b4YHkZ2Ea6Cc1ePYk
         Mb0n8ZIJXiXuTw2mwzvfyu/lhE8OVeYuIbrIrshDSMHL8+kXsWMP4iNFLWl8eA0EUdT8
         oPy5BfUs0wYF7/u0wR/a9z08U/DWLxW/sktTc=
Received: by 10.223.121.196 with SMTP id i4mr5899608far.66.1285500915207;
        Sun, 26 Sep 2010 04:35:15 -0700 (PDT)
Received: from localhost.localdomain (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id k25sm1892374fac.41.2010.09.26.04.35.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 04:35:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8QBYuW9028954
	for <git@vger.kernel.org>; Sun, 26 Sep 2010 13:35:07 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157220>

This means that call to evaluate_git_version() is now inside
run_request(), which means that is called for each request instead of
once per starting gitweb; this matter currently only when using
FastCGI interface (gitweb.fcgi).

This change was done becayse evaluate_git_version() uses $GIT
variable, which can be set / modified by gitweb config file... and it
is modified this way by gitweb config file used in gitweb tests.
Without this change there is spurious extra output from t9500 test
when tests are run with '--debug' option.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..d521b4c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1061,6 +1061,7 @@ sub run_request {
 
 	evaluate_uri();
 	evaluate_gitweb_config();
+	evaluate_git_version();
 	check_loadavg();
 
 	# $projectroot and $projects_list might be set in gitweb config file
@@ -1113,7 +1114,6 @@ sub evaluate_argv {
 
 sub run {
 	evaluate_argv();
-	evaluate_git_version();
 
 	$pre_listen_hook->()
 		if $pre_listen_hook;
