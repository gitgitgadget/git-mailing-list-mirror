Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D621F859
	for <e@80x24.org>; Mon, 22 Aug 2016 12:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbcHVMse (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:48:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:62410 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbcHVMsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:48:32 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MN1C4-1bVCvq0MW0-006c2T; Mon, 22 Aug 2016 14:47:46
 +0200
Date:   Mon, 22 Aug 2016 14:47:43 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v3 0/2] Do not lock temporary files via child processes on
 Windows
In-Reply-To: <cover.1471531799.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1471869985.git.johannes.schindelin@gmx.de>
References: <cover.1471531799.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LuIV83yxIN9ea6v8yWw4KRNbfCEtKYUnIE275uOkBNf74uCo5Wq
 jOOLkbvYLd4+9XrwLiSPRPG5Nxj9JXU65UPZcLK9Nl8EwMN9NWddnUx3MTxiumB8cvz0mLb
 8PYv/ga1u1fY+RaRjVrntlvNmhuSH+G7KpF/o0Vwl3rfTJxZnHeqhCyClHHgVbHq9ViwOfC
 u6q/EQ7CMfVvhznGmFNMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E+8Sky2PBgg=:4r8A3IbKfaYWq2htfKlqlO
 0AA1H0e+Epmu4b0SRZYU3TDdCvN0NAQAdMTbVwCIGLB4hZ/5CRFwQa7J8gdfyr/woyVJpkBJ1
 9+V1ZU0LtOwBCoSNt1LRad5d+hJaKJGRArPrnabsWpbu2rPKSsmIAjVTSKDT0Tq/DAihOhmId
 0pwTxQoM2cQxIyRhjdXI/fQwM+F1Nld/5LHs+UknGOcT5d3Lp5iJjqgcQQ738/4vxk78Gzb9Y
 m5UiehMbhLisxFrfHAvSvtm3IAduP+kLAYgD7CQaLfxMK5oiolrJXLMnSdS6KE6cH/WAGSaj9
 w97BE6gD6m24/YGhDjLdd6KOC/r3Zx3xWYPFFultG4/NW7JXe/465JajjWa68W5uT+1v9kvWm
 bBIFB7mbvVNYdLLtbGUY7aEsUOXep1U3evtwyxEUKMf1YP10Fw56F8Xsl9c/CbkPkXqn5Eq8q
 1wXEZHiNvfhT81DV1MEMlpop4VI9A7+0PqWu8v7HQdP5D7hT0yi08qNb79f3kg5TuqHFrt/g2
 c+m0zmu87MOs47AGZR9SSReMUN2NX/u6/L9ysQzdQGeIm8mIWZ5X8MGGzn5xhoDmzKSemXuNq
 2C7eYyr1iuPq6CxoiXhiM3NehK1Es3dEzjXlOl8Ia/UINkN6Xv180Ef3bdvarDmvK+bVzbfKo
 fGlUW0E7OEV8A5vJHYCp1cYFnnaO5XGUDz3Brhecs40qUZ3zzE52VvDS+4Re04lkKn37kRMT+
 eqeYV6tIvcrGo9wkhKKXyV/3yJpdQ1yMysd9OzHs/heOOAoXemz4cBXD6hl6gJWDUUfa8lX1o
 vIOKIyD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This issue was originally reported and fixed in
https://github.com/git-for-windows/git/pull/755

The problem is that file handles to temporary files (such as
index.lock) were inherited by spawned processes. If those spawned
processes do not exit before the parent process wants to delete or
rename them, we are in big trouble.

The original use case triggering the bug is a merge driver that does
not quit, but listen to subsequent merge requests.

However, the same issue turned up in Lars Schneider's work on making
clean/smudge filters batchable (i.e. more efficient by avoiding
possibly thousands of child processes, one per file).

Changes since v2:

- O_CLOEXEC is defined in git-compat-util.h unless already defined
- we now handle EINVAL by trying again without O_CLOEXEC


Ben Wijen (2):
  t6026-merge-attr: child processes must not inherit index.lock handles
  mingw: ensure temporary file handles are not inherited by child
    processes

 compat/mingw.h        |  4 ++++
 git-compat-util.h     |  4 ++++
 lockfile.h            |  4 ++++
 t/t6026-merge-attr.sh | 13 +++++++++++++
 tempfile.c            |  7 ++++++-
 tempfile.h            |  4 ++++
 6 files changed, 35 insertions(+), 1 deletion(-)

Published-As: https://github.com/dscho/git/releases/tag/mingw-index-lock-v3
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-index-lock-v3

Interdiff vs v2:

 diff --git a/git-compat-util.h b/git-compat-util.h
 index f52e00b..db89ba7 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -667,6 +667,10 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
  #define getpagesize() sysconf(_SC_PAGESIZE)
  #endif
  
 +#ifndef O_CLOEXEC
 +#define O_CLOEXEC 0
 +#endif
 +
  #ifdef FREAD_READS_DIRECTORIES
  #ifdef fopen
  #undef fopen
 diff --git a/tempfile.c b/tempfile.c
 index db3981d..2990c92 100644
 --- a/tempfile.c
 +++ b/tempfile.c
 @@ -120,7 +120,12 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
  	prepare_tempfile_object(tempfile);
  
  	strbuf_add_absolute_path(&tempfile->filename, path);
 -	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
 +	tempfile->fd = open(tempfile->filename.buf,
 +			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
 +	if (O_CLOEXEC && tempfile->fd < 0 && errno == EINVAL)
 +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
 +		tempfile->fd = open(tempfile->filename.buf,
 +				    O_RDWR | O_CREAT | O_EXCL, 0666);
  	if (tempfile->fd < 0) {
  		strbuf_reset(&tempfile->filename);
  		return -1;

-- 
2.10.0.rc0.115.ged054c0

base-commit: 2632c897f74b1cc9b5533f467da459b9ec725538
