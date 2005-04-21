From: Alecs King <alecsk@gmail.com>
Subject: Re: HOWTO: PATCH: don't hardcode path-to-bash, use sys/limits.h
Date: Thu, 21 Apr 2005 22:31:02 +0800
Message-ID: <20050421143102.GA830@alc.bsd.st>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com> <4267387A.6040602@timesys.com> <20050421102326.GA22541@xdt04.mpe-garching.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 21 16:20:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOcX6-0000Ii-Po
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 16:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVDUOYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 10:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDUOYR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 10:24:17 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:31818 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261372AbVDUOYG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 10:24:06 -0400
Received: by rproxy.gmail.com with SMTP id a41so322621rng
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 07:24:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MBXfFhwF4b+lfhlQml7t01VgpLpjYzwlpBjaU6u/WGZlBV+pVgRyW36RkJi54xa50FeFlgf4W61tfwrRniIJFWXLNkpWfciEQggRZIytHJt+9Aus3mSdox9dSr5pBAKKTo/IKg5HwIPWp6gwjmJIcoCgGuaDwdFsu3ZzZxmQdDI=
Received: by 10.38.13.29 with SMTP id 29mr2360678rnm;
        Thu, 21 Apr 2005 07:24:04 -0700 (PDT)
Received: from localhost ([210.77.3.122])
        by mx.gmail.com with ESMTP id 79sm349051rnc.2005.04.21.07.24.02;
        Thu, 21 Apr 2005 07:24:04 -0700 (PDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050421102326.GA22541@xdt04.mpe-garching.mpg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2005 at 12:23:26PM +0200, Klaus Robert Suetterlin wrote:
> Hi,
> 
> I supply a patch that dehardcodes the path to bash (which is not /bin
> on all computers) and adds sys/limits.h to provide ULONG_MAX.

Hi, i did a similar patch a while back ago. As for ULONG_MAX, not every
sytem has <sys/limits.h>, i think <limits.h> is the rite place to go.

The patch below tested on both debian and fbsd.


commit 2deea74db72fb57a8b80e7945f23814112b22723
tree 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd
parent cd1c034369b73da7503da365fa556aab27004814
author Alecs King <alecsk ! gmail d@t com> 1114075114 +0800
committer Alecs King <alecsk ! gmail d@t com> 1114075114 +0800

trivial fix for making it more portable

Index: commit-tree.c
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/commit-tree.c  (mode:100644 sha1:043c7aa371101a1ea8cfc467279abf6c8acc7fd1)
+++ 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/commit-tree.c  (mode:100644 sha1:8a1f12dca07041d203ce22442b8470d42d322ef5)
@@ -252,7 +252,7 @@
 
 	then -= offset;
 
-	snprintf(result, maxlen, "%lu %5.5s", then, p);
+	snprintf(result, maxlen, "%lu %5.5s", (unsigned long) then, p);
 }
 
 static void check_valid(unsigned char *sha1, const char *expect)
Index: commit.c
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/commit.c  (mode:100644 sha1:eda45d7e15358ed6f2cd0502de2a08987307fc98)
+++ 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/commit.c  (mode:100644 sha1:9f0668eb68cec56a738a58fe930ae0ae2960e2b2)
@@ -1,6 +1,7 @@
 #include "commit.h"
 #include "cache.h"
 #include <string.h>
+#include <limits.h>
 
 const char *commit_type = "commit";
 
Index: gitdiff-do
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/gitdiff-do  (mode:100755 sha1:afed4e40b259a61b0f12979ba7326f26743bc553)
+++ 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitdiff-do  (mode:100755 sha1:218dfabeb4a5dcbd2cf58bd6f672f385690ec397)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Make a diff between two GIT trees.
 # Copyright (c) Petr Baudis, 2005
Index: gitlog.sh
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/gitlog.sh  (mode:100755 sha1:a496a864f9586e47a4d7bd3ae0af0b3e07b7deb8)
+++ 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitlog.sh  (mode:100755 sha1:7b3aa8a89bc64273c648920ccd1686859754803e)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Make a log of changes in a GIT branch.
 #
Index: revision.h
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/revision.h  (mode:100644 sha1:46cc10440be781cea4993aca37ee35e251495084)
+++ 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/revision.h  (mode:100644 sha1:f0754f5d8ea3da52503b8ea8c16b34566e4ae6e0)
@@ -10,6 +10,7 @@
  * definition for this rev, and not just seen it as
  * a parent target.
  */
+#include <limits.h>
 #define marked(rev)	((rev)->flags & 0xffff)
 #define SEEN 0x10000
 #define USED 0x20000

-- 
Alecs King
