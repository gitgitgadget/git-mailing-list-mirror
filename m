From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: honor advice.detachedHead when reattaching to a
 branch
Date: Fri, 06 May 2011 13:35:37 -0700
Message-ID: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIRkb-0007TX-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 22:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab1EFUfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 16:35:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab1EFUfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 16:35:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 03414577A;
	Fri,  6 May 2011 16:37:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=x
	i6WtF0nSWtGCOPBhWmZDfJJvX4=; b=Pfq/XZ6J39AmONbC06Ha+Ln4dgfQoId+q
	3OdT1VHquHk5oxXyzuhHNEcykqaRBjFLMHtQqZ6ta61IW+eKqWoCaBXD3QlvU1XO
	qmDa5rPVcWmjpM59BCJLoIouyQbsRH7qWb1bkJxK7GUpDJ11g3dcPbrnFAN8izV8
	LOmoe7uPDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=a3q
	d9LPnV4bKLSUCQXgcCQPjLCfRW/EoYGVWLeDqc6M4fHnCHI7BUA2KYQiGJneWHfG
	V5SL5eeYHcfKIc+1zrV8H6a0fnwUzBUkprsIVwxpRMHT3aeMcZFaAVRPNaEnCU2M
	WsqxUdMjwkotXQj2YYxxjjFoXLECogHMNmgyFz4s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3DDB5778;
	Fri,  6 May 2011 16:37:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22DFC5776; Fri,  6 May 2011
 16:37:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B264FB68-7820-11E0-BA4F-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173006>

When switching away from a detached HEAD with "git checkout", we give a
final warning to tell how to resurrect the commits being left behind since
8e2dc6a (commit: give final warning when reattaching HEAD to leave commits
behind, 2011-02-18) rather loudly.

This is a good safety measure for people who are not comfortable with the
detached HEAD state, but the warning was given even to those who set the
advice.detachedHead to false to decline the warning given when detaching,
resulting in an asymmetric experience.  Silent when going detached, and
very loud when coming back.

Make the call to orphan check and warning conditional to the advice
setting to correct this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Admittedly, going into the detached HEAD state is much less warn-worthy
   event than coming out of it, especially if you made any commit that
   will become unreachable, so there is an inherent asymmetry and some
   people may want to have a silent entry and loud exit (i.e. the current
   behaviour).  I do not mind a separate "advice.abouttolosecommit", but
   with this weatherbaloon I am trying to see if we can get away without
   adding yet another knob that the user has to tweak.

 builtin/checkout.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index eece5d6..eb92250 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -723,8 +723,13 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	if (ret)
 		return ret;
 
-	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-		orphaned_commit_warning(old.commit);
+	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit) {
+		if (advice_detached_head)
+			orphaned_commit_warning(old.commit);
+		else
+			describe_detached_head(_("Previous HEAD position was"),
+					       old.commit);
+	}
 
 	update_refs_for_switch(opts, &old, new);
 
