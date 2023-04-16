Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2681C77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 17:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDPR05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDPR0z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 13:26:55 -0400
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Apr 2023 10:26:48 PDT
Received: from smtp110.ord1d.emailsrvr.com (smtp110.ord1d.emailsrvr.com [184.106.54.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4335AD
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1681665621;
        bh=BPfRLmKFO5bGfuQ2c92N/dJ9fpoDg3oqy9hUdqxOERM=;
        h=Date:From:To:Subject:From;
        b=d5bUpnraX8qk1sBIN1bqOAbfDSXM31qFEDwA8cqAnRgVGTiOLjviHNagB6Y9AG2a6
         aS5hwTNjA5vztqEkSS6El+xi7+ZXhgtyVxYgrzphWBRgxCREs4phFrJZQOYOOe6y2N
         RmxAJQrv4fwHQ15wRDXSDBHI5OUnl0IsQJ44zvnc=
X-Auth-ID: lars@oddbit.com
Received: by smtp14.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 340A240085;
        Sun, 16 Apr 2023 13:20:21 -0400 (EDT)
Date:   Sun, 16 Apr 2023 13:20:20 -0400
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: Regression introduced in 03267e8656truct object_id oid;
Message-ID: <bt4342bdip3nzlikjsv6wozszmcbsc2av6cyo3z2lra4jhx3ii@ut2sl5h4f5xn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: iscard_index(&the_index);ie(_("Cannot read index"));
Content-Disposition: inline
X-Classification-ID: 86387881-2356-4603-96ac-4dea5cbd3b33-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This behavior was originally reported in
https://stackoverflow.com/q/76022720/147356.]

Prior to commit 03267e8656, the following sequence would result in an
empty commit:

    git init testrepo
    date > testrepo/testfile
    git -C testrepo add testfile
    git -C testrepo commit -m test --allow-empty --only

After commit 03267e8656, the same sequence creates a commit that
contains "testfile". I believe the original behavior was correct,
based on the documentation for the `--only` option:

> If used together with --allow-empty paths are also not required, and
> an empty commit will be created.

A simple change that corrects this behavior would be to prevent git
from refreshing the cache when --only is active:

    diff --git a/builtin/commit.c b/builtin/commit.c
    index 9d8e1ea91a..8c441548f8 100644
    --- a/builtin/commit.c
    +++ b/builtin/commit.c
    @@ -995,7 +995,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
        struct object_id oid;
        const char *parent = "HEAD";
     
    -		if (!the_index.cache_nr) {
    +		if (!the_index.cache_nr && !only) {
          discard_index(&the_index);
          if (repo_read_index(the_repository) < 0)
            die(_("Cannot read index"));

And while that passes all the tests, I'm not sure if its correct; the
change in 03267e8656 was correcting a memory leak and I'm not sure I
completely understand the details.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS
