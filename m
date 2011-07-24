From: Jon Seymour <jon.seymour@gmail.com>
Subject: [RFC 0/9] bisect: allow git bisect to be used with repos containing damaged trees.
Date: Sun, 24 Jul 2011 15:57:45 +1000
Message-ID: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhu-0007mm-Vr
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1GXF6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab1GXF6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:08 -0400
Received: by pzk37 with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=X51JdHU9Tvr65L8NEXgR7lTl1Nq3qvX+Aw2cLcVQmNI=;
        b=OfrKKR7RVxxZb/NXS+aHFYvbRQgO9M576QVElE2m6+K1FBjsnsHl4sD+J6p+pqDZV/
         +D8iQdUqADCVSbqfP058XHpLA3TeL9b0YGqs6qym0+ZTq9npWw/BCD+NXZREa4yRVZcu
         fVSLFd1x0Dh4q8ZSHMEV9j1owXAlz9NUmF9TU=
Received: by 10.68.36.225 with SMTP id t1mr5268629pbj.8.1311487087460;
        Sat, 23 Jul 2011 22:58:07 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177717>

Currently git bisect assumes that the respository to be undamaged. This limits the usefulness
of git bisect when working with damaged repositories.

This series introduces an option, --ignore-checkout-failure, which can be used with 
"git bisect start" to indicate that checkout failures should be tolerated for the life
of the (new) bisection process. This allows git bisect to be used on damaged repositories. In
particular, it allows git bisect to be used to locate commits containing damaged trees.

If the --ignore-checkout-failure option is specified, then if git checkout fails either 
at the start of the bisection process or later while probing a new trial commit, then the 
checkout failure will be noisily ignored and the HEAD reference will be updated to the 
intended commit. This may leave the working tree and index in an inconsistent state
w.r.t the HEAD commit.

"git bisect reset" uses the same logic to restore the original HEAD reference. This allows
"git bisect reset" to work in circumstances where it might otherwise fail (for example, if 
the current HEAD contains a damaged tree).

Jon Seymour (9):
  bisect: add tests to document expected behaviour in presence of
    broken trees.
  bisect: introduce a --ignore-checkout-failure option to
    bisect--helper.
  bisect: implement support for --ignore-checkout-failure option
  bisect: introduce a helper function to tolerate checkout failures.
  bisect: replace existing calls to git checkout with
    bisect_checkout_with_ignore
  bisect: enable --ignore-checkout-failure in the porcelain.
  bisect: better diagnostics, in case of mis-typed option.
  bisect: add tests for --ignore-checkout-failure option.
  bisect: add documentation for --ignore-checkout-failure option.

 Documentation/git-bisect.txt |   13 ++++-
 bisect.c                     |   18 ++++++-
 bisect.h                     |    2 +-
 builtin/bisect--helper.c     |    8 ++-
 git-bisect.sh                |   36 +++++++++++--
 t/t6030-bisect-porcelain.sh  |  119 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+), 10 deletions(-)

-- 
1.7.6.347.g96e0b.dirty
