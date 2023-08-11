Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EBC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 01:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjHKBBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHKBBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 21:01:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3DF273E
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:01:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61B531B6B87;
        Thu, 10 Aug 2023 21:01:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hEU+l7uzYZmAP/E1HCLxqJxL55LzRymEpRbnmx
        RfNBg=; b=lIrDCZzzhJwNpXtNrpdtiofQt9m40FyeC63zHguDLXE0R9YS09WMsI
        5k+F4vZ9CZ8qfNgZw44myHaf5HTBhzBMacmhlD4zXZ4PbWFbzpFklZUW9mQMFQo0
        /fMTrXpeyr5pzft8RPJXGntZKdG984p597Jejg3DpaGrM8B4sYixg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A0AD1B6B86;
        Thu, 10 Aug 2023 21:01:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC19F1B6B85;
        Thu, 10 Aug 2023 21:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
References: <20230810004956.GA816605@coredump.intra.peff.net>
        <20230810011831.1423208-1-wesleys@opperschaap.net>
Date:   Thu, 10 Aug 2023 18:01:12 -0700
In-Reply-To: <20230810011831.1423208-1-wesleys@opperschaap.net> (Wesley
        Schwengle's message of "Wed, 9 Aug 2023 21:18:31 -0400")
Message-ID: <xmqqcyzupf3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9179F31A-37E2-11EE-AAD9-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

> diff --git a/git-svn.perl b/git-svn.perl
> index be987e316f..93f6538d61 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> ...
> -	if ($@) {
> -		$term = new FakeTerm "$@: going non-interactive";
> +		$term = $ENV{"GIT_SVN_NOTTY"}
> +				? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
> +				: new Term::ReadLine 'git-svn';
> +		};

This line with "};" on it should not be added, I think.

cf. https://github.com/git/git/actions/runs/5827208598/job/15802787783#step:5:74

> +		return $term;
>  	}
>  }

 git-svn.perl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 93f6538d61..e919c3f172 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -307,7 +307,6 @@ package main;
 		$term = $ENV{"GIT_SVN_NOTTY"}
 				? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
 				: new Term::ReadLine 'git-svn';
-		};
 		return $term;
 	}
 }
-- 
2.42.0-rc1

