From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/5] Miscellaneous fixes from static analysis
Date: Sun, 16 Feb 2014 16:06:01 +0000
Message-ID: <cover.1392565571.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4Ex-0007s8-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaBPQGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:06:22 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35710 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaBPQGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:06:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 588C5CDA590;
	Sun, 16 Feb 2014 16:06:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l4SGvIp8llCw; Sun, 16 Feb 2014 16:06:19 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id B26BDCDA523;
	Sun, 16 Feb 2014 16:06:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8BD9D161E521;
	Sun, 16 Feb 2014 16:06:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EGcWEQVFTUpb; Sun, 16 Feb 2014 16:06:18 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 82A13161E262;
	Sun, 16 Feb 2014 16:06:15 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242227>

The first two of these fix real bugs, the rest just clean up some of the
less obviously "not actually a problem" issues identified by Clang's
static analyzer [1] and stack[2].

Stack is interesting in that it is designed to detect potentially
undesirable optimizations where undefined behaviour may be being invoked
unwittingly.  It only detected two error's in git.git, the first of
which is fixed by the final patch.  The second it describes as:

	bug: anti-algebra
	model: |
	  %11 = icmp ult i8* %extra_args, %7, !dbg !342
	  -->  %10 = icmp slt i64 %9, 0, !dbg !342
	  ************************************************************
	  %extra_args <u ((sext i32 %buflen to i64) + %extra_args)<nsw>
	  -->  (-1 * (sext i32 %buflen to i64)) <s 0
	stack: 
	  - daemon.c:522:0
	ncore: 1
	core: 
	  - daemon.c:520:0
	    - pointer overflow

which shows that Clang has converted (simplifying from daemon.c:520):

	char *end = extra_args + buflen;
	if (extra_args < end)

into:

	if (buflen < 0)

This doesn't look like it can ever be subject to pointer overflow, so I
have not considered the churn worth it here.


[1] http://clang-analyzer.llvm.org/
[2] https://github.com/xiw/stack

John Keeping (5):
  notes-utils: handle boolean notes.rewritemode correctly
  utf8: fix iconv error detection
  utf8: use correct type for values in interval table
  builtin/mv: don't use memory after free
  streaming: simplify attaching a filter

 builtin/mv.c  | 3 ++-
 notes-utils.c | 2 +-
 streaming.c   | 5 +----
 utf8.c        | 6 +++---
 4 files changed, 7 insertions(+), 9 deletions(-)

-- 
1.9.rc0.187.g6292fff
