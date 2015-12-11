From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 11 Dec 2015 15:33:28 -0800
Message-ID: <xmqqr3isd0hj.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7XC1-00085c-7V
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 00:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbbLKXdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 18:33:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753088AbbLKXdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 18:33:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1414D33767;
	Fri, 11 Dec 2015 18:33:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7i73KRjvf/9icL7yP19sUq4Rxo=; b=kMiD6u
	SGNSEqQwXw2CVO4IdOdsBpZ4YiY4ed2+g/9K+VrxSSDEgi0XJ6pW/E9zTXP35YEk
	JYVAvKXSTlDUIfjtH6p6sSqpuBvEAgRF+nDF5x2604gqqyJW2+3mF59xc5rqKorJ
	uqwtkxvEWxU6FkrGJ53ORkjkd74hvrMqQJFQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLV3S6U+HTiawGRotKM6sT/f7p3VokFU
	t2U82SDinU6jBahKJQLLGe7u+ckq9szsu3bT7IwtckkqA9FbJbJx5KR6mOC1uhp5
	yHWPzoI1OKH0hHo5wBWavSAHkpu+Lggy0UcHP1MYk+aORR//TUeIjgfzB0EYE+u9
	j0YLV6UFUvY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B1DD33766;
	Fri, 11 Dec 2015 18:33:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 81AB733764;
	Fri, 11 Dec 2015 18:33:29 -0500 (EST)
In-Reply-To: <1449102921-7707-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Dec 2015 19:35:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 958E2994-A05F-11E5-A789-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282285>

David Turner <dturner@twopensource.com> writes:

> diff --git a/cache.h b/cache.h
> index 51c35c3..707455a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1111,6 +1111,13 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
>  extern int interpret_branch_name(const char *str, int len, struct strbuf *);
>  extern int get_sha1_mb(const char *str, unsigned char *sha1);
>  
> +/*
> + * Return true iff abbrev_name is a possible abbreviation for
> + * full_name according to the rules defined by ref_rev_parse_rules in
> + * refs.c.
> + */
> +extern int refname_match(const char *abbrev_name, const char *full_name);
> +
>  extern int validate_headref(const char *ref);

This hunk is strange.  It duplicates what is in refs.h, risking the
two copies to drift away from each other over time.

As the only callsites are in remote.c that includes refs.h, this
probably should be dropped.

Other changes that give redirection to various operations via vtable
looked all sensible.

>  struct ref_be {
>  	struct ref_be *next;
>  	const char *name;
>  	ref_transaction_commit_fn *transaction_commit;
> +
> +	pack_refs_fn *pack_refs;
> +	peel_ref_fn *peel_ref;
> +	create_symref_fn *create_symref;
> +
> +	resolve_ref_unsafe_fn *resolve_ref_unsafe;
> +	verify_refname_available_fn *verify_refname_available;
> +	resolve_gitlink_ref_fn *resolve_gitlink_ref;
>  };
>  
>  #endif /* REFS_REFS_INTERNAL_H */
