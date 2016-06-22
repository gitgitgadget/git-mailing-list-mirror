Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C380820189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcFVUMg (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:12:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbcFVUMg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:12:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40926263A8;
	Wed, 22 Jun 2016 16:12:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t9zD61xullDUREw39ZTX4T+2ztg=; b=cs75nq
	8fQXofpiDvUfAv+77GkqxZ8xPKLbCpJYzUY/WoIPUHVbXNemWKOmMujBayWbssY/
	LydloELOU7f6NioXMHzTFCiarXQG4pA2jTiw3y855NOkRswTJ9m9bhUKCNe1c1rg
	SvPWWj7xYzauO0qOMOwhnzdJMwQkXJ6rTXBq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWOzzxP4/NwSX7hw2n8zBilnLR18hpSe
	++2m1e/o8kzoO67dei7CANW6tHGXUvqqclunbQ7x3sgYP75/M+X/YOFhrWFvZERt
	INR2jcouuSlooeKnNagvqo8T2ofKhyrXbVTk1Eaeg9vFXMqac9a/NBPVBN2AG2bn
	CzTmBFpicEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38EBE263A7;
	Wed, 22 Jun 2016 16:12:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2049263A6;
	Wed, 22 Jun 2016 16:12:33 -0400 (EDT)
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
	<xmqqa8idnpj9.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 22 Jun 2016 13:12:31 -0700
In-Reply-To: <xmqqa8idnpj9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 22 Jun 2016 09:42:34 -0700")
Message-ID: <xmqqvb11kmog.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7D5451C-38B5-11E6-9257-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think I know that well enough; please sanity check.  My
> understanding is:
> ...
> The patch under discussion is the only door left for that test, and
> a similar trickery is needed for any end-user scripts used for hooks
> and aliases that use 'git --exec-path', if they ever want to be
> cross-platform.
>
> So let's take that "if Windows do this" change to t2300 as-is.

Assuming that the sanity check passes, here is a suggested rewrite
to explain the real problem better.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 18 Jun 2016 12:49:11 +0200
Subject: [PATCH] t2300: "git --exec-path" is not usable in $PATH on Windows as-is

The "git" command itself has an internal logic to prepend the
exec-path to the PATH environment variable for processes it spawns.
That is how ". git-sh-setup" in our scripted Porcelains can find the
dot-sourced file in $GIT_EXEC_PATH that is not usually on user's
PATH.

When t2300 runs, because it is not spawned by the "git" command, the
scriptlet being tested did not run with a realistic setting of PATH
environment.  It lacked the exec-path on the PATH, and failed to
find the dot-sourced file.  A recent update to t2300 attempted to do
so, with "PATH=$(git --exec-path):$PATH", which was the recommended
way around v1.6.0 days (a script whose original was written before
that release that survives to this day is likely to have such a line).

However, the "git --exec-path" command outputs C:\path\to\exec\dir
(not /c/path/to/exec/dir) on Windows; the recent update failed to
consider the problem that comes from it.

Even though Git itself, when doing the equivalent internally, does
so in a platform native way (i.e. on Windows, C:\path\to\exec\dir is
prepended to the existing value of %PATH% using ';' as a component
separator), the result is further massaged by bash and gets turned
into $PATH that uses /c/path/to/exec/dir with ':' separating the
components, which is the form understood by bash, so scripted
Porcelains finds commands from PATH correctly even on Windows.

An end user script written in shell, however, cannot prepend
"C:\path\to\exec\dir:" to the existing value of $PATH and expect
bash to magically turn it into the form it understands.  In other
words, "PATH=$(git --exec-path):$PATH" does not work as an emulation
of what "Git" internally does to the PATH on Windows.

To correctly emulate how exec-path is prepended to the PATH
environment internally on Windows, we'd need to convert
C:\git-sdk-64\usr\src\git to at least /c\git-sdk-64\usr\src\git
ourselves before prepending it to PATH.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2300-cd-to-toplevel.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index cccd7d9..c8de6d8 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -4,11 +4,19 @@ test_description='cd_to_toplevel'
 
 . ./test-lib.sh
 
+EXEC_PATH="$(git --exec-path)"
+test_have_prereq !MINGW ||
+case "$EXEC_PATH" in
+[A-Za-z]:/*)
+	EXEC_PATH="/${EXEC_PATH%%:*}${EXEC_PATH#?:}"
+	;;
+esac
+
 test_cd_to_toplevel () {
 	test_expect_success $3 "$2" '
 		(
 			cd '"'$1'"' &&
-			PATH="$(git --exec-path):$PATH" &&
+			PATH="$EXEC_PATH:$PATH" &&
 			. git-sh-setup &&
 			cd_to_toplevel &&
 			[ "$(pwd -P)" = "$TOPLEVEL" ]
-- 
2.9.0-346-g30ec1fd

