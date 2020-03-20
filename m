Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F9C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C7C20739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCTFhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:37:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:44740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726030AbgCTFhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:37:32 -0400
Received: (qmail 30991 invoked by uid 109); 20 Mar 2020 05:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:37:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3028 invoked by uid 111); 20 Mar 2020 05:47:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 01:47:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:37:30 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Ed Maste <emaste@FreeBSD.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
Message-ID: <20200320053730.GE499858@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
 <20200319161200.GF3513282@coredump.intra.peff.net>
 <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
 <20200320014142.GF1858@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320014142.GF1858@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 08:41:42AM +0700, Danh Doan wrote:

> On 2020-03-19 15:16:09-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Thu, Mar 19, 2020 at 09:00:06PM +0700, Đoàn Trần Công Danh wrote:
> > >
> > >> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> > >> update feature, 2016-08-03), we started to use ls as a trick to update
> > >> directory's mtime.
> > >> 
> > >> However, `-ls` flag isn't required by POSIX's find(1), and
> > >> busybox(1) doesn't implement it.
> > >> 
> > >> Use an equivalence `-exec ls -dils {} +` instead.
> > >
> > > Makes sense. I wonder if we need all of "-dils", but it's not clear to
> 
> From the original commit message, I think whichever flags that call
> stat(2) would be do it. It's `-d` (to check is_directory), and `-i`
> for inode number.
> 
> This make make wonder, will it be enough to just use:
> 
> 	find . -type d >/dev/null

Perhaps we can get a friendly FreeBSD developer (cc'd) to run a quick
test for us.

Ed, the question is whether:

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..6791c6b95a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
 export GIT_FORCE_UNTRACKED_CACHE
 
 sync_mtime () {
-	find . -type d -ls >/dev/null
+	find . -type d >/dev/null
 }
 
 avoid_racy() {

lets t7063 consistently pass on FreeBSD.

-Peff
