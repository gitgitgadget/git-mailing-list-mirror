From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] pack-objects: never deltify objects bigger than window_memory_limit.
Date: Wed, 22 Sep 2010 03:25:05 -0700
Message-ID: <1285151105-32454-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, nico@fluxnic.net
X-From: git-owner@vger.kernel.org Wed Sep 22 12:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyMW2-0005P0-Bb
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 12:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab0IVKZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 06:25:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55008 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0IVKZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 06:25:24 -0400
Received: by pzk34 with SMTP id 34so72366pzk.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=iJJzD6c5Za1lG06Kv4pn16YCtCwtk/YkZ4h5KJUWIaw=;
        b=G8h6JGc3EftMser7x3CacxPKljWtukk3JsgOF0La0sRaSzzPelAbaSbeIfuyuezvKe
         sONpWz0Jhlfsaw0sbXZ8OAXMqMFTPu/EtweFDxt/G8MaL1DZyjl8zsSW/9rc5ozqph2z
         twGiQcgJzWlzccc73u2RLbPSNRn9A1x0dXB+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uPL8BQyz5HOCuCbYZQS/+MYuAQmCwcslrf7qZad7wX/+nII1X2D7hZ3tW7f/YeqowV
         JQJcwMjNnJS9omtinT+QzTYBi9jdr+bC/VXnFD1isMKNZ/w/lLXhY07tMfsoFXYzQxpd
         COUn72Um3TP1prqTSnhkUl+4O1qlNTotHqueo=
Received: by 10.142.47.12 with SMTP id u12mr10275575wfu.47.1285151123365;
        Wed, 22 Sep 2010 03:25:23 -0700 (PDT)
Received: from lean (d207-216-3-45.bchsia.telus.net [207.216.3.45])
        by mx.google.com with ESMTPS id 9sm12279657wfd.12.2010.09.22.03.25.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 03:25:22 -0700 (PDT)
Received: from apenwarr by lean with local (Exim 4.69)
	(envelope-from <apenwarr@apenwarr.local>)
	id 1OyMVq-0008SF-6z; Wed, 22 Sep 2010 03:25:18 -0700
X-Mailer: git-send-email 1.7.3.1.gca9d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156795>

With very large objects, just loading them into the delta window wastes a
huge amount of memory.  In one repo, I have some objects around 1GB in size,
and git-pack-objects seems to require about 8x that in order to deltify it,
even when the window memory limit is small (eg. --window-memory=100M).  With
this patch, the maximum memory usage is about halved.

Perhaps more importantly, however, disabling deltification for large objects
seems to reduce memory thrashing when you can't fit multiple large objects
into physical RAM at once.  It seems to be the difference between "never
finishes" and "finishes eventually" for me.

Test:

I created a test repo with 10 sequential commits containing a bunch of
nearly-identical 110MB files (just appending a line each time).

Without this patch:

    $ /usr/bin/time git repack -a --window-memory=100M

    Counting objects: 43, done.
    warning: suboptimal pack - out of memory
    Compressing objects: 100% (43/43), done.
    Writing objects: 100% (43/43), done.
    Total 43 (delta 14), reused 0 (delta 0)
    42.79user 1.07system 0:44.53elapsed 98%CPU (0avgtext+0avgdata
      866736maxresident)k
      0inputs+2752outputs (0major+718471minor)pagefaults 0swaps

With this patch:

    $ /usr/bin/time -a git repack -a --window-memory=100M

    Counting objects: 43, done.
    Compressing objects: 100% (30/30), done.
    Writing objects: 100% (43/43), done.
    Total 43 (delta 14), reused 0 (delta 0)
    35.86user 0.65system 0:36.30elapsed 100%CPU (0avgtext+0avgdata
      437568maxresident)k
      0inputs+2768outputs (0major+366137minor)pagefaults 0swaps

It apparently still uses about 4x the memory of the largest object, which is
about twice as good as before, though still kind of awful.  (Ideally, we
wouldn't even load the entire large object into memory even once.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 builtin/pack-objects.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..9f1a289 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1791,6 +1791,9 @@ static void prepare_pack(int window, int depth)
 		if (entry->size < 50)
 			continue;
 
+		if (window_memory_limit && entry->size > window_memory_limit)
+                	continue;
+
 		if (entry->no_try_delta)
 			continue;
 
-- 
1.7.3.1.gca9d1
