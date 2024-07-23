Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD87F
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693098; cv=none; b=HsPVDtQO0HHYFoQTcZtUHMrBYZguaL6Ft+wnLDxA0aLqftglqYxzdONjSwJGHZiAFwNmmWhtOrOxBiCvMOg7oB7s9ueeZMr93I0R187+y/lVwCLxUvljaMtA6dbkoUVGUU89c1cMBDhaw4KKXBHUtX2TN55klZAJxlrr5ZVAutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693098; c=relaxed/simple;
	bh=/hLDixh8QUtndYLY+SpILAfLwEFIJJGfKPWRz3e0EEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPEpontz/7KClbr+ZMKJz2SiOiWui+li0WI3sJDZxmsU70xc2hR4xalY7/v4NUGkFhE7oAMi6+sCxidi6sHantjbXKZuuBl3UtvdaiG8982fGOWjPqBtpD7lXNDMNtlvp7/WcOZDAUSqWScORleX1YTaysTfCEIiRQ80wl7KLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vnfc+eL0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vnfc+eL0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53C3624422;
	Mon, 22 Jul 2024 20:04:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/hLDixh8QUtndYLY+SpILAfLwEFIJJGfKPWRz3
	e0EEw=; b=vnfc+eL0XyCnjypjWdTjhQG2peYDzSMVqQzCzci/0oNL2GHgSlq/7i
	s2fbU/VVyrdQ81ExuuxdWeEXyI1ureFovElzDicMffI/NnNlG3sjbQob4izEUu4L
	8kLcJjhmunLOMpbZ2EtoAupGMjbMZ+3Wsi0AHVF7oRYfCQOCiqZFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ADF624421;
	Mon, 22 Jul 2024 20:04:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6DBC24420;
	Mon, 22 Jul 2024 20:04:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
    =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: [PATCH v3] CodingGuidelines: document a shell that "fails" "VAR=VAL
 shell_func"
In-Reply-To: <xmqqjzhd81la.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jul 2024 16:10:41 -0700")
References: <xmqqjzhd81la.fsf@gitster.g>
Date: Mon, 22 Jul 2024 17:04:54 -0700
Message-ID: <xmqqwmld55y1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 315BE8B0-4887-11EF-AEA1-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Over the years, we accumulated the community wisdom to avoid the
common "one-short export" construct for shell functions, but seem to
have lost on which exact platform it is known to fail.  Now during
an investigation on a breakage for a recent topic, we found one
example of failing shell.  Let's document that.

This does *not* mean that we can freely start using the construct
once Ubuntu 20.04 is retired.  But it does mean that we cannot use
the construct until Ubuntu 20.04 is fully retired from the machines
that matter.  Moreover, posix explicitly says that the behaviour for
the construct is unspecified.

Helped-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03..ad71c26152 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -204,6 +204,33 @@ For shell scripts specifically (not exhaustive):
 	local variable="$value"
 	local variable="$(command args)"
 
+ - The common construct
+
+	VAR=VAL command args
+
+   to temporarily set and export environment variable VAR only while
+   "command args" is running is handy, but this triggers an
+   unspecified behaviour accoreding to POSIX when used for a command
+   that is not an external command (like shell functions).  Indeed,
+   some versions of dash (like 0.5.10.2-6 found on Ubuntu 20.04) and
+   AT&T ksh do make a temporary assignment without exporting the
+   variable, in such a case.  Do not use it for shell functions.  A
+   common workaround is to do an explicit export in a subshell, like
+   so:
+
+	(incorrect)
+	VAR=VAL func args
+
+	(correct)
+	(
+		VAR=VAL &&
+		export VAR &&
+		func args
+	)
+
+   but be careful that the effect "func" makes to the variables in the
+   current shell will be lost across the subshell boundary.
+
  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    "\xc2\xa2") in printf format strings, since hexadecimal escape
    sequences are not portable.

Range-diff:
1:  75d07c05c7 ! 1:  8462cbb740 CodingGuidelines: document a shell that "fails" "VAR=VAL shell_func"
    @@ Commit message
         This does *not* mean that we can freely start using the construct
         once Ubuntu 20.04 is retired.  But it does mean that we cannot use
         the construct until Ubuntu 20.04 is fully retired from the machines
    -    that matter.
    +    that matter.  Moreover, posix explicitly says that the behaviour for
    +    the construct is unspecified.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ Documentation/CodingGuidelines: For shell scripts specifically (not exhaustive):
     +	VAR=VAL command args
     +
     +   to temporarily set and export environment variable VAR only while
    -+   "command args" is running is handy, but some versions of dash (like
    -+   0.5.10.2-6 found on Ubuntu 20.04) makes a temporary assignment
    -+   without exporting the variable, when command is *not* an external
    -+   command.  Do not use it for shell functions.  A common workaround
    -+   is to do an explicit export in a subshell, like so:
    ++   "command args" is running is handy, but this triggers an
    ++   unspecified behaviour accoreding to POSIX when used for a command
    ++   that is not an external command (like shell functions).  Indeed,
    ++   some versions of dash (like 0.5.10.2-6 found on Ubuntu 20.04) and
    ++   AT&T ksh do make a temporary assignment without exporting the
    ++   variable, in such a case.  Do not use it for shell functions.  A
    ++   common workaround is to do an explicit export in a subshell, like
    ++   so:
     +
     +	(incorrect)
     +	VAR=VAL func args
-- 
2.46.0-rc1-52-g816ffef0a1

