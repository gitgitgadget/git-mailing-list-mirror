Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919E71F404
	for <e@80x24.org>; Thu, 13 Sep 2018 12:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeIMR2h (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 13:28:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:43997 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIMR2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 13:28:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8DCJBO1041608
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Sep 2018 08:19:12 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>     <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org> <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com> <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com> <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Question] Signature calculation ignoring parts of binary files
Date:   Thu, 13 Sep 2018 08:19:04 -0400
Message-ID: <001101d44b5b$fa337350$ee9a59f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1dHr/8n7yCB9UeIXEGLjm31C4owFRfwXbAhcuk1ECJbKk4AITag6rom677TA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 12, 2018 7:00 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> author is important to our process. My objective is to keep the
> >> original file 100% exact as supplied and then ignore any changes to
> >> the metadata that I don't care about (like Creator) if the remainder of
the
> file is the same.
> 
> That will *not* work.  If person A gave you a version of original, which
> hashes to X after you strip the cruft you do not care about, you would
> register that original with person A's fingerprint on under the name of X.
> What happens when person B gives you another version, which is not byte-
> for-byte identical to the one you got earlier from person A, but does hash
to
> the same X after you strip the cruft?  If you are going to store it in
Git, and if
> by SHA-1 you are calling what we perceive as "object name" in Git land,
you
> must store that one with person B's fingerprint on it also under the name
of
> X.  Now which version will you get from Git when you ask it to give you
the
> object that hashes to X?

The scenario is slightly different.
1. Person A gives me a new binary file-1 with fingerprint A1. This goes into
git unchanged.
2. Person B gives me binary file-2 with fingerprint B2. This does not go
into git yet.
3. We attempt a git diff between the committed file-1 and uncommitted file-2
using a textconv implementation that strips what we don't need to compare.
4. If file-1 and file-2 have no difference when textconv is used, file-2 is
not added and not committed. It is discarded with impunity, never to be seen
again, although we might whine a lot at the user for attempting to put
file-2 in - but that's not git's issue.
5. If file-1 and file-2 have differences when textconv is used, file-2 is
committed with fingerprint B2.
6. Even if an error is made by the user and they commit file-2 with B2
regardless of textconv, there will be a human who complains about it, but
git has two unambiguous fingerprints that happen to have no diffs after
textconv is applied.

My original hope was that textconv could be used to influence the
fingerprint, but I do not think that is the case, so I went with an
alternative. In the application, I am not allowed to strip any cruft off
file-1 when it is stored - it must be byte-for-byte the original file. This
application is marginally related to a DRM-like situation where we only care
about the original image provided by a user, but any copies that are
provided by another user with modified metadata will be disallowed from
repository.

Does that make more sense? 

Cheers,
Randall

