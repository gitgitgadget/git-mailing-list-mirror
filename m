From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix overstrict :<path> diagnosis
Date: Tue, 10 May 2011 11:10:30 -0700
Message-ID: <7vhb92jujt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 20:10:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJrOQ-00083l-Ny
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 20:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab1EJSKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 14:10:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab1EJSKi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 14:10:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C09AA4DB7;
	Tue, 10 May 2011 14:12:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	RNDEhZ/XXeHO85+vxE6YR5uNvU=; b=mLBVh9+M/j71puxFbP6FtXy2AYmFVOuXL
	MSSJ1BsGAAgb12eUq3qAwfP7swZ7s8W2l322mup0U1nlsdGORzfuzOjo7Tzue3XC
	2467rOYqLbdSZf+UAumSooWSdHkwb0VvMSc5BZBfYYm8ZVRLnX2Pq3OrLrcny/Gm
	IwnrgrsIDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=EM+zOVo3/sKCzaa6/rsIyNt5mZYfU4Q4d8Wsam+oz3RTl6C4S/leAq2z
	tl1aLpd67fjCntqDaJkJJ4BfxPmMkm7AdsNeEA17nRIFylb9n1RRb2cQak7DZIRB
	RmhqYC5L2uwydEyXj59H+hUBfiTkl9QodzF4wEZlST3indBZ4Ao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EC7E4DB5;
	Tue, 10 May 2011 14:12:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B8A234DB4; Tue, 10 May 2011
 14:12:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17E4C1FE-7B31-11E0-AE1C-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173344>

Given "git log :", we get a disambiguation message that tries to be
helpful and yet totally misses the point, i.e.

    $ git log :
    fatal: Path '' does not exist (neither on disk nor in the index).
    $ git log :/
    fatal: Path '/' exists on disk, but not in the index.

An empty path nor anything that begins with '/' cannot possibly in the
index, and it is wrong to guess that the user might have meant to access
such an index entry.

It should yield the same error message as "git log '*.c'", i.e.

    $ git log '*.c'
    fatal: ambiguous argument '*.c': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I actually think the message should say

 	fatal: ambiguous argument '*.c': neither a rev nor a path.
        Use '--' to separate pathspec from revisions.

   for brevity, but that is a separate topic.

 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index faea58d..90d8bfa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1173,7 +1173,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			}
 			pos++;
 		}
-		if (!gently)
+		if (!gently && name[1] && name[1] != '/')
 			diagnose_invalid_index_path(stage, prefix, cp);
 		free(new_path);
 		return -1;
