Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB0C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 03:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347359AbiAKDvq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Jan 2022 22:51:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59057 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiAKDvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 22:51:46 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20B3piFa004356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jan 2022 22:51:44 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com> <Ydzw+RqR6IfbT/oM@nand.local> <010b01d80697$0c848770$258d9650$@nexbridge.com> <Ydzyv8ZCEpDDRBXT@nand.local>
In-Reply-To: <Ydzyv8ZCEpDDRBXT@nand.local>
Subject: RE: [BUG] Re: Git 2.35.0-rc0
Date:   Mon, 10 Jan 2022 22:51:39 -0500
Organization: Nexbridge Inc.
Message-ID: <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIzMkomfuhrYaYzn51cwdtqNnfQqQHkNVZQAf1QdqACJzV1/qt2iM6w
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 10, 2022 10:00 PM, Taylor Blau wrote:
> On Mon, Jan 10, 2022 at 09:57:57PM -0500, rsbecker@nexbridge.com
> wrote:
> > > If your system doesn't have a modern-ish zlib, you may try building
> > > with that knob, or upgrading your system's copy of zlib. And if
> > > NonStop doesn't have a modern zlib available at all, we should
> > > modify the NonStop section of config.mak.uname.
> >
> > There is no provision in reftable/block.c to avoid using uncompress2,
> > so the knob will not help. Our zlibc is not that recent (as in it does
> > not have uncompress2) and we cannot make the 2.35.0 timeframe to
> > upgrade it. The current zlib seems to require gcc and is very
> > difficult to port at this stage. This is a blocker situation.
> 
> NO_UNCOMPRESS2 does not avoid calling uncompress2, but instead compiles
> a copy-and-pasted implementation in compat/ so that the function is available.
> 
> Looking through it, I can't imagine that it wouldn't compile just fine even on
> NonStop.
> 
> Have you tried building with NO_UNCOMPRESS2?

The patch for NonStop to make this compile is as follows. Test is running - will be 2 days:

diff --git a/config.mak.uname b/config.mak.uname
index a3a779327f..9b3e9bff5f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
        NO_SETENV = YesPlease
        NO_UNSETENV = YesPlease
        NO_MKDTEMP = YesPlease
+       NO_UNCOMPRESS2 = YesPlease
        # Currently libiconv-1.9.1.
        OLD_ICONV = UnfortunatelyYes
        NO_REGEX = NeedsStartEnd

Could we get that into rc1?

I now have a different issue:

make -C t/ all
make[1]: Entering directory '/home/git/git/t'
rm -f -r 'test-results'
/usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long

Is there anyway to move to xargs? I am not sure why /usr/bin/perl is having issues with the build.

Regards,
Randall


