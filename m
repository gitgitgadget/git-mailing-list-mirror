From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/12] delete_ref(): handle special case more explicitly
Date: Mon, 15 Jun 2015 11:22:21 -0700
Message-ID: <xmqqbnggal2a.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<0c66a6bd6e49b9c28fa3617ee50de746ef4ea9a3.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:22:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Z1i-0006CP-1K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbbFOSW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:22:26 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37990 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbbFOSWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:22:24 -0400
Received: by igblz2 with SMTP id lz2so56765584igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Tr91j5r8DPHdv7XwU4QdoYi835zyiIW0GNatY1LPOHk=;
        b=zrsuBs0nTqQ9gEdeekZPPtGNJFF6/BbSgC7UwMnzzEPEnOPZXZUuA952AX/hB2SqwS
         3DI4lbZEscM4eXVSB+hAsy2rxSlyv0li4YsW43SJimzxo2X5hl3rbdyszxjeUvg61qLU
         8Xooq+t8fz6VzDVXoECl30dTvYZYHEYSubz8G3NZTsKMC9w8BRJN1e7uqWQNTDE1mGpG
         mTp0fDR7h4Kr+QMpv8cUBcIVlrBSEUeKyy/1vRCIf8TM5bKEHoNNLxIcaG1N6mZLY1zv
         3VxcujbvrT751PkQsTHcyYRbUqGX7s9nSOrZNB6Ufw5PVW+9zxSoV1KFlGXnW8s1nCUd
         a0Zg==
X-Received: by 10.42.135.131 with SMTP id p3mr31836364ict.81.1434392544104;
        Mon, 15 Jun 2015 11:22:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id d81sm9356704ioe.12.2015.06.15.11.22.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:22:22 -0700 (PDT)
In-Reply-To: <0c66a6bd6e49b9c28fa3617ee50de746ef4ea9a3.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271697>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> delete_ref() uses a different convention for its old_sha1 parameter
> than, say, ref_transaction_delete(): NULL_SHA1 means not to check the
> old value. Make this fact a little bit clearer in the code by handling
> it in explicit, commented code rather than burying it in a conditional
> expression.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

I think this is a very sensible first step, but I wonder if
delete_ref() should be taught the difference between "we do not
expect anything" and "we expect it not to exist".

>  refs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index b575bb8..f0b6cec 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2795,10 +2795,17 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
>  
> +	/*
> +	 * Treat NULL_SHA1 and NULL alike, to mean "we don't care what
> +	 * the old value of the reference was (or even if it didn't
> +	 * exist)":
> +	 */
> +	if (old_sha1 && is_null_sha1(old_sha1))
> +		old_sha1 = NULL;
> +
>  	transaction = ref_transaction_begin(&err);
>  	if (!transaction ||
> -	    ref_transaction_delete(transaction, refname,
> -				   (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
> +	    ref_transaction_delete(transaction, refname, old_sha1,
>  				   flags, NULL, &err) ||
>  	    ref_transaction_commit(transaction, &err)) {
>  		error("%s", err.buf);
