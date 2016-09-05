Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31AC1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 15:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755019AbcIEPpP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 11:45:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:54373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754234AbcIEPpL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 11:45:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MSdNs-1bX8xD3oRg-00RVaN; Mon, 05 Sep 2016 17:45:00
 +0200
Date:   Mon, 5 Sep 2016 17:44:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
Message-ID: <cover.1473090278.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XBqh69LTg9XHP17GbzssbBH/a0aN9tjA14AY1V5a0RiR2SbtOZB
 /q+BuEG4hLo/y8xbrTVjwLvaDbRiI4HlVXZQIS/321iTvseo4n664aYhrI9RKfDUWCj8Yis
 l1lR+Kndxaz4WbA6Uos5AhqJGyY/ErYu0kLAZwEY398LTjl7D84AjxHYEojMGI+Mjj5PyX+
 uTLrLi6zfA8WJdcq39EyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ympzpMqnfPY=:rBYBNmr6a8mf/8A1IT7dVE
 np1pAWlZr0Vraanlz50+2gnHrRPsu5gqcCOnev/aq5fsT7825ca8NsVWkZGGg4ogxObWVkSf9
 2hD+ojAnA6I4SkdH/Vra3EnBMws2kLXpgmHHqRsJOBJ5zKJlAfORNLBxxJtXU5j61itVJNoDy
 jIODwzAz1R2TKLqRUDju1CKtRAruVebL1vsKO9rrOWoUyz4fCqrJr7DtCdczuXIwY4mdDtQnm
 Ghpd2N9emvwTndPEkEnyfRgAvRQcfKfqduzOHIgk0EFf2wWNnJMbNqEymolkWiwZU777nba9H
 HvGkxinxR7DJVRZJRV0Lf8ByJLKgO3ePncITRZkxktBYojUQMCEFoT84ZeEHdIVHoPkWC48Qr
 vos4cgd+iurO9hmgdnnmUsq7IBqYnLaEACHDTYtkEgUPB8L39E1axU5hYHqI/VuF/lf6OMRdF
 NyJF9f1794JEnMQuGp1t9atc8C98ad6xKcRkJ2HLBKvZRfCqkcZ8GadJ4uX9nyEL+T4+YWM/s
 ddMsix7lmQu1RzxBeztF9X6jjUxx2GEbJ2zg/VWvbx4PjmWbYkWNlgZ0EDAcCxrWsxb0PRRd8
 lKbSVZy5WtJCpnlM7pN5s8tdEpGJFN+Ed6KmL3Ds0Kmk4MG+c/nP8rBNvgCSr1DG6zTLzZ7Wo
 ygXZKM4zU9R0yChG1ynERBrcCXgahqQk4eHLWYk/2ZSyN9+jRUmmk/nWeBo67riUL2kdVXZM+
 aNRUM69ykYClpi+qwGKEkBtLrXpneTrmohK4vE0pXD+MdiVJg+LxWfwETp18cQ66ycoy3U4lO
 3hK1Y9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series addresses a problem where `git diff` is called using
`-G` or `-S --pickaxe-regex` on new-born files that are configured
without user diff drivers, and that hence get mmap()ed into memory.

The problem with that: mmap()ed memory is *not* NUL-terminated, yet the
pickaxe code calls regexec() on it just the same.

This problem has been reported by my colleague Chris Sidi.

Please note that this patch series is a hot fix I applied to Git for
Windows (the bug does not trigger a segmentation fault for me on Linux,
strangely enough, but it is really a problem on Windows).

So at least I have a workaround in place. Ideally, though, we would
NUL-terminate the buffers only when needed, or somehow call regexec() on
ptr/size parameters instead of passing a supposedly NUL-terminated
string to it?


Johannes Schindelin (3):
  Demonstrate a problem: our pickaxe code assumes NUL-terminated buffers
  diff_populate_filespec: NUL-terminate buffers
  diff_grep: add assertions verifying that the buffers are
    NUL-terminated

 diff.c                  |  9 +++++++++
 diffcore-pickaxe.c      |  2 ++
 t/t4059-diff-pickaxe.sh | 22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 t/t4059-diff-pickaxe.sh

Published-As: https://github.com/dscho/git/releases/tag/mmap-regexec-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mmap-regexec-v1

-- 
2.10.0.windows.1.2.g732a511

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
