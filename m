From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Don't sort ref_list too early
Date: Tue, 27 Sep 2011 01:00:09 +0100
Message-ID: <20110927000010.79913.71464.julian@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
	<9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
	<201109261539.33437.mfick@codeaurora.org>
	<201109261552.04946.mfick@codeaurora.org>
	<ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
	<7vsjnizxf5.fsf@alter.siamese.dyndns.org>
Cc: Martin Fick <mfick@codeaurora.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 02:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8LAk-0006uk-8X
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 02:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab1I0AFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 20:05:11 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:49950 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103Ab1I0AFK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 20:05:10 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id B5084C0602;
	Tue, 27 Sep 2011 01:05:09 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 9043336A7B8;
	Tue, 27 Sep 2011 01:05:09 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JEv0Det85Z4h; Tue, 27 Sep 2011 01:05:09 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [IPv6:2001:470:96a1:2:e2f8:47ff:fe26:e1cc])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 0E56C36A74D;
	Tue, 27 Sep 2011 01:05:09 +0100 (BST)
X-git-sha1: add19b18460bf3b80bffdfe13f08e6d0ea29f35d 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <7vsjnizxf5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182196>

get_ref_dir is called recursively for subdirectories, which means that
we were calling sort_ref_list for each directory of refs instead of
once for all the refs.  This is a massive wast of processing, so now
just call sort_ref_list on the result of the top-level get_ref_dir, so
that the sort is only done once.

In the common case of only a few different directories of refs the
difference isn't very noticable, but it becomes very noticeable when
you have a large number of direcotries containing refs (e.g. as
created by Gerrit).

Reported by Martin Fick.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

This time the typos are fixed too ... perhaps I wrote the original commit at 1am
too ... :$

 refs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index a615043..a49ff74 100644
--- a/refs.c
+++ b/refs.c
@@ -319,7 +319,7 @@ static struct ref_list *get_ref_dir(const char *submodule, const char *base,
 		free(ref);
 		closedir(dir);
 	}
-	return sort_ref_list(list);
+	return list;
 }
 
 struct warn_if_dangling_data {
@@ -361,11 +361,13 @@ static struct ref_list *get_loose_refs(const char *submodule)
 	if (submodule) {
 		free_ref_list(submodule_refs.loose);
 		submodule_refs.loose = get_ref_dir(submodule, "refs", NULL);
+		submodule_refs.loose = sort_ref_list(submodule_refs.loose);
 		return submodule_refs.loose;
 	}
 
 	if (!cached_refs.did_loose) {
 		cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
+		cached_refs.loose = sort_ref_list(cached_refs.loose);
 		cached_refs.did_loose = 1;
 	}
 	return cached_refs.loose;
-- 
1.7.6.1
