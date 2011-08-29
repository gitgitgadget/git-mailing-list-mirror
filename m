From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diff-index: pass pathspec down to unpack-trees machinery
Date: Mon, 29 Aug 2011 14:33:23 -0700
Message-ID: <1314653603-7533-4-git-send-email-gitster@pobox.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 23:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9Sb-00085Q-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab1H2Vdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:33:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755084Ab1H2Vdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:33:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B1047DE;
	Mon, 29 Aug 2011 17:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KFko
	tUAnVtz4KlFig8imT3r5Zqc=; b=pVpIgbWF7N1SdMyrIkd4DLIdc3Pe2UN5DOEz
	uv8sztgPZMq+YuR2sWGqpXwV6I9+2rFBzB6gyx8Mrix0/c+2Vutxvgc4Vnjvc2Wl
	aUaOwOy+NkyjiOuOueEQmb59zxhveQZiRwPeOACyCyzXslYdRPzPOc9dWvSQ6g+N
	xk8dVWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Hghr9ecGhoRyZjIWCcDBBA+wcZI9vhOncBneEs9AsaNWe+sB7Pm6eIraeJBTJ5IP
	9Qf43wCbAwdN5aDecaEN+zReaWtG/GxXUF7fgU8CWb4uKpF1I/VRinPjEkrrS1KC
	vXUX3aVfGPV664L9kbelzT79soCOVZ3rBHiZWC2xxh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F07947DD;
	Mon, 29 Aug 2011 17:33:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26BDB47D7; Mon, 29 Aug 2011
 17:33:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.70.g82660
In-Reply-To: <1314653603-7533-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A781958-D286-11E0-B12B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180361>

And finally, pass the pathspec down through unpack_trees() to traverse_trees()
callchain.

Before and after applying this series, looking for changes in the kernel
repository with a fairly narrow pathspec gets a moderate speeds up.

  (without patch)
  $ /usr/bin/time git diff --raw v2.6.27 -- net/ipv6 >/dev/null
  0.48user 0.05system 0:00.53elapsed 100%CPU (0avgtext+0avgdata 163296maxresident)k
  0inputs+952outputs (0major+11163minor)pagefaults 0swaps

  (with patch)
  $ /usr/bin/time git diff --raw v2.6.27 -- net/ipv6 >/dev/null
  0.01user 0.00system 0:00.02elapsed 104%CPU (0avgtext+0avgdata 43856maxresident)k
  0inputs+24outputs (0major+3688minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f8454dd..ebe751e 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -468,6 +468,7 @@ static int diff_cache(struct rev_info *revs,
 	opts.unpack_data = revs;
 	opts.src_index = &the_index;
 	opts.dst_index = NULL;
+	opts.pathspec = &revs->diffopt.pathspec;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
-- 
1.7.7.rc0.70.g82660
