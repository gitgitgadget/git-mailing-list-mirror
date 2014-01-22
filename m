From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] repack: accept larger window-memory and max-pack-size
Date: Wed, 22 Jan 2014 11:58:05 -0800
Message-ID: <1390420685-18449-3-git-send-email-gitster@pobox.com>
References: <1390420685-18449-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 20:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W63wQ-0007W5-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 20:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbaAVT6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 14:58:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851AbaAVT6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 14:58:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44F5A6437B;
	Wed, 22 Jan 2014 14:58:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=M+pE
	ChOZ3KjChPVMqujS+VW01ME=; b=FslAa2R35Ww9SkhOErxPlrPkwsdu9MVk5wEF
	G6EcO+X9COinx/tKizPpQe9xnveM8hcG5sknvra+kc8e3DsAqsYFRwl32VVSPENi
	OKrZuPOX4Xg+sJb0nvzahIC0HUG5bCuU8u5982yUNtEkcUKLQnfNzaRb7BIJp2RM
	dEww2qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DyJUYNApQzw58Iz8na9CnRI1TNtCgtlFmZWY+NwURT49XV4l7OkmalHkLgjQ3P5l
	HDmiFJidnYsTWysWjCc2+8hw5m4dfywcmLO2T8tSP3OsosJF/yhymwcJjnx9vaTn
	XfZl+bQ6Dbzu7fIewvPksR0IH1yioZCIxlUnN5w3/mI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 309096437A;
	Wed, 22 Jan 2014 14:58:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CEBE64379;
	Wed, 22 Jan 2014 14:58:20 -0500 (EST)
X-Mailer: git-send-email 1.9-rc0-151-ga5225c0
In-Reply-To: <1390420685-18449-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8AC79A56-839F-11E3-9573-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240848>

These quantities can be larger than an int.  Use ulong to express
them like the underlying pack-objects does, and also parse them with
the human-friendly unit suffixes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..8ce396b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -130,9 +130,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int pack_everything = 0;
 	int delete_redundant = 0;
 	char *unpack_unreachable = NULL;
-	int window = 0, window_memory = 0;
+	int window = 0;
 	int depth = 0;
-	int max_pack_size = 0;
+	unsigned long max_pack_size = 0, window_memory = 0;
 	int no_reuse_delta = 0, no_reuse_object = 0;
 	int no_update_server_info = 0;
 	int quiet = 0;
@@ -159,11 +159,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("with -A, do not loosen objects older than this")),
 		OPT_INTEGER(0, "window", &window,
 				N_("size of the window used for delta compression")),
-		OPT_INTEGER(0, "window-memory", &window_memory,
+		OPT_HUM_ULONG(0, "window-memory", &window_memory,
 				N_("same as the above, but limit memory size instead of entries count")),
 		OPT_INTEGER(0, "depth", &depth,
 				N_("limits the maximum delta depth")),
-		OPT_INTEGER(0, "max-pack-size", &max_pack_size,
+		OPT_HUM_ULONG(0, "max-pack-size", &max_pack_size,
 				N_("maximum size of each packfile")),
 		OPT_END()
 	};
@@ -187,11 +187,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (window)
 		argv_array_pushf(&cmd_args, "--window=%u", window);
 	if (window_memory)
-		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
+		argv_array_pushf(&cmd_args, "--window-memory=%lu", window_memory);
 	if (depth)
 		argv_array_pushf(&cmd_args, "--depth=%u", depth);
 	if (max_pack_size)
-		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
+		argv_array_pushf(&cmd_args, "--max_pack_size=%lu", max_pack_size);
 	if (no_reuse_delta)
 		argv_array_pushf(&cmd_args, "--no-reuse-delta");
 	if (no_reuse_object)
-- 
1.9-rc0-151-ga5225c0
