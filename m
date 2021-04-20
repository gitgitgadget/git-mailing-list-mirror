Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C151C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DE1613D3
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDTVlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:41:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58105 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhDTVlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:41:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B14FB9890;
        Tue, 20 Apr 2021 17:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bk2ph84ApJaYcMWRbWL++wV6IeA=; b=ZTWy5r
        9PL59T4PoUWj7pTLwv4Ztg/GdXBdyWh8FeZyQ/amt3CNuybPlLzQj4bvE7F1J8Tw
        iFmXSU49E9ZVQUU2W2pveprLZzH/9mLrc9tHfWxkX7N9bTi4wYcXObc9hWUGVOX2
        UojZegp8pZzuauPSi8aQgMykPqTjwe0NmC2Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MfXD+K96J0JvO0XD753LrATncld4yK+q
        TNQNFwyRjv5606m+6tTzbKNWWnpVLm+HS58wnYp2IW5HnOx1DZSh4gA/nLXsGn5G
        DxuldshJ9LULB53cMic2RE9qujGdWNunOePQQMhhYkyLtdB/L8EuOoK14zgvlsyh
        C/iDYztTw3k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C191B988E;
        Tue, 20 Apr 2021 17:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC0E3B988A;
        Tue, 20 Apr 2021 17:40:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
Date:   Tue, 20 Apr 2021 14:40:37 -0700
In-Reply-To: <20210420190552.822138-1-lukeshu@lukeshu.com> (Luke Shumaker's
        message of "Tue, 20 Apr 2021 13:05:52 -0600")
Message-ID: <xmqqa6ps4otm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C393BF6-A221-11EB-B26D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> That'd work fine if they're lightweight tags, but if they're annotated
> tags, then after the rename the internal name in the tag object
> (`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
> is still mostly fine, since not too many tools care if the internal
> name and the refname disagree.
>
> But, fast-export/fast-import are tools that do care: it's currently
> impossible to represent these tags in a fast-import stream.
>
> This patch adds an optional "name" sub-command to fast-import's "tag"
> top-level-command, the stream
>
>     tag foo
>     name bar
>     ...
>
> will create a tag at "refs/tags/foo" that says "tag bar" internally.
>
> These tags are things that "shouldn't" happen, so perhaps adding
> support for them to fast-export/fast-import is unwelcome, which is why
> I've marked this as an "RFC".  If this addition is welcome, then it
> still needs tests and documentation.

I actually think this is a good direction to go in, and it might be
even an acceptable change to fsck to require only the tail match of
tagname and refname so that it becomes perfectly OK for Gitk's
"v0.0.1" tag to be stored at say "refs/tags/gitk/v0.0.1".

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 39cfa05b28..6514b42d28 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -824,6 +824,7 @@ lightweight (non-annotated) tags see the `reset` command below.
>  ....
>  	'tag' SP <name> LF
>  	mark?
> +	('name' SP <name> LF)?
>  	'from' SP <commit-ish> LF
>  	original-oid?
>  	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF

The documentation after this part must be updated, too.  Here is my
attempt.

 Documentation/git-fast-import.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git c/Documentation/git-fast-import.txt w/Documentation/git-fast-import.txt
index 39cfa05b28..c3c5a7ed16 100644
--- c/Documentation/git-fast-import.txt
+++ w/Documentation/git-fast-import.txt
@@ -822,22 +822,28 @@ Creates an annotated tag referring to a specific commit.  To create
 lightweight (non-annotated) tags see the `reset` command below.
 
 ....
-	'tag' SP <name> LF
+	'tag' SP <refname> LF
 	mark?
+	('name' SP <tagname> LF)?
 	'from' SP <commit-ish> LF
 	original-oid?
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
 
-where `<name>` is the name of the tag to create.
+where `<refname>` is also used as `<tagname>` if `name` option is
+not given.
 
-Tag names are automatically prefixed with `refs/tags/` when stored
+The `<tagname>` is used as the name of the tag that is stored in the
+tag object, while the `<refname>` determines where in the ref hierarchy
+the tag reference that points at the resulting tag object goes.
+
+The `<refname>` is prefixed with `refs/tags/` when stored
 in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
-use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
+use just `RELENG-1_0-FINAL` for `<refname>`, and fast-import will write the
 corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
 
-The value of `<name>` must be a valid refname in Git and therefore
+The `<refname>` must be a valid refname in Git and therefore
 may contain forward slashes.  As `LF` is not valid in a Git refname,
 no quoting or escaping syntax is supported here.
 
