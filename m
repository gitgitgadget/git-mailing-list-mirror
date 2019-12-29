Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A2C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A3120722
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 18:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfL2SIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:08:19 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:6694 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731595AbfL2SIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 13:08:18 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47m7pS1J3Xz5tl9;
        Sun, 29 Dec 2019 19:08:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0275A238;
        Sun, 29 Dec 2019 19:08:14 +0100 (CET)
Subject: Re: ERANGE strikes again on my Windows build; RFH
To:     Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
 <20191229142909.7bmjbrroboitvnzq@tb-raspi4>
 <a32e075b-9e6c-2b6a-8619-0330501eee97@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b6e3fc5b-1d16-f7c9-0069-a2938b00f0fc@kdbg.org>
Date:   Sun, 29 Dec 2019 19:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a32e075b-9e6c-2b6a-8619-0330501eee97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.19 um 18:25 schrieb Alban Gruin:
> Le 29/12/2019 à 15:29, Torsten Bögershausen a écrit :
>> On Sat, Dec 28, 2019 at 04:41:42PM +0100, Johannes Sixt wrote:
>>> In sha1-file.c:read_object_file_extended() we have the following pattern:
>>>
>>> 	errno = 0;
>>> 	data = read_object(r, repl, type, size);
>>> 	if (data)
>>> 		return data;
>>>
>>> 	if (errno && errno != ENOENT)
>>> 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>>>
>>> That is, it is expected that read_object() does not change the value of
>>> errno in the non-error case. I find it intriguing that we expect a quite
>>> large call graph that is behind read_object() to behave this way.
>>>
>>> What if a subordinate callee starts doing
>>>
>>> 	if (some_syscall(...) < 0) {
>>> 		if (errno == EEXIST) {
>>> 			/* never mind, that's OK */
>>> 			...
>>> 		}
>>> 	}
>>>
>>> Would it be required to reset errno to its previous value in this
>>> failure-is-not-an-error case?
>>>
>>> The problem in my Windows build is that one of these subordinate
>>> syscalls is vsnprintf() (as part of a strbuf_add variant, I presume),
>>> and it fails with ERANGE when the buffer is too short. Do I have to
>>> modify the vsnprintf emulation to restore errno?
>>
>> If you ask me: I think so, yes.
>> At least the documentation about vsnprintf does not mention that errno is touched at all.
>> That is the man pages for Linux and Mac OS, or see here:
>> https://linux.die.net/man/3/vsnprintf
>>
>> It would make sense to analyze the complete callstack, I think.
>> Is your problem reproducable ?
>>
>> Changing the function strbuf_vaddf() strbuf.c seems to be straight forward to me.
>>
> 
> According to the standard, vsnprintf() _can_ change errno[1] (and the
> BSDs do so[2][3][4].)  But apparently, not to ERANGE.

I am not worried about errno being set (or to what value) when there
actually is an error. I am asking what to do when there is actually *no*
error. In my vsnprintf emulation, the case where ERANGE happens is *not*
an error as far as the emulation is concerned.

What if in the huge call graph behind read_object() some function
changes errno to, say, EEXIST, EISDIR, or ENODIR and the condition under
which this happens is *not* an error in that context? Is the function
required to restore the original errno?

Consider the task to create file "foo/bar.c". We would have to
mkdir("foo"), but it is *not* an error when mkdir() fails with errno ==
EEXIST. Are we required to reset errno back to its old value?

(I know, read_object() is unlikely to allocate files, but I think I have
to explain in some way that the context may define that there is no
error -- even though a lower-level function failed and modified errno.)

-- Hannes
