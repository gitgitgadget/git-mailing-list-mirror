From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge: simplify code flow
Date: Thu, 23 Apr 2015 13:01:44 -0700
Message-ID: <xmqqh9s6397b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 22:01:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlNJr-00087u-5K
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 22:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030880AbbDWUBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 16:01:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030657AbbDWUBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 16:01:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0D524B9CF;
	Thu, 23 Apr 2015 16:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	1O36qMNGGkquUVLANpLF7yV2WQ=; b=UO6Z6zpIOaoPD9RVIgGLHlyu+OvgKfAaU
	tVem599K8hoSnXxXdGUzjinX6hYFLjf9njIRTs7Atal9xuSiDbn13qjOAQl2nveK
	hQYhOEgS8ZRQ59bTVRvYYpduqjCDg3Vyr8B6DlpCmVriB1u9rFbv+CEVGuP+QuvO
	aBAyxjcW+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=e6m
	qGUzAcdiKOdMInXVecOyE6fs2msSRy04ErZwGsnANHf/wu3aBzbiLQA/U6MUrIe/
	vzlQUC54fzI5IYcA884nrfoFY3RuivSRqBUv/oKd8PI4TP3dDqMJ4aG128Lw18nK
	QmGKCIExS1vz1KQ07jBiomq1gGDLrzCJZFF+z2kw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A73484B9CE;
	Thu, 23 Apr 2015 16:01:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 162F34B9CC;
	Thu, 23 Apr 2015 16:01:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91D69912-E9F3-11E4-8599-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267705>

One of the first things cmd_merge() does is to see if the "--abort"
option is given and run "reset --merge" and exit.  When the control
reaches this point, we know "--abort" was not given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..0ab7142 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1158,15 +1158,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
