Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95818DF61
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369744; cv=none; b=t1ylGSEGuBXpScYJ6ilgfq3bMBa5PMds5RBbH5kVpXSwmUamTnyGO9ypXLMsfLME5jtJ9ch2dwu8DZs5Ymg8lQ0vfhulrbKd46G9GGpTllIhdaVmutvuj+noon5+txLQ01ebhoyFDNSo7gCoi8YXpULF2Cvdsn9pPwlvLBAgjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369744; c=relaxed/simple;
	bh=SY86AXtK5iyciUlH+8ZyiBpGk2+tEGuCQ3ZrlgGuUkc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KAAHT39MrxfAvqvonZt3Wf/MYXUDr+wnMPQzcqouG3zLk8W5P5M6tNiLqHL7Xmrwz5Ocp2+bKNobQrAZycAu+2eW3nLX39yXmgvjEZasp+tQ4imV+HKBxWSAW4rU7q4EGFUvp+whTDeCX9scfcM0cCNV5GI0dtiAZKGcTMcl3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WYQHH2Sq9z5vRs
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 21:27:55 +0200 (CEST)
Received: from [192.168.1.102] (213-147-165-170.nat.highway.webapn.at [213.147.165.170])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4WYQH66XKbzRnmG;
	Tue, 30 Jul 2024 21:27:46 +0200 (CEST)
Message-ID: <2d7d6b38-b3f1-45f5-a6f0-54bd8a0d64d0@kdbg.org>
Date: Tue, 30 Jul 2024 21:27:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bug: Git GUI "No differences detected"
To: Steve <steves.sk@gmail.com>
Cc: git@vger.kernel.org
References: <CAAQS9UL14d_LxTKFMghGvQQWS6dfj1RhTJYyKsz0PKoFot8v5w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAQS9UL14d_LxTKFMghGvQQWS6dfj1RhTJYyKsz0PKoFot8v5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 25.07.24 um 12:37 schrieb Steve:
> Problem:
> Git GUI shows a "No differences detected" popup when clicking on a
> file, and it returns back to the same state after closing the popup.
> When I do `git status`, the file is listed there, but `git diff` (with
> any line-ending-related switches inspired by stackoverflow) doesn't
> show anything for the file.
> 
> Cause:
> I assume it's typically due to LF/CRLF changes.
> 
> Workaround:
> Manually add the file, which makes the diff disappear.

Back in 2006, the only case where a file could be listed as modified,
but then not have any changes was when the timestamp (and perhaps other
stat information) was modified, but not the content. Such false
positives can be rectified by running git update-index --refresh,
therefore, Git GUI does so by default. For this reason, users generally
do not see false positives in the unstaged files list.

However, in large repositories git update-index --refresh can be so
expensive that it becomes annoying. For this reason, the option "trust
file modification times" was invented that, when enabled, skips this
expensive step. On the flip side, there can now be files listed as
modified that are actually not. As a work-around, the popup message was
invented to notify the user that a --refresh step is performed to remove
all false positives.

This worked sufficiently well. Until core.autocrlf was invented in 2007.

Enabling this option introduced a new case that can trigger false
positives. But this time, git update-index --refresh does *not* clear
the files that are falsly marked as modified. And we end up in the loop
that you described and that requires the file to be staged (git add) to
be recognized as unmodified.

I suggest the following changes to Git GUI:

1. Remove the popup.

2. Write a message in the diff pane when the diff is empty saying that
no differences where found and that the file should be staged to remove
it from the unstaged file list.

3. If the option "trust file modification times" is set, extend the
message with an hyperlink that, when clicked, runs the --refresh stage,
i.e., the action that currently happens when the popup is dismissed.

Step 2 effectively makes the workaround the official solution. Would
that work for you?

-- Hannes
