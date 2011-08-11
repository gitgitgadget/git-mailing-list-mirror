From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/11] pack-objects --count-only
Date: Thu, 11 Aug 2011 10:53:08 -0700
Message-ID: <1313085196-13249-4-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZST-0000IQ-07
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab1HKRxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab1HKRx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8B44185
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OcTV
	ghqSVnPnl13yKhTR0MXhqi8=; b=EQf51iL0YZh6ZEpDwK7erRDsOR3EEpGX+ZUl
	9QJFWTdwj0yBGR+R7j6/PBWSyNttWXO2xgXUqtIhord5uMl3oJ8VIr7p3qYDDtNp
	F5KjYE6ynP3QcacyoETizLt9QF6Q8OlvCTU8v85/zCEZFEBjXKZxW79tJfdHO8vG
	Lxv6Ci4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UL54Iu
	IeK+Gs9lBBP3OMuo6JivKZ4/fSXJrI2MeMCVBcNSKPd9Kgcj5Uuek7A6WqOydbJL
	FSgAwcXv8LGw7rV3/3ol3yHk/WYiYbhHlcfd9Mc5WczqpVySLCtQ2o8MUXKd3oWc
	aV2fEjGsTpy+sjyv0mFwuoSOLiUJmwTDq/0WY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 146BF417D
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44800417B for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CE86324E-C442-11E0-8E19-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179125>

This is merely to help debugging the bottleneck of "Counting objects"
phase of the pack-objects process.  Use it like this:

git pack-objects --count-only --keep-true-parents --honor-pack-keep \
	--non-empty --all --reflog --no-reuse-delta \
	--delta-base-offset --stdout </dev/null >/dev/null

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f402a84..6a208a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2121,6 +2121,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	int all_progress_implied = 0;
+	int count_only = 0;
 	uint32_t i;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
@@ -2291,6 +2292,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			grafts_replace_parents = 0;
 			continue;
 		}
+		if (!strcmp("--count-only", arg)) {
+			count_only = 1;
+			continue;
+		}
 		usage(pack_usage);
 	}
 
@@ -2348,6 +2353,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (non_empty && !nr_result)
 		return 0;
+	if (count_only)
+		return 0;
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
-- 
1.7.6.433.g1421f
