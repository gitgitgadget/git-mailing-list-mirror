From: newren@gmail.com
Subject: [PATCH] git-filter-branch: avoid collisions with variables in eval'ed commands
Date: Wed, 25 Mar 2009 15:13:01 -0600
Message-ID: <1238015581-12801-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com, pasky@suse.cz,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:15:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmaRz-0005mH-AS
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbZCYVOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbZCYVOT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:14:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:6117 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZCYVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:14:18 -0400
Received: by wf-out-1314.google.com with SMTP id 29so249615wff.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BL2MGlTs2CJdOkoqE4zk3ic5i2ocum1irv1/KLEnhNI=;
        b=Et+pPPQRYzre1oJSnIowxJItExQOxzYZMJHws/y87VVTZ4scGlIKbsZE9eITOSQ7+4
         lCBRuxtctFn9lPWvC1UraW3UOPb+xJEa+RyvdDYt1qjxusKcOdVk2zZ2OiCm4Y3wRFGV
         cJjV7YAboGXsLMZTS6IZk29suQbeJYKts4I9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fcPd2UtqgNeKbkPsg1DsRURkeGvL5AcGnt5+sypQEnn89e9qkBSzYq4qc89Y+DQKYu
         teBQ5RpAizuHy+wLKlVrvSzVkXN7m9AFfKAB3cG88L+3MRufV39AAsHYgcBK1YyB82tO
         7XpFD/3CA9Tvp/FoGRXS8MRrS0GipmLw+4O4Y=
Received: by 10.142.165.21 with SMTP id n21mr21031wfe.56.1238015656312;
        Wed, 25 Mar 2009 14:14:16 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id 29sm16601315wfg.53.2009.03.25.14.14.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 14:14:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.317.g3d051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114664>

From: Elijah Newren <newren@gmail.com>

Avoid using simple variable names like 'i', since user commands are eval'ed
and may clash with and overwrite our values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

I discovered this a few months ago, but apparently never got around to
sending it earlier.  Anyway, without this patch in a repository with a
file called 'world' I see the following behavior:

$ git filter-branch --tree-filter '
   for i in $(find . -type f); do
     if ( file $i | grep "\btext\b" > /dev/null ); then
       perl -i -ple "s/\\\$(Id|Date|Source|Header|CVSHeader|Author|Revision):[^\
\$]*\\$/\\$\1\\$/" $i;
     fi;
   done ' -- --all

Rewrite 7a78604e90b9debfaa6a755019b5d3df541abcba (1/6)/usr/bin/git-filter-branch
: line 249: ./world+1: syntax error: operand expected (error token is "./world+1
")


In case anyone is wondering: This isn't the right way to nuke CVS keywords.
It's a good start, but it'll miss a few files (particularly with older
versions of the 'file' program) due to some types such as 'FORTRAN program
source' not containing 'text'.  Also, it's incredibly slow to the point
that I dropped filter-branch entirely and wrote a 'git_fast_filter' helper
(serving as a pipe between fast-export and fast-import) that I'll soon be
making available.

 git-filter-branch.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 20f6f51..5da63b1 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -272,10 +272,10 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 # Rewrite the commits
 
-i=0
+git_filter_branch_count=0
 while read commit parents; do
-	i=$(($i+1))
-	printf "\rRewrite $commit ($i/$commits)"
+	git_filter_branch_count=$(($git_filter_branch_count+1))
+	printf "\rRewrite $commit ($git_filter_branch_count/$commits)"
 
 	case "$filter_subdir" in
 	"")
-- 
1.6.0.6
