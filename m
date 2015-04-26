From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/14] merge: simplify code flow
Date: Sat, 25 Apr 2015 22:25:54 -0700
Message-ID: <1430025967-24479-2-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5K-0002kU-1t
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbbDZF0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbbDZF0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36817466E0;
	Sun, 26 Apr 2015 01:26:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2c0F
	Eyfh7252BXdcRmyjFVyGiLY=; b=iQnp9GlkldjakglUng6c4I4poIZd5uryDDGN
	ec4kBM7qnuCF9h+jfXeh+p2tTkXFEEGkel+qWgdLj8Sb6kjoqzIoDcDVeXtPguVU
	reevw8AB1x1+Sy/IyyscwZSw1fQEzgbP5id77Xc7DCo8aufOas6r166mfZedGXcC
	qsbIr7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Mg+3u2
	Q0CHGQenjo6wCw64+uD4IewH9ViwqoTthMDQ6RKfWl0Lho2W+zHIOeBApm3QtpXr
	S9Qq+6gGNV1G1lAGlZLNlZ3EdHaAfr/8apuQqyj9qq/AdChqFkyzjRjOe3ckPDdY
	Jr9JMPE2iItO2iFfGuEak0+4dt1kaxTIA0ZsE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F267466DF;
	Sun, 26 Apr 2015 01:26:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5891466DE;
	Sun, 26 Apr 2015 01:26:09 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BEEF5244-EBD4-11E4-A4CE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267807>

One of the first things cmd_merge() does is to see if the "--abort"
option is given and run "reset --merge" and exit.  When the control
reaches this point, we know "--abort" was not given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bebbe5b..8477878 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1165,15 +1165,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		option_commit = 0;
 	}
 
-	if (!abort_current_merge) {
-		if (!argc) {
-			if (default_to_upstream)
-				argc = setup_with_upstream(&argv);
-			else
-				die(_("No commit specified and merge.defaultToUpstream not set."));
-		} else if (argc == 1 && !strcmp(argv[0], "-"))
-			argv[0] = "@{-1}";
+	if (!argc) {
+		if (default_to_upstream)
+			argc = setup_with_upstream(&argv);
+		else
+			die(_("No commit specified and merge.defaultToUpstream not set."));
+	} else if (argc == 1 && !strcmp(argv[0], "-")) {
+		argv[0] = "@{-1}";
 	}
+
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
-- 
2.4.0-rc3-238-g36f5934
