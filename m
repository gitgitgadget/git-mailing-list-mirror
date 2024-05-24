Received: from ant.isi.edu (ant.isi.edu [128.9.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC516FC3
	for <git@vger.kernel.org>; Fri, 24 May 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.9.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570392; cv=none; b=ThTCLZGuAQpOikLUGdE9wi5wh4ZM0yaHBDvOTWobOTTRwFdEh6Y9nlskJxUaN4+kKklMgPWq+GafrDP8Z6DVORfYPuWtj7D+LjfdU2QB+57S8XCKaqZyYFMh1U0a4yHZPLzP5g9CYnSGeJzSZuvoCzEMXCs4X+dW19/54nOD+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570392; c=relaxed/simple;
	bh=Z4kV43hxGcqYKwDa+WEATtWPJXfEMCJQr35w9ZLHlpk=;
	h=To:Subject:From:MIME-Version:Content-Type:Date:Message-ID; b=Km5fZiqQ/VPo0sqEU9bZpsgq7dg8zr7YcG4l43ZPMZTzDYAXl94BH6WNwhWn8ndaHkzbCLeQLLJdJ8gKyXeiweeGhNlmT4SlJ0cxrtl3AgiFPGZ0qCfMuRRPrJGcRmeNXRUWO/QnC2F2hhgu6bETrVPbJimFzVLKky2+wV3rC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isi.edu; spf=pass smtp.mailfrom=isi.edu; arc=none smtp.client-ip=128.9.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isi.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isi.edu
Received: from dash.ant.isi.edu (localhost [127.0.0.1])
	by ant.isi.edu (Postfix) with ESMTP id A0838200CD
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:00:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 ant.isi.edu A0838200CD
Received: from dash.ant.isi.edu (localhost6.localdomain6 [IPv6:::1])
	by dash.ant.isi.edu (Postfix) with ESMTP id CEA5C36002A
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:00:31 -0700 (PDT)
To: git@vger.kernel.org
Subject: dubious permissions on shared repositorys as of 2.45.1
From: John Heidemann <johnh@isi.edu>
X-url: http://www.isi.edu/~johnh/
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <924425.1716570031.1@dash.ant.isi.edu>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 10:00:31 -0700
Message-ID: <924426.1716570031@dash.ant.isi.edu>

Since upgrading to git-core-2.45.1-1.fc39 (in Fedora 39),
pushing to a remote server (so one is on another computer,
in a copy shecked out with
ssh://server.example.com/home/commonuser/bare_repo.git )
where the repo is shared (core.sharedRepo 1)
and owned by someone else (say, the user is "me", but the directory is
owned by "originalauthor") throws the error:

    fatal: detected dubious ownership in repository at '/home/commonuser/b=
are_repo.git'
    To add an exception for this directory, call:
    =

    	git config --global --add safe.directory /home/commonuser/bare_repo.g=
it
    fatal: Could not read from remote repository.
    =

    Please make sure you have the correct access rights
    and the repository exists.

On one hand, this message is correct:
the directory IS owned by someone else ("originalauthor", not "me").
And the suggested fix works, when it is run on the server.


But this error is new... it didn't happen last week, when the server was
running, I think  git-core-2.44.1-1.fc39.  It definitely didn't happen
with the git that shipped with Fedora 39, which was git-core-2.41.0-2.fc39

And since it's a shared repo (the server side git is config'ed
core.sharedRepo 1), we *intend* to have multiple people writing it,
using unix accounts and groups for access control.

Because multiple people write to it cannot be the case that all users
own the git repo on the server.  That's the intended behavior!

But now, to push to it, each user has to run the safe.directory config
(a new requirement).

To make matters worse, they have to run it on the server (not just
their laptop, since there they are already owner of all the files and
directories).  It's not very obvious where one should run it.  (Most
other server-side messages, such as those from hooks on the server,
have the prefix "remote:"  on the client.)


I suspect this problem occurs for my use case and not for other people
because often git users pushing to a remote repo push to a single user
(say, gitlab or gitea or something) and use ssh to map from the
client-side user to the common user.  In this case, the remote git repo
is owned by one userid, and is probably not marked core.sharedRepo).

I suggest that the check for "does user own the repo directory" be
skipped if the repo is marked core.sharedRepo.

I suggest this is a bug and not just tigher security because (a) this
warning is new.  I think since 2.44.) and (b) how else is a sharedRepo
supposed to work?!?

If you disagree and want to keep the current behavior, it would be great
if the warning message could indicate it needs to run on the remote
side.

(I tried looking at diff from 2.44.1 vs. 2.45.1, and from 2.41.1
vs. 2.45.1.  I found the checks for "dubious ownership", but it was not
obvious what had changed.)

Thanks,
   -John Heidemann



