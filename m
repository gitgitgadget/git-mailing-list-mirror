Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3A1863E
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743861705; cv=none; b=dgYx0fg6hUdQmfbz+YHcaCeZILZMTQRDMs7gLPHgCsAUUG+Xa836MaUNsQlI4g+uJ4oMiq+8MbMTHGWMMeWJ1WV0RKjdk91DDaQB87ZyRR1Fih+0wMIc74c6ZqBAxg9RIWYotM8DVA6ZopFSESMReLAI/P7z6jom4mEjleg2acU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743861705; c=relaxed/simple;
	bh=knvJ1LL0tj+c+awWH9k7sWqA/2CGkZYcdbVzA1fZcLU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KbmVy/qdBMmgwMVIii67GN4yay6HOXYRCKXzOW48RD8Y0HfXkVyTV4rpsmxrIdtyNPnxEOnyxtRsQIHRFuwySEWXGavphXuP5iBN1y2FWOcHQ1xznenYPNvms/A6acGJCaU0AtM2nTY73TpSzq/9zlYnaLCtiMExgzN3FGBo2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=MleABqgt; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="MleABqgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1743861701; bh=knvJ1LL0tj+c+awWH9k7sWqA/2CGkZYcdbVzA1fZcLU=;
	h=Date:From:To:Subject:From;
	b=MleABqgty8yUyr0u2O3YB3frvBGPB8L4Ff4+O3JtK5Btz19wgf52V9U+AoCMdtkZe
	 o8Wjs0BP2HQl53yXgwx+Kn+ZO72AOsVfMdq2jQL6cxZhNbixtytGdmkSxLelve0h4t
	 +qw9M82k2B/gt09u9oT92G1E2ZoFE0q1iWZU21jAs7tiP1G3AjI0RZgXhA0NvIGv6C
	 cVoaGt/AXNPjbY992ObFeVpl0je0D3GlMYJL5Y6bEm01A1AKNWJ1JEWCbsGA8KV/RT
	 JNBmGXcbYnTSYaX2GCrQdzyXasbek3e+w0Kd4f60hYVTA2WEXPaGaqjRXXjKVeiGoz
	 2O18wdi8/xBoA==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id 7D2101120144; Sat, 05 Apr 2025 16:01:41 +0200 (CEST)
Date: Sat, 5 Apr 2025 14:01:41 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: git@vger.kernel.org
Subject: Way to "impersonate" remote or sync remotes without fetching
 everything?
Message-ID: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
User-Agent: Mozilla Thunderbird
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: de-DE, en-US-large, en-US
Content-Disposition: inline

Hi,

what is the best way to sync multiple remotes with each other without 
having to pull everything into a local checkout first?

Now as many projects have moved off of github onto their own gitlab 
instances it is kinda hard to keep track of all of the contributions as 
you basically have to create a fork on each of these instances to open 
PRs and because I'd like to have my contributions also on my gitlab 
server too I've now the issue of having to keep multiple remote 
repositories in sync. And then sometimes there are additional remotes 
from others that you'd like to interact with as well, so now these need 
to be mirrored as well. Then there is also the issue of archiving, e.g. 
freeing oneself from a dependency getting deleted upstream that I see at 
more and more companies I work with. They want to have an internal fork 
of everything (someties also wanting to review all of the commits before 
pulling them into their internal git server; but for most it was enough 
to just fail on rewritten/force-pushed history so far). And just for my 
personal projects I'd like to be able to have them on github, gitlab, 
and my own gitlab server, while being able to make edits (and accept 
PRs) at any of these and keep the repos in sync (or at least 
automatically sync them as long as nothing conflicts).

Is there a way to use some of the more advanced features of git to 
accomplis this? Like e.g. the alternative object database mechanism in a 
local temp project and pushing to the other remotes or something?

If any of you ran into similar issues in the past, how did you solve them?


What I tried so far in order:

My initial thought was to look for a way to do:

1. "impersonate" a remote (something like "git clone --bare" but
    without actually cloning any of the objects and querying the remote
    when needed)
2. Any git command within that repo will now be treated as if it was
    ran within/by the impersonated remote. E.g. It'll consider all of
    the objects the remote has as its own.
3. Add all of the other remotes as usual (the impersonated one wouldn't
    be reported as remote but as the local one the others were added to)
4. Doing a "git push --all" to any of these remotes will cause git to
    download thouse objects from the impersonated one that it needs to
    push towards that remote (and hasn't cached locally already).

As I wasn't able to find such a feature I tried to workaround this. At 
first I tried to use a shallow clone but that didn't really work as I 
didn't know where I'd have to start in order to be able to give all of 
the remotes a common commit to be detected as belonging together (esp. 
if one of the remotes didn't exist and had to be created by pushing to 
it...).

Then I managed to find these two suboptimal ones so far:

1. pull-push-style:
     1. "Pull --mirror --bare" the first one
     2. "Push --all" to all of the other(s)
2. Without always pulling the same server for the entire repo,
    regardless of it having changes or not:
     1. Create new and empty repo locally
     2. Add all of the remotes
     3. Fetch from the nearest server,
     4. "lfs fetch --all" from the nearest server
     5. fetch from all others
     6. "lfs fetch --all" from all others
     7. Hackishly update all of the local refs to basically be the ones
        of the remote that should be used as source (aka "rm -rf
        .git/refs/heads/*; cp -r .git/refs/remotes/origin/*
        .git/refs/heads/")
     8. "Push --all" to all of the remotes

The 1st one is the most simple, it almost always works (only fails in 
some very rare cases, like when the remote contains "zero-padded file 
modes" and such) but it'll cause unecessary load on the origin server as 
it has to always first make an entire clone of the repo. Even if the 
remotes are already in sync. Having local state would partially would 
solve that but then I'd need a lot of disk space and I wouldn't be able 
to just run this within a CI job. => Therefore undesirable.

The 2nd one is more sophisticated, it may look kinda righit at first, 
but it keeps breaking all the time for countless different reasons. Even 
though it allows to only pull new/changed commits from the origin server 
(aka it doesn't overload a single server unecessarily), it'll still 
clone all of the repos from the local git server onto the CI worker, 
esp. considering larger repos using git-lfs (or trying to do it in 
parallel with multiple/all of my repos) it causes the CI worker to run 
out of disk space as well as a lot of unecessary network and disk IO => 
Therefore also undesirable.

Also not to mention that none of my current approaches can do a real 
sync, they are all relying upon having one of the remotes designated as 
the authoritative source and if any of the others changed instead it'll 
just fail.

Sincerely,
Klaus Frank

