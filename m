Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00521F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757617AbcIHHdm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:33:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:50029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756987AbcIHHdm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:33:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LqQTl-1b49JD0Rbl-00e6hv; Thu, 08 Sep 2016 09:33:30
 +0200
Date:   Thu, 8 Sep 2016 09:33:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Fix a segfault caused by regexec() being called
 on mmap()ed data
In-Reply-To: <cover.1473319844.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1609080931250.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <cover.1473319844.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bSkcSoXV3uLcgwv6OipYPJN6ACHhTkapbfhkZp2iuRK1FFUU9/R
 rwIo2+za9GAxivi8SqQR4qvN+BwA53ovyt2w/3Rm8Mm7SxnCJRjbJuJ1RlYPAK1ojC6Y1zi
 TpsPYAa1JIYJ6tsm3wYv4/OhlgsNXPlhZYo6iyPgJ7weRJykfMvMWtwhzh8WMmEFYu+Vjal
 lR8uptA65+xcDXxvu0Dyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PkcUSdObWus=:QXfwXjWiVwuBOo50g2w/Xv
 mTcKgj9BOVZAHKySClz9Uu86Pvn9hlROAd2JCgsDb5T5Ij9H/BmCPI52LrQJlC3bR/3ClaXyN
 1iHngheF5uTYL6xXK9+z+3Bf1nbr1GPlde70N4Jk8y5695Tr2792LxEYVklpBBR09YkYjpVMz
 6WNXT9CRCGipQuZu8KCtVskBOAH3ryKp5Ar/i2m2J2H77Z70abGsdBGuDDMGAb4afeZL2pSi6
 mKR/cR0XC/TSkHTcp1f/Tlkbt63qQp9JsQRjrLMTZdgLZCVRxQAOCkvoUKaXsqEM05tpO5G1B
 DQS/Ld4iCIF8j6L8QUNYhNqbyrpfR2LXBoonbmFCk/tjjjKr6u9WeuZB8HB8vPUx+5K4IcItl
 /9hBhIDGIGsAKzaExKRAe3FBM+8GyJ/LEP8zp7fMHONpWaJkxN5gVKoiDOS9q9GSMdyaUVMDp
 ryQKf9kjhNSBBYNZJ/DSCVPW0LOVCZWYyUu4U1dM7L8XmZ8a1FWSfNc7EjRuha+DXNgCLqdv0
 /FnUh9dbDRdwY6TKhhvqwJJI/9SCloT+P2nsoIBPMfOkmU900tMpn1jb3QnOzDitpxfuY1/fW
 /XWGUGVzvaz8D6N4U4yQZVR5H6bQ1ZY/BXsetmEAdYS8JA91CgIvsktnVFEkk7yQLLACYSMKf
 s+CgXwyv8ubd2mkzbd1sYvxFKh3hvFsWpl3tCCd8RNx8V4o60YhaQoR1/tvGSot6NCgwZDFpN
 YYLfcJim7a/FR/XQkPdBpdt3xI6Fil5ONSsTmIDpL222/5G5BSGGc3hz4AxFfb6kfSYw4Xij+
 Ao7/2ro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 8 Sep 2016, Johannes Schindelin wrote:

> We solve this by introducing a helper, regexec_buf(), that takes a
> pointer and a length instead of a NUL-terminated string.

BTW I should have clarified why I decided on another name than regexecn()
(I had considered this even before reading Peff's proposed patch): the <n>
in string functions suggest a limiting of NUL-terminated strings. In other
words, if n = 100 and the provided pointer points to a NUL-terminated
string of length 3, the *n function will treat it as a string of length 3.

That is not what regexec_buf() does: it ignores the NUL. Hence the
different name.

Ciao,
Dscho
