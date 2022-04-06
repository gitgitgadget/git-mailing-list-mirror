Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08262C433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiDFUOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiDFUMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:12:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6C23ACA9
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 10:55:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 236HtFQd007933
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Apr 2022 13:55:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 096B315C3EC0; Wed,  6 Apr 2022 13:55:15 -0400 (EDT)
Date:   Wed, 6 Apr 2022 13:55:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Markus Vervier <markus.vervier@x41-dsec.de>, git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
Message-ID: <Yk3UAz3sn9KhMnyf@mit.edu>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
 <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2204061620110.379@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2204061620110.379@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 06, 2022 at 05:08:37PM +0200, Johannes Schindelin wrote:
> I have fixed Git for Windows' Coverity build and started to sift through
> the 154 new defects reported as of v2.36.0-rc0.
> 
> Sadly, there is now a new class of overwhelming false positives: Coverity
> claims that "strbuf_addstr does not [NUL-]terminate", which is of course
> false.

It should be possible to suppress this by uploading a Coverity model
file.  See[1] for more details:

[1] https://community.synopsys.com/s/article/practical-example-of-coverity-function-model

I've suppressed a similar issue by using the attribute __nonstring,
but I don't think that will work for git, because strbuf->buf really
*is* a NUL-terminated string, where as in ext4 we have some fields
which are designed to be NUL padded, but it is *not* guaranteed to be
NUL-terminated:

#ifndef __nonstring
#ifdef __has_attribute
#if __has_attribute(__nonstring__)
#define __nonstring                    __attribute__((__nonstring__))
#else
#define __nonstring
#endif /* __has_attribute(__nonstring__) */
#else
# define __nonstring
#endif /* __has_attribute */
#endif /* __nonstring */

struct ext2_super_block {
       ...
/*068*/	__u8	s_uuid[16] __nonstring;		/* 128-bit uuid for volume */
/*078*/	__u8	s_volume_name[EXT2_LABEL_LEN] __nonstring;	/* volume name */
       ...
};

(This is needed to suppress warnings by Clang as well.)

Using __nonstring will result in attempts to use s_volume_name in "C"
string context to give a warning, which is why this isn't right for
strbuf->buf.

Cheers,

						- Ted
