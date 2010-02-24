From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] builtin-fetch --all/--multi: propagate options correctly
Date: Wed, 24 Feb 2010 10:22:06 -0800
Message-ID: <1267035726-2815-2-git-send-email-gitster@pobox.com>
References: <1267035726-2815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 19:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLsI-000578-78
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab0BXSWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:22:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab0BXSWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 13:22:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B4D9C5BD
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 13:22:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lCcO
	8RQX7ZaaECI7wnwPc2c7q7I=; b=MkJSfVYkdygDdFJPoJOASfS+dNkSV0Pt+Zpx
	ALBRM0GqQPVhj9LNTrRbIuqfFKwIhZCaXJanOortXNpwOznztaXXT546mW0tNSs8
	4XDu1U4F/NOgaNbsyC89aT0LShPfWN5LVgtuzIA5mc8T7Qqdvbx9wXH7HmDCAruy
	d9m40Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=V5PtkQ
	8qdrQ/BsrsuyipFE2rP7lWnsw5CrZL8pb+QCTYCikKXgGfr6TvoANZC3i3EG6R3w
	FS2U+1LTwyzcxBlMVxZMf55AiyrBG8eL3EigDAQybZWA3S9XNGJ6SdIYAbotUIeM
	sVStNlE5K3HLvWTBec4+jRpf0XjTLUo/gRx3g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEFCC9C5BC
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 13:22:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68FFB9C5BB for
 <git@vger.kernel.org>; Wed, 24 Feb 2010 13:22:09 -0500 (EST)
X-Mailer: git-send-email 1.7.0.207.gac4ec
In-Reply-To: <1267035726-2815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 85709556-2171-11DF-86BF-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140968>

When running a subfetch, the code propagated some options but not others.
Propagate --force, --update-head-ok and --keep options as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fetch.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 8654fa7..61b2e40 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -784,13 +784,19 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result = 0;
-	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL, NULL, NULL };
+	const char *argv[10] = { "fetch" };
 	int argc = 1;
 
 	if (dry_run)
 		argv[argc++] = "--dry-run";
 	if (prune)
 		argv[argc++] = "--prune";
+	if (update_head_ok)
+		argv[argc++] = "--update-head-ok";
+	if (force)
+		argv[argc++] = "--force";
+	if (keep)
+		argv[argc++] = "--keep";
 	if (verbosity >= 2)
 		argv[argc++] = "-v";
 	if (verbosity >= 1)
@@ -801,6 +807,7 @@ static int fetch_multiple(struct string_list *list)
 	for (i = 0; i < list->nr; i++) {
 		const char *name = list->items[i].string;
 		argv[argc] = name;
+		argv[argc + 1] = NULL;
 		if (verbosity >= 0)
 			printf("Fetching %s\n", name);
 		if (run_command_v_opt(argv, RUN_GIT_CMD)) {
-- 
1.7.0.207.gac4ec
