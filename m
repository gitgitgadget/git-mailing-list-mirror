From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2] oneway_merge(): only lstat() when told to update worktree
Date: Thu, 20 Dec 2012 13:03:36 -0800
Message-ID: <1356037416-23527-1-git-send-email-martinvonz@gmail.com>
References: <7vk3sc4hle.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 22:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlnHg-0004Uo-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 22:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab2LTVDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 16:03:42 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:50328 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2LTVDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 16:03:40 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so409479ggn.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 13:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=ntbBu5TQ9zPJLR/Bf+d04a2XOiZYUkPZpdHVJLVh9cY=;
        b=MdvJDQaBSykl6Wxe/RLqMw8YE4NBlU/j/V5a1CEkp3HBAv0k1vQrkixPa5Z9wFtF39
         WnCCD1mPnpkP4iEZ66bM7r/GB1Pp/2+3yIx9JSeqPhJ5VCyFn6OF9q2KsBsWDzlEQL2H
         Rc4uKzspVqPrJJ/lLgYSSqoiUxVyoDwxo2SMaslydfZWwSzEsx/g9wWPMqxV2YAfXb6i
         ZA7VivRyR+LICIjrwRBqmDVqS6TmZErwg25Rd5W+bB0gihOqxRRakzVWyfMOydPYWbYN
         9NClIK+bD1WxJbw+Zsz2cvC3AcmzzRlBkOxgipy1D9bfnCDSZyyWmAoOKJwmFDIohp9p
         J+ow==
X-Received: by 10.101.139.18 with SMTP id r18mr1226342ann.26.1356037419675;
        Thu, 20 Dec 2012 13:03:39 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si848443yhe.4.2012.12.20.13.03.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 20 Dec 2012 13:03:39 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 3A81D100047;
	Thu, 20 Dec 2012 13:03:39 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id D66DF1024BA; Thu, 20 Dec 2012 13:03:38 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
In-Reply-To: <7vk3sc4hle.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkyhCTRQ/wsoOF5Vcv/ZBbr1T/L+DLtSlLt711o6kYHGawpaVfFOt1zmMYf/4vHWp/eKFwF9WV5gB1VCTHkmGGK4Fmt1t0m5tRrEizncjkq5FHnAJStidPZJeDZ45Bhk9I1M9cuzLsgPuaVidhKQ/oXfrDhQd7Cek1AeisoOeN/NzQSpS1KS1yl1/kDi5l6y56Dc+vG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211929>

Although the subject line of 613f027 (read-tree -u one-way merge fix
to check out locally modified paths., 2006-05-15) mentions "read-tree
-u", it did not seem to check whether -u was in effect. Not checking
whether -u is in effect makes e.g. "read-tree --reset" lstat() the
worktree, even though the worktree stat should not matter for that
operation.

This speeds up e.g. "git reset" a little on the linux-2.6 repo (best
of five, warm cache):

        Before      After
real    0m0.288s    0m0.233s
user    0m0.190s    0m0.150s
sys     0m0.090s    0m0.080s

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6d96366..61acc5e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1834,7 +1834,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && !ce_uptodate(old) && !ce_skip_worktree(old)) {
+		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
-- 
1.8.0.1.240.ge8a1f5a
