Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D689202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 16:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbdIUQpL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:45:11 -0400
Received: from avasout07.plus.net ([84.93.230.235]:60587 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdIUQpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:45:11 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CGl61w0090M91Ur01Gl903; Thu, 21 Sep 2017 17:45:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=HL2xxSYxMnIEFej-H7QA:9 a=9LAEfzFv19nPCBB1:21
 a=mqNezXLinRICz98g:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/4] avoid some -Wsign-compare warnings
Message-ID: <7c6dc899-fc98-e5cf-f16b-6b996a8dd6ef@ramsayjones.plus.com>
Date:   Thu, 21 Sep 2017 17:45:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This series removes 687 '-Wsign-compare' warnings when applied to the
current master branch (@ commit 59c0ea183). Using gcc v5.4.0 and adding
'-Wextra' to the compilation flags, we can summarize the warnings as
follows:

  $ grep warning out1 | sed -e 's/.*\[/\[/' | sort | uniq -c | sort -rn
     1437 [-Wunused-parameter]
     1410 [-Wsign-compare]
      670 [-Wmissing-field-initializers]
        7 [-Wempty-body]
  $ 

After applying this series, we see:

  $ grep warning out2 | sed -e 's/.*\[/\[/' | sort | uniq -c | sort -rn
     1437 [-Wunused-parameter]
      723 [-Wsign-compare]
      670 [-Wmissing-field-initializers]
        7 [-Wempty-body]
  $ 

The number of -Wunused-parameter warnings is not as bad as it seems; for
example, we can get rid of 690 such warning with the following patch:

  $ git diff
  diff --git a/git-compat-util.h b/git-compat-util.h
  index cedad4d58..8e7388082 100644
  --- a/git-compat-util.h
  +++ b/git-compat-util.h
  @@ -118,6 +118,9 @@
   /* Approximation of the length of the decimal representation of this type. */
   #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
   
  +/* suppress 'unused parameter' warnings */
  +#define UNUSED(x) ((void)(x))
  +
   #if defined(__sun__)
    /*
     * On Solaris, when _XOPEN_EXTENDED is set, its header file
  @@ -341,6 +344,7 @@ typedef uintmax_t timestamp_t;
   #ifndef has_dos_drive_prefix
   static inline int git_has_dos_drive_prefix(const char *path)
   {
  +	UNUSED(path);
   	return 0;
   }
   #define has_dos_drive_prefix git_has_dos_drive_prefix
  @@ -349,6 +353,7 @@ static inline int git_has_dos_drive_prefix(const char *path)
   #ifndef skip_dos_drive_prefix
   static inline int git_skip_dos_drive_prefix(char **path)
   {
  +	UNUSED(path);
   	return 0;
   }
   #define skip_dos_drive_prefix git_skip_dos_drive_prefix
  $ 
  
  $ grep warning out3 | sed -e 's/.*\[/\[/' | sort | uniq -c | sort -rn
      747 [-Wunused-parameter]
      723 [-Wsign-compare]
      670 [-Wmissing-field-initializers]
        7 [-Wempty-body]
  $ 

The original version of the UNUSED macro used the gcc __unused__ attribute,
but that caused some issues with msvc IIRC, so this version has been
simplified. I have been meaning to check that this does not cause any bloat
in the git executable (with all optimisation levels), so I haven't submitted
it before. What do you think?

These patches reduce the error count quite a bit, without touching too many
files, but additional patches may have to be batched up and submitted over
several releases, viz:

  $ grep warning out2 | cut -d: -f1 | sort | uniq | wc -l
  264
  $ 

Ramsay Jones (4):
  git-compat-util.h: xsize_t() - avoid -Wsign-compare warnings
  commit-slab.h: avoid -Wsign-compare warnings
  cache.h: hex2chr() - avoid -Wsign-compare warnings
  ALLOC_GROW: avoid -Wsign-compare warnings

 builtin/pack-objects.c |  4 ++--
 cache.h                |  4 ++--
 commit-slab.h          |  6 +++---
 config.c               |  2 +-
 diff.c                 |  2 +-
 git-compat-util.h      |  6 ++++--
 line-log.c             | 18 +++++++++---------
 line-log.h             |  2 +-
 revision.c             |  2 +-
 tree-walk.c            |  3 +--
 10 files changed, 25 insertions(+), 24 deletions(-)

-- 
2.14.0
