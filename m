From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] describe: use argv-array
Date: Sun,  7 Jul 2013 15:33:43 -0700
Message-ID: <1373236424-25617-4-git-send-email-gitster@pobox.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:34:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxWw-00050T-UK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab3GGWd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:33:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab3GGWdw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12DC42EA87
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=owhH
	nZAyEQWGEX0+De4+OkQXxds=; b=ppKNALd5hQhXLb2rac8nkCCmTj91YQMR8Djp
	L439jLPVdleh3Om9eZ80EKOjZHzZOCN7WoH2U/nE/MAve4t3x+3WbUdFY63NxUTj
	zLd0n3Li/Scixc1AsumoKlePTDnB0xeqDOn8oq/pgC4nAdhrMsih9xhzLU+av7kN
	FM+/V+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sPez6Q
	XCPlR3sUvJdtNW5xlVGQWzJlBgxgupqPsw4ekohSH70hxnCkS3WsacR5g9+0KtP9
	hJx3jnTJK0IQOrdacCyWPiM+ouNFRPLcXrdiDFKUcTzaMaLY6MyjlNBMvIYXCV+s
	8TvatYyyUGcyAZjkI+4Qz4PHSJUhgUMhUXK30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04F4B2EA85
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FD432EA84
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:51 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-853-ga8cbcc9
In-Reply-To: <1373236424-25617-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4C7BFD28-E755-11E2-9DD0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229816>

Instead of using a hand allocated args[] array, use argv-array API
to manage the dynamically created list of arguments when invoking
name-rev.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 4e675c3..b5434e4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "hash.h"
+#include "argv-array.h"
 
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -442,24 +443,24 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("--long is incompatible with --abbrev=0"));
 
 	if (contains) {
-		const char **args = xmalloc((7 + argc) * sizeof(char *));
-		int i = 0;
-		args[i++] = "name-rev";
-		args[i++] = "--name-only";
-		args[i++] = "--no-undefined";
+		struct argv_array args;
+
+		argv_array_init(&args);
+		argv_array_push(&args, "name-rev");
+		argv_array_push(&args, "--name-only");
+		argv_array_push(&args, "--no-undefined");
 		if (always)
-			args[i++] = "--always";
+			argv_array_push(&args, "--always");
 		if (!all) {
-			args[i++] = "--tags";
-			if (pattern) {
-				char *s = xmalloc(strlen("--refs=refs/tags/") + strlen(pattern) + 1);
-				sprintf(s, "--refs=refs/tags/%s", pattern);
-				args[i++] = s;
-			}
+			argv_array_push(&args, "--tags");
+			if (pattern)
+				argv_array_pushf(&args, "--refs=refs/tags/%s", pattern);
+		}
+		while (*argv) {
+			argv_array_push(&args, *argv);
+			argv++;
 		}
-		memcpy(args + i, argv, argc * sizeof(char *));
-		args[i + argc] = NULL;
-		return cmd_name_rev(i + argc, args, prefix);
+		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
 	init_hash(&names);
-- 
1.8.3.2-853-ga8cbcc9
