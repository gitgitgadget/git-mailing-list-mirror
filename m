From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] refs: speed up is_refname_available
Date: Wed, 10 Sep 2014 15:21:39 -0700
Message-ID: <xmqqk35bf764.fsf@gitster.dls.corp.google.com>
References: <20140910101730.GA12399@peff.net>
	<20140910111155.GA14995@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 00:21:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqGo-0005rq-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbaIJWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 18:21:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57534 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbaIJWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:21:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB13439C54;
	Wed, 10 Sep 2014 18:21:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w9Vd1MlTu0GLTK5LDaZXOBp+KjI=; b=grpwc9
	TtbizgIwboBe5PQnqj6fkNBz82bttO01krHehIfkKeIEQ/3ETJs+nbLWZXlvzK1W
	Zz/LEU3Qs8BQJuXX0kexllIqlcaCsgCHJYN9BmAzKUTjDxqV+LMDUqYivA7Nl4mD
	ySBE6HlfcFtCT3fTJtrhnPxU5Thy3QdDYpGps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoaN94sBZULDgKjzKyelCPsNfomaOsT5
	nLm7FP+1xqFfMmLq3Jz1OfClG8ouIztmkfXDJdgXGBmthX80Lnw6m1r5GkYhw0gX
	Im1ksuNG+FCc789MKc8gWQoaHORocD0IMb+AWCr9Ykbav1vstDbgpdaJ+8JxG6P+
	y9F1DHqV78g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D25A939C53;
	Wed, 10 Sep 2014 18:21:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C9D639C52;
	Wed, 10 Sep 2014 18:21:41 -0400 (EDT)
In-Reply-To: <20140910111155.GA14995@peff.net> (Jeff King's message of "Wed,
	10 Sep 2014 07:11:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D6D5AE70-3938-11E4-AC4C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256774>

Jeff King <peff@peff.net> writes:

> ...
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Sorry for the quick v2; Michael and I crossed emails off-list, and I
> missed some of his review. This version has some minor style and comment
> fixups.

Looks sensible from a cursory read, but it conflicts heavily with
54e696fc (refs.c: pass a skip list to name_conflict_fn, 2014-07-16)
which is queued early on 'pu', and I am definitely not in the
business of re-designing that huge topic myself.

I am tempted to

 - merge rs/ref-transaction-1 to 'master' as planned;

 - drop other rs/ref-transaction* topics temporarily, expecting them
   to be rerolled like rs/ref-transaction-1 was done recently;

 - ask you three (or four, counting Duy as well) who seem to want to
   touch refs to coordinate among yourselves a bit better next time
   ;-)

Thanks.

