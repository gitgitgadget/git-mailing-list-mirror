Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33781F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeG3NtO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 09:49:14 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:32737 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeG3NtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 09:49:14 -0400
Received: from [192.168.2.201] ([92.22.39.78])
        by smtp.talktalk.net with SMTP
        id k74GfpX07pXFjk74GfVycp; Mon, 30 Jul 2018 13:14:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532952870;
        bh=hKK6my429S0Vt9oPW5A518+wRvNfUiPYBOZXp2TZwTE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W0rHpBn1lDh8sS0nQtZ2QWBqnj2ZAZwDPXqrhs6pYOo5NrpgmkIVqPACcMvLTxQth
         AtPYDiIRbLLa8fD+ohFDEqXI+vAbG7ga+sWQkVpOIkfl8/F6R+E9Ni44IZoBLgE7Vv
         vX9QSd1y6xexM5mc2OPfRD9jQFiVIzd6Rs5LxaeU=
X-Originating-IP: [92.22.39.78]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=uA7GO7HkTMgiH16tn5xvbw==:117
 a=uA7GO7HkTMgiH16tn5xvbw==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=5rxgeBVgAAAA:8 a=cETuxoCwAAAA:8 a=nN7BH9HXAAAA:8 a=7ltTmRvql-wU2H8yZnEA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=tb6VMGFFq-HsUJGUQiVL:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180730092929.71114-1-sunshine@sunshineco.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net>
Date:   Mon, 30 Jul 2018 13:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730092929.71114-1-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLmuxF7sHcNd4bSEvk+7kEEFtRileBZZlvgp/501+RJQfcaIdlkXo4NpQjWO8xn2cellr+u95pM0oPfx/25YG7zRWl5j/tw1thLmLPs3S5Uk9pqL4T+i
 zoi/HlslntcyLTXALq8Ss7TRk7z9hsMiqHUW3dBxauQqUiRi1g3+JrVFuatdaUQAFU8HoVAvCEKf6JK8ELzuMu6SLahJ1SsnKlfsBNOnhHWA9RgTRtPA6JeZ
 QkEXPIx+rHs6m55jqmnPFEYGybA4m7Ue7r+c+JxHK725y9XVOQUjtmPaIPhaM0vgQrRLOhTgmaFK3cuKBA4IXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/07/18 10:29, Eric Sunshine wrote:
> This series fixes bugs causing corruption of the root commit when
> "rebase -i --root" is used to swap in a new root commit. In particular,
> the "author" header has trailing garbage. Some tools handle the
> corruption somewhat gracefully by showing a bogus date, but others barf
> on it (gitk, for instance). git-fsck correctly identifies the
> corruption. I discovered this after git-rebase corrupted one of my own
> projects.
> 
> Unfortunately, these bugs (from js/sequencer-and-root-commits) made it
> into the v2.18.0 release. It's worrying that a released Git can be
> creating corrupt commits, but fortunately "rebase -i --root" is not
> likely used often (especially on well-established projects).
> Nevertheless, it may be 'maint' worthy and applies cleanly there.
> 
> It was only after I diagnosed and fixed these bugs that I thought to
> check 'pu' and discovered that Akinori MUSHA already made a stab[1] at
> fixing one of the three bugs which this series fixes. Akinori's fix has
> the somewhat undesirable property that it adds an extra blank line to
> the end of the script, as Phillip correctly pointed out in review[2].
> Patch 2/2 of this series has the more "correct" fix, in addition to
> fixing another bug.
> 
> Moreover, patch 2/2 of this series provides a more thorough fix overall
> than Akinori, so it may make sense to replace his patch with this
> series, though perhaps keep the test his patch adds to augment the
> strict test of the "author" header added by this series.

Johannes and I have some fixups for Akinori's patch on the branch
fix-t3403-author-script-test at https://github.com/phillipwood/git

That branch also contains a fix for the bad quoting of names with "'" in
them. I think it would be good to somehow try and combine this series
with those patches.

I'd really like to see a single function to read and another to write
the author script that is shared by 'git am' and 'git rebase -i', rather
than the two writers and three readers we have at the moment. I was
thinking of doing that in the longer term, but given the extra bug
you've found in read_author_script() maybe we should do that sooner
rather than later.

> [1]: https://public-inbox.org/git/86a7qwpt9g.knu@iDaemons.org/
> [2]: https://public-inbox.org/git/f5b56540-d26a-044e-5f46-1d975f889d06@talktalk.net/
> 
> Eric Sunshine (2):
>   sequencer: fix "rebase -i --root" corrupting author header
>   sequencer: fix "rebase -i --root" corrupting author header timezone
> 
>  sequencer.c                   |  9 +++++++--
>  t/t3404-rebase-interactive.sh | 10 +++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

