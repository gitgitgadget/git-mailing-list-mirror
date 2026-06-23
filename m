Received: from deneb.mcrowe.com (deneb.mcrowe.com [88.97.37.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC692236EE
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.37.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227036; cv=none; b=Yxi4yP8XPOLf3gNWmysdcXCQhjUNgmfOmPZO4fXxlYXDjXPuUcV6Giluj7D/tQiNoGRUVQN1qZ66XNculzaqrhndzkR7/GMAlziV7I33r80nydidGt9qnIxDrxF8VkXKvocRM9B6b5QzTF4fCbi5eTDkbGiReMJKGkrps/u3Kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227036; c=relaxed/simple;
	bh=eAnn8qX9UUA1pP5zVHLtbLsozW9mp9QkfR4pqp070DM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eSE/nf+9QJJZxOkj3H/ehjyON+9verHqcnPcon648J5auXPtE0JBvNmL4/ml3X65bTGIc1CbfA/YOy8dIM9forOXXmGysd7/LsPeNlGgRboVRNXAzBP05V2Hl62VT3ewzgxclHdM8zG+aib07tPc8WKQsUdD5wEcSNeyyOgCu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mcrowe.com; spf=pass smtp.mailfrom=mcrowe.com; dkim=pass (2048-bit key) header.d=mcrowe.com header.i=@mcrowe.com header.b=1WawLJ5f; arc=none smtp.client-ip=88.97.37.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mcrowe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcrowe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcrowe.com header.i=@mcrowe.com header.b="1WawLJ5f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20260328; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZVGLR3g9ZgLqw/nCDAZXM7hyQZOKz4ayhsmMRPFQYvw=; b=1WawLJ5fO9xrn3vBZ1eLh2CB9G
	KYJkDPrjtOxrfjma/HO0mA9ceKR5Hw23WRnEMDGdLr2GMh5k5QpM80Wd2bHd7k1SeCqWNgZ39JRJf
	QvTNt4Ljn56QOri1eKke6YLrrACeUrZrF3+8j9LJIxCxXHqFrOPutZPLwGlWKCPlqMVDz6dECX/IC
	9Rd5HuXKKTInpo3fYsLfjYriWpX30H16dgiqo9Joy1rUncm97hewl1UKW/1j5p1v0S690ceOr745W
	YmLbXmm5DikLgXGWbxHcvJ6Q2mH/sdEVZHXrppGsTxnoNbKUFGwxfKv/8IDRf54dFjFXyRn80HDBp
	mjT/GgUQ==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.98.2)
	(envelope-from <mac@mcrowe.com>)
	id 1wc26O-00000005K7q-3BIK
	for git@vger.kernel.org;
	Tue, 23 Jun 2026 15:27:48 +0100
Date: Tue, 23 Jun 2026 15:27:48 +0100
From: Mike Crowe <mac@mcrowe.com>
To: git@vger.kernel.org
Subject: Fetching missing submodule refs unnecessarily fatal
Message-ID: <ajqX5FOz6tsQqvlI@mcrowe.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When Git fetches in a superproject with --recurse-submodules, it appears to
try to fetch the corresponding submodule repository commits for every new
or updated superproject branch. Presumably this is so that everthing is
ready to switch to one of those branches without further fetching.

Developers may create commits that contain submodules that reference
commits in the submodule repository, but those commits may not be pushed to
the submodule's remote repository. When the superproject commits are pushed
to a personal remote branch anyone else's Git fetch cannot find the
corresponding submodule commit and fails. For example:

 $ git fetch
 remote: Enumerating objects: 4, done.
 remote: Counting objects: 100% (4/4), done.
 remote: Compressing objects: 100% (2/2), done.
 remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
 Unpacking objects: 100% (3/3), 355 bytes | 355.00 KiB/s, done.
 From ssh://localhost/home/mac/git/git/repro/repositories/super
  * [new branch]      repro-branch -> origin/repro-branch
 Fetching submodule submodule
 error: Server does not allow request for unadvertised object f6b0ccce6e2085cf03c3fd924730f5c9f91e3db1
 Errors during submodule fetch:
         submodule

(when fetching via ssh)

or:

 fatal: remote error: want c1f59d10bd6f24adbc96fee6a5041e9f3dc94b7c not valid
 fatal: internal server error
 fatal: remote error: want f91af98469911e79c2a27329d8e115dfc59f31c0 not valid
 fatal: internal server error
 Errors during submodule fetch:
 	sources/repo-1
 	sources/repo-2

(when using a JGit server configured to allow any SHA-1 to be fetched.)

These are hard errors that cause Git to exit with a non-zero exit status.
Repeating the operation succeeds because no there is no update to the
remote branch to trigger the submodule fetch again.

I've had a couple of goes at bisecting this but I always end up failing on
unrelated commits due to the master/main default branch change and my
attempts to work around that produce inconsistent results.

I don't believe that developers who have the ability to create personal
branches should be able to force anyone else cloning or fetching from the
repository to suffer such a failure. This is particularly a problem for CI
systems but it confuses users too.

Potential mitigations:

1. Use --no-recurse-submodules. This disables all submodule processing
   though, which is not desirable.

2. Use `git fetch || git fetch` to repeat the fetch if it fails the first
   time. This will work around the problem almost all of the time but is
   racy since there's a small risk that the second fetch will encounter a
   new branch with the same problem.

I've added a script which can be used to reproduce the problem to the end
of this message.

I'm not really sure what a good solution to this is:

1. The recursive fetch could only look for submodule commits to fetch on
   the current tracking branch.

2. Treat any failure to fetch submodules as non-fatal. Hacking
   fetch_submodules() to always return zero does solve this problem but at
   the cost of not failing for more-serious ones! Any attempt to check out
   the unfetchable commit would fail at that point though.

Thanks.

Mike.

--8<--
#!/bin/bash
set -xe
temp=$(pwd)/repro

rm -rf ${temp}
mkdir ${temp}
repositories=${temp}/repositories

# Work around protocol.file.allow = "user" by default in new
# repositories without affecting the user's global Git configuration
# by fetching over ssh from localhost.
remote=ssh://localhost${repositories}

# Create the "remote" repositories
mkdir -p ${repositories}/{super,sub}
git -C ${repositories}/super init --bare
git -C ${repositories}/sub init --bare

# Create original submodule repository contents
mkdir -p ${temp}/sub
pushd ${temp}/sub
git init .
date > submodule-file
git add submodule-file
git commit -m "Initial submodule commit"
git remote add origin ${remote}/sub
git push -u origin
popd
rm -rf ${temp}/sub

# Create original super repository contents
workspace=${temp}/workspace
mkdir -p ${workspace}
pushd ${workspace}
git clone ${remote}/super orig
pushd orig
date > file
git add file
git commit -m "Initial supermodule commit"
git submodule add ${remote}/sub submodule
git commit -m "Add initial submodule"
git push
popd

# Create a new clone of the super and submodules
git clone --recurse-submodules ${remote}/super clone

# Now create a dangling submodule commit in the original supermodule
date >> ${workspace}/orig/submodule/submodule-file
git -C ${workspace}/orig/submodule add submodule-file
git -C ${workspace}/orig/submodule commit -m "Modify submodule"
git -C ${workspace}/orig checkout -b repro-branch
git -C ${workspace}/orig add submodule
git -C ${workspace}/orig commit -m "Bump submodule"
git -C ${workspace}/orig push origin repro-branch

# Now update the second clone to show an error even though the
# missing submodule commit is on a completely different branch.
git -C ${workspace}/clone fetch
