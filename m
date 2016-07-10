Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6C72018F
	for <e@80x24.org>; Sun, 10 Jul 2016 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757311AbcGJWQq (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 18:16:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33918 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757207AbcGJWQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 18:16:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06242018E;
	Sun, 10 Jul 2016 22:16:44 +0000 (UTC)
Date:	Sun, 10 Jul 2016 22:16:44 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Ronald Wampler <rdwampler@gmail.com>, git@vger.kernel.org,
	mackyle@gmail.com, reubenhwk@gmail.com, sunshine@sunshineco.com
Subject: [PATCH] config.mak.uname: define NEEDS_LIBRT under Linux, for now
Message-ID: <20160710221644.GA4927@whir>
References: <20160707204554.14961-1-rdwampler@gmail.com>
 <xmqqwpkxnoae.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpkxnoae.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Ronald Wampler <rdwampler@gmail.com> writes:
> 
> > I am not sure if this the correction solution. Another option I
> > considered was to wrap the EXTLIBS += -lrt is an ifndef NO_RT and only
> > defining NO_RT for Mac OS X in config.mak.uname.
> 
> That alternative would make the resulting code noisier/uglier with
> nested ifdef, I would imagine, but it would be of less impact to the
> existing users.  But my gut feeling is that the patch you sent is
> probably a better solution for the longer term.

That change broke my Debian wheezy LTS system, which isn't too
out-of-date.  I think having excessive linkage on newer systems
is preferable to breaking the out-of-the-box experience.

I don't know about other platforms, but I think the following
will help users on older GNU/Linux systems for the next few
years:

-------8<------
Subject: [PATCH] config.mak.uname: define NEEDS_LIBRT under Linux, for now

My Debian wheezy LTS system is still on glibc 2.13; and LTS
distros may use older glibc, still, so lets not unnecessarily
break things out-of-the-box.

We seem to assume Linux is using glibc in our Makefiles anyways,
so I don't think this will introduce new breakage for users of
alternative libc implementations.

Signed-off-by: Eric Wong <e@80x24.org>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index a88f139..22958a8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -36,6 +36,8 @@ ifeq ($(uname_S),Linux)
 	HAVE_DEV_TTY = YesPlease
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
+	# -lrt is needed for clock_gettime on glibc <= 2.16
+	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 endif
-- 
EW
