From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/7] refs: add function to repack without multiple refs
Date: Thu, 29 Aug 2013 10:34:58 -0700
Message-ID: <xmqqli3k5rjx.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<85ef4bbb02b7648560d016a5b7ec62df9d394bdb.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF67i-0006gz-6y
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab3H2RfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:35:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969Ab3H2RfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:35:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4AC3DE7E;
	Thu, 29 Aug 2013 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/EU7PVrcZs3CABOjQtcIO5Ro1gE=; b=xyRKRV
	lqfyLhgF1vHfzp3iVi5GWbMp46ezsFAAKBcN14r9C7FGefJIt8IpZ3Z/AAyXBMBX
	48IfSt8AX7u/fYebq2A4+1bv2XBFOM08IxnjzXzEzSOvwLkSBPDvxfEdCEXZxFC7
	F+qrnyOnBcqkAGzCzWt/J2Xo3VWO8DahXlXng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F4vBnK0nsnTJJMP2V/Di2jmEOMs+4rpA
	SYgafVWPEpcugPWfIPdYwS5x12JV2a0u5Ky8keE2g+sspVwILWLhruZxaaB9bexz
	QduA/5dP7aURjSuxWnM0+kWJ4mohgtMfRjCjkcn7uL/qhB42XGcHc2oK56CC07ML
	xKjCS03G2lY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A05823DE7C;
	Thu, 29 Aug 2013 17:35:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D271C3DE78;
	Thu, 29 Aug 2013 17:34:59 +0000 (UTC)
In-Reply-To: <85ef4bbb02b7648560d016a5b7ec62df9d394bdb.1377784597.git.brad.king@kitware.com>
	(Brad King's message of "Thu, 29 Aug 2013 10:11:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 543C934C-10D1-11E3-AA2A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233291>

Brad King <brad.king@kitware.com> writes:

> Generalize repack_without_ref as repack_without_refs to support a list
> of refs and implement the former in terms of the latter.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  refs.c |   29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 5908648..5a6c14e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2414,25 +2414,35 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> -static int repack_without_ref(const char *refname)
> +static int repack_without_refs(const char **refnames, int n)
>  {
>  	struct ref_dir *packed;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>  	struct string_list_item *ref_to_delete;
> +	int i, removed = 0;
> +
> +	/* Look for a packed ref: */
> +	for (i = 0; i < n; ++i)
> +		if (get_packed_ref(refnames[i]))
> +			break;
>  
> -	if (!get_packed_ref(refname))
> -		return 0; /* refname does not exist in packed refs */
> +	/* Avoid locking if we have nothing to do: */
> +	if(i == n)

Style:
	if (i == n)

> +		return 0; /* no refname exists in packed refs */
>  
>  	if (lock_packed_refs(0)) {
>  		unable_to_lock_error(git_path("packed-refs"), errno);
> -		return error("cannot delete '%s' from packed refs", refname);
> +		return error("cannot delete '%s' from packed refs", refnames[i]);
>  	}
>  	packed = get_packed_refs(&ref_cache);
>  
> -	/* Remove refname from the cache: */
> -	if (remove_entry(packed, refname) == -1) {
> +	/* Remove refnames from the cache: */
> +	for (i = 0; i < n; ++i)
> +		if (remove_entry(packed, refnames[i]) != -1)
> +			removed = 1;
> +	if (!removed) {
>  		/*
> -		 * The packed entry disappeared while we were
> +		 * All packed entries disappeared while we were
>  		 * acquiring the lock.
>  		 */
>  		rollback_packed_refs();

... and this is not an error; somebody else did the work we wanted
to do for us, which is good ;-)

> @@ -2450,6 +2460,11 @@ static int repack_without_ref(const char *refname)
>  	return commit_packed_refs();
>  }
>  
> +static int repack_without_ref(const char *refname)
> +{
> +	return repack_without_refs(&refname, 1);
> +}
> +
>  static int delete_ref_loose(struct ref_lock *lock, int type)
>  {
>  	int err, i, ret = 0;
