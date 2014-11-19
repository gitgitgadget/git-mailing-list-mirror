From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] refs.c: use a stringlist for repack_without_refs
Date: Wed, 19 Nov 2014 12:44:50 -0800
Message-ID: <20141119204450.GX6527@google.com>
References: <xmqq4mtvt6jj.fsf@gitster.dls.corp.google.com>
 <1416423000-4323-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:45:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrC7X-0002Lh-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbaKSUov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:44:51 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52528 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbaKSUot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:44:49 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so1407414iec.10
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 12:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uqGN+6fDexK4efI5KDMhI8CKs37O56z6Eaorqxp3zWk=;
        b=uWqTKruzZ2MHdQrOuNwrSnaHqXSbhTT7fxYypeWE5610lhZomal7thphZrx5IMs8K4
         jA7BJcDOi6W7MPGZQsrvax/RFdaJNNYf0aP4J9pEGCXDa+qPuzbvCghDcGWOFW0ChwBU
         mY+2KTauD4tKmaC4CWRjaHRWmK3Hc1RwnOWzGpY0Z53mtne4wbOP/HztvyhUdgI5zQYY
         7AMY26evjOlmr0t0ImsEBVm2cTsbW70jXdtVpl6IULk6K6oP8EFNP6WE8EgazytvrsTc
         NQAfCWihP8ZwkvVkd/aWYPa6e4C9W8KYXa22yHjJESVI+pyx5DA1Xv62x2VzPgbC3ei6
         6aHQ==
X-Received: by 10.43.128.71 with SMTP id hd7mr4520720icc.36.1416429889036;
        Wed, 19 Nov 2014 12:44:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id am5sm446827igc.12.2014.11.19.12.44.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 12:44:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416423000-4323-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> This patch doesn't intend any functional changes.

Yay. :)

> a refactoring, which replaces a char** array by a stringlist
> in the function repack_without_refs.
> This is easier to read and maintain as it delivers the same
> functionality with less lines of code and less pointers.

Please wrap to a consistent width and add a blank line between
paragraphs.  So, either:

	... repack_without_refs.  This is easier to read and ...

or:

	... repack_without_refs.

	This is easier to read and ...

[...]
> +++ b/builtin/remote.c
> @@ -750,16 +750,11 @@ static int mv(int argc, const char **argv)
[...]
> @@ -1325,6 +1320,9 @@ static int prune_remote(const char *remote, int dry_run)
>  	memset(&states, 0, sizeof(states));
>  	get_remote_ref_states(remote, &states, GET_REF_STATES);
>  
> +	for (i = 0; i < states.stale.nr; i++)
> +		string_list_append(&delete_refs, states.stale.items[i].util);

warn_dangling_symref requires a sorted list.  Possible fixes:

 (a) switch to string_list_insert, or
 (b) [nicer] call sort_string_list before the warn_dangling_symrefs
     call.

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -2639,23 +2639,26 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> -int repack_without_refs(const char **refnames, int n, struct strbuf *err)
> +int repack_without_refs(struct string_list *without, struct strbuf *err)
>  {
>  	struct ref_dir *packed;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>  	struct string_list_item *ref_to_delete;
> -	int i, ret, removed = 0;
> +	int ret, needs_repacking = 0, removed = 0;
>  
>  	assert(err);
>  
>  	/* Look for a packed ref */
> -	for (i = 0; i < n; i++)
> -		if (get_packed_ref(refnames[i]))
> +	for_each_string_list_item(ref_to_delete, without) {
> +		if (get_packed_ref(ref_to_delete->string)) {
> +			needs_repacking = 1;
>  			break;
> +		}
> +	}
>  
> -	/* Avoid locking if we have nothing to do */

This comment was helpful --- it's sad to lose it (but if you feel
strongly about it then I don't mind).

> -	if (i == n)
> -		return 0; /* no refname exists in packed refs */
> +	/* No refname exists in packed refs */
> +	if (!needs_repacking)
> +		return 0;

I kind of liked the 'i == n' test that avoided needing a new auxiliary
variable.  This is fine and probably a little clearer, though.

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -163,8 +163,14 @@ extern void rollback_packed_refs(void);
>   */
>  int pack_refs(unsigned int flags);
>  
> -extern int repack_without_refs(const char **refnames, int n,
> -			       struct strbuf *err);
> +/*
> + * Repacks the refs pack file excluding the refs given
> + * without: The refs to be excluded from the new refs pack file,
> + *          May be unsorted
> + * err: String buffer, which will be used for reporting errors,
> + *      Must not be NULL
> + */
> +extern int repack_without_refs(struct string_list *without, struct strbuf *err);

(nit) Other comments in this file use the imperative mood to describe
what a function does, so it would be a little clearer to do that here,
too ("Repack the ..." instead of "Repacks the ...").

It might be just me, but I find this formatted comment with everything
jammed together hard to read.  I'd prefer a simple paragraph, like:

	/*
	 * Remove the refs listed in 'without' from the packed-refs file.
	 * On error, packed-refs will be unchanged, the return value is
	 * nonzero, and a message about the error is written to the 'err'
	 * strbuf.
	 */

Thanks,
Jonathan
