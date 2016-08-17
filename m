Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC511FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 18:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbcHQSWE (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 14:22:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752973AbcHQSWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 14:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC26236295;
	Wed, 17 Aug 2016 14:22:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3g9NlSSq+B37bakT0Pe2hf6UznM=; b=e6vbfh
	0mxghM9+o36885uicAMUMP1zU/bPM2Ib7L01Lzqj6tTzlx+/atmQ9tEGtTuSyZEP
	BQZhh5DY7N9R5xkv8Hvlw0ca4OLbzLtPNiuGjbrHwtnbjZC/2ciH9Pf0bq3zf0Jw
	NZ92FXBiy4Cp0hsBayK/nZKapb/P/2BB+YQfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=he8sDJt3h5pgDHys1bDhrZVvZyV0fr/8
	pUyjMKUMWRMfqYdDFOkULOjfwG6y/zxFQDMbIMsPCnN9+mgpjTWvWR7qoV1N3bo+
	AgEhcTVXbqe4APXxUUzVDXm2CL+6wamSgHq8RYXBr+f6xHfXL5W0PciAJfh3HahF
	wSc7wshomRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B530736294;
	Wed, 17 Aug 2016 14:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DF7B36293;
	Wed, 17 Aug 2016 14:22:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ben Wijen <ben@wijen.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited by child processes
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
	<77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
Date:	Wed, 17 Aug 2016 11:22:00 -0700
In-Reply-To: <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 17 Aug 2016 14:41:19 +0200
	(CEST)")
Message-ID: <xmqqd1l79rxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E4CFDD4-64A7-11E6-B039-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Ben Wijen <ben@wijen.net>
>
> When the index is locked and child processes inherit the handle to
> said lock and the parent process wants to remove the lock before the
> child process exits, on Windows there is a problem: it won't work
> because files cannot be deleted if a process holds a handle on them.
> The symptom:
>
>     Rename from 'xxx/.git/index.lock' to 'xxx/.git/index' failed.
>     Should I try again? (y/n)
>
> Spawning child processes with bInheritHandles==FALSE would not work
> because no file handles would be inherited, not even the hStdXxx
> handles in STARTUPINFO (stdin/stdout/stderr).
>
> Opening every file with O_NOINHERIT does not work, either, as e.g.
> git-upload-pack expects inherited file handles.
>
> This leaves us with the only way out: creating temp files with the
> O_NOINHERIT flag. This flag is Windows-specific, however. For our
> purposes, it is equivalent our purposes) to O_CLOEXEC (which does not
> exist on Windows), so let's just open temporary files with the
> O_CLOEXEC flag and map that flag to O_NOINHERIT on Windows.

The callchain that leads to create_tempfile() eventually goes up to
hold_lock_file_for_update() and its _timeout() variant in the
current codebase.  There is no other create_tempfile() caller.

I think all the callers of these public entry points use them to
open a lockfile for its own use, and never delegate the writing to
it to their children, so this change is safe right now, and I do not
think it is too bad that a new caller that wants to do that have to
explicitly drop O_CLOEXEC (perhaps by dup(2)ing).

But it deserves mention in the lockfile and the tempfile API docs in
<lockfile.h> and <tempfile.h> that the file descriptor returned from
these public entry points does not survive across fork(2).

Something along the line shown by the attached patch, perhaps.

Other than that, this is very nicely analyzed and discusses possible
alternative approaches sufficiently to easily convince readers that
this is the best solution.

Very nicely done.  Thanks.

 lockfile.h | 4 ++++
 tempfile.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lockfile.h b/lockfile.h
index 3d30193..e976c7a 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -55,6 +55,10 @@
  *   * calling `fdopen_lock_file()` to get a `FILE` pointer for the
  *     open file and writing to the file using stdio.
  *
+ *   Note that the file descriptor returned by hold_lock_file_for_update()
+ *   is marked O_CLOEXEC, so the new contents must be written by
+ *   you, and not by your subprocess.
+ *
  * When finished writing, the caller can:
  *
  * * Close the file descriptor and rename the lockfile to its final
diff --git a/tempfile.h b/tempfile.h
index 4219fe4..d357177 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -33,6 +33,10 @@
  *   * calling `fdopen_tempfile()` to get a `FILE` pointer for the
  *     open file and writing to the file using stdio.
  *
+ *   Note that the file descriptor returned by create_tempfile()
+ *   is marked O_CLOEXEC, so the new contents must be written by
+ *   you, and not by your subprocess.
+ *
  * When finished writing, the caller can:
  *
  * * Close the file descriptor and remove the temporary file by
