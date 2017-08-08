Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D664920899
	for <e@80x24.org>; Tue,  8 Aug 2017 21:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdHHVBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 17:01:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50892 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752246AbdHHVBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 17:01:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB1199F240;
        Tue,  8 Aug 2017 17:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RaHZCRYZPCeXcycuLbYPYEf0bFE=; b=Ii3B9G
        rCFdC0XQkQA7UGePvgSl42BujsR6ldqjWy13IZ5Zb8J/ishJG4Zk8HRxu6tvpXja
        /pAXf52iV4Bh/l5UK30WfmTvQqWJxsK1zISpUZKT32nNXsFJR2CtJkbc46rmSMon
        Y+Ju5VyM2QnEhy5rxaQouudmwdeeODZDZeKDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MOVqRo6SAmCQ96t6AyoiRBSL7tdMg/Kl
        8wKGjkEtT71MKTiwXdHlYeGOh74l5DEqrQmY9LHbeA+3OgKJSstH4kqtyZGmi4Oa
        45VD8LjMzM2aMI4xVWOH5B2MB2xLmzR0uvRJCSTKzI7iBjRk2ITcvxuWwL7kIwSH
        TM+TmMeZgpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B29829F23F;
        Tue,  8 Aug 2017 17:00:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20A2F9F23E;
        Tue,  8 Aug 2017 17:00:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style tags which lack tagger
References: <1502179560.2735.22.camel@hellion.org.uk>
        <20170808080620.9536-2-ijc@hellion.org.uk>
Date:   Tue, 08 Aug 2017 14:00:52 -0700
In-Reply-To: <20170808080620.9536-2-ijc@hellion.org.uk> (Ian Campbell's
        message of "Tue, 8 Aug 2017 09:06:20 +0100")
Message-ID: <xmqqzib9ai63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AACD4A42-7C7C-11E7-84FD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> Such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel source tree.
>
> Insert a fake tag header, since newer `git mktag` wont accept the input
> otherwise:
>
>     $ git cat-file tag v2.6.12-rc2
>     object 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>     type commit
>     tag v2.6.12-rc2
>
>     Linux v2.6.12-rc2 release
>     -----BEGIN PGP SIGNATURE-----
>     Version: GnuPG v1.2.4 (GNU/Linux)
>
>     iD8DBQBCbW8ZF3YsRnbiHLsRAgFRAKCq/TkuDaEombFABkPqYgGCgWN2lQCcC0qc
>     wznDbFU45A54dZC8RZ5JxyE=
>     =ESRP
>     -----END PGP SIGNATURE-----
>
>     $ git cat-file tag v2.6.12-rc2 | git mktag
>     error: char76: could not find "tagger "
>     fatal: invalid tag signature file
>     $ git cat-file tag v2.6.13-rc4 | git mktag
>     7eab951de91d95875ba34ec4c599f37e1208db93
>
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> ---
>  git-filter-branch.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index d07db3fee..6927aa2da 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -540,6 +540,9 @@ if [ "$filter_tag_name" ]; then
>  			new_sha1=$( ( printf 'object %s\ntype commit\ntag %s\n' \
>  						"$new_sha1" "$new_ref"
>  				git cat-file tag "$ref" |
> +				awk '/^tagger/	{ tagged=1 }
> +				     /^$/	{ if (!tagged && !done) { print "tagger Unknown <unknown@example.com> 0 +0000" } ; done=1 }
> +				     //		{ print }' |
>  				sed -n \
>  				    -e '1,/^$/{
>  					  /^object /d

What the change wants to do makes perfect sense, but piping output
from awk into sed looks somewhat gross.  Perhaps we'd want to roll
what the existing sed script is trying to do into this new awk
script?


