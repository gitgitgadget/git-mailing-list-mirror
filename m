Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F33C202AA
	for <e@80x24.org>; Fri, 22 Feb 2019 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBVQf3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 22 Feb 2019 11:35:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55807 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfBVQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 11:35:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1MGZIiv017958
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Feb 2019 11:35:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Dominik Salvet'" <dominik.salvet@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAEXP2g92_pnbh4_V8VOgzzdUv6w5eDhCsXf=+NOdsRwyjQUb5A@mail.gmail.com> <20190222160722.GA22531@sigill.intra.peff.net>
In-Reply-To: <20190222160722.GA22531@sigill.intra.peff.net>
Subject: RE: Fetching master branch with tags associated with it
Date:   Fri, 22 Feb 2019 11:35:11 -0500
Message-ID: <000801d4cacc$981e2ac0$c85a8040$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0KRRU5QStWoFS8sMyJ3GRdr7vCgKjZ1k0pJgoVXA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 22, 2019 11:07, Jeff King wrote:
> To: Dominik Salvet <dominik.salvet@gmail.com>
> Cc: git@vger.kernel.org
> Subject: Re: Fetching master branch with tags associated with it
> 
> On Thu, Feb 21, 2019 at 06:02:54PM +0100, Dominik Salvet wrote:
> 
> > Now, I want to refresh the repository the same way - fetching only
> > commits from the master branch and tags that are pointing to the
> > master branch and also refresh those tags as well in case of their
> > target commit change at the remote (you can expect that it always
> > points to a master commit). Nevertheless, I don't really know how to
> > do it. The closest I got, are the following commands:
> >
> > ```sh
> > git fetch --tags origin master &&
> > git merge FETCH_HEAD
> > ```
> >
> > However, there obviously are some problems with this solution. The
> > `--tags` flag will cause to fetch tags from all branches. Furthermore,
> > it will fetch also their commits, which is absolutely what I don't
> > want to.
> >
> > I have Git 2.17.1 (on Ubuntu 18.04.2) and in its `git fetch --help` is
> > stated, if I understood it correctly, that without passing neither
> > `--tags` nor `--no-tags`, it will do exactly what I want.
> > Nevertheless, without using any of the mentioned flags, it behaves
> > more like using `--no-tags`.
> 
> Generally yes, that's how it's supposed to work. However, I think tag-
> following does not kick in when you've given a specific refspec.
> 
> So take this toy setup for example:
> 
> -- >8 --
> git init repo
> cd repo
> 
> # one tags accessible from master
> git commit --allow-empty -m one
> git tag one
> 
> # one tag accessible only from "other"
> git checkout -b other
> git commit --allow-empty -m two
> git tag two
> 
> # now fetch into another repository
> git init child
> cd child
> git remote add origin ..
> git fetch origin master
> -- 8< --
> 
> That won't pick up the "one" tag in that final fetch. But if you use the normal
> configured refspec (but tell it only to grab "master"):
> 
>   git config remote.origin.fetch
> refs/heads/master:refs/remotes/origin/master
>   git fetch origin
> 
> then it works. I don't know if there's a less-awkward way to get what you
> want, though. It really seems like there should be a "--tags=follow"
> or similar.

This may be restating, but I had a received request a while back to fetch only tags commits known to the repository. The scenario here is as follows:

git clone --depth=1 url-ish
git fetch --depth=1 --tags

This actually fetches all tags and expands the depth of the repository to the whole history to provide the basis for all of the tags. What I would have anticipated is that the HEAD commit from the depth=1, if it had a tag, would fetch that tag, and then expand the history of the tag in support of it, but only if the tag were signed. If the tag is not signed, I'm not sure that the history to build it is required, since the same argument could be made for the HEAD commit itself. If there was no tag on the HEAD commit, there would be no tag fetched in this situation.

So to further the request above, a fetch of tags of known unsigned tags seems reasonable, in a depth restricted situation or a branch limited situation. In an island of sparceness situation, with gaps in the history, I can see how git describe would give wildly wrong answers, but having those gaps could break the validation of signed tags anyway.

Of course, my expectations may be completely wrong here.

Regards,
Randall 

