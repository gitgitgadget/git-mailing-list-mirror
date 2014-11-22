From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] repack_without_refs(): make the refnames argument a
 string_list
Date: Sat, 22 Nov 2014 13:17:22 -0800
Message-ID: <20141122211722.GD15320@google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <1416578950-23210-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:17:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsI3X-0002sv-24
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 22:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbaKVVRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 16:17:17 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36683 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbaKVVRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 16:17:16 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so6960168ier.27
        for <git@vger.kernel.org>; Sat, 22 Nov 2014 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C1qV/qHQ+OkvdPPDkn/MvYV6Yqk7mL0EWO6ufojZvWM=;
        b=oO1yCakZv94QtLHtyvlotc3qFuUrVpEvhIt4rzhCBkoWEZCF50O/jTooCKjlGjbjyK
         qvILw64ggCbxyWXB+qQ5YNFyGC9CMF6vmEIG/lAKbPnAuMHeG1hfwVltfWRf7B2LJLDW
         v/D3+20MD8pM0MgXVmMsJW/TCWQBE7Mz8BBgxdtIz/9ZsTTC271AxEBB1z7FVFh2F/lH
         F77EYuCnx5hnjjExGVgS35Ta6v5j6nds+Lt5ZtZsNSTBzUcogp2DKK0otd2Lh3Ibh6Fd
         QFT67h0S/gw8sTmPzsvmz8jjZ/vj07ybOgL4SpZs73ZyFjgRkcdjv4A6L5CTGBj53zJ2
         p9Lg==
X-Received: by 10.42.144.196 with SMTP id c4mr14910599icv.0.1416691035656;
        Sat, 22 Nov 2014 13:17:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8d62:add2:ab4d:c706])
        by mx.google.com with ESMTPSA id fk8sm1888926igb.9.2014.11.22.13.17.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 22 Nov 2014 13:17:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416578950-23210-5-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260078>

Michael Haggerty wrote:

> All of the callers have string_lists available already

Technically ref_transaction_commit doesn't, but that doesn't matter.

> Suggested-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 14 ++------------
>  refs.c           | 38 ++++++++++++++++++++------------------
>  refs.h           | 11 ++++++++++-
>  3 files changed, 32 insertions(+), 31 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

One (optional) nit at the bottom of this message.

[...]
> +++ b/refs.c
> @@ -2639,22 +2639,25 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> -int repack_without_refs(const char **refnames, int n, struct strbuf *err)
> +int repack_without_refs(struct string_list *refnames, struct strbuf *err)
>  {
>  	struct ref_dir *packed;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
> -	struct string_list_item *ref_to_delete;
> -	int i, ret, removed = 0;
> +	struct string_list_item *refname, *ref_to_delete;
> +	int ret, needs_repacking = 0, removed = 0;
>  
>  	assert(err);
>  
>  	/* Look for a packed ref */
> -	for (i = 0; i < n; i++)
> -		if (get_packed_ref(refnames[i]))
> +	for_each_string_list_item(refname, refnames) {
> +		if (get_packed_ref(refname->string)) {
> +			needs_repacking = 1;
>  			break;
> +		}
> +	}
>  
>  	/* Avoid locking if we have nothing to do */
> -	if (i == n)
> +	if (!needs_repacking)

This makes me wish C supported something like Python's for/else
construct.  Oh well. :)

[...]
> +++ b/refs.h
> @@ -163,7 +163,16 @@ extern void rollback_packed_refs(void);
>   */
>  int pack_refs(unsigned int flags);
>  
> -extern int repack_without_refs(const char **refnames, int n,
> +/*
> + * Remove the refs listed in 'refnames' from the packed-refs file.
> + * On error, packed-refs will be unchanged, the return value is
> + * nonzero, and a message about the error is written to the 'err'
> + * strbuf.
> + *
> + * The refs in 'refnames' needn't be sorted. The err buffer must not be
> + * omitted.

(nit)

s/buffer/strbuf/, or s/The err buffer/'err'/
s/omitted/NULL/

Thanks,
Jonathan
