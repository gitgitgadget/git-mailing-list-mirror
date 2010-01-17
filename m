From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] rerere: use ll_merge() instead of using xdl_merge()
Date: Sun, 17 Jan 2010 01:39:01 -0800
Message-ID: <1263721144-18605-6-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbw-0003v2-Ha
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab0AQJjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705Ab0AQJjb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab0AQJjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE3A9140E;
	Sun, 17 Jan 2010 04:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=P4Y9
	Lxlfuh3vdj3vu+mv1RKIb+Y=; b=OjAZMcZiEnhzhty+Ttpe7PeHb4B7Czeb6sOo
	XiiaHAqDN7yb2U8/OvV2dDcpCUvK1vtsU8tFybJsn9xNfmGlxeK65xOc8G4AWElp
	fshf9V1NzH0NA1eW3xsz6qEB3/P5B08VGGE8fRLQQBjN/wQ4MD9n7BO3OK0tK49n
	oP9ZWzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	otDchdr4NMpbnkDnl6/6tkxEaO0mYk93dph5kFX56LD93AG7n2zitu2b3mVpy6Ee
	blksHMcYdgcnZNrH1oiTT+KX3zL3LYI7VeF1cn53WiGtnwHjqLw5Z+BpVa+MFDTG
	KBaQOLCd9PU0ODWW+77rQTrxfWu1mGh6kKKd/mTadJI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16A069140D;
	Sun, 17 Jan 2010 04:39:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CB649140B; Sun, 17 Jan
 2010 04:39:16 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2EB7B502-034C-11DF-906B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137288>

This allows us to pay attention to the attribute settings and custom
merge driver the user sets up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index adb0694..5b8ebcb 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
 #include "rerere.h"
-#include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "dir.h"
 #include "resolve-undo.h"
@@ -332,7 +331,6 @@ static int merge(const char *name, const char *path)
 	int ret;
 	mmfile_t cur, base, other;
 	mmbuffer_t result = {NULL, 0};
-	xmparam_t xmp = {{XDF_NEED_MINIMAL}};
 
 	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
 		return 1;
@@ -341,8 +339,7 @@ static int merge(const char *name, const char *path)
 			read_mmfile(&base, rerere_path(name, "preimage")) ||
 			read_mmfile(&other, rerere_path(name, "postimage")))
 		return 1;
-	ret = xdl_merge(&base, &cur, "", &other, "",
-			&xmp, XDL_MERGE_ZEALOUS, &result);
+	ret = ll_merge(&result, path, &base, &cur, "", &other, "", 0);
 	if (!ret) {
 		FILE *f = fopen(path, "w");
 		if (!f)
-- 
1.6.6.405.g80ed6.dirty
