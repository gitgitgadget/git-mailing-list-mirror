Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E7C1F424
	for <e@80x24.org>; Wed, 20 Dec 2017 11:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755060AbdLTLuL (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 06:50:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:49744 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754153AbdLTLuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 06:50:10 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1eRcsz-0001Kv-6D; Wed, 20 Dec 2017 12:50:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 8F071120195; Wed, 20 Dec 2017 12:43:37 +0100 (CET)
Date:   Wed, 20 Dec 2017 12:43:37 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
Message-ID: <20171220114337.GE18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
 <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to you both for your patience with me. Sorry for the late reply, my day
job was needing me ;-)

On Fri, Dec 15, 2017 at 07:58:14PM +0100, Igor Djordjevic wrote:
> On 15/12/2017 17:33, Junio C Hamano wrote:
> > 
> >     $ git fetch <remote> <branch>
> >     $ git checkout -m -B <master> FETCH_HEAD

For some reason, this seems to double the local modifications. After executing
the following commands:


  rm -rf reposA reposB
  
  git init reposA
  (
    cd reposA
    echo 1 >>1
    echo 2 >>2
    git add 1 2
    git commit -m1
  )
  
  git clone reposA reposB
  
  (
    cd reposA
    echo 1 >>1
    git commit -a -m2
  )
  
  (
    cd reposB
    echo 3 >>2
    git fetch
    git checkout -m -B master FETCH_HEAD
  )

git-diff gives me:

  $ diff --git a/2 b/2
  index 0cfbf08..4e8a2de 100644
  --- a/2
  +++ b/2
  @@ -1 +1,3 @@
   2
  +3
  +3

With Igor's set of commands, I did not see this doubling:

>     git checkout -b temp &&               #1
>     git fetch &&                          #2
>     git branch -f master origin/master && #3
>     git checkout -m master &&             #4
>     git add -u &&                         #5
>     git reset &&                          #6
>     git branch -d temp                    #7

> ... aaand that`s how you do it[1] without a temporary branch :)
> 
> Junio, what about consecutive runs, while merge conflicts are still 
> unresolved?
> 
> Seeing Josef having a pretty relaxed flow, and his cron job running 
> every 15 minutes, would adding something like:
> 
>     $ git add -u
>     $ git reset

This would be added after the "git checkout -m -B master FETCH_HEAD" command?

> ... to the mix, to "silence" actually still unresolved merge 
> conflicts, making next script execution possible, make sense?
> 
> Yes, `git diff` won`t be the same as if conflicts were still in, but 
> it might be worth it in this specific case, conflicting parts still 
> easily visible between conflict markers.

That means, the conflict is still there, but git would think this is an
ordinary modification?

-- 
Josef Wolf
jw@raven.inka.de
