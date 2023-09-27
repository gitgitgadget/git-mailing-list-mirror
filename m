Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C994E810DB
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjI0Mm3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Sep 2023 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjI0Mm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 08:42:26 -0400
Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3013A
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 05:42:20 -0700 (PDT)
Received: from c-73-69-87-143.hsd1.nh.comcast.net ([73.69.87.143] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <yoh@onerussian.com>)
        id 1qlTru-0006AN-BH; Wed, 27 Sep 2023 08:42:18 -0400
Date:   Wed, 27 Sep 2023 08:42:17 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Isaac To <isaac.chun.to@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <ZRQjKYBLwNg42xAd@bilena>
References: <ZRMLNyHXoWOj6K-l@bilena>
 <ZRNv-n_VlIDPX0oi@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ZRNv-n_VlIDPX0oi@debian.me>
X-URL:  http://www.oneukrainian.com
X-Image-Url: http://www.oneukrainian.com/img/yoh.png
X-PGP-Key: http://www.oneukrainian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
X-SA-Exim-Connect-IP: 73.69.87.143
X-SA-Exim-Rcpt-To: bagasdotme@gmail.com, git@vger.kernel.org, isaac.chun.to@gmail.com, gitster@pobox.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: git-retry tool or git.retry config (built-in implementation)?
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 27 Sep 2023, Bagas Sanjaya wrote:

> On Tue, Sep 26, 2023 at 12:47:51PM -0400, Yaroslav Halchenko wrote:
> > Dear Git Gurus,

> > In DataLad (https://datalad.org) we are doing lots of automated cloning,
> > fetching etc as part of our CI etc jobs.  Once in a while git operations
> > fail [see e.g. 1], and beg us to retry but we need to know when to
> > do so, and not do it upon every failed git invocation since some
> > failures could be legit (repository is gone). While looking how others
> > solve it we found
> > https://stackoverflow.com/questions/35014012/git-retry-if-http-request-failed
> > which pointed to tools like git-retry and later part of
> > https://chromium.googlesource.com/infra/infra/+/HEAD/go/src/infra/tools/git/retry_regexp.go
> > which serve as a collection of regexes to be on lookout for to retry.

> > Would that be the "best" strategy currently?  

> Looking at the actual git_retry.py script [1], it really just wraps
> actual Git commands. IMO, git-retry(1) shell script as you mentioned
> only calls the python version, which adds another level of indirection
> (why not doing it in pure shell?).

My guess would be that it is just easier to code in Python usually for
such cases with a "registry" of hits etc.  But why not just to strip .py
from python script which has shebang already and not require bash
wrapper at all? ;)

> AFAIK, to solve the retrying problem, we need to have a way to tell
> transport backend (curl/ssh) to resume transfer from the faulty point.

some times it seems not even getting connected (https) entirely and that
(?) leading to error in the caller above, e.g. from
https://github.com/datalad/datalad/issues/7485#issuecomment-1735619755

error: Failed to connect to datasets-tests.datalad.org port 443 after 8291 ms: Couldn't connect to server (curl_result = 28, http_code = 0, sha1 = 3980af8de56946a10ff5c48879e5d6025965d936)\nerror: Unable to find 3980af8de56946a10ff5c48879e5d6025965d936 under ...


> > As regex matching might eventually break whenever `git` changes
> > anything in the output messages, I wondered if there could be a more
> > robust internal implementation in git itself?  Similarly git-annex has
> > annex.retry config setting which sets the count of retries for
> > "retriable" operations.  

> Do you use porcelain interfaces instead of plumbing ones?

I would say -- a "mix". 

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

