From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "add -p": work-around an old laziness that does not coalesce
 hunks
Date: Wed, 06 Apr 2011 14:36:18 -0700
Message-ID: <7vsjtvgizx.fsf_-_@alter.siamese.dyndns.org>
References: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
 <BANLkTimh+--iRNEpr2XOFf4jXoVhmHUnoA@mail.gmail.com>
 <7voc4ji23p.fsf@alter.siamese.dyndns.org>
 <7v4o6bi1lm.fsf_-_@alter.siamese.dyndns.org>
 <7vy63ngj7a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Arnaud Lacombe <lacombar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 23:36:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7aOx-0003dx-4Y
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 23:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162Ab1DFVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 17:36:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab1DFVg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 17:36:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5134C54B0;
	Wed,  6 Apr 2011 17:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cnRo0asDR57hvwsoFRTV1+dt6SA=; b=bD1eGq
	IRt1Nf+Qj90JO7XWNLCqbte4XwVAgVvmIpJEFfMJ7jwh1T1Gj4/bYg/CVYzuiLoM
	l0M8ovuTCgnPA6KSgVo6VRsqlm1a1dP/cyv5UWXDNLSghOJbR770jKUsl84ycITS
	zsDoZdVFSZ2hAEFiNjYHwPkjzhWOE7r9ZTJ+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voUijH+xtBnJiKTaS8Slx4g0q21TQfmf
	GKTtIfAdsawz10twZdD+Bsmp+mDUgDv/f6rfiSvkmAG70Bn8fTlvqAB6JC9SHpFj
	9+wdLvHogg/b3qJnkdWxFzzonL0B9ksYFkzbnuqDoc3ldLOWMI3DjhISiBGeUSV6
	3r5MAaNIJaQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F18A54AD;
	Wed,  6 Apr 2011 17:38:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD75654AB; Wed,  6 Apr 2011
 17:38:14 -0400 (EDT)
In-Reply-To: <7vy63ngj7a.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Apr 2011 14:31:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 301E3C60-6096-11E0-9409-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171019>

Since 0beee4c (git-add--interactive: remove hunk coalescing, 2008-07-02),
"git add--interactive" passes overlapping hunks to "git apply" without
coalescing adjacent hunks.  This was partially corrected by 7a26e65 (its
partial revert, 2009-05-16), but overlapping hunks are still passed when
the patch is edited.

Teach the --allow-overlap option to "git apply" to disable the recent
safety feature that avoids misapplication of patches by not applying
patches to overlapping hunks (Cf.  9d15860 (apply: do not patch lines that
were already patched, 2011-03-04), and pass this option from "add -p".

Do not even advertise the option, as this is a workaround; the correct fix
ought to be to make "add -p" correctly coalesce adjacent patch hunks.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           |    9 ++++++---
 git-add--interactive.perl |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 04f56f8..8be1ce5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -43,6 +43,7 @@ static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
+static int allow_overlap;
 static int no_add;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -2430,9 +2431,9 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
-	for (i = 0; i < postimage->nr; i++)
-		img->line[applied_pos + i].flag |= LINE_PATCHED;
-
+	if (!allow_overlap)
+		for (i = 0; i < postimage->nr; i++)
+			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->nr = nr;
 }
 
@@ -3877,6 +3878,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"don't expect at least one line of context"),
 		OPT_BOOLEAN(0, "reject", &apply_with_reject,
 			"leave the rejected hunks in corresponding *.rej files"),
+		OPT_BOOLEAN(0, "allow-overlap", &allow_overlap,
+			"allow overlapping hunks"),
 		OPT__VERBOSE(&apply_verbosely, "be verbose"),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			"tolerate incorrectly detected missing new-line at the end of file",
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 6a439db..8de96d9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -705,7 +705,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd . " --recount";
+	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
 	print $fh @_;
 	return close $fh;
 }
-- 
1.7.5.rc1
