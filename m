From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] Git.pm: fix return value of config method
Date: Sun,  1 Jun 2008 22:34:47 +0200
Message-ID: <1212352487-12022-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 22:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2uHP-00056P-4Z
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 22:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYFAUew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYFAUew
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 16:34:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45050 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYFAUeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 16:34:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so573846fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=G64yCVMqnC4wvXREtGceocBt2tjOU1jTUxoEzarCgbg=;
        b=UAlKkCyFE7caR+TMcSbYB8fYexo6H/QPm09oG+6P5u3ZlsPG61fcs2VGneUka0XDIgts4teP6TUOeryR0v34bKsYFJ/+J1On9vG3s1hM/gZg4k3QhPJcma5sV3g4LEqcnk7UcwtBIJS3p3CLrOmcO+APXTRtRf4u2sz7XnqnVfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=bEitHEF1JrT2nCifp/NG/0OZsvFypCUomyTJKzyaBP4NucMM7IWOwptzMp7jus91uJv32p/uoh1rSZl8yqjHbm3XOb6pGD9XYsteY9quWFEY8uxAKLBRiahP5tenpU8mMV8+8iJcfDnogNZlyrOpYrafVWuqubRq+BmpWfPb3OI=
Received: by 10.86.52.6 with SMTP id z6mr5824590fgz.18.1212352489450;
        Sun, 01 Jun 2008 13:34:49 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id p9sm8187483fkb.9.2008.06.01.13.34.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 13:34:49 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2uGN-00038G-ES; Sun, 01 Jun 2008 22:34:47 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83465>

If config is called in array context, it is supposed to return all
values set for the given option key.  This works for all cases except
if there is no value set at all.  In that case, it wrongly returns
(undef) instead of ().  This fixes the return statement so that it
returns undef in scalar context but an empty array in array context.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Use the following command to test this:

perl -e 'use Git; $r = Git->repository("."); my @a = $r->config("nonexistent"); print scalar @a;'

This prints 1 before and 0 after applying this patch.

This will also be covered by the Git.pm test suite, which I'm
correctly working on.

 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 07b92c7..222fdbf 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -565,7 +565,7 @@ sub config {
 		my $E = shift;
 		if ($E->value() == 1) {
 			# Key not found.
-			return undef;
+			return;
 		} else {
 			throw $E;
 		}
-- 
1.5.5.GIT
