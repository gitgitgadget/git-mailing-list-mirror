Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D82C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiIGUuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiIGUuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:50:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3BE48CBB
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:50:13 -0700 (PDT)
Received: (qmail 23410 invoked by uid 109); 7 Sep 2022 20:50:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Sep 2022 20:50:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14659 invoked by uid 111); 7 Sep 2022 20:50:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 16:50:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 16:50:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
Message-ID: <YxkEAx/qq5Rmn/Yx@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
 <6018c526-4641-8374-8802-cfda5be330c3@github.com>
 <3f901613-72c6-b644-079a-f74e3024a8fe@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f901613-72c6-b644-079a-f74e3024a8fe@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 10:45:39AM -0400, Derrick Stolee wrote:

> After writing this, it was bothering me that 'rev-list --verify' should
> be checking for corruption throughout the history, not just at the tips.
> 
> This is done via the condition in builtin/rev-list.c:finish_object():
> 
> static int finish_object(struct object *obj, const char *name, void *cb_data)
> {
> 	struct rev_list_info *info = cb_data;
> 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
> 		finish_object__ma(obj);
> 		return 1;
> 	}
> 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
> 		parse_object(the_repository, &obj->oid);
> 	return 0;
> }
> 
> So this call is the one that is used most-often by the rev-list command,
> but isn't necessary to update for the purpose of our desired speedup. This
> is another place where we would want to use read_object_file(). (It may even
> be the _only_ place, since finish_object() should be called even for the
> tip objects.)

Yeah, I think this is the only place. At least, if you remove the hash
check entirely, then this parse_object() is the only spots that causes a
problem (via the existing test in t1450).

> In case you think it is valuable to ensure we test both cases ("tip" and
> "not tip") I modified your test to have a third commit and test two rev-list
> calls:

I don't think it's important to test here, as we know we just touched
the tip code here. But also, that existing "rev-list --verify-objects"
test in t1450 is covering that case: it corrupts a blob that is
reachable from an otherwise good commit/tree.

We should also have tip and non-tip tests for commits, but I posted
those in a separate series. ;)

-Peff
