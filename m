Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8618637
	for <git@vger.kernel.org>; Wed,  1 May 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584195; cv=none; b=XoQD8KrWR4Y6C2Ob1fKhQ0636c5+0XHmbJdvS5GVuhnW2nxlxwgcJZ0pTy5ZLaAnQCHdDheuaBWiyhUooAwIeTGDYxggknZ3gkGWcDhdtg+OHrYwYUdTfzyQmCuLdT57woZQOv5NVb0FtzSci8Uwl2qIyJ5j8d9gWWm2+Smu0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584195; c=relaxed/simple;
	bh=teY5Z4CyiKQMCSBLuzJnNZ1xloETinmqp1QnRxRVPPY=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=tbbAIjttZssmZ69kLbhOVekKqt2KfmyXhG0lGIV7tE/yvDwTzwhgoTZRSeU3A307+44c2aCDuyMZJCfAsxP+jGUTI6xxio9yGmtLsHyxAsV9HqrgkrY2HMzUyn8BD3f+85lgr7K8VoXWWlLZs19szTyNYNIAUk9p2930NeZYP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uPzqmGdC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uPzqmGdC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1651029860;
	Wed,  1 May 2024 13:23:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=teY5Z4CyiKQMCSBLuzJnNZ1xloETinmqp1QnRxRVPPY=; b=uPzqmGdC1Ql1
	RR4yCxWTQl8nUs0q2exVR5vof2da3EeWAHrSa1wv97tXRlo1zkOgtNPkUSi5CVU4
	xwbqfofpNfJSwrpKti/xEkbeFxIuoTjXkPED7K7Zodq4eVlK22AfgJVfJSOZnfa3
	bViNhKMV6QgkJPYbqOWEt1LytgPh+3g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D6AB2985E;
	Wed,  1 May 2024 13:23:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B5952985B;
	Wed,  1 May 2024 13:23:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] rev-parse: document how --is-* options work outside a
 repository
cc: Eric Sunshine <sunshine@sunshineco.com>,
    Toru Okugawa <castor.4bit@gmail.com>
Date: Wed, 01 May 2024 10:22:59 -0700
Message-ID: <xmqqplu54fbg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 761E60C4-07DF-11EF-B23D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

When "git rev-parse" is run with the "--is-inside-work-tree" option
and friends outside a Git repository, the command exits with a
non-zero status and says "fatal: not a repository".  While it is not
wrong per-se, in the sense that it is useless to learn if we are
inside or outside a working tree in the first place when we are not
even in a repository , it could be argued that they should emit
"false" and exit with status 0, as they cannot possibly be "true".

As the current behaviour has been with us for a decade or more
since it was introduced in Git 1.5.3 timeframe, it is too late to
change it.

And arguably, the current behaviour is easier to use if you want to
distinguish among three states, i.e.,

 (1) the cwd is not controlled by Git at all
 (2) the cwd is inside a working tree
 (3) the cwd is not inside a working tree (e.g., .git/hooks/)

with a single invocation of the command by doing

    if inout=$(git rev-parse --is-inside-work-tree)
    then
        case "$inout" in
        true)   : in a working tree ;;
        false)  : not in a working tree ;;
        esac
    else
        : not in a repository
    fi

So, let's document clearly that the command will die() when run
outside a repository in general, unless in some special cases like
when the command is in the --parseopt mode.

While at it, update the introductory text that makes it sound as if
the primary operating mode is the only operating mode of the
command, which was written long before we added "--parseopt" and
"--sq-quote" modes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 This time with a properly formatted, proposed log message.

 * Doc update.

 Documentation/git-rev-parse.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index f9d5a35fa0..04fe7b941c 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -18,8 +18,15 @@ Many Git porcelainish commands take a mixture of flags
 (i.e. parameters that begin with a dash '-') and parameters
 meant for the underlying 'git rev-list' command they use internally
 and flags and parameters for the other commands they use
-downstream of 'git rev-list'.  This command is used to
-distinguish between them.
+downstream of 'git rev-list'.  The primary purpose of this command
+is to allow calling programs to distinguish between them.  There are
+a few other operation modes that have noting to do with the above
+"help parse command line options".
+
+Unless otherwise specified, most of the options and operation modes
+require you to run this command inside a git repository or a working
+tree that is under control of a git repository, and will give you a
+fatal error otherwise.
 
 
 OPTIONS
@@ -32,11 +39,15 @@ Each of these options must appear first on the command line.
 
 --parseopt::
 	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
+	The command in this mode can be used outside a repository or
+	a working tree controlled by a repository.
 
 --sq-quote::
 	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
 	section below). In contrast to the `--sq` option below, this
 	mode only does quoting. Nothing else is done to command input.
+	The command in this mode can be used outside a repository or
+	a working tree controlled by a repository.
 
 Options for --parseopt
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.45.0-31-gd4cc1ec35f

