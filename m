From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge-recursive: Do not look at working tree during a
 virtual ancestor merge
Date: Fri, 23 Sep 2011 15:29:54 -0700
Message-ID: <7vzkhusxi5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 00:30:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7EFv-00012v-Hp
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 00:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690Ab1IWW35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 18:29:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab1IWW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 18:29:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8D1F47D6;
	Fri, 23 Sep 2011 18:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	21bxVZW/G5Q6ZiiqG+BABhPqsA=; b=FeMLZNaqvyFR/B26Sa1F+wsVySF5qaOa8
	W3pqn1lIlRyoQ3KS5XV/vNWWUXsZ6TxK/z1qGkG9PSbaoRFTNGIFuxf6FAhP4iJW
	ziMYg0blLL8fFBfX6x8GkUiPQWr4YCYDjprMrj33cmHSdnDEUf72OQlAwqz5gOJ5
	unRY+LdLGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=u5gP20qgZe63r5Sz7V45RkubRo+YLQID3D8yPuas1UpDDM2u+xdNZYFw
	nZwqDXaKBWHs1miA7LGu40n/PONwEBtCVE1qllEfyTGRkkfoaSVMx+j/wya0HZva
	nWLnQ3ND/PbNcwh1roK+ZHjm36XFxVRYLPS9LkJWJ4PmPHxdIQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0FB847D5;
	Fri, 23 Sep 2011 18:29:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36F2E47D4; Fri, 23 Sep 2011
 18:29:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9073F794-E633-11E0-878A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182009>

Fix another instance of a recursive merge incorrectly paying attention to
the working tree file during a virtual ancestor merge, that resulted in
spurious and useless "addinfo_cache failed" error message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The regression this fixes was seen while I was preparing a merge of
   maint (soon to become 1.7.6.4) back to master (I cannot write "soon to
   become 1.7.7" because I want to cook the fix at least for a few days)
   today.

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6bbc451..3efc04e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1627,7 +1627,7 @@ static int merge_content(struct merge_options *o,
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
 			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
+				      0, (!o->call_depth), 0);
 			return mfi.clean;
 		}
 	} else
-- 
1.7.7.rc2.4.g5ec82
