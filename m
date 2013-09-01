From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous updates
Date: Sat, 31 Aug 2013 23:08:34 -0700
Message-ID: <xmqqob8dul99.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<cover.1377885441.git.brad.king@kitware.com>
	<edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 08:08:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG0q6-0003Up-Dq
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 08:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab3IAGIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 02:08:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab3IAGIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 02:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73EC3390D3;
	Sun,  1 Sep 2013 06:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pyB8hlKtB0i2qEB5fbZb59zl8CY=; b=DFPAWz+nS7Rf9Rbow9o9
	SoIUB2gDyJbNPExcLPYXYkhMnjLy0ZtXK6My7cbCEspqX6O9a8XhAkkU6dcZcJjR
	asdwSwcAYQ5vb9IMTVJOSQtImi/Xdv/yPItXkEkTPBvidNg4vkSgN/3qeNsZKZbW
	etvtdqTgte84cJB7vetwe3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ApeAloJ3N65Us8wD4gCmX5BqtwBEJIK3fwFRtpa2zYQq22
	D8ogkYAZPP0BiyfFP6Q6FuG08y9qKk6dFZEh08RS8EZycB7NPnUE4V4r9xBPmYUZ
	2vN5k8E9kJ8qCGPZFbh9M0F0b7ev7bjcFk1mbfMmM2plsA1NxVc3rpRheUXoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68907390D2;
	Sun,  1 Sep 2013 06:08:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA4AF390D1;
	Sun,  1 Sep 2013 06:08:35 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EFE0EB98-12CC-11E3-B417-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233566>

Brad King <brad.king@kitware.com> writes:

> Add 'struct ref_update' to encode the information needed to update or
> delete a ref (name, new sha1, optional old sha1, no-deref flag).  Add
> function 'update_refs' accepting an array of updates to perform.  First
> sort the input array to order locks consistently everywhere and reject
> multiple updates to the same ref.  Then acquire locks on all refs with
> verified old values.  Then update or delete all refs accordingly.  Fail
> if any one lock cannot be obtained or any one old value does not match.

OK.  The code releases the locks it acquired so far when it fails,
which is good.

> Though the refs themeselves cannot be modified together in a single

"themselves".

> atomic transaction, this function does enable some useful semantics.
> For example, a caller may create a new branch starting from the head of
> another branch and rewind the original branch at the same time.  This
> transfers ownership of commits between branches without risk of losing
> commits added to the original branch by a concurrent process, or risk of
> a concurrent process creating the new branch first.

> +static int ref_update_compare(const void *r1, const void *r2)
> +{
> +	struct ref_update *u1 = (struct ref_update *)(r1);
> +	struct ref_update *u2 = (struct ref_update *)(r2);
> +	int ret;

Let's have a blank line between the end of decls and the beginning
of the body here.

> +	ret = strcmp(u1->ref_name, u2->ref_name);
> +	if (ret)
> +		return ret;
> +	ret = hashcmp(u1->new_sha1, u2->new_sha1);
> +	if (ret)
> +		return ret;
> +	ret = hashcmp(u1->old_sha1, u2->old_sha1);
> +	if (ret)
> +		return ret;
> +	ret = u1->flags - u2->flags;
> +	if (ret)
> +		return ret;
> +	return u1->have_old - u2->have_old;
> +}

I notice that we are using an array of structures and letting qsort
swap 50~64 bytes of data, instead of sorting an array of pointers,
each element of which points at a structure.  This may not matter
unless we are asked to update thousands at once, so I think it is OK
for now.

> +static int ref_update_reject_duplicates(struct ref_update *updates, int n,
> +					enum action_on_err onerr)
> +{
> +	int i;
> +	for (i = 1; i < n; ++i)
> +		if (!strcmp(updates[i - 1].ref_name, updates[i].ref_name))
> +			break;

Optionally we could silently dedup multiple identical updates and
not fail it in ref-update-reject-duplicates.  But that does not have
to be done until we find people's script would benefit from such a
nicety.

By the way, unless there is a strong reason not to do so,
post-increment "i++" (and pre-decrement "--i", if you use it) is the
norm around here.  Especially in places like the third part of a
for(;;) loop where people are used to see "i++", breaking the idiom
makes readers wonder if there is something else going on.

> +	/* Perform updates first so live commits remain referenced: */
> +	for (i = 0; i < n; ++i)
> +		if (!is_null_sha1(updates[i].new_sha1)) {
> +			ret |= update_ref_write(action,
> +						updates[i].ref_name,
> +						updates[i].new_sha1,
> +						locks[i], onerr);
> +			locks[i] = 0; /* freed by update_ref_write */

I think what is assigned here is a NULL pointer.

Will locally tweak while queuing.  Thanks.
