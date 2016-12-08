Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E561FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbcLHPgT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:65262 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbcLHPgR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:17 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQhyf-1c4ieD0cv7-00U6pE; Thu, 08
 Dec 2016 16:36:00 +0100
Date:   Thu, 8 Dec 2016 16:35:56 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/7] Pie-in-the-sky attempt to fix the early config
Message-ID: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lXbgNJF/WBE9JzCTLUnMgmUlgX85AIpyPaz6Dk7IgJs4SvbZ54/
 PPl32qRu9oYIzrVVIDbhy5EEgzGL36gmcGLr+ztZDZZ6HHOz6Pu7Mh5pHf5lo4KEd5qZoNJ
 qU/J/7hl6fY1CmiWHZf8nGG0kL99yfHd8N5MowFVf5RKjscm056jsEMDszr2dogvZRw3+NH
 bJgROSRYTHpJUAt6JULtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W+p9vT2cujc=:qxWy9Yv98CMsPbLWIJtk0u
 dHQLwkYWc/Myed65L5q5vHCombFsc/f5DTAWL848e0dTut/mDwedbEVIHt6jNdtALu5qxhJHI
 P2tR0o5ZO8MosVTkF+XlH9zlVgQJ6dIUf+cWTNk/ad7j1gO3TjtP3HPN3ms559BkgElKHjeDn
 9xzQyzWIbV2xEegXV18d2HNkQHignekp3h6cGo+EEpKS3SY9La80YvRgwjvKWtxn9+4hAi+vn
 HEhi4jPNLHx5CG4l/fltwr4h7nCZEeGIpxOybkyntLa/7Hw1szTPYruNFP/cvNLDk2n3ki3OO
 NOf7cGt9zym+xbzL8rjwh11tyM+ufgKtA7ogn8H08/ZH5EU+hLhavraIwHI8QR326nIXPrlL0
 /GngV+JDDFi0dBONE/0PELnarSuRhsLfK/+8S/z8mHxx1HJBofJg4t4dyHw7mouADa04P+Cde
 K/eK1C82T6yFPVZwnkVWFZJaEtmWQLyf27CiEqcmZPS8syv5FmY2la85mqAeRpBjJgku9blNp
 ow35fjk69E19L6WTp86tDVwDUveK2iD/5c2CUnUCyUbyBDLXs7gk4k3WHC5UZl3M9xHEOq0Sn
 DqKWIH3PUJiH9Zr7yu8F5mPSapun83ILDl/kTXi6yd8K4+lGpYFqxHIV8f/NoVUzX9PKD4L/O
 zjbgqsEX0SBz3w7WxfJC4xp+8kxqEr5cJVi+HGcmNwkgv/hISfEWtP5QKEyZxbtS/UpyGKmMG
 sqoDJckwHBspQl6d/skjqqOhJgA/vCaPRV3AExL8qekjMMVV2xvDtvpAgrgJ/FJjXZ0jZyxmf
 IJ1uMZR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully these patches will lead to something that we can integrate,
and that eventually will make Git's startup sequence much less
surprising.

The idea here is to discover the .git/ directory gently (i.e. without
changing the current working directory), and to use it to read the
.git/config file early, before we actually called setup_git_directory()
(if we ever do that).

Notes:

- I find the diff pretty ugly: I wish there was a more elegant way to
  *disable* discovery of .git/ *just* for `init` and `clone`. I
  considered a function `about_to_create_git_dir()` that is called in a
  hard-coded manner *only* for `init` and `clone`, but that would
  introduce another magic side effect, when all I want is to reduce those.

- For the moment, I do not handle dashed invocations of `init` and
  `clone` correctly. The real problem is the continued existence of
  the dashed git-init and git-clone, of course.

- There is still duplicated code. For the sake of this RFC, I did not
  address that yet.

- The read_early_config() function is called multiple times, re-reading
  all the config files and re-discovering the .git/ directory multiple
  times, which is quite wasteful. For the sake of this RFC, I did not
  address that yet.

- t7006 fails and the error message is a bit cryptic (not to mention the
  involved function trace, which is mind-boggling for what is supposed
  to be a simply, shell script-based test suite). I did not have time to
  look into that yet.

- after discover_git_directory_gently() did its work, the code happily
  uses its result *only* for the current read_early_config() run, and
  lets setup_git_dir_gently() do the whole work *again*. For the sake of
  this RFC, I did not address that yet.


Johannes Schindelin (7):
  Make read_early_config() reusable
  read_early_config(): avoid .git/config hack when unneeded
  Mark builtins that create .git/ directories
  read_early_config(): special-case `init` and `clone`
  read_early_config(): really discover .git/
  WIP read_config_early(): respect ceiling directories
  WIP: read_early_config(): add tests

 builtin/am.c            |   2 +-
 builtin/blame.c         |   2 +-
 builtin/grep.c          |   4 +-
 builtin/log.c           |   4 +-
 builtin/var.c           |   2 +-
 cache.h                 |   8 ++--
 config.c                | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
 diff.c                  |   4 +-
 git.c                   |  25 +++++------
 pager.c                 |  44 +++----------------
 t/helper/test-config.c  |  15 +++++++
 t/t1309-early-config.sh |  50 ++++++++++++++++++++++
 12 files changed, 209 insertions(+), 61 deletions(-)
 create mode 100755 t/t1309-early-config.sh


base-commit: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
Published-As: https://github.com/dscho/git/releases/tag/early-config-v1
Fetch-It-Via: git fetch https://github.com/dscho/git early-config-v1

-- 
2.11.0.rc3.windows.1

