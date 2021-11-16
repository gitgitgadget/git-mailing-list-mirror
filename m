Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F558C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261F263214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhKPQEi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Nov 2021 11:04:38 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39735 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbhKPQEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 11:04:38 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AGG1PKI056263
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Nov 2021 11:01:25 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net> <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
In-Reply-To: <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
Subject: RE: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Tue, 16 Nov 2021 11:01:20 -0500
Organization: Nexbridge Inc.
Message-ID: <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHRZsJQSwQVxvA803MGEaqTSKtEHwGUCvbjAr89fOqr8J3MYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 16, 2021 10:31 AM, Jeff King wrote:
> On Tue, Nov 16, 2021 at 03:35:41AM +0000, brian m. carlson wrote:
> 
> > The order of options is also important here.  On systems with
> > arc4random, which is most of the BSDs, we use that, since, except on
> > MirBSD, it uses ChaCha20, which is extremely fast, and sits entirely
> > in userspace, avoiding a system call.  We then prefer getrandom over
> > getentropy, because the former has been available longer on Linux, and
> > finally, if none of those are available, we use /dev/urandom, because
> > most Unix-like operating systems provide that API.  We prefer options
> > that don't involve device files when possible because those work in
> > some restricted environments where device files may not be available.
> 
> I wonder if we'll need a low-quality fallback for older systems which don't
> even have /dev/urandom. Because it's going to be used in such a core part of
> the system (tempfiles), this basically becomes a hard requirement for using
> Git at all.
> 
> I can't say I'm excited in general to be introducing a dependency like this, just
> because of the portability headaches. But it may be the least bad thing
> (especially if we can fall back to the existing behavior).
> One alternative would be to build on top of the system mkstemp(), which
> makes it libc's problem. I'm not sure if we'd run into problems there, though.

None of /dev/urandom, /dev/random, or mkstemp are available on some platforms, including NonStop. This is not a good dependency to add. One variant PRNGD is used in ia64 OpenSSL, while the CPU random generator in hardware is used on x86. I cannot get behind this at all. Libc is also not used in or available to our port. I am very worried about this direction.

-Randall

