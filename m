From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 0/6] transport: catch non-fast forwards
Date: Fri,  8 Jan 2010 10:12:39 +0800
Message-ID: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
References: <20091224154005.a642c8ec.rctay89@gmail.com>, <20091204125042.c64f347d.rctay89@gmail.com>, <20091204144822.a61355d2.rctay89@gmail.com>, <alpine.LNX.2.00.0912040153090.14365@iabervon.org>, <20091204102039.GB27495@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:13:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Lk-0005Gi-B4
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0AHCNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195Ab0AHCNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:09 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49270 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab0AHCNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:08 -0500
Received: by ywh6 with SMTP id 6so19094895ywh.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:references;
        bh=W2EELTL631qG6x29FDn/W5yP/+FQvInxvQVYa3ZbA0Q=;
        b=dpj8z/8KyLJ3HJjCab8a8uTe7apPrTcQ2Q3AVgwJU9aHo/4YxpUSHOhHNM5jjem5gu
         leL+pChAelumDSoEwZH4lAk+RK1AAhHOVYUPusM2S/eVel6WjcJ4JiHQbMOIenskvgsS
         7F2QsfRj3W3A7eWyEMg0ggWBZWYUUXOdyj9vY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:references;
        b=x5TcwITDNIj7PNFgPO7JegdjqRPSboVWImsGImugTZmbSjB9NTrCJvEjF73Yoysyjc
         S5NT6kRJyETh/MwoF3cDybi2X/rhnaKlnXU8Csr3WyycUfIuuGIdyn9UzLtml10pcOc5
         37yXvs4dy8zc8mBZRdW83bqX77NzFYk+B27xk=
Received: by 10.90.37.13 with SMTP id k13mr2518599agk.101.1262916787046;
        Thu, 07 Jan 2010 18:13:07 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:06 -0800 (PST)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136405>

Junio, this is re-roll of the 'tr/http-push-ref-status' branch in 'pu'.

Jeff, please don't see this re-roll as me assuming you gave your go-
ahead for the latest discussion; I didn't, I thought squashing in the
hunks I mentioned would make things easier for you, rather than having
them floating around.

Summary:
  This patch series applies on top of 'next', and deals with alerting
  the user to rejected non-fast-forward pushes when using helpers
  (smart).

  Previously, git silently exited. This situation involves the curl
  helper and the smart protocol. The non-fast-forward push is only
  detected when curl executes the rpc client (git-send-pack). Now, we
  detect it before telling the helper to push.

  The series also remedies the scenario where a user would not be aware
  of rejected non-fast-forward pushes.

  It occurs when
    1) there are one or more pushes that succeed and
    2) there are one or more rejected non-fast-forward pushes that
	   involve refs that cannot be matched without explicit refspecs.

  This is due to the re-marking of ref status in transport-helper.c::
  push_refs() when interacting with the remote helper.

  If only non-matched, non-fast-forward refs are involved (ie.
  condition #2 is present without #1), then the situtation does not
  occur - no 'push' commands are passed to the remote helper, no
  interaction with the helper takes place, and no re-marking of ref
  status takes place. The user will be alerted to the rejected
  non-fast-forward push.

  If both are present, re-marking occurs. Even if a ref was not part
  of a 'push' command to the helper, 'ok'/'error' status reports might
  be made for it, since the remote helper does ref matching on its
  side. This led to refs that cannot be matched without an explicit
  refspec marked as REF_STATUS_REJECT_NONFASTFORWARD to be re-marked
  REF_STATUS_NONE.

  (Note: helpers fail to match refs as explicit refspecs are always
  available to the top-level transport mechanism, but only on a need-
  to-know basis to the remote helper via a 'push' command when a ref
  is to be pushed.)

  Interestingly, it is possible for a user to be forever unaware of
  the rejected push if the user relies on information from git push
  alone. As long as the user ensures that one or more other pushes are
  successful (eg. change a tracked ref fast-forwardedly) between the
  execution of git push, the rejected non-fast-forward push won't be
  reported.

Changes from v3:
 - reworded commit message for the test in patch 2
 - added comment on what the switch block is checking for in patch 3
 - changed condition under which ref status reported by remote helper
   is ignored in patch 5

Tay Ray Chuan (6):
  t5541-http-push.sh: add tests for non-fast-forward pushes
  t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
  refactor ref status logic for pushing
  transport.c::transport_push(): make ref status affect return value
  transport-helper.c::push_refs(): ignore helper-reported status if ref
    is not to be pushed
  transport-helper.c::push_refs(): emit "no refs" error message

 builtin-send-pack.c  |   51 +++++++++++--------------------------------------
 remote.c             |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h             |    2 +
 t/t5541-http-push.sh |   44 +++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c   |   28 +++++++++++++++++++-------
 transport.c          |   11 ++++++++-
 6 files changed, 137 insertions(+), 49 deletions(-)
