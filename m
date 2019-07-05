Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E2F1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 04:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfGEEpe (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 00:45:34 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56462 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfGEEpe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 00:45:34 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hjG6E-0005Za-Jj
        for git@vger.kernel.org; Fri, 05 Jul 2019 13:45:30 +0900
Date:   Fri, 5 Jul 2019 13:45:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190705044530.mehpvei5lysy3czl@glandium.org>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704100530.smn4rpiekwtfylhz@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 04, 2019 at 07:05:30PM +0900, Mike Hommey wrote:
> My guess is all those stalls are happening when processing the files I
> already had problems with in the past[3], except there are more of them
> now (thankfully, they were removed, so there won't be more, but that
> doesn't make the existing ones go away).
>
> 3. https://public-inbox.org/git/20180703223823.qedmoy2imp4dcvkp@glandium.org/T/

I've more or less confirmed that's the cause of the long stalls during
the compression phase. It can be reproduced to some extent with:

$ git clone https://github.com/mozilla/gecko
$ cd gecko
$ git rev-list --all -- testing/web-platform/meta/MANIFEST.json | xargs -I '{}' git ls-tree '{}' testing/web-platform/meta/MANIFEST.json | sort -u | awk '{print $3}' | git cat-file --batch-check | sort -n -k 3 | awk '{print $1}' | git pack-objects --window=250 --depth=50 --no-reuse-delta my_pack

There might be some other file than testing/web-platform/meta/MANIFEST.json 
involved, because this uses "only" 40GB RAM, but that file is the one I know
of.

This however doesn't reproduce the "writing takes forever" part of the
problem.

Mike
