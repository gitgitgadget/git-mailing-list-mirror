Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5821F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKGGcZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:32:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:41718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726925AbfKGGcY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:32:24 -0500
Received: (qmail 29100 invoked by uid 109); 7 Nov 2019 06:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:32:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32341 invoked by uid 111); 7 Nov 2019 06:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:35:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:32:23 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] sequencer: reencode commit message for am/rebase
 --show-current-patch
Message-ID: <20191107063223.GF6431@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <36796e2b679cd8b2d341058e775db401f9abcef7.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36796e2b679cd8b2d341058e775db401f9abcef7.1573094789.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:19AM +0700, Doan Tran Cong Danh wrote:

> The message file will be used as commit message for the
> git-{am,rebase} --continue.
>
> [...]
>  	strbuf_addf(&buf, "%s/message", get_dir(opts));
>  	if (!file_exists(buf.buf)) {
> -		const char *commit_buffer = get_commit_buffer(commit, NULL);
> +		const char *encoding = get_commit_output_encoding();
> +		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);

That makes sense, though it's hard to understand the flow of this data
through multiple sequencer invocations. I _think_ this would be fixing a
case like this:

-- >8 --
git init repo
cd repo

# some commits to build off of
echo base >file
git add file
git commit -m base

echo side >file
git add file
git commit -m side

# now make a commit in iso8859-1
git checkout -b side HEAD^
echo iso8859-1 >file
git add file
iconv -f utf8 -t iso8859-1 <<-\EOF |
súbject

bödy
EOF
git -c i18n.commitEncoding=iso8859-1 commit -F -

# and rebase it with the merge strategy, which will fail;
# now .git/rebase-merge/message has iso8859-1 in it
git rebase -m master

# and if we resolve and commit, presumably we'd get a broken commit,
# with iso8859-1 and no encoding header
echo resolved >file
git add file
GIT_EDITOR=: git rebase --continue
-- 8< --

But somehow it all seems to work. The resulting commit has real utf8 in
it. I'm not sure if we pull it from the original commit via "commit -c",
or if it's in one of the other files. But it's not clear to me how
this "message" file is being used.

-Peff
