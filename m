From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] do not segfault if make_cache_entry failed
Date: Sun,  5 Oct 2008 06:14:40 +0400
Message-ID: <1223172881-4948-1-git-send-email-dpotapov@gmail.com>
References: <20081005004036.GO21650@dpotapov.dyndns.org>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 04:16:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmJA8-0005Yy-Dm
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 04:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYJECOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 22:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYJECOu
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 22:14:50 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:12238 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYJECOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 22:14:49 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1785854muf.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1TraU1/nhdF6daNUcq58vA7N8dJyBVDuD01JafHpaXM=;
        b=tJZQCXHyDASfAPQKIBNX9XrzbUQcZ9v3q7/7LHnRgkHqEevtNxpRE0E7W6Sq+9Ll7s
         GIufzIo/kCYS6jECBy9koHwlw2CAFzFbxWeH7jkFiP2RO8jN8pjH+AigLIZGR0CMxUr5
         N2O2fPVmDOXDfdOZ6Zp5uBdBR3cFS7ZbTcF/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z64CFCNMwER4kJw5UstJFOTrX72KygLu3m7HED6WTsoLedPZ5pkcZd04VtFeTXlxxP
         VgJHJ3oCxhZoUVFd19Pghkc4CLnAO5XPvxNu/EavbDNV2XO00V1qKdqyoNudFcvvb2fo
         joPidPjxC2qZursC8QsA93oQlbBREz6Ubytws=
Received: by 10.103.240.15 with SMTP id s15mr1813931mur.23.1223172885952;
        Sat, 04 Oct 2008 19:14:45 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id u26sm8065614mug.5.2008.10.04.19.14.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 19:14:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <20081005004036.GO21650@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97492>

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-apply.c    |    2 ++
 builtin-checkout.c |    2 ++
 builtin-reset.c    |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e2c611b..342f2fe 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2586,6 +2586,8 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			sha1_ptr = sha1;
 
 		ce = make_cache_entry(patch->old_mode, sha1_ptr, name, 0, 0);
+		if (!ce)
+			die("make_cache_entry failed for path '%s'", name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
 			die ("Could not add %s to temporary index", name);
 	}
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b572b3b..3762f71 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -206,6 +206,8 @@ static int checkout_merged(int pos, struct checkout *state)
 	ce = make_cache_entry(create_ce_mode(active_cache[pos+1]->ce_mode),
 			      sha1,
 			      path, 2, 0);
+	if (!ce)
+		die("make_cache_entry failed for path '%s'", path);
 	status = checkout_entry(ce, state, NULL);
 	return status;
 }
diff --git a/builtin-reset.c b/builtin-reset.c
index c24c219..16e6bb2 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -121,6 +121,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			struct cache_entry *ce;
 			ce = make_cache_entry(one->mode, one->sha1, one->path,
 				0, 0);
+			if (!ce)
+				die("make_cache_entry failed for path '%s'",
+				    one->path);
 			add_cache_entry(ce, ADD_CACHE_OK_TO_ADD |
 				ADD_CACHE_OK_TO_REPLACE);
 		} else
-- 
1.6.0
