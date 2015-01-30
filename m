From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 13:10:24 -0800
Message-ID: <xmqqmw50asan.fsf@gitster.dls.corp.google.com>
References: <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
	<xmqq61bocao1.fsf@gitster.dls.corp.google.com>
	<xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
	<20150130201620.GA4133@peff.net>
	<xmqqwq44auml.fsf@gitster.dls.corp.google.com>
	<20150130204805.GA10616@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 22:10:39 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHIpp-0003dk-9C
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 22:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763167AbbA3VKb (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 16:10:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760693AbbA3VK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 16:10:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F14E432C57;
	Fri, 30 Jan 2015 16:10:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ote7TYrQ3s6ZgwY6gI2uxb07GKI=; b=r4CCD2
	N397BwYPPHlkjypLk1JVYBM39jDdxPCkLuXDOt9sF+3RJcpe7NN84z694PLOTEYF
	IVE6KuGgfCxFvzEoSVMixfKNNEy+NCRXD++Akx0syF4fIKNjip6clB5Pe34dLblU
	+UiH9HXmE9vL1dkV5z/++vMgaEz7qExpSuBl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l30IA0OBCd+MPq9msLYD+H7z2zHVGqSf
	gPnPc+4+gDTAqryttlnNVFpOAuKW6kPhB4mLak834Ssm2y2rTEPSajQkGmaRknVb
	G6/rwtOo1peRGjbIJNpmSJbIu02mPNiQlpiFa3reU4GUXQQPme8a8640uyo+asgY
	6v/d8p8b2QQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E715332C56;
	Fri, 30 Jan 2015 16:10:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1494F32C55;
	Fri, 30 Jan 2015 16:10:26 -0500 (EST)
In-Reply-To: <20150130204805.GA10616@peff.net> (Jeff King's message of "Fri,
	30 Jan 2015 15:48:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 694C7DBA-A8C4-11E4-BAFE-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263198>

Jeff King <peff@peff.net> writes:

> Ah, OK. Yeah, doing it progressively can only be accurate if our
> name-checks follow the same order as applying, because we are checking
> against a particular state.
>
> But could we instead pull this check to just before the write-out time?
> That is, to let any horrible thing happen in-core, as long as what we
> write out to the index and the filesystem is sane?

That would make me feel dirty.

I noticed one thing.  The PATH_TO_BE_DELETED/PATH_WAS_DELETED crud
kicks in -only- during the actual application phase, and all patches
that remove paths from the end result should have been appropriately
marked in fn_table[] by the call to prepare_fn_table() at the
beginning of check_patch_list() as PATH_TO_BE_DELETED.

But it was wrong to call previous_patch() in my fix.  The function
is the cause of evil I see in the "let's support concatenated patch,
making the later patch depend on the result of earlier ones" and
deliberately ignores PATH_TO_BE_DELETED patches.  We would need to
do the early part of previous_patch() without the filtering.

This is a preparatory step to clean-up the mess I have in mind.  It
does not mean to change the semantics (applied to the codebase with
or without the changes we have been discussing); it only makes it
always return the "previous" patch to the callers and makes them
responsible to see if the previous was to-be-deleted or was-deleted.

With that change, I think my symlink fix plus the "check the deleted
one with old_name, too" change has a better chance to do the moral
equivalent of your two-phase thing.  Essentially, "First see what
will be deleted in the input as a whole" has already been done by
the prepare_fn_table() thing.

 builtin/apply.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 41b7236..a064017 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3097,25 +3097,12 @@ static int checkout_target(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static struct patch *previous_patch(struct patch *patch, int *gone)
+static struct patch *previous_patch(struct patch *patch)
 {
-	struct patch *previous;
-
-	*gone = 0;
 	if (patch->is_copy || patch->is_rename)
 		return NULL; /* "git" patches do not depend on the order */
 
-	previous = in_fn_table(patch->old_name);
-	if (!previous)
-		return NULL;
-
-	if (to_be_deleted(previous))
-		return NULL; /* the deletion hasn't happened yet */
-
-	if (was_deleted(previous))
-		*gone = 1;
-
-	return previous;
+	return in_fn_table(patch->old_name);
 }
 
 static int verify_index_match(const struct cache_entry *ce, struct stat *st)
@@ -3170,11 +3157,11 @@ static int load_preimage(struct image *image,
 	struct patch *previous;
 	int status;
 
-	previous = previous_patch(patch, &status);
-	if (status)
+	previous = previous_patch(patch);
+	if (was_deleted(previous))
 		return error(_("path %s has been renamed/deleted"),
 			     patch->old_name);
-	if (previous) {
+	if (previous && !to_be_deleted(previous)) {
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
@@ -3384,18 +3371,18 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 {
 	const char *old_name = patch->old_name;
 	struct patch *previous = NULL;
-	int stat_ret = 0, status;
+	int stat_ret = 0;
 	unsigned st_mode = 0;
 
 	if (!old_name)
 		return 0;
 
 	assert(patch->is_new <= 0);
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(patch);
 
-	if (status)
+	if (was_deleted(previous))
 		return error(_("path %s has been renamed/deleted"), old_name);
-	if (previous) {
+	if (previous && !to_be_deleted(previous)) {
 		st_mode = previous->new_mode;
 	} else if (!cached) {
 		stat_ret = lstat(old_name, st);
@@ -3403,6 +3390,9 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 			return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
+	if (to_be_deleted(previous))
+		previous = NULL;
+
 	if (check_index && !previous) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
