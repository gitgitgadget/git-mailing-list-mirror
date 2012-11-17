From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v4 0/5] push: update remote tags only with force
Date: Sat, 17 Nov 2012 14:16:32 -0600
Message-ID: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 21:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZop6-0007U8-P7
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 21:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab2KQUQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 15:16:50 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41760 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2KQUQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 15:16:49 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5173856iea.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=cGIU58jNzF7RXGMyoQ37kbmVEnNKbh0QlKNwSdp9G0s=;
        b=gmlbiVbphY/BEbNR6LvnDrB3dIDRNYNYhvwDCN/TtXK/L1rXa5DAmYNcanLo/LM6/S
         bWHWygIzK9lc+pDR7P6ygdNOZ6A6EQMOYxNPUKbw4VVDwvkVGeNRnbZfBFsY1buYbC03
         k77LTSHU4SeWXc3QAyQYtnbQq8FQghf/ozPK248xj8/Wb6dt3pxTBs5cuuCRkb9kfbVP
         ukohR6w3WSMyZCbz3h3DCepkUPEts/B/ve6z4JiY5IuC7SV6rPJVRPkhSzK3F2XRp8q9
         cKToqWyJyxPjObER8blfNXK1VO39iLNzX7wjuMT0LiV6LvRb9pUM0J9QYC5KjjSOhqRh
         4dCw==
Received: by 10.50.33.169 with SMTP id s9mr2755254igi.19.1353183408690;
        Sat, 17 Nov 2012 12:16:48 -0800 (PST)
Received: from marlin.localdomain (207-179-211-84.mtco.com. [207.179.211.84])
        by mx.google.com with ESMTPS id wm10sm3269004igc.2.2012.11.17.12.16.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 12:16:47 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209973>

This patch set can be divided into two sets:

  1. Provide useful advice for rejected tag references.

     push: return reject reasons via a mask
     push: add advice for rejected tag reference

     Recommending a merge to resolve a rejected tag update seems
     nonsensical since the tag does not come along for the ride.  These
     patches change the advice for rejected tags to suggest using
     "push -f".

  2. Require force when updating tag references, even on a fast-forward.

     push: flag updates
     push: flag updates that require force
     push: update remote tags only with force

     This is in response to the following thread:

       http://thread.gmane.org/gmane.comp.version-control.git/208354

     This solution prevents fast-forwards if the reference is of the
     refs/tags/* hierarchy or if the old object is not a commit.

These patches contain the following updates since the v3 set:

  * builtin/push.c: Remove "push --force" suggestion from advice.
  * remote.c: Only require old object to be a commit to be forwardable.
      I added the check for object types based comments from Peff in
      original thread, and I think this implementation is actually what
      he intended.  If the new object is a tag, the operation is not
      destructive so there is no reason to block it (at least within
      the scope of these changes) as was done in the previous iteration.
  * t/t5516-fetch-push.sh: Create separate tests for the lightweight and
      annotated cases.  Do the annotated tests outside of refs/tags/
      so that it actually tests different functionality.

Chris Rorvick (5):
  push: return reject reasons via a mask
  push: add advice for rejected tag reference
  push: flag updates
  push: flag updates that require force
  push: update remote tags only with force

 Documentation/git-push.txt | 10 +++++-----
 builtin/push.c             | 24 +++++++++++++++---------
 builtin/send-pack.c        |  9 +++++++--
 cache.h                    |  7 ++++++-
 remote.c                   | 46 ++++++++++++++++++++++++++++++++++++----------
 send-pack.c                |  1 +
 t/t5516-fetch-push.sh      | 30 +++++++++++++++++++++++++++++-
 transport-helper.c         |  6 ++++++
 transport.c                | 25 +++++++++++++++----------
 transport.h                | 10 ++++++----
 10 files changed, 126 insertions(+), 42 deletions(-)

-- 
1.8.0.155.g3a063ad.dirty
