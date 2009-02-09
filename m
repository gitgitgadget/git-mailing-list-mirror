From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] Warn use of "origin" when remotes/origin/HEAD is
 dangling
Date: Mon,  9 Feb 2009 01:09:24 -0800
Message-ID: <1234170565-6740-6-git-send-email-gitster@pobox.com>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <1234170565-6740-4-git-send-email-gitster@pobox.com>
 <1234170565-6740-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:11:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAv-0004Zb-Ns
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbZBIJJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbZBIJJp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbZBIJJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B2212ABFD
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 999A42ABE6 for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:39 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-To: <1234170565-6740-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 61BB93E0-F689-11DD-948F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109056>

The previous one squelched the diagnositic message we used to issue every
time we enumerated the refs and noticed a dangling ref.  This adds the
warning back to the place where the user actually attempts to use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 5d0ac02..3bd2ef0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -268,16 +268,18 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 		char fullref[PATH_MAX];
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
+		int flag;
 
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref(fullref, this_result, 1, NULL);
+		r = resolve_ref(fullref, this_result, 1, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		}
+		} else if (flag & REF_ISSYMREF)
+			warning("ignoring dangling symref %s.", fullref);
 	}
 	free(last_branch);
 	return refs_found;
-- 
1.6.2.rc0.28.g2593d
