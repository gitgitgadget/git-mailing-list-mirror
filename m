From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/5] Progressing with `git submodule foreach_parallel`
Date: Wed, 26 Aug 2015 17:52:41 -0700
Message-ID: <1440636766-12738-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:53:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUlR4-0000IB-6e
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 02:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbbH0Awx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 20:52:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35940 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbH0Aww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 20:52:52 -0400
Received: by pacgr6 with SMTP id gr6so5085341pac.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DZ+5d08PN8dmF6nfjL2SxDA8dz6ZZyJTdNmgScphXsE=;
        b=Fks781KNla4V1cWvDKQzxevMwS1sPzBRqGeDLoF6liVeyyz0z6+QCHVPZftgnw8MVW
         sl0rpMObTyx0pzdhwi2O1hy2URFR9+yb4OcdGRyA4yzpI/IOXqX+aocRTt1MUy+vqxc/
         Y0SFNHHzUUSwSmPYDASgyFo0yx6IOW74YuYI+jMym9alqZfJ8RVTdLnAZW4I0ImyjFyW
         6iHrJOf7wFUB94crODF770xXNGIRa8r2nNSzwdOOxEHpJ2R6qSUHpvC8nLqWB71V1NU/
         nn7PnP9inDZPwJGHhZAfPmCoMD/NdoUCw36w8Rn/IdvQm8uJ8NKIJIV1mLsJazU8u2UC
         8Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DZ+5d08PN8dmF6nfjL2SxDA8dz6ZZyJTdNmgScphXsE=;
        b=iV6g26U4DLQZcIe1+kwVz56slfUC1DCDsuax4mbjrcyynUmfYd1Vdy8oUp8RT3tRtD
         4l0z1o/5Wv4tHkuCPYXzllSPYZo8I7eB2PfriALYCWV/Y1B3TWEdR/C8Zf1sKbBcyo2n
         CdGmQdq0w+fo5f11ZNqGvWhdc9qLbIgPfzcs8PhZxkGFE5ILDQ50G7nAWQ9yNrtLfej1
         O7axts5jlshNiL0BTfmrmNpM3oo8ovThdnz/dhE+YEcfIgA2aOs3EmAak/il27HkdpCb
         6edDjUzj/HoGdJ6Y1LKrShO25GBIZC3uGcnda6rxHJuYASQoMgygNT+vjE+bQwLBX/E4
         Ecag==
X-Gm-Message-State: ALoCoQntmk9ILK7yFQkcOd1lLaxe8JFtskZalK5jivAprT1RDaC8OcbMh1e6839c/UPh+ZNBnkTV
X-Received: by 10.68.98.34 with SMTP id ef2mr2249296pbb.45.1440636772124;
        Wed, 26 Aug 2015 17:52:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:806a:7c76:ca55:3bf1])
        by smtp.gmail.com with ESMTPSA id ev2sm289035pbb.37.2015.08.26.17.52.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 17:52:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g784836d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276650>

This series applies on top of 10d0bef9981c8045b8c9aac1ca7b8761896bed0c in
the branch origin/sb/submodule-helper

The first patch is a resend of module_clone, which now contains all
memory leak fixes. 

The second patch adding the new task queue is rewritten to not
use semaphores any more, but only mutexes and condition variables
as that's what we use at other places in the code base. So it is
better to align to these places, it makes the threading pool also
easier to understand internally.
Originally there were 2 semaphores to control the queue length
(0 < queue length < number of threads), such that we don't overallocate
memory, but rather slow down the thread adding new tasks to the queue.
This has been removed and the queue may grow infinitely large.

The third patch adding `git submodule foreach_parallel` learned a
totally different behavior how to interact with the output channels
(way better for human consumption as you have early feedback and
feedback all the time, ok-ish for machine consumption, but far from
perfect).

The fourth patch rewriting index-pack was made smaller and doesn't 
rewrite the workflow any more, but only plugs in the new threading
API instead of constructing the pthreads themselves.
I started benchmarking that patch, but I seem to get only bogus results,
so I cannot tell if it still makes it 2 % slower as Jeff claimed.

The fifth patch refactors pack-objects to be *way* more understandable IMHO!
It also switches to the new threading pool, but the refactor may be
suitable also if we decide to not use the threading API there.
The reason for it being more readable is the movement of the rebalancing
into the threads themselves, which then turns out to require a lot less
of locking and communication variables.

Any feedback is welcome!
Thanks,
Stefan

Stefan Beller (5):
  submodule: implement `module_clone` as a builtin helper
  thread-utils: add a threaded task queue
  submodule: helper to run foreach in parallel
  index-pack: Use the new worker pool
  pack-objects: Use new worker pool

 builtin/index-pack.c        |  23 ++--
 builtin/pack-objects.c      | 175 ++++++++----------------
 builtin/submodule--helper.c | 318 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  91 ++-----------
 run-command.c               |  29 ++--
 thread-utils.c              | 227 +++++++++++++++++++++++++++++++
 thread-utils.h              |  35 +++++
 7 files changed, 677 insertions(+), 221 deletions(-)

-- 
2.5.0.264.g784836d
