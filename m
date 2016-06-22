Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB13120189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbcFVQmj (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:42:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752818AbcFVQmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:42:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA41D23AE4;
	Wed, 22 Jun 2016 12:42:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rDWgSfPsN95/pbx04CUtko3Et3I=; b=iGYV76
	O495sGTzcYPdznNyro+X25M04vBY4BZagyTYQ/61AXBQkpuzTpQd3hcT6lxyMvnQ
	ZyntTgjh6EwXXHbQFF2272OgC2x7/98zZf3aFQ5woSAnXgqDidNcM8n2lMvE1+BI
	hG1Ll6vm8OhJzu35haNQaUwB89+ivZYzdjPys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M9XdxcQiJ0f4l75y7XzmUt0R/NeS7lPf
	qaCLTXrB8j5YjuJe6ef8IgcCtDl5Pgsrw2KKtLOdTTqwTbWBMjUjXIiP8DKC5mbW
	NY+9+TftAZNAWOdnHAVOOQ19RQXQwQB4LgZuoZQmnR3rUXOt5s+dFVkys80mPvLF
	ElYmQ1HewYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C373123AE3;
	Wed, 22 Jun 2016 12:42:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4082823AE2;
	Wed, 22 Jun 2016 12:42:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows paths
References: <cover.1466246919.git.johannes.schindelin@gmx.de>
	<a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de>
	<xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606211356170.22630@virtualbox>
	<xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com>
	<xmqqk2hiqwpb.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606220927350.10382@virtualbox>
Date:	Wed, 22 Jun 2016 09:42:34 -0700
In-Reply-To: <alpine.DEB.2.20.1606220927350.10382@virtualbox> (Johannes
	Schindelin's message of "Wed, 22 Jun 2016 10:25:31 +0200 (CEST)")
Message-ID: <xmqqa8idnpj9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 532902F0-3898-11E6-A4ED-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 21 Jun 2016, Junio C Hamano wrote:
>
>> I said $PATH because --exec-path does not care what you do with
>> %PATH% but it deeply cares that its output is usable in $PATH.
>
> The really, really, really important part to keep in mind is that there is
> no $PATH on Windows.

I think I know that well enough; please sanity check.  My
understanding is:

 * Your (emulated) getenv(3) reads %PATH% which may look like
   "c:\a\b;c:\c\d", i.e. Windows style.

 * Your argv_exec_path also looks like "c:\e\f", i.e. Windows
   style.

 * Your setup_path() would yield "c:\e\f;c:\a\b;c:\c\d" because it
   concatenates the above two with PATH_SEP, i.e. Windows style, and
   your setenv(3) will set that to %PATH%.

 * After all that happens, your run_command(), execv_git_cmd(),
   etc. would honor that %PATH%.

 * In all of the above, a back-slash can be (and may indeed be) a
   forward-slash, as library functions and system calls are prepared
   to take both since the good old DOS days.  I.e. "c:\a\b" can be
   "c:/a/b".  It cannot be "/c/a/b", however.

 * When bash gets spawned (perhaps because a hook is written in that
   language, perhaps because child_process.use_shell is set when
   executing an alias "!cmd", running a pager, or running an
   editor), the value of %PATH% derived by the above sequence is not
   exposed as $PATH.  There is the "rewrite leading C: with /C/"
   outside us (i.e. in bash).

And that is why I suggested to keep that "internal paths are in
platform native format" and apply the same conversion as what bash
does immediately before the returned value from git_exec_path() is
fed to puts().  That way, "$PATH" (not %PATH%) can be modified with
"$(git --exec-path)" in scripts the same way on all the platforms
and you do not have to break people's hooks.

Having said that, I realize that I missed one huge thing to take
into consideration.  I assume that you have been shipping Git for
Windows with this "'git --exec-path' gives c:\a\b, not /c/a/b"
feature for a long time, so existing Windows users will be broken if
we "fix" this (which would allow them to use shell scripts their
friends use on other platforms without modification).  So from that
point alone, "PATH=$(git --exec-path):$PATH in shell should work on
any platform and "git --exec-path" should be fixed" would not fly.
This simply is too late to fix.

The patch under discussion is the only door left for that test, and
a similar trickery is needed for any end-user scripts used for hooks
and aliases that use 'git --exec-path', if they ever want to be
cross-platform.

So let's take that "if Windows do this" change to t2300 as-is.
