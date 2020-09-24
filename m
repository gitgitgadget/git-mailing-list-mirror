Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15858C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C407B206CD
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lbyn7HiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgIXSz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 14:55:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63096 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgIXSz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 14:55:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 094C392C53;
        Thu, 24 Sep 2020 14:55:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MORVpe5Ep8wYuYpxPsXIdW4uf/c=; b=lbyn7H
        iSAs/vFLjOj0eeT8j3EiBPrKyZA+734uA+RPhZcQMmaNNLHzrB6IR7MnFQa3OEfO
        8DLCLs/KP3BC0DeoWCnejVbevvr4wSR8L/yIOuSQnfFCbV5aOgnOVYfaORL5EFAG
        UHe6ERlXEkiCAsmZ+uNx6bMKr1ogc5QtSb9aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P+HvgrgHD5NleymOqQ3wNg0vJIji94bu
        bEKe98MkFjqRImGr0JkJZ2f1sn5SMDGAV4OpZdw55hXj+9DTmlc5j3lFXZCkbrM9
        wprdkFRylEC4/gi2pL9mabx2y1d4x8+u4mX/46AZ5+V1kpQDAoS+JSkieQwtbRLO
        /sPNbTrPUng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F40D792C52;
        Thu, 24 Sep 2020 14:55:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7517192C51;
        Thu, 24 Sep 2020 14:55:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <20200924060344.15541-1-chriscool@tuxfamily.org>
Date:   Thu, 24 Sep 2020 11:55:53 -0700
In-Reply-To: <20200924060344.15541-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 24 Sep 2020 08:03:44 +0200")
Message-ID: <xmqqsgb7m2bq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92D22A66-FE97-11EA-8B3E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> -		} else {
> -			char *commit_id = xstrfmt("%s^{commit}", arg);
> -			if (get_oid(commit_id, &oid) && has_double_dash)
> -				die(_("'%s' does not appear to be a valid "
> -				      "revision"), arg);
> -
> +		} else if (!get_oid_committish(arg, &oid))

This is wrong, I think.  The "_committish" only applies to the fact
that the disambiguation includes only the objects that are
committishes, and the result are not peeled---you'll get an
annotated tag back in oid, if you give it an annotated tag that
points at a commit.

This is not what ^{commit} does.

It may happen to work if the downstream consumers peel objects
(which are appended to the 'revs' here) down to commit when they are
used, and if somebody verified that is indeed the case, it would be
OK, but if this patch is presented as "unlike the previous broken
one, this is the faithful conversion of the original in shell, so
there is no need to verify anything outside of the patch context",
that is a problem.

We may need to audit recent additions of get_oid_committish() calls
in our codebase.  I suspect there may be other instances of the same
mistake.

Other than that, the code structure does look more straight-forward
compared to the previous round.  A fix on this version would involve
peeling what is in oid down to commit, and you need to handle errors
during that process, so it may not stay pretty with a fix, though.
I dunno.

Thanks.

>  			string_list_append(&revs, oid_to_hex(&oid));
> -			free(commit_id);
> -		}
> +		else if (has_double_dash)
> +			die(_("'%s' does not appear to be a valid "
> +			      "revision"), arg);
> +		else
> +			break;
>  	}
>  	pathspec_pos = i;
>  
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index b886529e59..70c39a9459 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
>  	git bisect bad $HASH4
>  '
>  
> +test_expect_success 'bisect start without -- uses unknown arg as path restriction' '
> +	git bisect reset &&
> +	git bisect start foo bar &&
> +	grep foo ".git/BISECT_NAMES" &&
> +	grep bar ".git/BISECT_NAMES"
> +'
> +
>  test_expect_success 'bisect reset: back in the master branch' '
>  	git bisect reset &&
>  	echo "* master" > branch.expect &&
