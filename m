Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D6E1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 16:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGQQoL (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 12:44:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62989 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQQoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 12:44:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D1096A436;
        Wed, 17 Jul 2019 12:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xMoU/5+mmz8H1HoCNlC84U6xlBk=; b=kFDGUz
        AOCXY4KFz+IA7KSuVw59JQkEXMU9UMoUEbpd0kp/2ejuFKtmgdRNZVLshEHVREpE
        LmXyGqnT3fDtzJtDKT0dGacMCXFi2IqErUXxVlTTyRnwuMUZT2Lbg9MW3njQ8Bez
        7UfPDJufiPE4c2SFaojimm69c3blUuPhP135g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aJiXaEx1nMRVWEbcCN08qdIXbLFu1YCU
        DjnW5lQia/O+MK1hWUleLBDWKLWnuc3Atf4fmmCAfgWMDOLZRdFstdytbW7m7Djg
        agc0G3Bb2ilPtEeMHZWjUw8JysdJUYTeCcVaB3UC8zI+53LlRZWJ1yn+gViwhDH5
        4xA2awPWp9U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 955FF6A435;
        Wed, 17 Jul 2019 12:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4DD16A432;
        Wed, 17 Jul 2019 12:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Merge: "git rm bla": "bla: needs merge", but still removes file "bla"
References: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de>
Date:   Wed, 17 Jul 2019 09:44:03 -0700
In-Reply-To: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Wed, 17 Jul 2019 09:58:05 +0200")
Message-ID: <xmqqd0i81ui4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17308CC2-A8B2-11E9-B7EF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> I just had "an interesting case" for a merge with conflicts:
> The merge re-introduced a file that had been renamed (say old one is "bla", and the new one is "foo").
> After merging the changes from bla into foo, I added foo, trying to remove bla:
>> git add foo
>> git rm bla
> bla: needs merge
> rm 'bla'

Yeah, I think I've known about this for a long time.  We have an
internal call to "update-index --refresh" before starting to remove,
because we need to know which path is up-to-date wrt the index, and
the machinery for refreshing the index by default gives the "needs
merge" message.  We never bothered to squelch it.

Perhaps this one-liner would be a sufficient fix.



 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 2eacda42b4..19ce95a901 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -273,7 +273,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
-	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
 
