From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] remote-http: use argv-array
Date: Mon, 08 Jul 2013 22:18:35 -0700
Message-ID: <7vfvvoxqdw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 07:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQK2-0000Ov-PT
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3GIFSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:18:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3GIFSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:18:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89CC82A3AA;
	Tue,  9 Jul 2013 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=i
	+3OkvT721lFwkvKL+q3vdnenUQ=; b=oJ1YRGpmKbD4tYXj96u/SQEmZSmIlvqtk
	N/mXiB/FE843ICX+CKlmooSH41jNzCA7NW0dmWaFJnFhRXNLF4iOsmEf+lGUs5uR
	LKvhOgbP7a25kH/48h3lGh7Z/E/7q9004qvni6EH93gvdzrp6ZOjp2W4ubyI1qup
	3mtgZ75iKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=H69
	rFyV+NGN/RqMlOYJ+AsmUxylwTfi+FN58FcqQOQ19rNE9LnatDvJz2PlibZSkVpY
	94OuiHfrlgR715PNlU5kX0RigRaBNCeW/a0E3nbCxkKvuGQXBGHWt87qyD6mEUUE
	feChAYWKjeKvqArA1HbTWasQZKm9/CHjKpk4TC6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FFFA2A3A9;
	Tue,  9 Jul 2013 05:18:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3D572A3A8;
	Tue,  9 Jul 2013 05:18:36 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 020D0860-E857-11E2-A9C1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229911>

Instead of using a hand-managed argument array, use argv-array API
to manage dynamically formulated command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 60eda63..884b3a3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -7,6 +7,7 @@
 #include "run-command.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "argv-array.h"
 
 static struct remote *remote;
 static const char *url; /* always ends with a trailing slash */
@@ -787,36 +788,34 @@ static int push_dav(int nr_spec, char **specs)
 static int push_git(struct discovery *heads, int nr_spec, char **specs)
 {
 	struct rpc_state rpc;
-	const char **argv;
-	int argc = 0, i, err;
+	int i, err;
+	struct argv_array args;
+
+	argv_array_init(&args);
+	argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status");
 
-	argv = xmalloc((10 + nr_spec) * sizeof(char*));
-	argv[argc++] = "send-pack";
-	argv[argc++] = "--stateless-rpc";
-	argv[argc++] = "--helper-status";
 	if (options.thin)
-		argv[argc++] = "--thin";
+		argv_array_push(&args, "--thin");
 	if (options.dry_run)
-		argv[argc++] = "--dry-run";
+		argv_array_push(&args, "--dry-run");
 	if (options.verbosity == 0)
-		argv[argc++] = "--quiet";
+		argv_array_push(&args, "--quiet");
 	else if (options.verbosity > 1)
-		argv[argc++] = "--verbose";
-	argv[argc++] = options.progress ? "--progress" : "--no-progress";
-	argv[argc++] = url;
+		argv_array_push(&args, "--verbose");
+	argv_array_push(&args, options.progress ? "--progress" : "--no-progress");
+	argv_array_push(&args, url);
 	for (i = 0; i < nr_spec; i++)
-		argv[argc++] = specs[i];
-	argv[argc++] = NULL;
+		argv_array_push(&args, specs[i]);
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
-	rpc.argv = argv;
+	rpc.argv = args.argv;
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
-	free(argv);
+	argv_array_clear(&args);
 	return err;
 }
 
-- 
1.8.3.2-876-ge3d3f5e
