From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 05 Feb 2012 18:06:53 -0800
Message-ID: <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 03:07:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuDyv-0003WT-7h
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 03:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab2BFCG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 21:06:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534Ab2BFCG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 21:06:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6584D61E1;
	Sun,  5 Feb 2012 21:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7iXLUUP3KKQqxH5bVndl1p2GO/8=; b=K+bCD6
	WEk3o56rOL1qFTKpYG4ZiVjnoygFs+BH2x/sj4GheJ7faUNYiPt9ZEh4pPfefhcx
	5yacxlFcvA8phHIYX2L2FcAHKeCVAWA/ysf7SH4QVCzx8J9vAKUQPWGICIYTjiAr
	3jcTqfP8molS9btYwt8GYshXpLh4jc73FgK10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eqJn5YR0sLV3V/4PjeMUJyeBzzoDuwgw
	Wm0rzi5VbdDiUjm5EoXD7yBwCzBW0V86rhlcywyIYteV9iR/ZoW4a36115TbO7/K
	ZphFjD455+on7N9att5YYisMX4UfvLKwew60EduThwt+YNdj7GMgMr+gM47M9wpA
	F66YrpINcWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D25861E0;
	Sun,  5 Feb 2012 21:06:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B24F161DF; Sun,  5 Feb 2012
 21:06:54 -0500 (EST)
In-Reply-To: <20120130215043.GB16149@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 Jan 2012 16:50:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DDA8ED2-5067-11E1-9DC2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189998>

Jeff King <peff@peff.net> writes:

> Is it really worth warning? After all, by definition you are not leaving
> any commits or useful work behind.

I actually do not know if this change itself is worth doing, but if we
were to do this, then I think the user benefits from the warning.

The patch is made on maint-1.7.6 track for no good reason, so it may have
some merge conflicts around "resolve_ref()" vs "resolve_refdup()" if we
were to apply it on a more modern codebase, but the resolution should be
trivial.

---
Subject: [PATCH] git checkout -b: allow switching out of an unborn branch

Running "git checkout -b another" immediately after "git init" when you do
not even have a commit on 'master' is forbidden, with a readable message:

    $ git checkout -b another
    fatal: You are on a branch yet to be born

It is readable but not easily understandable unless the user knows what
"yet to be born" really means.

So let's try allowing it and see what happens. I strongly suspect that
this may just shift the confusion one step further without adding much
value to the resulting system, because the next question that would come
to somebody who does not understand what "yet to be born" is is "why don't
I see 'master' in the output from 'git branch' command?", and the new
warning may not be descriptive enough to explain what the user is doing.

The early part of switch_branches() that computes old is probably be
better moved to the caller cmd_checkout() and used in the new code that
detects the "unborn" case, and passed as to switch_branches() as the third
parameter.  Such improvements and tests are left as an exercise for the
interested and motivated, as usual ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4c20dae..5894f40 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -916,6 +916,19 @@ static int parse_branchname_arg(int argc, const char **argv,
 	return argcount;
 }
 
+static int switch_unborn_to_new_branch(struct checkout_opts *opts, const char *old_ref)
+{
+	int status;
+	struct strbuf branch_ref = STRBUF_INIT;
+
+	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
+	warning(_("Leaving the unborn branch '%s' behind..."),
+		skip_prefix(old_ref, "refs/heads/"));
+	status = create_symref("HEAD", branch_ref.buf, "checkout -b");
+	strbuf_release(&branch_ref);
+	return status;
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -1089,5 +1102,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.writeout_stage)
 		die(_("--ours/--theirs is incompatible with switching branches."));
 
+	if (!new.commit) {
+		unsigned char rev[20];
+		int flag, status;
+		const char *old_ref = resolve_ref("HEAD", rev, 0, &flag);
+
+		if ((flag & REF_ISSYMREF) && is_null_sha1(rev)) {
+			status = switch_unborn_to_new_branch(&opts, old_ref);
+			free((char *)old_ref);
+			return status;
+		}
+	}
 	return switch_branches(&opts, &new);
 }
-- 
1.7.9.172.ge26ae
