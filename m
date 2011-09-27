From: David Barr <davidbarr@google.com>
Subject: [PATCH] refs.c: Fix slowness with numerous loose refs
Date: Tue, 27 Sep 2011 11:01:23 +1000
Message-ID: <1317085283-33943-1-git-send-email-davidbarr@google.com>
References: <CAFfmPPNCCCo=40CVvjRebXvkR7H_wh9+cz=tGxHZ1LtarE+w+A@mail.gmail.com>
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 03:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8M3X-0005rR-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 03:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab1I0BBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 21:01:51 -0400
Received: from smtp-out.google.com ([74.125.121.67]:30673 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab1I0BBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 21:01:50 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p8R11mbW024430
	for <git@vger.kernel.org>; Mon, 26 Sep 2011 18:01:48 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1317085309; bh=t8mC05RBqVsBMd2a/elPMWlIa4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
	b=OoXLvACpttIwkWTfsS+XwooQeBJACPaYfoJTzoWhIIHXf+nAdXEwoJUqb9TKLCVPf
	 B16HYo++BpaPlUY8sa4SQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references:x-system-of-record;
	b=xQB9HMmZ407FZqNDoNtfCoY5kukz61Y3x9en4QBWLV6JGY+Dzmr8PSbNftnlyLqKs
	TebdWJ66CjEkYTqPwrejg==
Received: from gyg8 (gyg8.prod.google.com [10.243.50.136])
	by wpaz24.hot.corp.google.com with ESMTP id p8R11Y8P010922
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Sep 2011 18:01:47 -0700
Received: by gyg8 with SMTP id 8so5837879gyg.6
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jslKuL5NJDtPZzH/j0GM02TCDFPahHof48s1UsOCaQw=;
        b=X6BfgVRk1cil/YkXkWa25aj3h5IKs2xIvmFUxFv1iJuC6vNA9jN+OI4X7CIbgS5MkG
         Qsd1ObTrKkI2pNf65eOw==
Received: by 10.236.187.36 with SMTP id x24mr43418550yhm.74.1317085307359;
        Mon, 26 Sep 2011 18:01:47 -0700 (PDT)
Received: by 10.236.187.36 with SMTP id x24mr43418533yhm.74.1317085307197;
        Mon, 26 Sep 2011 18:01:47 -0700 (PDT)
Received: from localhost.localdomain (davidbarr-macpro.syd.corp.google.com [172.23.4.51])
        by mx.google.com with ESMTPS id a35sm57036697ana.10.2011.09.26.18.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 18:01:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.75.g69330
In-Reply-To: <CAFfmPPNCCCo=40CVvjRebXvkR7H_wh9+cz=tGxHZ1LtarE+w+A@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182200>

Martin Fick reported:
 OK, I have found what I believe is another performance
 regression for large ref counts (~100K).

 When I run git br on my repo which only has one branch, but
 has ~100K refs under ref/changes (a gerrit repo), it takes
 normally 3-6mins depending on whether my caches are fresh or
 not.  After bisecting some older changes, I noticed that
 this ref seems to be where things start to get slow:
 v1.5.2-rc0~21^2 (refs.c: add a function to sort a ref list,
 rather then sorting on add) (Julian Phillips, Apr 17, 2007)

Martin Fick observed that sort_refs_lists() was called almost
as many times as there were loose refs.

Julian Phillips commented:
 Back when I made that change, I failed to notice that get_ref_dir
 was recursive for subdirectories ... sorry ...

 Hopefully this should speed things up. My test repo went from
 ~17m user time, to ~2.5s.
 Packing still make things much faster of course.

Martin Fick acked:
 Excellent!  This works (almost, in my refs.c it is called
 sort_ref_list, not sort_refs_list).  So, on the non garbage
 collected repo, git branch now takes ~.5s, and in the
 garbage collected one it takes only ~.05s!

[db: summarised transcript, rewrote patch to fix callee not callers]

[attn jch: patch applies to maint]

Analyzed-by: Martin Fick <mfick@codeaurora.org>
Inspired-by: Julian Phillips <julian@quantumfyre.co.uk>
Acked-by: Martin Fick <mfick@codeaurora.org>
Signed-off-by: David Barr <davidbarr@google.com>
---
 refs.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4c1fd47..e40a09c 100644
--- a/refs.c
+++ b/refs.c
@@ -255,8 +255,8 @@ static struct ref_list *get_packed_refs(const char *submodule)
 	return refs->packed;
 }
 
-static struct ref_list *get_ref_dir(const char *submodule, const char *base,
-				    struct ref_list *list)
+static struct ref_list *walk_ref_dir(const char *submodule, const char *base,
+				     struct ref_list *list)
 {
 	DIR *dir;
 	const char *path;
@@ -299,7 +299,7 @@ static struct ref_list *get_ref_dir(const char *submodule, const char *base,
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				list = get_ref_dir(submodule, ref, list);
+				list = walk_ref_dir(submodule, ref, list);
 				continue;
 			}
 			if (submodule) {
@@ -319,7 +319,13 @@ static struct ref_list *get_ref_dir(const char *submodule, const char *base,
 		free(ref);
 		closedir(dir);
 	}
-	return sort_ref_list(list);
+	return list;
+}
+
+static struct ref_list *get_ref_dir(const char *submodule, const char *base,
+				    struct ref_list *list)
+{
+	return sort_ref_list(walk_ref_dir(submodule, base, list));
 }
 
 struct warn_if_dangling_data {
-- 
1.7.5.75.g69330
