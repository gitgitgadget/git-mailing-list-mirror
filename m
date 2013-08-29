From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 6/7] refs: add update_refs for multiple simultaneous updates
Date: Thu, 29 Aug 2013 10:39:58 -0700
Message-ID: <xmqqhae85rbl.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6CZ-0001rd-IU
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab3H2RkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:40:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149Ab3H2RkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:40:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 864113D136;
	Thu, 29 Aug 2013 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rk7ysncDrbwigd2d3rdJeFqaxKI=; b=c5E4Ua
	+swPzj/2DcrMLjrjqSCJbftNaBhf5DJy8zupDvsznU3RUELVWh2xtgaOwrAbIr5Q
	r3bovAlWeBsjLsxQAMDviaxQCYiPZH5QBYz0IawqR6GsXChIv/TkHJby3UaqixM9
	IGrRyBXkCxxQ8Pw3GmjV8las0TDjuZ9SEtx+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TXtfWn+CWQTa9nYnfnwLJ/kOufUWHQOv
	tlJX+AVZVNUoGIfI7WJ8gD63rCWJ7IECcTdcBVw8cepTRhzvJXhhx7luSaHVM53T
	RryQazcyBPn/ZIl97n86wa8qY3wk9dVcvWgli4dOVFe3ylFVyy/YXZfmcZ0MyTlR
	9BbfXwUXw64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77F313D135;
	Thu, 29 Aug 2013 17:40:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E1773D126;
	Thu, 29 Aug 2013 17:40:01 +0000 (UTC)
In-Reply-To: <518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com>
	(Brad King's message of "Thu, 29 Aug 2013 10:11:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07F83210-10D2-11E3-98E7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233292>

Brad King <brad.king@kitware.com> writes:

> Add 'struct ref_update' to encode the information needed to update or
> delete a ref (name, new sha1, optional old sha1, no-deref flag).  Add
> function 'update_refs' accepting an array of updates to perform.  First
> acquire locks on all refs with verified old values.  Then update or
> delete all refs accordingly.  Fail if any one lock cannot be obtained or
> any one old value does not match.
>
> Though the refs themeselves cannot be modified together in a single
> atomic transaction, this function does enable some useful semantics.
> For example, a caller may create a new branch starting from the head of
> another branch and rewind the original branch at the same time.  This
> transfers ownership of commits between branches without risk of losing
> commits added to the original branch by a concurrent process, or risk of
> a concurrent process creating the new branch first.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  refs.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h |   11 +++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 5a6c14e..0a0c19e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3238,6 +3238,72 @@ int update_ref(const char *action, const char *refname,
>  	return update_ref_write(action, refname, sha1, lock, onerr);
>  }
>  
> +int update_refs(const char *action, struct ref_update *updates,
> +		int n, enum action_on_err onerr)
> +{
> +	int ret = 0, delnum = 0, i;
> +	int *types;
> +	struct ref_lock **locks;
> +	const char **delnames;
> +
> +	if (!updates || !n)
> +		return 0;
> +
> +	/* Allocate work space: */
> +	types = xmalloc(sizeof(int)*n);
> +	locks = xmalloc(sizeof(struct ref_lock*)*n);
> +	delnames = xmalloc(sizeof(const char*)*n);
> +
> +	/* Acquire all locks while verifying old values: */
> +	for (i=0; i < n; ++i) {

Style:

	for (i = 0; i < n; i++) {

> +		locks[i] = update_ref_lock(updates[i].ref_name,
> +					   updates[i].old_sha1,
> +					   updates[i].flags,
> +					   &types[i], onerr);
> +		if (!locks[i])
> +			break;
> +	}

Is it asking for AB-BA deadlock?  If so, is the caller responsible
for avoiding it?

> +	/* Abort if we did not get all locks: */
> +	if (i < n) {
> +		while (--i >= 0)
> +			unlock_ref(locks[i]);
> +		free(types);
> +		free(locks);
> +		free(delnames);
> +		return 1;
> +	}
> +
> +	/* Perform updates first so live commits remain referenced: */
> +	for (i=0; i < n; ++i)
> +		if (!is_null_sha1(updates[i].new_sha1)) {
> +			ret |= update_ref_write(action,
> +						updates[i].ref_name,
> +						updates[i].new_sha1,
> +						locks[i], onerr);
> +			locks[i] = 0; /* freed by update_ref_write */
> +		}
> +
> +	/* Perform deletes now that updates are safely completed: */
> +	for (i=0; i < n; ++i)
> +		if (locks[i]) {
> +			delnames[delnum++] = locks[i]->ref_name;
> +			ret |= delete_ref_loose(locks[i], types[i]);
> +		}
> +	ret |= repack_without_refs(delnames, delnum);
> +	for (i=0; i < delnum; ++i)
> +		unlink_or_warn(git_path("logs/%s", delnames[i]));
> +	clear_loose_ref_cache(&ref_cache);
> +	for (i=0; i < n; ++i)
> +		if (locks[i])
> +			unlock_ref(locks[i]);
> +
> +	free(types);
> +	free(locks);
> +	free(delnames);
> +	return ret;
> +}
> +
>  struct ref *find_ref_by_name(const struct ref *list, const char *name)
>  {
>  	for ( ; list; list = list->next)
> diff --git a/refs.h b/refs.h
> index 2cd307a..5763f3a 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -214,6 +214,17 @@ int update_ref(const char *action, const char *refname,
>  		const unsigned char *sha1, const unsigned char *oldval,
>  		int flags, enum action_on_err onerr);
>  
> +struct ref_update {
> +	const char *ref_name;
> +	unsigned char new_sha1[20];
> +	unsigned char *old_sha1;

This asymmetry is rather curious and will later become problematic
when we have more users of this API.  Maybe your callers happen have
static storage to keep old_sha1[] outside this structure but do not
have it for new_sha1[] for some unknown reason, which may not apply
to later callers we may want to add.

> +	int flags;
> +};
> +
> +/** lock all refs and then write all of them */
> +int update_refs(const char *action, struct ref_update *updates,
> +		int n, enum action_on_err onerr);
> +
>  extern int parse_hide_refs_config(const char *var, const char *value, const char *);
>  extern int ref_is_hidden(const char *);
