From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/12] merge: force edit mode when merging a tag object
Date: Mon,  7 Nov 2011 19:00:45 -0800
Message-ID: <1320721245-13223-13-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbwH-0001XL-7T
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab1KHDBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab1KHDBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C76652D;
	Mon,  7 Nov 2011 22:01:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=B9qz
	xrliJCs0XLGtwsYoMLRVRug=; b=jv/u+Uy8zkUJIc9h3IFyupbSz4bprfepwZST
	Y1+kRciaV1scUHC2xCmMZWAnUa+GEzBM7TgyaS5gFCErBMmgVVJ9m+FApv83ooFr
	N9CdIPm1ckfTjzvx6qDSYMdAdrfgw4thHWb0JfGKfOSh8momwNn/updam7drfq1f
	3VSGf2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Q3wrn7mNuUz+dR/KkfayVgwDwbRSbaV2hk/in/CbvmUn3bG0P+4UU0Hp2WbQoObl
	GbsMH3TvJS9KXiBekJnPWofjlyOin8pD/LID7Y6VWSvRJl7fL4KvR+qq0posj1ml
	W2Fx3T2Rv+HC9E+yAXNMMIu+KXKJxKco4c7I8ZEzWy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BF0C652C;
	Mon,  7 Nov 2011 22:01:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20714652B; Mon,  7 Nov 2011
 22:01:12 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EA3D081A-09B5-11E1-9E9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185059>

Now that we allow pulling a tag from the remote site to validate the
authenticity, we should give the user the final chance to verify and
edit the merge message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7158e8e..3b3e374 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1253,6 +1253,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    sha1_to_hex(commit->object.sha1));
 		setenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
+		if (merge_remote_util(commit) &&
+		    merge_remote_util(commit)->obj &&
+		    merge_remote_util(commit)->obj->type == OBJ_TAG)
+			option_edit = 1;
 	}
 
 	if (!use_strategies) {
-- 
1.7.8.rc0.128.g31aa4
