From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 0/7] was: long fast-import errors out "failed to apply delta"
Date: Thu, 28 Jul 2011 10:46:03 +0600
Message-ID: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRV-0004RA-HY
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab1G1EnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36852 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab1G1EnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:23 -0400
Received: by fxh19 with SMTP id 19so881708fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WnYo53qZq94qiIepFYmuUVNBNGVNAhW+l+TyEvVUDLE=;
        b=Pgi4iweurBoK0Tq0xlvbqH3x0Qef3GRBWUmnZfdvQQccY2mY9lyhqJN/vpPMCuASB1
         7qoIV7Bzt93OzKCiihK9bGg74SqBRou6r6D8h1oErYD8lvLaNJNpTDbpnNxTmI4ItDrF
         iVlhVW6AA+LS1rwmhzhO2G+4lWGNGPkVZk+OU=
Received: by 10.204.24.6 with SMTP id t6mr189892bkb.286.1311828201392;
        Wed, 27 Jul 2011 21:43:21 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178007>

A very short summary. It was found [1] that fast-import sometimes can produce
broken packfiles (sha1 mismatch) or even wrong packfiles (data differs
from what was expected). This happens mostly on not so tiny svn-to-git or
even cvs-to-svn-to-git imports with all these copying across the tree
(simulating tags/branches as a directories in git, for example). But I won't
be surprised if this can happen without these operations too.

Technically, fast-import has in-memory tree representation where it stores
sha1's of some previous tree states (to make delta on them), but when it comes
to producing the delta, old sha1's tree content is fetched from the in-memory
node and it's children (not via sha1->object lookup). And these can turn out
to be unrelated to each other as some operations changes the children's states.

The most wanted bit for these patches is small testcases. Keeping in mind all
the in-memory tree state and fast-import logic is hard for me, so I wasn't able
to create small tests (the best is [2] - 15M archive + custom git builds + fix the
Makefile in [2] + a few minutes to reproduce).
Another good todo is to always avoid base sha1's mismatch (not just to avoid 
corruption if it is detected). I think I can do this, but I won't be sure in 
the code unless there is a bunch of good tests, this series is quite big already.

[1] http://thread.gmane.org/gmane.comp.version-control.git/176753
[2] http://thread.gmane.org/gmane.comp.version-control.git/176753/focus=177901

Dmitry Ivankov (7):
  fast-import: extract object preparation function
  fast-import: be saner with temporary trees
  fast-import: fix a data corruption in parse_ls
  fast-import: fix data corruption in store_tree
  fast-import: extract tree_content reading function
  fast-import: workaround data corruption
  fast-import: fix data corruption in load_tree

 fast-import.c |  169 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 135 insertions(+), 34 deletions(-)

-- 
1.7.3.4
