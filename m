From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 0/2] Fix spurious conflicts with pull --rebase
Date: Thu, 12 Aug 2010 19:50:48 -0600
Message-ID: <1281664250-2703-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, santi@agolina.net,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 03:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjjIK-0002ek-IU
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab0HMBmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 21:42:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59135 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0HMBmp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 21:42:45 -0400
Received: by ywh1 with SMTP id 1so678055ywh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=yXhcHcrDOB2M/S6bHAplUqraBun14JiNAHyLwJnWzoQ=;
        b=XeJnXvO4yHyWvVQ4bmstDh17dyP7TxBNNqoTHfHMgyeR9HuCWiRg3M2uzoauX/k71v
         mTvm/xMwZlnEIc0REIc26PppMi7DLgAYI61K6i4s5vG3r0abRIaMSy/b447ZDJXqCxzT
         NF81ZGEzWbOUOIkbDFacLKiejJfZkAROeBS9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=SsIwzkC0ejY9MJi28pwtiKFgK5Ikq3FyKDD2co1gNWucE5VypB8QCnJLNJw6Chy5Lt
         xp7st6f77V6NpdQqX3n87kKX9tVheanH++W/457pvguw4BZinF1l+b+GEKf1E2+TYKYA
         OGXj9EqjeiAIlwYuaQMbkIUd4/dtCvz6YDECw=
Received: by 10.231.161.80 with SMTP id q16mr760203ibx.142.1281663764508;
        Thu, 12 Aug 2010 18:42:44 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id j2sm607195iba.12.2010.08.12.18.42.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 18:42:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.43.gbae63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153452>

Changes since v4
  * Added a little bit of detail to the commit log about cases when
    the change can affect
  * Fixed issue pointed out by Santi with moving 12 lines of code (to
    bring definition of oldupstream variable together); the different
    pieces had important reasons for being where they were.
Changes since v1
  * Changes above, plus other commit log wording changes and lots of
    style and formatting issues for the testcase

This patch series fixes spurious conflict issues with git pull
--rebase for the case where the upstream repository is *not* rebased.
(There is no change in the case where the upstream repository is
rebased.)

In cc85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26) and d44e712 (pull: support rebased upstream +
fetch + pull --rebase, 2009-07-19), the call to git-rebase was
modified in an effort to reduce the number of commits being reapplied,
by trying to avoid commits that upstream already had or has.  It was
specifically designed with an upstream that is rebased in mind.
Unfortunately, it had two side effects for the non-rebased upstream
case: (1) it prevented detecting if "local" patches are already
upstream, and (2) it could in some cases cause more patches known to
be upstream to be reapplied rather than less.  This series fixes both
of these issues for the non-rebased upstream case.  See the commit
message of the second patch for details.

It's worth noting that issue (1) above also affects the case where the
upstream repository has been rebased, which this patch series does not
address.  As far as I can tell, fixing it would require changes
(including new syntax) to format-patch to allow it to be told what
'upstream' is, and some changes to git-pull.sh/git-rebase.sh to pass
it this information.

Elijah Newren (2):
  t5520-pull: Add testcases showing spurious conflicts from git pull
    --rebase
  pull --rebase: Avoid spurious conflicts and reapplying unnecessary
    patches

 git-pull.sh     |    9 ++++++++
 t/t5520-pull.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

-- 
1.7.2.1.43.gbae63
