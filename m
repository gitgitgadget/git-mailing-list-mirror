Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510221FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbdJ3RK1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:10:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:49661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932291AbdJ3RK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:10:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH0eg-1dvUJr0S7G-00DlIE; Mon, 30
 Oct 2017 18:10:21 +0100
Date:   Mon, 30 Oct 2017 18:10:19 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] mingw: introduce a way to avoid std handle inheritance
Message-ID: <cover.1509382976.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DozJkLzlpQeIjqbFMK1Z/C720jQj5nsPdw4yz/O1NDOKfsDkAzX
 hh21sAkBOCQaL3bMDdJ78uXShIC//07J7uG3H5Ef32Zfrhih10qpJl+oWMvX9zGHXI8BFh9
 7kiKoeg9YTHOe4Al8F46uMavAOX+ABAAP7YZTWUnu35NNzD8jFvcyD+FNrR88WBiAmY7LpD
 g3Y2bHXlPrKCAFpZ0rslg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZzOsRiqeRJk=:EhSNTqiFpNS7k3r3fNkM3V
 XK+3CdfILYsNS3RzzwkqAuxk2LLR4cIPOCz4WmFa0IcavWtLlUfWoe/qbvmnrW+J/5scSgjeb
 33jjwWRKW+5cwSoO2j5JYOhfKlk7H0jLcClvC39x4pEF5vxFe0osNA4LCaRclPDR82JgTV7z4
 Yvvwn4tnZp6+T9wDGbjtJZ8/dp/rACdVK5FOYq1Y8WApzsYDLO3/4/R5I0yqgVseYjDPgJ7pA
 Q/dzqcye31nNG4VDrbzsEuQyDJW4oE3o37mBq0mOgxykCaUja0OJNwSPGPHtNnoa1sHwFspAa
 n1qj4kg1YSYKjCvT16NrKRcWVc6LrTafKu6dFyVVg1i1arI40BSncAwuSUUBEXGZIgRqPD/lJ
 zLX3xz1TzhCTAR9nBlVOwVUQHzsrKWwvA8qqbPkxot4v56JIQMKvEtAtMmZYpLeaqqaaUvckg
 mWEkzVlcXiXS8c4mqLIxiu0PPpnpeHe5gE0ognb8kNlOrttdbRd5LKzGYSC4QuZOaaEX4iKJ4
 Du6I8/4Npz9xZl3welJdgI1vzvbFtf/QKJNw++iI6SMYfAWvNq1OLj7i9RC0d5amJtY+dHzbE
 PODku46rT/akZRtAzI0KQNE3qerQpSGZkwtoUdnYVvu2cDhEShcbp3ZISTjcFHxPT3UjKdzaI
 otc/Lhn56syOThugrbZ7X/GGo+9W66h0MGXxLbUKQ2DSbOxX9da2BhHBNZD5C4ZJuqywa1sKP
 cKcpjXG9acu/UZ3NznawQnZbBqnw+xgsWIG0fQSTvQ+g0uqncXSOwCHZad7/T1OnkoPWvGKdn
 vst6OcL6AbdlLIvEBUYteZQNZQMeK8HBFuWxuj5KPJxZ0fGrDY3IwV/gA6VZRucXkdDmY1F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Particularly when calling Git from applications, such as Visual Studio,
it is important that stdin/stdout/stderr are closed properly. However,
when spawning processes on Windows, those handles must be marked as
inheritable if we want to use them, but that flag is a global flag and
may very well be used by other spawned processes which then do not know
to close those handles.

As a workaround, introduce handling for the environment variables
GIT_REDIRECT_STD* to read/write from/to named pipes instead
(conceptually similar to Unix sockets, for you Linux folks). These do
not need to be marked as inheritable, as the process can simply open the
named pipe. No global flags. No problems.

This feature was introduced as an experimental feature into Git for
Windows v2.11.0(2) and has been tested ever since. I feel it is
well-tested enough that it can be integrated into core Git.

Once it has been reviewed enough, I will gladly remove the
"experimental" adjectives and warnings.


Johannes Schindelin (3):
  mingw: add experimental feature to redirect standard handles
  mingw: special-case GIT_REDIRECT_STDERR=2>&1
  mingw: document the experimental standard handle redirection

 Documentation/git.txt | 17 +++++++++++++++
 compat/mingw.c        | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0001-init.sh       | 12 +++++++++++
 3 files changed, 87 insertions(+)


base-commit: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
Published-As: https://github.com/dscho/git/releases/tag/redirect-std-handles-v1
Fetch-It-Via: git fetch https://github.com/dscho/git redirect-std-handles-v1
-- 
2.15.0.windows.1

