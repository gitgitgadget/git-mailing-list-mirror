Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193211F42D
	for <e@80x24.org>; Sat, 26 May 2018 01:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030865AbeEZBGR (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 21:06:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54717 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030834AbeEZBGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 21:06:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E204FE1309;
        Fri, 25 May 2018 21:06:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=S4eCHdF8KmzuPkD0C+WejnjxcNo=; b=FLRGpVH
        zezWXz+maEf1oIyTQ00xg5mzJD3j9XMDxaCTTNAx931WRxeGeP1Vs7IWZ9AOD4Ua
        raXwWz3RbGd0Vj6QI3UmyzPe4zPfA1bTNcCv/G1gGl6Fhn/lmxaBuWWB5cDAbqk1
        Xz2rU4ejvp+AI2YaaaZECjS4kTMdZC67Lgdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=j+gPj4WAhQ+fHBgqcPOBt0CNJofbMpNSy
        +fDpIb9+2sf/w7IMuZUhIv9l+P6OBbNrMfPmUoxqyCnsy+HR+bvv4/S8nNshMpFJ
        WtTYp9n8FRKCqT1fVFMQrqdcIveSj4XKpTnrZy+AmvTdElyzqt+grCF48MQ9bhuM
        62H2z58VFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D93A9E1308;
        Fri, 25 May 2018 21:06:13 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C357E1307;
        Fri, 25 May 2018 21:06:13 -0400 (EDT)
Date:   Fri, 25 May 2018 21:06:11 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeremy Linton <lintonrjeremy@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pavel Cahyna <pcahyna@redhat.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
Message-ID: <20180526010611.GI26695@zaya.teonanacatl.net>
References: <20180525231713.23047-1-lintonrjeremy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525231713.23047-1-lintonrjeremy@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: FBFBC964-6080-11E8-BE1A-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Linton wrote:
> The buffer being passed to zlib includes a null terminator that
> git needs to keep in place. unpack_compressed_entry() attempts to
> detect the case that the source buffer hasn't been fully consumed
> by checking to see if the destination buffer has been over consumed.
> 
> This yields two problems, first a single byte overrun won't be detected
> properly because the Z_STREAM_END will then be set, but the null
> terminator will have been overwritten. The other problem is that
> more recent zlib patches have been poisoning the unconsumed portions
> of the buffers which also overwrites the null, while correctly
> returning length and status.
> 
> Lets rely on the fact that the source buffer will only be fully
> consumed when the when the destination buffer is inflated to the
> correct size. We can do this by passing zlib the correct buffer size
> and properly checking the return status. The latter check actually
> already exists if the buffer size is correct.
> 
> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
> ---

As a little background, earlier today Pavel Cahyna filed a
ticket about a regression in a recent zlib update on aarch64
in Fedora[1].

While he was doing that I was just beginning to look at why
the git test suite failed fairly badly a build last
night[2].  The aarch64 build on Fedora 28 failed, while it
succeeded on all other architectures (armv7hl, i686, ppc64,
ppc64le, s390x, x86_64).  It also passed on newer and older
Fedora releases.

The difference was that the Fedora 28 zlib build has some
aarch64 optimization patches applied[3].  (Those patches are
in rawhide/f29 as well, but due to an unrelated issue have
not yet made it into the buildroot used for the git build.)

I'm woefully unqualified to comment on the patch, but if
there are any questions about how this was found, I hope the
above background will be helpful.

A big thanks to Jeremy for dropping whatever he had planned
to do today and dig into this issue.  I can only hope it was
either more fun or less work than what he hoped to do with
his Friday. :)

Thanks also to Pavel for finding the source of the failures
and filing a detailed bug report to get things moving.

[1] https://bugzilla.redhat.com/1582555
[2] https://fedorapeople.org/~tmz/git-aarch64-make-test
[3] https://src.fedoraproject.org/rpms/zlib/c/25e9802

>  packfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/packfile.c b/packfile.c
> index 7c1a2519f..245eb3204 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>  		return NULL;
>  	memset(&stream, 0, sizeof(stream));
>  	stream.next_out = buffer;
> -	stream.avail_out = size + 1;
> +	stream.avail_out = size;
>  
>  	git_inflate_init(&stream);
>  	do {
> @@ -1424,7 +1424,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>  		stream.next_in = in;
>  		st = git_inflate(&stream, Z_FINISH);
>  		if (!stream.avail_out)
> -			break; /* the payload is larger than it should be */
> +			break; /* done, st indicates if source fully consumed */
>  		curpos += stream.next_in - in;
>  	} while (st == Z_OK || st == Z_BUF_ERROR);
>  	git_inflate_end(&stream);

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
An election is coming. Universal peace is declared and the foxes have
a sincere interest in prolonging the lives of the poultry.
    -- T.S. Eliot

