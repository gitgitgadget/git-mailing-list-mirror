From: Daniel J Clark UNMONITORED EMAIL ADDRESS <noreply@danjcla.com>
Subject: Bulk dump of git metadata / getting git metadata into a database
Date: Wed, 14 Jan 2015 21:08:18 -0500
Message-ID: <CAJJ6HBC+VWL+DN5P2zMtd6v_+pO8q9DZRfj3AbwdQBk_=fFYGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 03:08:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBZrF-0003fo-6H
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 03:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbbAOCIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 21:08:21 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52873 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbAOCIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 21:08:19 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so11332780obc.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=danjcla.com; s=google4danjcla;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xbX7jX5DbP643hrA2bOYbPPzlEFIHcg9bYN4k658mdc=;
        b=DZllZo3x6dDI1Yu1aFv7C0bM8sCfqsuh4D3T/MlBwZhhOzkpTGLsRy7JzReXeVZIb7
         PlcJi/iMWZrYTRXHayV+25M6/Vdi3ZJbzp44ZQAQboeoTadUhDC/ygDx+e309zJxnjwM
         6CLC6DW1VhYCLGowkAmcpcfeYDfy+GWiSjz74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=xbX7jX5DbP643hrA2bOYbPPzlEFIHcg9bYN4k658mdc=;
        b=mMy0VqqPMv997X7Tl1+dZ1tRQ1+fZ/BWJN9IQ2K5Z5wUYY5dWegKMWyvebCd14/Ew2
         IkyWehFBSJBKAqDlHFBCQddA7GFZxnabQOjeLSffAJjC+MPIgzZ0BqMSnEh6lgu68xWB
         xwDbjRbU8X0neWany4YxqDIckshK7AaXxB0mHzqwdbGN8r/JaGOImy2yOaFj2Z8HjlwP
         FzULYpb9Z+E29ndZ38OLtLPcvxATapHYq3zLt9NC+P0uuKQJRHtRSQViduCGzXHezje7
         +F/Wuw512kpf2XJqm18IAIW9kZGaoTq0ov/7yrUpH/4rbnsNrq6BEVFLxZWIie9cW9O4
         qJ6w==
X-Gm-Message-State: ALoCoQmlvapgkLcmbZZQuGnskEmujGyHn13f6KJwfBEkvKvhwpZ4j0jrtyphK67kSS4ieo/Y8Njq
X-Received: by 10.202.194.212 with SMTP id s203mr4147799oif.115.1421287698311;
 Wed, 14 Jan 2015 18:08:18 -0800 (PST)
Received: by 10.182.131.5 with HTTP; Wed, 14 Jan 2015 18:08:18 -0800 (PST)
X-Originating-IP: [37.58.52.30]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262453>

I'm wondering if anyone happens to know of software to dump all a git
repo's metadata, both stored and derived, to a format - sql, xml, csv,
whatever - that is easily importable into a database / manipulated
programmatically.



Background, for the interested:

There is git repo HAPPY and and a separate git repo with branch SAD.

Repo HAPPY is canonical; branch SAD is in a separate fork repo. Files
from HAPPY have been copied over on an irregular basis to SAD. So SAD
has a mixture of files that are exactly the same as (the one in some
commit to) HAPPY, and files that have diverged since the initial copy
over from HAPPY as per the needs of the SAD fork.

The end goal is to get a diff that shows only fork-specific changes.
Identify the common file ancestor, and then diff the most recent
fork'ed file against that. Or put another way:

(a) Remove any files from SAD's most recent commit that are exactly
the same as any commit to HAPPY.

(b) For each file still in SAD's most recent commit, walk backwards in
SAD until a version is found that exists in HAPPY.

For (a) the below two git commands plus a little scripting look like enough:

# HAPPY: Get all file hases for a repo
git verify-pack -v .git/objects/pack/*.idx > HAPPY.hashes
grep ' blob   ' git.hashes | awk '{print $1}' > HAPPY.blobs

# SAD: Get hases and paths from current checkout
git ls-files --full-name -s | awk '{print $2" "$4}' > SAD.blobs

I haven't looked into (b) as much yet, but at the moment I'm thinking
of using git log to get a chronological list of commit hashes, then
walk backwards, at each checkout using git ls-files to dump the tree's
hashes to a separate file.

-- 
Daniel J Clark - off-list: djc @ first initial last name . us
