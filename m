From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout -m dumping core
Date: Wed, 06 Jan 2010 21:07:16 -0800
Message-ID: <7vaawq8pvf.fsf@alter.siamese.dyndns.org>
References: <4B4381CA.1080504@dbservice.com>
 <2b9e2ea1.461a9565.4b4445be.38bda@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Tomas Carnecky <tom@dbservice.com>
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Thu Jan 07 06:07:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSkaq-0008Uf-PI
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 06:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab0AGFH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 00:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796Ab0AGFH2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 00:07:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab0AGFH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 00:07:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E08FB8ECB6;
	Thu,  7 Jan 2010 00:07:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qUytK8knTFqWcApb8LpTC91wuC0=; b=M1XvUF
	wCNOgP12AHvf7ZI56XjYMw+ytVDAwCVdYBACzYCX+GYLFnEsMIpSdoEpDWfN7387
	HbW2uNoLFHiVKvJbrBkiQwHL3/M34JT3jWbkq8lV1r1fH7UQJT/t8iWca+beWbGh
	E7Z/oVj4D8oeDkzLRP+wCJOhWzxNi/TxoSPhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MkZxkHVpCx6VbiGZCKB7F0Xj+RfiOPw2
	t/o23sZ6xy+Pb5v3ows0ILR26Os/oozSYhZk3Nnk3HR5yu8gDQi/w2HVAErM4OPM
	t0JJsgK3kcFLj0ZFzd8907wmLJHd6MM33Fc1qaRprAZTj+miYsAUZVQo+8jM973q
	LRu1a6wiYiQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE4B38ECB3;
	Thu,  7 Jan 2010 00:07:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D55CB8ECB0; Thu,  7 Jan
 2010 00:07:17 -0500 (EST)
In-Reply-To: <2b9e2ea1.461a9565.4b4445be.38bda@o2.pl> (Daniel's message of
 "Wed\, 06 Jan 2010 09\:11\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8945147E-FB4A-11DE-BF04-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136325>

Daniel <mjucde@o2.pl> writes:

> Does this patch help?

There actually is no point running parse_commit() at that point, as the
code obtained old->commit from lookup_commit_reference_gently() in
switch_branches() which must have already parsed it.  We do use it to try
switching the branches before falling back to the --merge mode (or we
notice old->commit does not exist and switch from an empty tree).

Instead of silently dying without diagnosing what paths are problematic
like your patch does, we can unsquelch the error from the unpack_tree() we
run before falling back to the --merge mode, and allow it to notice and
report the paths that will be overwritten (since you do not have HEAD,
everything in the work tree will be overwritten).  Perhaps like this.

 builtin-checkout.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..2708669 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -397,7 +397,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.initial_checkout = is_cache_unborn();
 		topts.update = 1;
 		topts.merge = 1;
-		topts.gently = opts->merge;
+		topts.gently = opts->merge && old->commit;
 		topts.verbose_update = !opts->quiet;
 		topts.fn = twoway_merge;
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -422,7 +422,13 @@ static int merge_working_tree(struct checkout_opts *opts,
 			struct merge_options o;
 			if (!opts->merge)
 				return 1;
-			parse_commit(old->commit);
+
+			/*
+			 * Without old->commit, the below is the same as
+			 * the two-tree unpack we already tried and failed.
+			 */
+			if (!old->commit)
+				return 1;
 
 			/* Do more real merge */
 
