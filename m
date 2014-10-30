From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/15] refs.c: add an err argument to pack_refs
Date: Thu, 30 Oct 2014 12:57:39 -0700
Message-ID: <xmqqr3xpuy8c.fsf@gitster.dls.corp.google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-16-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 20:57:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjvqs-0004xY-3C
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 20:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbaJ3T5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 15:57:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933566AbaJ3T5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 15:57:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE0B119602;
	Thu, 30 Oct 2014 15:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yjW5yhQST2cTSrmzRmKn8ch3gdY=; b=Ouui/J
	rrs82klrS2031GJ8Qls04Q9F3qIhXUVf55GfuKGvBBhjwijmnhMN0Ns/yTMxv5D+
	8QqCxs2s+6W+X7Xk7Cd2VlCyTN2aVg1120WvFHXLKNtEs2ksdGF84A0k0bVNT/ho
	5rcfMQBaIsQEmWaX/7sIGvWLK5jeZRlcC8HY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IXk0TJO40Jx/iDVqCDhQMB+d/8iLNvEI
	te68I8DvR+QI45PBwgJLugNctdXx9aLNQFF3eCMzyEqmH4bYT8YdTpbZ0PHAyX31
	ZZvUjkogIUtw5c382B128cquX4o54a/HAJ3CUqIYu8v5TCMFrOf9jQsJhSUqJU9i
	xEuT/GFP4X4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B45A919601;
	Thu, 30 Oct 2014 15:57:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34A3E19600;
	Thu, 30 Oct 2014 15:57:40 -0400 (EDT)
In-Reply-To: <1413923820-14457-16-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:37:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00FE1E78-606F-11E4-A45C-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
> index b20b1ec..299768e 100644
> --- a/builtin/pack-refs.c
> +++ b/builtin/pack-refs.c
> @@ -10,6 +10,7 @@ static char const * const pack_refs_usage[] = {
>  int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned int flags = PACK_REFS_PRUNE;
> +	struct strbuf err = STRBUF_INIT;
>  	struct option opts[] = {
>  		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
>  		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
> @@ -17,5 +18,10 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>  	};
>  	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
>  		usage_with_options(pack_refs_usage, opts);
> -	return pack_refs(flags);
> +	if (pack_refs(flags, &err)) {
> +		error("%s", err.buf);
> +		strbuf_release(&err);
> +		return -1;
> +	}
> +	return 0;
>  }
> diff --git a/refs.c b/refs.c
> index 7fb0d6c..a5e1eff 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2588,16 +2588,15 @@ static void prune_refs(struct ref_to_prune *r)
>  	}
>  }
>  
> -int pack_refs(unsigned int flags)
> +int pack_refs(unsigned int flags, struct strbuf *err)
>  {
>  	struct pack_refs_cb_data cbdata;
> -	struct strbuf err = STRBUF_INIT;
>  
>  	memset(&cbdata, 0, sizeof(cbdata));
>  	cbdata.flags = flags;
>  
> -	if (lock_packed_refs(&err))
> -		die("%s", err.buf);
> +	if (lock_packed_refs(err))
> +		return -1;
>  
>  	cbdata.packed_refs = get_packed_refs(&ref_cache);
>  
> diff --git a/refs.h b/refs.h
> index f3e08f5..be16c08 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -130,8 +130,9 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
>  /*
>   * Write a packed-refs file for the current repository.
>   * flags: Combination of the above PACK_REFS_* flags.
> + * Returns 0 on success and fills in err on failure.
>   */
> -int pack_refs(unsigned int flags);
> +int pack_refs(unsigned int flags, struct strbuf *err);
>  
>  extern int ref_exists(const char *);

Makes sense.
Thanks.
