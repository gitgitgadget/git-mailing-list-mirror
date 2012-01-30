From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 30 Jan 2012 12:10:08 -0800
Message-ID: <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:10:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxYQ-0004cr-Qi
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab2A3UKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:10:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab2A3UKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:10:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46C8A604F;
	Mon, 30 Jan 2012 15:10:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7hudlfztmQ/b+9LsmzlOHGEgzY=; b=LroenN
	vAYdsfaX/U2Ign3+XVOVtzK9vONqlu39WxqskE9Nbxfo3CfTx9xQ2ImlW5aV45q8
	fIqJ6RRfhJlQYtiG9cgcJEeFAldDGrq7w10izjvuQHVNkYeQLxEgSd55YRQqRPt3
	+d+qog5wfVefZ9/YS0Uqvu9gu7f/9gYt4k/bA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RHKMSrB5KIHyuGhxrNwEca4j4YWCqS03
	OPf3pQq/WWUb/Do/MouwpyRQjmbogpKmJvWaqw73quAp2vc4BpYC5dkCbBdMeqv+
	BTYORpMw5q2SHyfzsA6m4SiqpwDsJqNrQBamDvIS5AvcTxtJBO/uE5xkHN5xi/q3
	ZxnGPSx+Cb8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB34604D;
	Mon, 30 Jan 2012 15:10:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5926604C; Mon, 30 Jan 2012
 15:10:09 -0500 (EST)
In-Reply-To: <7v39axc9gp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 30 Jan 2012 10:48:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69023FD0-4B7E-11E1-9A01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189416>

Junio C Hamano <gitster@pobox.com> writes:

> Note that I am not saying that we shouldn't add support for special cases
> with special case codepaths.
>
> Perhaps we would need to sprinkle more special case magic like this (this
> is for the special case that arises from the same cause)?
> ...

And the special case for "checkout -b" may look like this.

The early part of switch_branches() that computes old is probably be
better moved to the caller cmd_checkout() and used in the new code that
detects the "unborn" case, and passed as to switch_branches() as the third
parameter.  Such improvements, adding tests and pleasant commit log
message is left as an exercise for the interested and motivated, as usual
;-)



 builtin/checkout.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f1984d9..195c40b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -922,6 +922,19 @@ static int parse_branchname_arg(int argc, const char **argv,
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
+	strbuf_reset(&branch_ref);
+	return status;
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -1093,5 +1106,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.writeout_stage)
 		die(_("--ours/--theirs is incompatible with switching branches."));
 
+	if (!new.commit) {
+		unsigned char rev[20];
+		int flag, status;
+		char *old_ref = resolve_refdup("HEAD", rev, 0, &flag);
+
+		if ((flag & REF_ISSYMREF) && is_null_sha1(rev)) {
+			status = switch_unborn_to_new_branch(&opts, old_ref);
+			free(old_ref);
+			return status;
+		}
+	}
 	return switch_branches(&opts, &new);
 }
