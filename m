Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA12C2D0C6
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68820208C4
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 15:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfL1Plq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Dec 2019 10:41:46 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:44477 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfL1Plq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Dec 2019 10:41:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47lSbr4yQgz5tl9
        for <git@vger.kernel.org>; Sat, 28 Dec 2019 16:41:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C6A831C93
        for <git@vger.kernel.org>; Sat, 28 Dec 2019 16:41:42 +0100 (CET)
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: ERANGE strikes again on my Windows build; RFH
Message-ID: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
Date:   Sat, 28 Dec 2019 16:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In sha1-file.c:read_object_file_extended() we have the following pattern:

	errno = 0;
	data = read_object(r, repl, type, size);
	if (data)
		return data;

	if (errno && errno != ENOENT)
		die_errno(_("failed to read object %s"), oid_to_hex(oid));

That is, it is expected that read_object() does not change the value of
errno in the non-error case. I find it intriguing that we expect a quite
large call graph that is behind read_object() to behave this way.

What if a subordinate callee starts doing

	if (some_syscall(...) < 0) {
		if (errno == EEXIST) {
			/* never mind, that's OK */
			...
		}
	}

Would it be required to reset errno to its previous value in this
failure-is-not-an-error case?

The problem in my Windows build is that one of these subordinate
syscalls is vsnprintf() (as part of a strbuf_add variant, I presume),
and it fails with ERANGE when the buffer is too short. Do I have to
modify the vsnprintf emulation to restore errno?
