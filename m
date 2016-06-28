Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59971FE4E
	for <e@80x24.org>; Tue, 28 Jun 2016 05:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbcF1Fjh (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 01:39:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:57244 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbcF1Fjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 01:39:36 -0400
Received: from [192.168.71.20] ([77.179.59.51]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MQ7sF-1bD72Z2K3P-005EG1 for <git@vger.kernel.org>;
 Tue, 28 Jun 2016 07:39:28 +0200
To:	git@vger.kernel.org
From:	Martin von Gagern <Martin.vGagern@gmx.net>
Subject: Shallow submodule efficiency
Message-ID: <f572d4ee-c618-6501-a8e5-717feca3ed7c@gmx.net>
Date:	Tue, 28 Jun 2016 07:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9ssChrJGF0z6r96aENDtqC/l9hxQ4YmDLm+0XB9XXzspBQtC/kD
 FfHDfy1f+HKTJHccA5HyDta/hz09vPJONM6d07t6aUhQ2ThSuv4T5PTwovRUtvLu3lzK3r6
 tQaisCQryh2FRjOxEOXU/5SBuZUtfv3nxLt//XXzaxT+DnToH4NMXZHJ5NFDLuUWR4/Je0x
 9uxVRUYTI+XhMjeLtRaPg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:IS0J2o6CrqA=:vr5o3UQoU5pr0hS8mT8tm7
 dKXcPuA7GfnCAHgyYIzPsTfupWqgCg3zZ4YSuMHoO+GFFlDX+JBnflXmHdsj+G5hikpuC9vD9
 aCBjSTvMpeeC1lcJMs1JqkQ7YRQUQ1kWlblXUssmDN0C68fJaBtPOKCOaPraMhm52fRhepOAV
 +Sd1r27A64NhzAg9iYGkHyZNgi5NRc/xc6FnU6CiHJpMc3UpjM9tgRnVT2h03FA9mpIbFllPO
 keo3P1+8a+NpaWWXpHbMIZbHydp+vVzukt5ZVQUJueTmBm4nBBD0z/eL6uILqzcd4hpZlgzoi
 emwJ58d/SuWGhQA0pNfemTIxx6MKH+9DZdH15quVlSPJqr4naWTZdohuRGamAcjzeH/IgMFEm
 /XVfabPDpztyrD4lq+2d7C3/VAcJIceM7z+XaYUdzE4G0d1bkmu90SFZnaeOAyIpAZjw2/8nP
 h99Dz6ISWc/WffufaDmYuDqmPH7su3EYgk0yzcr+q27q7uEB4dX7tIfn1pO4CmUwKeuo33mEj
 gKnTq9SnYPTmzQhq5+vJG6Z/qU59K20+oMSceKn8qZvCdfxWoJtmbFBZiRIU3jhAFq/pH2i/e
 Kgh581TTierjM7kiJzLTvrz7IyURb11CtwUNI107+LqCE94nePANyjxHaHI1sk+zASnKXlAgF
 Sq1oSJivLhOyW2GIZffLYtDO1soMCM3vG9LXrsM8TymQ4GFTRVnFCFUyIkdKnbXMD+nZFq0Im
 zU7hG08DenY6UOfd5LrrcrB8wjRKY0sb9ZdcFYLDHhd8invb3zPcDGppUFsejvq5FdCyPUSGL
 YjqpfDp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi!

I have the feeling that “git submodule update --depth 1” is less clever
than it could be. Here is one example I observed with git 2.0.0:

  git init foo
  cd foo
  git clone --single-branch \
            -b v0.99 https://github.com/git/git.git git-scm
  git submodule add https://github.com/git/git.git git-scm
  git commit -m Submod
  git clone --dissociate . ../bar
  cd ../bar
  git submodule update --init --depth 1 git-scm

This will download quite a bit of history, then result in an error message:

  error: no such remote ref a3eb250f996bf5e12376ec88622c4ccaabf20ea8
  Fetched in submodule path 'git-scm', but it did not contain
  a3eb250f996bf5e12376ec88622c4ccaabf20ea8. Direct fetching of that
  commit failed.

That seems so avoidable, since the commit in question is a tag, so it
would be perfectly possible to fetch that specific commit from the
server directly. Something like the following commands would do the trick:

  git fetch $url $(git ls-remote $url | \
                   awk /$sha1/'{print $2}' | sed 's/\^{}//')

If the commit in question is NOT a ref, then whether asking for it by
unlisted SHA1 is supported will probably depend on the server's
uploadpack.allowReachableSHA1InWant setting. I guess this is a reason
why fb43e31 made the fetch for a specific SHA1 a fallback after the
fetch for the default branch. Nevertheless, in case of “--depth 1” I
think it would make sense to abort early: if none of the listed refs
matches the requested one, and asking by SHA1 isn't supported by the
server, then there is no point in fetching anything, since we won't be
able to satisfy the submodule requirement either way.

For the case of “--depth n” with n > 1, I was wondering whether it would
make sense to prefer the branch listed in submodule.‹name›.branch over
the default branch.

I think shallow submodules would be very useful to embed libraries into
projects, without too much care for history (and without the download
times getting it entails), but with efficient updates to affected files
only in case of a change in library version. But not being able to get a
specific tag as a shallow submodule is a major showstopper here, I think.

Greetings,
 Martin von Gagern
