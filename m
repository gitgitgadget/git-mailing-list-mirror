From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/15] merge: simplify code flow
Date: Wed, 29 Apr 2015 14:29:20 -0700
Message-ID: <1430342973-30344-3-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYp-0006ou-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbbD2V3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbD2V3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2C7E4DA9A;
	Wed, 29 Apr 2015 17:29:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xH2n
	KNYaJWKLAqwi4GwZ5Bpm3R0=; b=RRS6m2JxfCKyw4CU0D8nGTnxPd6OFRwp/4Ie
	hnfNb9k6O9fx1v0e5EZRcu4CcOrbmHHuqEtfqNdG01w41JSv1a7d+W/BOtJeadQ5
	1C9Qi4PJXMgAfaztNtbUOJe4J5IOY7iWPkSNJADvJQYFMdkOZgAwGCOghwTBGDn6
	FWQGhLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pcQ7JR
	FeH7Tn5E/LeW9B2DcrswUf33f7cgy/+Z6FjaLThZTEVCuXNMdKiwcy2zJJoUd8LF
	dXqrwCB7yO3b2AqPTffwLXL9TrN53czeik89Z6hNB+l+Ci6UAU8x8ASg95eOEtlV
	HMJOsoyaCeAZeu0uuc/pVL3+IrKkoNeDDKI4A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA8F14DA99;
	Wed, 29 Apr 2015 17:29:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F2D84DA97;
	Wed, 29 Apr 2015 17:29:37 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D6417578-EEB6-11E4-8E75-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268023>

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
2.4.0-rc3-300-g052d062
