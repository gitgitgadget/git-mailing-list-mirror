From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge: allow "-" as a short-hand for "previous branch"
Date: Thu, 07 Apr 2011 16:03:14 -0700
Message-ID: <7vmxk164wd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 01:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7yEa-0007Kj-VA
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab1DGXDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 19:03:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab1DGXDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 19:03:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C667B57BF;
	Thu,  7 Apr 2011 19:05:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	hbpWwab6JLISYs+r7K9ePlrxzY=; b=UA0Xc8EO5HoI9oaSdHqyOrjKFHY/JP5+5
	FzFhWfzLpWx553/xqwH+ccybyT8mzrkxnPw0Un3gQCYn/R25nmwOwwLDXO+f/8H2
	NkCLSOGTIJ9hrAZFpU9Y+j3Vj3zW+DXqqj2ztmRQe0I0PsK0gyA386nAvXWBF2IA
	//h91Tc1Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=QuS
	V/I9LTf3ORNA8lGtPVlk/qKSOccPjSjp+a7gzHTFhO9cXfAN6uNNeEVOnnmoYEWM
	sELsuTTMDb65DZdFeVWbeEswhQxxYJsW9nbMAWHB1dW2B7UOpKBfDg0ce1ctEdKF
	UGNg3sjxdjcqSPeOg9XzvgItBSfco9oX9esQpdM8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B212457BD;
	Thu,  7 Apr 2011 19:05:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4A4957BC; Thu,  7 Apr 2011
 19:05:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EB74B8E-616B-11E0-AF25-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171090>

Just like "git checkout -" is a short-hand for "git checkout @{-1}" to
conveniently switch back to the previous branch, "git merge -" is a
short-hand for "git merge @{-1}" to conveniently merge the previous branch.

It will allow me to say:

    $ git checkout -b au/topic
    $ git am -s ./+au-topic.mbox
    $ git checkout pu
    $ git merge -

which is an extremely typical and repetitive operation during my git day.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d54e7dd..0bdd19a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1062,9 +1062,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die(_("You cannot combine --no-ff with --ff-only."));
 
-	if (!argc && !abort_current_merge && default_to_upstream)
-		argc = setup_with_upstream(&argv);
-
+	if (!abort_current_merge) {
+		if (!argc && default_to_upstream)
+			argc = setup_with_upstream(&argv);
+		else if (argc == 1 && !strcmp(argv[0], "-"))
+			argv[0] = "@{-1}";
+	}
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
-- 
1.7.5.rc1
