Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9470C2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 22:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbcGAWLr (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 18:11:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbcGAWLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2016 18:11:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E22F29C1E;
	Fri,  1 Jul 2016 18:11:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PhyEAiRtJa6A
	AcY8Du0gm894hOc=; b=eH7Oipkk8s2lpTjXz5fQuThgTDuGmx3qiasNVgOkIepz
	ckvKmIy4I0/YdsTEzuB16v0R/u3f/jQkGitNPeS5Y72Gk9DgGpZztHGXAnSIrmDY
	xuJTimdSGoPU1Zv6bb9kRtxR68X2t8H4jy5DXvA864viBto4zP9UKufwkr/RwNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MYP4Wk
	QVcUAd5+v42n9N1ZjMpar1zVz9tQy6YKUpricUOxc55ucWGJhIeFD77D80IUonrZ
	9cebp+P7DOoZ+tsFGWnseLlS8mKeh+iS/1wsBY+ji6B660zmoYRgUVK1If2rst6H
	FtHG8AoF5ArXqmM9VYSnHVt0HJQaD6fCZPmRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1705029C1D;
	Fri,  1 Jul 2016 18:11:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8ECEA29C1C;
	Fri,  1 Jul 2016 18:11:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
Date:	Fri, 01 Jul 2016 15:11:42 -0700
In-Reply-To: <62eb3d75-126e-427b-8701-d490e80e3501@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 30 Jun 2016 18:52:20
 +0200")
Message-ID: <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBCB9FB4-3FD8-11E6-B46F-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> The checkout process hopefully does not blindly turn LF into CRLF,
>> making it "first line \r\r\nsame line\r\rn".  Instead the (virtual)
>> working tree file will have "first line\r\nsame line\r\n".
> Yes
>> 
>> Then "git add" should turn that CRLF into LF, which would give us
>> "first line\nsame line\n", but because the "safer autocrlf" rule
>> prevents it from happening.  The (real) index already has CR in it
>> in the blob in stage #2, so the check-in process would (this is not
>> describing the ideal, but what is done by today's code) disable
>> CRLF->LF conversion.
>> 
>> Is that the problem you are trying to solve?
> Not sure, if that problem isn't already solved.

OK, so in short, renormalizing three blobs in the conflicted index
is done correcte because you do not allow safer-crlf kicks in during
the renormalization?

So how does ce_compare_data() judge "first line\r\nsame line\r\n"
in stage #2 and working tree (both with CRLF) not to match?  The
CRLF in working tree data, when run convert_to_git(), will be kept
as CRLF because of safer-crlf rule, and would match, no?  Or do you
disable safer-crlf for that case, too?

> This is my understanding:
> - git checkout and git add are working as expected:
>   LF in blob gives CRLF in the working tree at checkout (if attr says "auto")
>   CRLF in blob gives CRLF in the working tree at checkout.

OK.
>   CRLF in the working tree gives CRLF in the blob at "git add", when
>   the new safer CRLF handling says so.

OK.

> - Merges
>  First the working tree is checked, if it is clean.
>  I haven't digged deep enough to follow the whole code path,
>  but that is what ce_compare_data() does, and it fails in a merge.

OK, I misunderstood what you are trying to fix.  I somehow thought
that you wanted to tweak the renormalization of three blobs.

>  Next thing is that the blobs are merged, and when a blob with CRLF
>  is merged with a blob with LF, there are only conflicts :-(
>  (Remember that both may have CRLF in the worktree)
>  And here renormalize_buffer() comes in (only when "merge.renormalize" is true):
>  - convert the blob with convert_to_working_tree_internal() into the working
>     tree format (but do it in memory), and back to the "blob":
>  - convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE, NULL);
>
>  Note the the "new safer autocrlf" is suppressed here, because of SAFE_CRLF_RENORMALIZE.

That makes sense.

> - check for a clean worktree in ce_compare_data() # fails -> this is the problem to be solved

But it is unclear to me how that need an extra "no, do not look at
the indexed blob, but look at this blob instead"?

The relevant part is this:

diff --git a/read-cache.c b/read-cache.c
index a3ef967..c109b6d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
+		unsigned flags = HASH_USE_SHA_NOT_PATH;
+		memcpy(sha1, ce->sha1, sizeof(sha1));
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
 			match = hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}

I do not quite see how "Don't use ce->sha1, but use sha1 given to
you" flag affects this call, when sha1 and ce->sha1 are the same due
to memcpy() just before the call?

