From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git checkout --nodwim
Date: Sun, 18 Oct 2009 01:01:37 -0700
Message-ID: <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 10:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzQi9-00071a-KH
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 10:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZJRIBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 04:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZJRIBn
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 04:01:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZJRIBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 04:01:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D03F7BE40;
	Sun, 18 Oct 2009 04:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0pFymXh12cirQI1eIGDJDhxyCbc=; b=DYmXiz
	5btwDKs05cHp6X2Y9bncXCfCA5duZGYGUFzKKnNGDireh4/qKX9govbFApF5QM+l
	Mi+4RSGgAl4fSwbIJ12y3z+M95x4dv5JYEM7M1ho+3sqnpInLapQvyQiqlu66Eev
	FngEl35PE2bKq7hXLJW3v3ju/tGsNV8Qo+asA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehl5UCH4crrh87SsIWOxgckmWKOvyBYd
	8nyeVlxdFbKuD0cc92J5U+iDOC2XoFpkVfCivxvQyYcOXkUt96f6U9ZkqJH9du9j
	CScb4/I+0WX1Wj6OA7+Uedo2dBWy5OjE3x+sjD0pKX/bRYTl06ElAOaP282nq7KL
	1obMbN5trkU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6500E7BE3E;
	Sun, 18 Oct 2009 04:01:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FB1C7BE3A; Sun, 18 Oct 2009
 04:01:38 -0400 (EDT)
In-Reply-To: <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 18 Oct 2009 00\:58\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A0ED2E2-BBBC-11DE-B336-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130589>

Porcelains may want to make sure their calls to "git checkout" will
reliably fail regardless of the presense of random remote tracking
branches by the new DWIMmery introduced.

Luckily all existing in-tree callers have extra checks to make sure they
feed local branch name when they want to switch, or they explicitly ask
to detach HEAD at the given commit, so there is no need to add this option
for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fb7e68a..6ec9b83 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -616,6 +616,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct tree *source_tree = NULL;
 	char *conflict_style = NULL;
 	int patch_mode = 0;
+	int dwim_new_local_branch = 1;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
@@ -631,6 +632,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
+		OPT_SET_INT(0, "nodwim", &dwim_new_local_branch,
+			    "do not dwim local branch creation", 0),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -715,6 +718,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
 			if (!patch_mode &&
+			    dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			    !opts.new_branch &&
 			    !check_filename(NULL, arg) &&
-- 
1.6.5.1.95.g09fbd
