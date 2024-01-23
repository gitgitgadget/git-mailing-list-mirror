Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996E823A6
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035755; cv=none; b=FtbfUB+/Fv98RfggU3jhFpGMiSkE2ZtT2yT6qEb7/xbGcWqzVuO+mKBnV55sinqGngy6w7uTgn36vjVsybc2ltx9S9TnixoACAjOWK4bj+FiAINrmTIKKB98YZ2l+KOwPtLspMqm3IVahpnkgXBTMFLP6BuzMU6jkJLDihk5v3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035755; c=relaxed/simple;
	bh=YD2daYin3CqlCkNmd4OQJPOstsIrKJcZQVloPfYnVWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGCZ22pBNScfP40q8GaY6Ium1KjshXvKfc3G3+JWDfLH0SJ6G+h24UicqvckdLBMiewLZM+sdyHARwQVBwMY0nPSAv1SzrkokSFPd60jGGhZAXmZpYAo5ooTGB/saMwOUMQQdB7G5Sp4BtPNLWHc4OmgnapMYtqaW/AEwMjFSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HRa3zo8B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HRa3zo8B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0299B1DBE38;
	Tue, 23 Jan 2024 13:49:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YD2daYin3CqlCkNmd4OQJPOstsIrKJcZQVloPf
	YnVWE=; b=HRa3zo8B2CC7URWKmSqaz3wDc+LEiJb0aP/PPQGHU2+SIIpa4EuIWK
	3+W+zUznEyYmW0BJIXxB6lP9aitlb8+qrpNo43L4EK/o6gMXYQ8OzL6lZhPDPzPN
	gAaq90ZkfGsz8YhnEoBMvXBFNMZzrlbkZJ+XrksQujFb7GCqU26vY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E83831DBE37;
	Tue, 23 Jan 2024 13:49:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 568201DBE36;
	Tue, 23 Jan 2024 13:49:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,  Brian Lyles
 <brianmlyles@gmail.com>
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust
 redundant commit handling
In-Reply-To: <xmqqa5owot07.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	23 Jan 2024 09:32:24 -0800")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240119060721.3734775-5-brianmlyles@gmail.com>
	<06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
	<CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
	<10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
	<CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
	<xmqqa5owot07.fsf@gitster.g>
Date: Tue, 23 Jan 2024 10:49:10 -0800
Message-ID: <xmqqede7navt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 18D9E8C8-BA20-11EE-9C5D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I got curious and took a look at files that has hits with "lines
> that end with SP or HT":
>
>     $ git grep -l -e '[  ]$'

Another more interest way to check is to do this:

    $ git diff --check $(git hash-object --stdin -t tree </dev/null)

which will not just catch trailing whitespaces but other whitespace
errors.  Good thing is that the projects can even customize the rules
used for various paths using the attributes mechanism.

Here is a sample patch based on what the above command line found.

------ >8 ----------- >8 ----------- >8 ----------- >8 ------
Subject: [PATCH] docs: a few whitespace fixes

Some documentation files have 8-space indented lines where other
indented lines in the same list use a single HT to indent.  As
Documentation/.gitattributes says *.txt files use the default
whitespace rules, let's fix some of them as a practice.

Note that git-add documentation has other instances of space
indented lines, but they are samples of manually aligned output
of the "git add -i" command and it would be better to keep them
as-is.  Which in turn may mean we may want to loosen the whitespace
rules for some parts of the documentation files, but we currently do
not have such a feature.  The attribute based whitespace rules apply
to the whole file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-format.txt | 8 ++++----
 Documentation/git-add.txt     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git c/Documentation/diff-format.txt w/Documentation/diff-format.txt
index a3ae8747a2..bcaf9ca608 100644
--- c/Documentation/diff-format.txt
+++ w/Documentation/diff-format.txt
@@ -8,16 +8,16 @@ These commands all compare two sets of things; what is
 compared differs:
 
 git-diff-index <tree-ish>::
-        compares the <tree-ish> and the files on the filesystem.
+	compares the <tree-ish> and the files on the filesystem.
 
 git-diff-index --cached <tree-ish>::
-        compares the <tree-ish> and the index.
+	compares the <tree-ish> and the index.
 
 git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
-        compares the trees named by the two arguments.
+	compares the trees named by the two arguments.
 
 git-diff-files [<pattern>...]::
-        compares the index and the files on the filesystem.
+	compares the index and the files on the filesystem.
 
 The "git-diff-tree" command begins its output by printing the hash of
 what is being compared. After that, all the commands print one output
diff --git c/Documentation/git-add.txt w/Documentation/git-add.txt
index ed44c1cb31..e1a5c27acd 100644
--- c/Documentation/git-add.txt
+++ w/Documentation/git-add.txt
@@ -73,7 +73,7 @@ in linkgit:gitglossary[7].
 
 -v::
 --verbose::
-        Be verbose.
+	Be verbose.
 
 -f::
 --force::

