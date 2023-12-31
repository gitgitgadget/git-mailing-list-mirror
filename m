Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419974436
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="n3Fy289H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704029406;
	bh=a5rUC8t7JyJ0VWcoe5Ge5Gw628j/b/QlbMXj0IzVgPo=;
	h=Date:To:From:Subject:From;
	b=n3Fy289HftMp9GPindKJBCfVpEFknDLkU3o9WaP7OqqrzghW0IezvDV3HQru3c0E2
	 q3BLq97SCVAwdDAn4QoX90gtQ0Tsmt0L7ea6hgNmd/jL7As1B88gthWYmg9v4uV9F9
	 Czia3d7ZPnQiuzWcif7BQTbQnVupJ8ai5yVYYTUnZgU5x3hO1Pesg9oDctdQruN/F3
	 sCswFQkJzVRembfuY/9A0ODyB691vHpEMr21JPf1G2fXPXb7tRuYyP9BgxKesR3Wyu
	 gYeTNDA7zXWiYdL2l5Kh+qwDZmXSEryHBA1pZzx0IPdiPVxGham5AxOztWhj4qcpHH
	 QN2zFeMkUXIrQ==
Received: from [192.168.42.22] (0-48-142-46.pool.kielnet.net [46.142.48.0])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 34E993C064B
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 14:30:06 +0100 (CET)
Message-ID: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
Date: Sun, 31 Dec 2023 14:30:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
Subject: Concurrent fetch commands
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

Currently, git doesn't seem to be very good at handling two concurrent
invocations of git fetch (or git fetch and git pull). This is a problem
because it is common for git clients to run git fetch periodically in
the background. In that case, when you happen to invoke git pull while
such a background fetch is running, an error occurs ("Cannot rebase onto
multiple branches").

I can reliably reproduce this by doing

   $ git fetch&; sleep 0.1; git pull
   [1] 42160
   [1]  + done       git fetch
   fatal: Cannot rebase onto multiple branches.

The reason for this failure seems to be that both the first fetch and
the fetch that runs as part of the pull append their information to
.git/FETCH_HEAD, so that the information for the current branch ends up
twice in the file.

Do you think git fetch should be made more robust against scenarios like
this?


More context: the git client that I'm contributing to (lazygit) used to
guard against this for its own background fetch with a global mutex that
allowed only one single fetch, pull, or push at a time. This solved the
problem nicely for lazygit's own operations (at the expense of some lag,
occasionally); and I'm not aware of any reports about failures because
some other git client's background fetch got in the way, so maybe we
don't have to worry about that too much.

However, we now removed that mutex to allow certain parallel fetch
operations to run at the same time, most notably fetching (and updating)
a branch that is not checked out (by doing "git fetch origin
branch:branch"). It is useful to be able to trigger this for multiple
branches concurrently, and actually this works fine.

But now we have the problem described above, where a pull of the
checked-out branch runs at the same time as a background fetch; this is
not so unlikely, because lazygit triggers the first background fetch at
startup, so invoking the pull command right after starting lazygit is
very likely to fail.

We could re-introduce a mutex and just make it a little less global;
e.g. protect only pull and parameter-less fetch. But fixing it in git
itself seems preferable to me.

Sorry for the wall of text, but I figured giving more context could be
useful.

Thanks,
Stefan
