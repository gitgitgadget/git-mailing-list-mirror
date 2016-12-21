Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E9A1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760806AbcLURxj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 12:53:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:60580 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760794AbcLURxi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 12:53:38 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M24ap-1cYgYy2tvn-00u2rv; Wed, 21
 Dec 2016 18:53:31 +0100
Date:   Wed, 21 Dec 2016 18:53:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/2] Really fix the isatty() problem on Windows
Message-ID: <cover.1482342791.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M9cADCxUw1vU9IX+B2azrHZOiDfgRX3FNdDrTpF6/xeXGd28tCX
 2yJogyjKD97w/CoV3kdkvKdtqftaTMwS1uVmrjUhy4XrsXT14ZCcoNaOI42EshLkYKswHtv
 UFdWoknKCc0/pc9dPKmckn46MJQWxipRfGSB1/KajOetKIL5puUd50jYPj8hWvsmaL+RL+Q
 bfnOrtVLlJ7Ko5g+Liz/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l6XvR9WtlxA=:n9OC8qaRkgBwIo/7qWXTwA
 j5lecTEO+nvEcFN9qjej26faRSjuMuK9xJMu+Q0DwQAOX+EeTF2r8oFgLSpvrxarqz4D1KWCS
 7v6F05OfSINp7V/Pi7H0W6dKA5k8jMoio/fhzM+mEEQfpv6nne+d9xFhOiw/4wCbZBODsfs59
 UZD7PmYP9ZREhzjDbhPmWhdwTf5ARS/E1r6w9typ4lRmeEadWE8cwW1IgytHT+VpnVC724aFf
 UdF0WUDXxb2qGmL+tIcwT2GQ2jtHVx3V0/0xCzdAhjZbjNmVLZxjeaynE5Bq82xMuqDlcUTZV
 jKGXFZnCsN/cRkAeVAJfngQiw/eXERk7RsZ3KBAWm3Fqo5YO5ylPOBI1JpKzNkktqr1AVQJzR
 Pr8YbO2GOaq97oOqD9oirC60qsPuANJnmgQVHv+0cBZeoDJNGSPfpaji7thZeKWIdS7HBgY/F
 knoIHXMnAcqenT0SwE9JUTLmIspHQYAqpv98Pw9p617wzn+ObhVejBlgQzk4a39n0AYd3J3Mk
 W0wq+xvH2mhuRhH24rcunjA9/EXheuFkiQq5CZMX/hqHGdRS9/OczrU+HnzB58HJt0nNE3dn3
 w2NcP1Duo71y103yyJwvrFPQ+nBTK0ZEWKZmYhOUdaCZXLyyrDzZlBugn3pREK5SrQJrrmtzX
 gH3IySlwLPFWX98p8us2t/dMstnbbYZDiKVcXfHON4Tv9XEVR7Dx1S2pOjMjIDvbF4XLQzzqK
 U0W2RoEcfrziUUZUe24oBV1Th5CWBGvz0jHMEw7YkLngkV26IHzZFGvc7OIm5hPoy+Or8npF1
 pOhB3Zv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My previous fix may have fixed running the new
t/t6030-bisect-porcelain.sh script that tested the new bisect--helper,
which in turn used isatty() to determine whether it was running
interactively and was fooled by being redirected to /dev/null.

But it not only broke paging when running in a CMD window, due to
testing in the wrong worktree I also missed that it broke paging in Git
for Windows 2.x' Git Bash (i.e. a MinTTY terminal emulator).

Let's use this opportunity to actually clean up the entire isatty() mess
once and for all, as part of the problem was introduced by a clever hack
that messes with internals of the Microsoft C runtime, and which changed
recently, so it was not such a clever hack to begin with.

Happily, one of my colleagues had to address that latter problem
recently when he was tasked to make Git compile with Microsoft Visual C
(the rationale: debugging facilities of Visual Studio are really
outstanding, try them if you get a chance).

And incidentally, replacing the previous hack with the clean, new
solution, which specifies explicitly for the file descriptors 0, 1 and 2
whether we detected an MSYS2 pseudo-tty, whether we detected a real
Win32 Console, and whether we had to swap out a real Win32 Console for a
pipe to allow child processes to inherit it.

Hannes, I am really sorry that I did not test the original attempt
better, I tried to be a better boy this time. Could you maybe also give
it a try?

The current patch series is based on `pu`, as that already has the
winansi_get_osfhandle() fix. For ease of testing, I also have a branch
based on master which you can pull via

	git pull https://github.com/dscho/git mingw-isatty-fixup-master


Jeff Hostetler (1):
  mingw: replace isatty() hack

Johannes Schindelin (1):
  mingw: adjust is_console() to work with stdin

 compat/winansi.c | 197 +++++++++++++++++++++++--------------------------------
 1 file changed, 83 insertions(+), 114 deletions(-)


base-commit: 1921ea0f1c7358b5200a456fba02aa79fb9e76d3
Based-On: junio/pu at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git junio/pu
Published-As: https://github.com/dscho/git/releases/tag/mingw-isatty-fixup-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-isatty-fixup-v1

-- 
2.11.0.rc3.windows.1

