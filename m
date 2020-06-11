Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C9FC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA1D2065C
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKnfNbav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFKPFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:05:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51012 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFKPFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:05:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3009CE586;
        Thu, 11 Jun 2020 11:05:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xI26NpELMxE5yt/nES0XJw9jLt0=; b=FKnfNb
        avO/83s/oVDdXIYrpWE0n3LJC65GmtpAVqDQAadzgWrwQo5yyNJHUxgS4GJTXJXy
        /EWkedecWXVdWKb2K+Znq9/J35Mr21wySnW3XCJ6EJRWqO3cvkRZe7Y3FNaeTZp5
        muGh1WkXuGKEvZWbLkiVGOuwpzUOXmNOZblvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TGA+sd50A7cW67TSqrLO6XPy1oXzj4Jb
        zvkQ35VNMt64QZUYlw2AenEWAlvEDwRqUdtz2+F48HROO+N/4PWJrc3MgyBAq9gQ
        F2gmf/nJVam+fwxSMg8u4WCAUk/NeOK+zePJMfbcGFj5XjjfUE6sfF+YvjRfElq2
        DsrYYNShTzA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B8F9CE585;
        Thu, 11 Jun 2020 11:05:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5005CE583;
        Thu, 11 Jun 2020 11:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Jun 2020 08:05:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 11 Jun 2020 16:05:24 +0200 (CEST)")
Message-ID: <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 034CAD3E-ABF5-11EA-A2F3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It is a good argument.  I also heard a rumor that often branch names
>> contain codewords given to pre-released hardware that are highly
>> confidential in certain circles, and heard that it is one of the
>> reasons why Gerrit has server side ACL that lets you hide some
>> branches from authenticated users that can access other branches.
>
> Yes, branch names in general _can_ contain information users may prefer to
> keep private.
>
> However, we're not talking about branch names in general. We are talking
> about the default name of the main branch, to be picked in _all_ of your
> new repositories.

No, we are talking about the name of the branch, chosen to be the
primary one, in one particular repository whose contents are
exported via fast-export with explicit request from the user to
anonymize end-user data.

> Yes. And you're unlikely to configure the default name to be used for all
> of your future `git init` operations to be something non-generic.
>
> Now, if you suggest that `git fast-export --anonymize` should either not
> special-case the main branch, or at least have a configurable set of names
> it skips from protecting, then I will be much more in favor of those
> suggestions. However, those suggestions are quite a bit orthogonal to the
> patch series at hand, so I would want to discuss them in their own code
> contribution instead of here.


I think after writing the message about your "two variable"
approach, you would retract the "something non-generic" part in the
above sentence.  The original "we redact branch names but 'master'
is used by and known by everybody so there is no need to redact"
would have been a good argument.  Perhaps there is a value to keep
the primary branch identifiable even in an export stream that has
all the refnames and payload anonymized, and leaving 'master' intact
would have been a viable approach for solving that issue.

That trick NO LONGER applies once you allow the name of the primary
branch customizable, and the end user has used a name that is not to
be exposed.  Yes, "we want to ensure that readers of the export
stream can identify which ref is the primary branch of the
repository" is orthogonal from "how do we make primary branch
configurable in a live repository?" and "how do we make the default
name used for the primary branch in repositories newly created?".
But because the old solution would not work in the new world order
this topic created, a new solution needs to be found when you move
the world to the new order.

An easy solution would be to reserve "ref0" for the primary branch
in the repository and anonymize other refs "ref1", "ref2", ...

That can be done as a preparatory step regardless of the "'master'
may not be in the name of the primary branch in this repository"
topic.

-- >8 --
Subject: [PATCH] fast-export: do anonymize the primary branch name

In a fast-export stream with --anonymize option, all the end-user
data including refnames are munged to prevent exposure, but the
'master' branch is left intact.

There is a comment that explains why it is OK to leave 'master'
unanonymized (because everybody calls the primary branch 'master'
and it is no secret), but that does not justify why it is bad to
anonymize 'master' and make it undistinguishable from other
branches.  Assuming there _is_ a need to allow the readers of the
output to tell where the tip of the primary branch is, let's keep
the special casing of 'master', but still anonymize it to "ref0".
Because all other branches will be given ref+N where N is a positive
integer, this will keep the primary branch identifiable in the
output stream, without exposing what the name of the primary branch
is in the repository the export stream was taken from.

This is in preparation for introducing a mechanism to affect the
name of the primary branch used in the repository.  Once the
mechanism is in use, the name of the primary branch won't be
'master', and may not be allowed to be exposed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fast-export.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85868162ee..a306a60d25 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -497,7 +497,7 @@ static void *anonymize_ref_component(const void *old, size_t *len)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
-	strbuf_addf(&out, "ref%d", counter++);
+	strbuf_addf(&out, "ref%d", ++counter);
 	return strbuf_detach(&out, len);
 }
 
@@ -522,7 +522,7 @@ static const char *anonymize_refname(const char *refname)
 	 * anything interesting.
 	 */
 	if (!strcmp(refname, "refs/heads/master"))
-		return refname;
+		return "ref0";
 
 	strbuf_reset(&anon);
 	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
