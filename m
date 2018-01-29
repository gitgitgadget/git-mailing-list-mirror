Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8577E1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 18:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeA2Snz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 13:43:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55388 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeA2Snu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 13:43:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBC47D656E;
        Mon, 29 Jan 2018 13:43:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=XWJGDKgCHY3YVPS7QZ1IYWKjKa0=; b=qsszS+D
        d3DwIdn4dn0iNzBUSQaGrS0xlOTxI/ECk+Dj5l4LY0qHtuC5BFiurqnhHEQ5QD71
        t/CbTratBT/8zIfFuV43dM4eGrk9XWMOkguMIkPZ77Q6h4rCB1rPg9mxsMmFsTo7
        Emnsgq8tppH4sy8nPvDOhFKOK/fE2f1A62nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=yL6PWPRHOK/TGpSc8eArLbo3NT5kgn3U1
        7HYS5rbLZLnaKNJthQytTfwEoF0ZnA5RHYPc6ZAUhAitkG3Ev0/5uhXtKlJNPgzt
        /hrULMfwn9kYF05G1ILTY9yUMKN3wVgKgyMGkWzS2q/6+QOcOrKFC6lBJrX3z1hF
        VHB/mHzFZ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3F9AD656D;
        Mon, 29 Jan 2018 13:43:47 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E14BD656C;
        Mon, 29 Jan 2018 13:43:47 -0500 (EST)
Date:   Mon, 29 Jan 2018 13:43:45 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: t9128 failing randomly with svn 1.9?
Message-ID: <20180129184345.GI1427@zaya.teonanacatl.net>
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
 <20180129025812.GD1427@zaya.teonanacatl.net>
 <20180129120627.al2xvx4yhhvwn6ih@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129120627.al2xvx4yhhvwn6ih@untitled>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: 572D0AB8-0524-11E8-9711-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote:
> Todd Zullinger <tmz@pobox.com> wrote:
> Just a guess, but it might be related to destruction order.
> Running t9128 on a 32-bit Pentium-M, it took me 39 tries to
> fail.
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 76a75d0b3d..2ba14269bb 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1200,6 +1200,11 @@ sub cmd_branch {
>  	$ctx->copy($src, $rev, $dst)
>  		unless $_dry_run;
>  
> +	# Release resources held by ctx before creating another SVN::Ra
> +	# so destruction is orderly.  This seems necessary Subversion 1.9.5
> +	# to avoid segfaults.
> +	$ctx = undef;
> +
>  	$gs->fetch_all;
>  }
>  
> I'll be looping t9128, t9141 and t9167 with that for a few
> hours or day.  Will report back sooner if it fails.
> I'm on an ancient 32-bit system, I guess you guys encountered
> it on 64-bit machines?

Yeah.  I saw it on numerous architectures, x86 and x86_64.
I believe I saw it on aarch64 and ppc as well, but I don't
have build logs at hand to confirm.

I'm running the tests with and without your patch as well.
So far I've run t9128 300 times with the patch and no
failures.  Without it, it's failed 3 times in only a few
dozen runs.  That's promising.

Thanks for poking this Eric, and Brian for bringing it up.
I had intended to look at it again and mention it,
eventually. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I figure that if God actually does exist, He's big enough to
understand an honest difference of opinion.
    -- Isaac Asimov

