From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Wed, 20 Jan 2010 11:13:01 -0800
Message-ID: <7vocko3802.fsf@alter.siamese.dyndns.org>
References: <hj7abm$5vc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 20:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXfzT-000493-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 20:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab0ATTNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724Ab0ATTNP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 14:13:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0ATTNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 14:13:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF2292A52;
	Wed, 20 Jan 2010 14:13:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IH6RQoQOy3w7ZBWybQ+bn+WXv58=; b=FJAz/q
	I/7SN4SR28MzuY40LfGnur3bIb/Wx+N+1hQmIkzxF2abT/AVxpIWbiokIbM4cjp3
	5NA7qmu4kb0wrBGjOPD9Smd+Fi4QRFltYHdqaouFaCYf7eiT5sxf4uA1ECvOVcOQ
	Wlx5McL75dwK+KNozWd6pFuyuaEIo2U+4E11E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3HzY+C4j+Fs9HVTsU23DXWYtYdcLtgZ
	WTJsuQ31zJ7F0GrNUIttrpUYmIMZl1AK0noBG7OFup6trxmJQ9UANtG0BEv/R65A
	TMIBSzYUnubdWOBCOgSAOQoqAyDGiWCrzhzILNJsPF6CFlIoxLPoMmHOcRoFjU6F
	UWIWZK1TMyA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A0592A4E;
	Wed, 20 Jan 2010 14:13:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 449C592A48; Wed, 20 Jan
 2010 14:13:03 -0500 (EST)
In-Reply-To: <hj7abm$5vc$1@ger.gmane.org> (Tim Olsen's message of "Wed\, 20
 Jan 2010 11\:17\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7FF112A-05F7-11DF-BA03-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137562>

Tim Olsen <tim@brooklynpenguin.com> writes:

> The following happens on 1.6.6 and master as of
> 5b15950ac414a8a2d4f5eb480712abcc9fe176d2.  The problem goes away if I
> use the resolve merge strategy instead.

Thanks.

Since you can build and run git yourself, can I ask you to run another
experiment with this one-liner patch applied?

diff --git a/builtin-merge.c b/builtin-merge.c
index 82e2a04..08a8f24 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -550,7 +550,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		return error("Unable to write index.");
 	rollback_lock_file(lock);
 
-	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
+	if (0) {
 		int clean;
 		struct commit *result;
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));

This disables the codepath that special-cases the calling convention for
these merge strategies, and was introduce by 18668f5 (builtin-merge: avoid
run_command_v_opt() for recursive and subtree, 2008-08-28 -- authors Cc'ed
to ask for help in diagnosing).

If this experiment "fixes" the failure for you, then it would be a sign
that the caller (not necessarily in the code in this "if()" block) may be
doing something wrong (or more likely, not doing enough) before calling
into merge_recursive().  I am suspecting that it is not parsing some
commit objects properly, e.g. using lookup_commit(SHA-1) and using the
result without calling parse_object() on it first, or something similar
that is silly but trivial to fix.

After the experiment, please revert the above one-liner.  I don't want to
use a work-around forever; we'd be better off finding where in the code it
goes wrong.  Looking at your gdb trace, I notice...

> (gdb) r
> Starting program: /usr/local/bin/git merge origin/deployed
> [Thread debugging using libthread_db enabled]
> ...
> #3  0x0000000000499523 in merge_trees (o=0x7fffffffd5b0, head=0x77b058,
> merge=0x77b030, common=0x0, result=0x7fffffffd548) at merge-recursive.c:1209
>         code = 8076320
>         clean = 13064

"common = NULL" means merged_common_ancestors->tree is NULL in the caller.
Somebody is passing a bogus commit in "ca" (aka common ancestors) list
when calling merge_recursive(), or forgetting to parse them before calling
it.  In your debugger could you find out where it comes from and what it
has before this call into merge_trees() is made?  Specifically, what the
"ca" list at 0x7b3c00 contains, and how "merged_common_ancestors" at
0x121e360 looks like. in this trace we see below:

> #4  0x0000000000499a46 in merge_recursive (o=0x7fffffffd5b0,
> h1=0x7932d0, h2=0x793240, ca=0x7b3c00, result=0x7fffffffd628) at
> merge-recursive.c:1343
