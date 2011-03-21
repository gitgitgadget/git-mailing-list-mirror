From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] update $GIT_INDEX_FILE when there are racily clean
 entries
Date: Mon, 21 Mar 2011 10:18:19 -0700
Message-ID: <7voc54qtmf.fsf@alter.siamese.dyndns.org>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
 <7vipvcs9xt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lasse Makholm <lasse.makholm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 18:19:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ilE-0008Ly-AO
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab1CURTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:19:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1CURTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED45A4DB3;
	Mon, 21 Mar 2011 13:20:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=UMTxCsnRb2U6FHGGwNLmEvV5T/0=; b=AqKzpFIDMP4GXUScsT3l
	Y3s97TDi15YoPRvnK3HVQGAwBHW0uLOaGHRtnvhHJsZD6kWaoadMa7iF57q1D8Kn
	YFH117cGzbRVjG0ArEtBnNB62yB1uGt02JShjuqMdLvppfWBZdcYxB/O/0jYcTYQ
	RQRua6PNSDGimj+XJakRRnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fDXQr6IQ+eBELgBAX9z+UUfH+orX2vnmz76NxjvYh6g8K5
	cfhGOByMPL2j+vtl5fDDQFlluqEyuVLnxNOytCRPBwSmZjFHrpMeFCjiOOWuEBOW
	Zzwp2DMRrVu6NPwHkLcWEMBZEtA3xaGI1/1lr8ndn6xssSZcD0hdJImgcJCSw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CABA24DB1;
	Mon, 21 Mar 2011 13:20:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C62814DAC; Mon, 21 Mar 2011
 13:20:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F4364C2-53DF-11E0-801E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169614>

Traditional "opportunistic index update" done by read-only "diff" and
"status" was about updating cached lstat(2) information in the index for
the next round.  We missed another obvious optimization opportunity to
when there are racily clean entries that will ceas to be racily clean
by updating $GIT_INDEX_FILE.

Noticed by Lasse Makholm by stracing "git status" in a fresh checkout and
counting the number of open(2) calls.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 561dc66..971e277 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1545,12 +1545,25 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 	return result;
 }
 
+static int has_racy_timestamp(struct index_state *istate)
+{
+	int entries = istate->cache_nr;
+	int i;
+
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (is_racy_timestamp(istate, ce))
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Opportunisticly update the index but do not complain if we can't
  */
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
-	if (istate->cache_changed) &&
+	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
 	    !write_index(istate, lockfile->fd))
 		commit_locked_index(lockfile);
 	else
-- 
1.7.4.1.554.gfdad8
