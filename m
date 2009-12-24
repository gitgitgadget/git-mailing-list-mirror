From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 0/6] transport: catch non-fast forwards
Date: Thu, 24 Dec 2009 15:40:05 +0800
Message-ID: <20091224154005.a642c8ec.rctay89@gmail.com>
References: <20091204125042.c64f347d.rctay89@gmail.com>,
 <20091204144822.a61355d2.rctay89@gmail.com>,
 <alpine.LNX.2.00.0912040153090.14365@iabervon.org>,
 <20091204102039.GB27495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiJ9-0004HX-IC
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbZLXHkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbZLXHkX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:40:23 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:46558 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbZLXHkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:40:22 -0500
Received: by ywh6 with SMTP id 6so8158040ywh.4
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=h56NvAVc/S5oqMyLJLr9rfA1hFM1oyUgVZzf90HJJmk=;
        b=gXt4NSKBkcPurp4NUhZ6UxqQ7wXPIBW8T9zxrmYm1yAYG95ea90/vqJfzKzuJbKt3F
         xt+c9CrB2zXYrZFzu2EiymJPEyUxXZsHdekUtu2G6MU5JUefZ1GzSshAAKY4ohWIvDxt
         fv9Tkyci3qrFuFESFXdKnBRCPUNeA8IydRC1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=DoOgysmGGsixbOCJ76YPzpy2/Gye/HoXUA2j5Jy5QgpM9HMCONst88sFmMlSyIoE9A
         JNLsmzRp/8/YbgnRlsck12Xmfjl0VANsXjT2DVRASCkgin7Y8SCs6DIMzGCci0/0yE09
         34EA82oqMJcKJXfBc942loYwnxxY4u4sTMTOs=
Received: by 10.90.8.38 with SMTP id 38mr1411832agh.14.1261640417263;
        Wed, 23 Dec 2009 23:40:17 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4245582gxk.10.2009.12.23.23.40.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:40:16 -0800 (PST)
In-Reply-To: <20091208223413.98e99d3e.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135644>

Junio, this is re-roll of the 'tr/http-push-ref-status' branch in 'pu'.

Summary:
  This patch series applies on top of 'next', and deals with alerting
  the user to rejected non-fast-forward pushes when using helpers
  (smart).

  Previously, git silently exited. This situation involves the curl
  helper and the smart protocol. The non-fast-forward push is only
  detected when curl executes the rpc client (git-send-pack). Now, we
  detect it before telling the helper to push.

Changes from v2:
 - add tests
 - modify commit messages to mention tests
 - report rejected non-fast-forward pushes for unmatched refs
   (without an explicit refspec) by the remote helper (see patches #2
   and #5).

   This remedies the scenario where a user would not be aware of
   rejected non-fast-forward pushes.

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

Tay Ray Chuan (6):
  t5541-http-push.sh: add tests for non-fast-forward pushes
  t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
  refactor ref status logic for pushing
  transport.c::transport_push(): make ref status affect return value
  transport-helper.c::push_refs(): ignore helper-reported status if ref
    is not to be pushed
  transport-helper.c::push_refs(): emit "no refs" error message

 builtin-send-pack.c  |   50 +++++++++++---------------------------------------
 remote.c             |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h             |    2 ++
 t/t5541-http-push.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c   |   32 ++++++++++++++++++++++----------
 transport.c          |   11 +++++++++--
 6 files changed, 137 insertions(+), 51 deletions(-)

--
Cheers,
Ray Chuan
