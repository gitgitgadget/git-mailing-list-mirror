From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] name-hash.c: always initialize dir_next pointer
Date: Tue, 01 Nov 2011 23:21:06 +0100
Message-ID: <4EB070D2.4040709@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLMi6-0003tj-Mz
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 23:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab1KAWVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 18:21:30 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:50901 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756071Ab1KAWV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 18:21:29 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id DC61CCDFA9
	for <git@vger.kernel.org>; Tue,  1 Nov 2011 23:21:37 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D6301130044;
	Tue,  1 Nov 2011 23:21:06 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B68B319F4B5;
	Tue,  1 Nov 2011 23:21:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184599>

Test t2021-checkout-overwrite.sh reveals a segfault in 'git add' on a
case-insensitive file system when git is compiled with XMALLOC_POISON
defined. The reason is that 2548183b (fix phantom untracked files when
core.ignorecase is set) added a new member dir_next to struct cache_entry,
but forgot to initialize it in all cases.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 You can also insert git config core.ignorecase true before the first
 test script in t2021 to see the segfault.

 I actually found the crash with an MSVC debug build, which has something
 like XMALLOC_POISON built-in.

 name-hash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 225dd76..d8d25c2 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -74,7 +74,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	ce->next = NULL;
+	ce->next = ce->dir_next = NULL;
 	hash = hash_name(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
-- 
1.7.7.1.586.ga0958b
