Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67521FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbcFURPg (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 13:15:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752807AbcFUROR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 13:14:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 96D7324E9D;
	Tue, 21 Jun 2016 13:10:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OlYEV7C27Xe/wNdWYEExwOcVSLo=; b=APfbrc
	pLBe2CSsyya0T2f0IZjsSmqtgOAfzmrqBXHOHq5VUkSH18SMW+N8fVdP8Ha/ZGT9
	xTtFBbtQAqBnQsTEBh4ddFf+LZW23ZwK6TEIbP/+M3AWSgLtHBNOT6+TV7pvo/OH
	8eA8HCX6t17GEZo281+kBbVuUnal3HcAXPCDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tj7w8wXaJSdR28VoxX4+3hPevdbJJ+04
	LDWw5UZ2CDo//CMnptwzIZ9XnnEpUYbYQcQEofM4rTQbpV8KabYtWfDRWIgeL3gx
	5Pe4bltgeFJJc34cQpdAAZiA5l/nMfUalJayT/qlxeyicr5mSfEXma8mySNgVXOn
	N2xEwTrUbsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F3F124E9B;
	Tue, 21 Jun 2016 13:10:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 175BC24E9A;
	Tue, 21 Jun 2016 13:10:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows paths
References: <cover.1466246919.git.johannes.schindelin@gmx.de>
	<a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de>
	<xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606211356170.22630@virtualbox>
Date:	Tue, 21 Jun 2016 10:10:23 -0700
In-Reply-To: <alpine.DEB.2.20.1606211356170.22630@virtualbox> (Johannes
	Schindelin's message of "Tue, 21 Jun 2016 14:01:31 +0200 (CEST)")
Message-ID: <xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B729360-37D3-11E6-ABE9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Hmm, I am confused.  `git --exec-path` _is_ meant to "spit out" a
>> path that is usable when prepended/appended to $PATH [1], and it
>> does _not_ have to be POSIX-ish path.  It is totally up to the port
>> to adjust it to the platform's convention how the $PATH environment
>> variable is understood.
>
> The port does exactly what it is supposed to do: the output of `git
> --exec-path` can be prepended/appended to %PATH%. The point here is:
> %PATH% is *semicolon*-delimited.

I said $PATH because --exec-path does not care what you do with
%PATH% but it deeply cares that its output is usable in $PATH.

I think you would need something similar to "pwd -W", that is, leave
"git --exec-path" as a way to give shell scripts people have written
over the years that allows them to say "git-cmd" as long as they do
PATH="$(git --exec-path):$PATH" upfront.  And for Windows scripts,
introduce a new option "git --exec-path-windows" that can give
C:/git-sdk-64/usr/src/git (or even using backslash).

I do not mean to say that exec_cmd.c::git_exec_path() function must
return a string /c/git-sdk-64/usr/src/git by the above.  It should
keep returning C:/git-sdk-64/usr/src/git, I think.  Its use in
exec_cmd.c::add_path() to use PATH_SEP to do the equivalent
internally for the platform would want C:/git-sdk-64/usr/src/git
there.  Also I think exec_cmd.c::argv_exec_path should keep using
platform native format.

Perhaps you can do the conversion you are doing with this
"let's change t2300" patch instead in C where the return value of
git_exec_path() is fed to puts() in git.c::handle_options(), or
better yet make a helper function git_exec_path_for_shell() that
calls git_exec_path() and does the conversion on Windows (and passes
the result from git_exec_path() intact on other platforms).

I say all of the above because I see this in hits from "git grep -e
--exec-path":

contrib/subtree/git-subtree.sh:PATH=$PATH:$(git --exec-path)

and I would imagine there are countless other shell scripts that
follow the "Output from 'git --exec-path' can be prepended/appended
to PATH to allow you write 'git-cmd' instead of 'git cmd'".  They
would not work unless your "git --exec-path" gives an output that is
usable by shell in $PATH (and not %PATH%).

