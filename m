From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Improve behavior for actionless path_info gitweb
	URLs
Date: Wed, 13 Oct 2010 13:35:20 +0200
Message-ID: <20101013113411.9292.43309.stgit@localhost.localdomain>
References: <20101013112738.9292.46672.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eli Barzilay <eli@barzilay.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 13:36:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5zco-0006n1-R3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 13:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab0JMLf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 07:35:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab0JMLf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 07:35:57 -0400
Received: by bwz15 with SMTP id 15so3094201bwz.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=zz9bSnIdpU1l4eHcA3YE4OCwYhg/u5EONgQGu01yc8w=;
        b=XKU/vgvdEPe3uXi9MoCKM+ORnhtYkvooZfmuECae2Jr1H6iJ8//RoBlL+Jg+sIgBg0
         6y/tQoyHH691T/gyb9d30Wk8UL4+10ELB4a7qNi1JR3QA8kGR14G15ARdia1l8rBeVDL
         MrRkrwsSrHscDDNR/ABlLJVC+1DfWkcbq1Hqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=doMrzDRk905qaKRqyUcQGPuF6fTKTS9cH5BzLc7iH81Hs9Vp3RfWVEEtNTDmHkVHQI
         AwSyTiKnDBx6zfuCU6M7jsS9YNknAx4xYQ2y1JCAOrszjb3rQ1ImVP2Ey2X4bZmbo8fO
         ibkqy1/3p+mO6ndZn+ghi3OJIBr6JtXXWZePI=
Received: by 10.204.52.77 with SMTP id h13mr7582406bkg.120.1286969754191;
        Wed, 13 Oct 2010 04:35:54 -0700 (PDT)
Received: from localhost.localdomain (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id g12sm8495153bkb.2.2010.10.13.04.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 04:35:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9DBZK6O009449;
	Wed, 13 Oct 2010 13:35:31 +0200
In-Reply-To: <20101013112738.9292.46672.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158930>

Eli Barzilay noticed that

  http://server/gitweb/project/<commit-sha1>

link goes to 'shortlog' view, while 'commit' view would be more
useful, but that 'shortlog' action is more apropriate for

  http://server/gitweb/project/<commit-sha1>..<other-commit-sha1>

links.


Therefore for the case when we don't have either action, or filename,
or parent hash [base] in path_info-based URL, i.e. for

  http://server/gitweb/project/<object-id>

link, instead of using 'shortlog' view we allow dispatch() subroutine
to detect type of object and use appropriate action (in most case it
would be either 'commit' action, or 'tag', or 'tree' for top
directory).

Requested-by: Eli Barzilay <eli@barzilay.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Tested-by: Eli Barzilay <eli@barzilay.org>
---
This is one-line (discounting comments and braces) alternative
solution to the one proposed by Eli in the

  http://thread.gmane.org/gmane.comp.version-control.git/150527

thread from 8 July 2010.

A side-effect of this patch was discovering (and fixing in previous
commit) long standing bug in corner case of path_info URLs parsing.

 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9116a0e..928b5c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -819,8 +819,15 @@ sub evaluate_path_info {
 		# hash_base instead. It should also be noted that hand-crafted
 		# links having 'history' as an action and no pathname or hash
 		# set will fail, but that happens regardless of PATH_INFO.
-		$input_params{'action'} ||= "shortlog";
-		if (grep { $_ eq $input_params{'action'} } @wants_base) {
+		if (defined $parentrefname) {
+			# if there is parent let the default be 'shortlog' action
+			# (for http://git.example.com/repo.git/A..B links); if there
+			# is no parent, dispatch will detect type of object and set
+			# action appropriately if required (if action is not set)
+			$input_params{'action'} ||= "shortlog";
+		}
+		if ($input_params{'action'} &&
+		    grep { $_ eq $input_params{'action'} } @wants_base) {
 			$input_params{'hash_base'} ||= $refname;
 		} else {
 			$input_params{'hash'} ||= $refname;
