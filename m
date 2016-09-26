Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E891207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034445AbcIZTvY (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:51:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52797 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936198AbcIZTvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:51:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3A4D41601;
        Mon, 26 Sep 2016 15:51:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EsY6FIgKvnmnOXu00kalM2GgoDo=; b=k6apOW
        pzLoYST+e2NmO9OoHEU8XA1mYOPEtOV/AVhBf00oAxET/SRztBVfwxE6rYqSN++q
        kkp7yrEyJ6M4zjVFiOBdImEZXaUMm3y450caMEKy01XqyvRO8odhiIMo2w0bf6bK
        TzPM3ugERfHW42T8cJ3/Lvjt66dWbohhG5XiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N/oz4XrBICZRJlRg6ptGIfcKPamb+NUb
        nkJ0Zr8gFRWVhgGsWlACYrhYTv0Pkioyc+tNr+AKfAwMQPtCaLB+Yvhdce3qcBEn
        pP9Cs3KdxSN5CJUuPUgs8J9cITH+pNSMa8M1Wf4TTqMEfGQYM5mP3QJwpXB9xMoM
        dKldJfSE9vg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD11841600;
        Mon, 26 Sep 2016 15:51:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 540A6415FF;
        Mon, 26 Sep 2016 15:51:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 2/2] fsck: handle bad trees like other errors
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
        <1474918365-10937-3-git-send-email-novalis@novalis.org>
Date:   Mon, 26 Sep 2016 12:51:19 -0700
In-Reply-To: <1474918365-10937-3-git-send-email-novalis@novalis.org> (David
        Turner's message of "Mon, 26 Sep 2016 15:32:45 -0400")
Message-ID: <xmqqlgyeqw20.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9917B33A-8422-11E6-85B5-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> @@ -535,7 +536,10 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
>  	unsigned o_mode;
>  	const char *o_name;
>  
> -	init_tree_desc(&desc, item->buffer, item->size);
> +	if (init_tree_desc_gently(&desc, item->buffer, item->size)) {
> +		retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
> +		return retval;
> +	}

Good.  If BAD_TREE is being ignored, this may report a non-error,
but we won't descend into the unreadable tree so it is OK.

> @@ -556,7 +560,10 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
>  			       is_hfs_dotgit(name) ||
>  			       is_ntfs_dotgit(name));
>  		has_zero_pad |= *(char *)desc.buffer == '0';
> -		update_tree_entry(&desc);
> +		if (update_tree_entry_gently(&desc)) {
> +			retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
> +			break;
> +		}

Likewise; breaking out of the loop will stop us from reading further
into the corrupted tree data, so this is good.

> @@ -597,7 +604,6 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
>  		o_name = name;
>  	}
>  
> -	retval = 0;

Good code hygiene that you moved this to the very top where it is
defined, so anybody before this step can set it if it wants to.

Reading purely from the text of this function, it was surprising
that you can do without a gently variant of tree_entry_extract(),
but it merely reads into two variables and does not do any error
detection (which happens all in the caller), so it is not at all
surprising after all ;-)

I didn't see anything objectionable in this patch.  Thanks for
working on this.