>
>  refs.c               | 122 +++++++++++++++++++++++++++++++++++++--------------
>  t/t3210-pack-refs.sh |  31 ++++++++++++-
>  2 files changed, 120 insertions(+), 33 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 27927f2..eb2262a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -779,37 +779,32 @@ static void prime_ref_dir(struct ref_dir *dir)
>  			prime_ref_dir(get_ref_dir(entry));
>  	}
>  }
> -/*
> - * Return true iff refname1 and refname2 conflict with each other.
> - * Two reference names conflict if one of them exactly matches the
> - * leading components of the other; e.g., "foo/bar" conflicts with
> - * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
> - * "foo/barbados".
> - */
> -static int names_conflict(const char *refname1, const char *refname2)
> +
> +static int entry_matches(struct ref_entry *entry, const char *refname)
>  {
> -	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
> -		;
> -	return (*refname1 == '\0' && *refname2 == '/')
> -		|| (*refname1 == '/' && *refname2 == '\0');
> +	return refname && !strcmp(entry->name, refname);
>  }
>  
> -struct name_conflict_cb {
> -	const char *refname;
> -	const char *oldrefname;
> -	const char *conflicting_refname;
> +struct nonmatching_ref_data {
> +	const char *skip;
> +	struct ref_entry *found;
>  };
>  
> -static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
> +static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
>  {
> -	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
> -	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
> +	struct nonmatching_ref_data *data = vdata;
> +
> +	if (entry_matches(entry, data->skip))
>  		return 0;
> -	if (names_conflict(data->refname, entry->name)) {
> -		data->conflicting_refname = entry->name;
> -		return 1;
> -	}
> -	return 0;
> +
> +	data->found = entry;
> +	return 1;
> +}
> +
> +static void report_refname_conflict(struct ref_entry *entry,
> +				    const char *refname)
> +{
> +	error("'%s' exists; cannot create '%s'", entry->name, refname);
>  }
>  
>  /*
> @@ -818,21 +813,84 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>   * oldrefname is non-NULL, ignore potential conflicts with oldrefname
>   * (e.g., because oldrefname is scheduled for deletion in the same
>   * operation).
> + *
> + * Two reference names conflict if one of them exactly matches the
> + * leading components of the other; e.g., "foo/bar" conflicts with
> + * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
> + * "foo/barbados".
>   */
>  static int is_refname_available(const char *refname, const char *oldrefname,
>  				struct ref_dir *dir)
>  {
> -	struct name_conflict_cb data;
> -	data.refname = refname;
> -	data.oldrefname = oldrefname;
> -	data.conflicting_refname = NULL;
> +	const char *slash;
> +	size_t len;
> +	int pos;
> +	char *dirname;
>  
> -	sort_ref_dir(dir);
> -	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
> -		error("'%s' exists; cannot create '%s'",
> -		      data.conflicting_refname, refname);
> +	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
> +		/*
> +		 * We are still at a leading dir of the refname; we are
> +		 * looking for a conflict with a leaf entry.
> +		 *
> +		 * If we find one, we still must make sure it is
> +		 * not "oldrefname".
> +		 */
> +		pos = search_ref_dir(dir, refname, slash - refname);
> +		if (pos >= 0) {
> +			struct ref_entry *entry = dir->entries[pos];
> +			if (entry_matches(entry, oldrefname))
> +				return 1;
> +			report_refname_conflict(entry, refname);
> +			return 0;
> +		}
> +
> +
> +		/*
> +		 * Otherwise, we can try to continue our search with
> +		 * the next component; if we come up empty, we know
> +		 * there is nothing under this whole prefix.
> +		 */
> +		pos = search_ref_dir(dir, refname, slash + 1 - refname);
> +		if (pos < 0)
> +			return 1;
> +
> +		dir = get_ref_dir(dir->entries[pos]);
> +	}
> +
> +	/*
> +	 * We are at the leaf of our refname; we want to
> +	 * make sure there are no directories which match it.
> +	 */
> +	len = strlen(refname);
> +	dirname = xmallocz(len + 1);
> +	sprintf(dirname, "%s/", refname);
> +	pos = search_ref_dir(dir, dirname, len + 1);
> +	free(dirname);
> +
> +	if (pos >= 0) {
> +		/*
> +		 * We found a directory named "refname". It is a
> +		 * problem iff it contains any ref that is not
> +		 * "oldrefname".
> +		 */
> +		struct ref_entry *entry = dir->entries[pos];
> +		struct ref_dir *dir = get_ref_dir(entry);
> +		struct nonmatching_ref_data data;
> +
> +		data.skip = oldrefname;
> +		sort_ref_dir(dir);
> +		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
> +			return 1;
> +
> +		report_refname_conflict(data.found, refname);
>  		return 0;
>  	}
> +
> +	/*
> +	 * There is no point in searching for another leaf
> +	 * node which matches it; such an entry would be the
> +	 * ref we are looking for, not a conflict.
> +	 */
>  	return 1;
>  }
>  
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 1a2080e..3d5cb4c 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -11,7 +11,9 @@ semantic is still the same.
>  '
>  . ./test-lib.sh
>  
> -echo '[core] logallrefupdates = true' >>.git/config
> +test_expect_success 'enable reflogs' '
> +	git config core.logallrefupdates true
> +'
>  
>  test_expect_success \
>      'prepare a trivial repository' \
> @@ -151,4 +153,31 @@ test_expect_success 'delete ref while another dangling packed ref' '
>  	test_cmp /dev/null result
>  '
>  
> +test_expect_success 'disable reflogs' '
> +	git config core.logallrefupdates false &&
> +	rm -rf .git/logs
> +'
> +
> +test_expect_success 'create packed foo/bar/baz branch' '
> +	git branch foo/bar/baz &&
> +	git pack-refs --all --prune &&
> +	test_path_is_missing .git/refs/heads/foo/bar/baz &&
> +	test_path_is_missing .git/logs/refs/heads/foo/bar/baz
> +'
> +
> +test_expect_success 'notice d/f conflict with existing directory' '
> +	test_must_fail git branch foo &&
> +	test_must_fail git branch foo/bar
> +'
> +
> +test_expect_success 'existing directory reports concrete ref' '
> +	test_must_fail git branch foo 2>stderr &&
> +	grep refs/heads/foo/bar/baz stderr
> +'
> +
> +test_expect_success 'notice d/f conflict with existing ref' '
> +	test_must_fail git branch foo/bar/baz/extra &&
> +	test_must_fail git branch foo/bar/baz/lots/of/extra/components
> +'
> +
>  test_done
