From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCHv3 0/2] merge-tree: fix (merge-base a b) b a
Date: Wed, 14 Jul 2010 18:04:05 +0100
Message-ID: <1279127047-3273-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 19:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5O7-0001yA-Ag
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab0GNREe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:04:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39342 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0GNREc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:04:32 -0400
Received: by wwi17 with SMTP id 17so2255027wwi.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KBoKHrWhDPyOGyvSC9VxZpWK4TPFRxFgN7BtUl3/eD8=;
        b=cyX1mQ43xWaywi9XAghTzpVgFlq4XTU58bTuDvVuhEhlc+XX0TBH+kf2KnqEXKMo/w
         NXNa8QCMtf1fAkF8lc+byK6QTIZWKedR9tNXCKyq7JuZ5YIimjrOitVMw6F44b76QDnN
         XLRPolYnGQeTnvferTt+BxN9Fw1CgUH/n5PtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OEx4zAObCHVTWQrhB3bmIduTPCgM32IvabuOsXSJzawe4m17iog2f46/vmmrjrfcKf
         6E3cz3RU5KQ761EMTKNz0yVW5CuXzb3BnHujHYxjeI+r8tHR1jwUkk+QnGra4t1ByW9I
         XAbm3elnhifjNiGvGr6au09B4xdIt/deDwJ18=
Received: by 10.227.136.80 with SMTP id q16mr16243383wbt.93.1279127065751;
        Wed, 14 Jul 2010 10:04:25 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id o11sm3259854wej.21.2010.07.14.10.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 10:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151013>

This series notes, then fixes, a regression introduced by
15b4f7a68d8c3c8ee28424415b203f61202d65d1 /
	merge-tree: use ll_merge() not xdl_merge()

I don't know the proper terminology to describe what's being fixed here.
This seems to most-easily be triggered by (for example):
	git merge-tree $(git merge-base HEAD @{u}) HEAD @{u}

In the git repository at the moment, this could be triggered with:
	git merge-tree $(git merge-base origin/next origin/master) \
		origin/next origin/master

Though as I write this, next has only just been merged with master, so
that is not the case. For an example which is less likely to go away,
try:
	git merge-tree c9eaaab4165d8f402930d12899ec097495b599e6 \
		be16ac8cc8ce693c6adf37b80db65d10a41b4eb9 \
		9918285fb10d81af9021dae99c5f4de88ded497c

It's actually very trivial to reproduce this, to the point where I
can't help but wonder how much merge-tree is actually being used. As
I narrowed the test-case more and more, I was surprised by how little
it took to trigger it. The first patch in this series includes some
very basic tests for merge-tree, the last of which demonstrates the
regression.

The second patch implements the trivial fix for it.

This is the third version of the patch. The first version of the patch
included very trivial tests for merge-tree, which were really only
intended to demonstrate the breakage being fixed. The second version of
the patch included proper tests, with real "expected vs actual"
testing, rather than dumb "did it return successfully?" checks. This
version of the patch escapes the HERE documents, since they didn't
require any expansions; joins up the remaining commands in && groups;
and fixes a couple of lines which went beyond column 80.


Will Palmer (2):
  add basic tests for merge-tree
  fix merge-tree where two branches share no changes

 builtin/merge-tree.c  |    3 +-
 t/t4300-merge-tree.sh |  257 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 259 insertions(+), 1 deletions(-)
 create mode 100755 t/t4300-merge-tree.sh

-- 
1.7.1.703.g42c01
