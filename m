Received: from lb2.peda.net (lb2.peda.net [130.234.6.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5794052C7
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.234.6.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635426; cv=none; b=G5FgHmnUcEJrwqCWPC9VaIZhwwJJ3sCYL8lJtpBVNwSh3NogGViDMAmPDzgc6pM5C/x2m/puyabrizzwn+YtSUiKfXwgHedeWWAcO4qiIQ/jXD3PhFRt0VScpCS/eA1E606JYLwKjoIqeOgIJ4oARBHUduDy8qa8tLpVo1sdb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635426; c=relaxed/simple;
	bh=puWhUFyebP571x55NOcTo1aCW1EvLXeyZrgxm4O/bNM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lJJJMx6tK9Pg1dXPJDlzg2G5ZmpY494Y3WKvPFnywwtJyKAROvwfDtB768+Se2BBHcxBnLCCe7A3XVcmAVMfnU03hnUOm3Krg28AvU+tZQBQDIedfuyYZl7ancPjZXOkRM3CJJZJ7W3w6I/SF2XNa7bKNl/vMlMnooFBf0lIQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peda.net; spf=pass smtp.mailfrom=peda.net; dkim=pass (2048-bit key) header.d=peda.net header.i=@peda.net header.b=LATKa6gE; arc=none smtp.client-ip=130.234.6.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peda.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peda.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peda.net header.i=@peda.net header.b="LATKa6gE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=peda.net; s=default;
	t=1789635409; bh=puWhUFyebP571x55NOcTo1aCW1EvLXeyZrgxm4O/bNM=;
	h=Date:To:From:Subject:From;
	b=LATKa6gE5KyJlO9DK8s4EU8ZssMnxO78X8Z34CMy74Du8L5zEBtCNOBJBwOUmfXWf
	 eF82wRvWMNT6d3rXoi/R00d9KT4t1LcOYzjhiHGvXhQfKUzj7J8k5raBIwtD5ywpC/
	 L8tni3XH6QAVKDP2gQJ8lPX485iF1Lnoq+BxP15fHWahWzIVcJgbXVt9Wfe7Rr3OVm
	 xj+x5x3FcXeCWqojbEPpoB/+nZam2Us40bZTfKYiygave9KEGD82x6zOTOdI3w6Xn/
	 94WdJ9+ANK81BdcuSuFae2+YTCZ4pm0KDPTePkUWwXVVjcPXCK9jOkI1Y8GZCEOMuw
	 NtWsqewPqfNyg==
Received: from [130.234.82.94] (semyol-329-b.ktl.jyu.fi [130.234.82.94])
	by lb2.peda.net (lb2.peda.net) with ESMTPSA id AE81DD6014A;
	Thu, 17 Sep 2026 11:56:49 +0300 (EEST)
Message-ID: <32062ff9-6dfc-4452-b8f3-66881c3957cd@peda.net>
Date: Thu, 17 Sep 2026 11:56:49 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: [BUG] `rerere remaining` skips consecutive conflicted paths
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I found what appears to be a bug in `git rerere remaining` which can
also cause `git mergetool` to exit successfully while unresolved
conflicts still remain.

I originally encountered this during a large rebase. Some conflicts were
reported by `git mergetool` like this:

```
Deleted merge conflict for 'some/path':
   {local}: deleted
   {remote}: deleted
Use (m)odified or (d)eleted file, or (a)bort?
```

Choosing `d` resolved that path, but `git mergetool` then exited
successfully even though additional unresolved paths remained. Running
`git mergetool` again presented the next such path.

`git mergetool -- .` processes all of them in one invocation, which
led me to `git rerere remaining`.

It appears that `git rerere remaining` skips consecutive conflicted
paths when each path has only a stage-1 index entry.

For example, if the unmerged index contains:

```
100644 <object> 1	a
100644 <object> 1	b
```

then:

```
git diff --name-only --diff-filter=U
```

reports:

```
a
b
```

but:

```
git rerere remaining
```

reports only:

```
a
```

After resolving `a`, invoking `git rerere remaining` again reports `b`.

I then used ChatGPT Sol High to look for possible causes...

The issue is probably  caused by `check_one_conflict()` in `rerere.c.
There is currently a loop of the form:

```
*type = PUNTED;
while (i < istate->cache_nr && ce_stage(istate->cache[i]) == 1)
         i++;
```

According to ChatGPT, this is probably intended to skip multiple stage-1
entries belonging to the same conflicted pathname, but it also skips a
stage-1 entry belonging to the next pathname.

The loop may need an additional same-path check, maybe
something like:

```
while (i < istate->cache_nr &&
        ce_stage(istate->cache[i]) == 1 &&
        ce_same_name(e, istate->cache[i]))
         i++;
```

I have not checked whether `ce_same_name()` is necessarily the
preferred helper here, so this is only a possible fix rather than
a proposed patch.

The effect becomes visible through `git mergetool` because, when rerere
state exists and no explicit pathspec is supplied, `git mergetool`
obtains the paths to process from:

```
git rerere remaining
```

Thus only the first of a sequence of these conflicts is given to the
mergetool. It resolves that path and exits with status 0, although
other unmerged index entries still exist.

Giving an explicit pathspec avoids that path-selection logic:

```
git mergetool -- .
```

This was an effective workaround for the actual rebase I had to do.


Here is a minimized reproducer. It uses a rebase with two files
renamed to different destinations on the two histories. After resolving
the destination-side conflicts, the two original source paths are left
as consecutive stage-1-only conflicts.

It reproduces the problem on Ubuntu 24.04 LTS using git version 2.43.0.

Run this in an empty directory with bash:


```
#!/bin/bash
set -eu

test ! -e .git || {
     echo "ERROR: .git already exists" >&2
     exit 1
}

git init -q -b main

git config user.name "Bug Reproducer"
git config user.email "reproducer@example.invalid"

git config rerere.enabled true

# Avoid trying to start a graphical merge tool. This command should not
# actually be invoked for the delete/delete conflicts below.
git config merge.tool dummy
git config mergetool.dummy.cmd true
git config mergetool.dummy.trustExitCode true

printf 'file a\n' > a
printf 'file b\n' > b
git add a b
git commit -qm 'base'

git branch topic

mkdir z-main
git mv a z-main/a
git mv b z-main/b
git commit -qm 'main: move files'

git switch -q topic

mkdir z-topic
git mv a z-topic/a
git mv b z-topic/b
git commit -qm 'topic: move files differently'

set +e
git rebase main >/dev/null 2>&1
rebase_rc=$?
set -e

if test "$rebase_rc" -eq 0; then
     echo "ERROR: rebase unexpectedly succeeded" >&2
     exit 1
fi

# Resolve the destination paths while leaving the original source paths
# unresolved.
git add z-main/a z-main/b z-topic/a z-topic/b

echo
echo "=== Unmerged index entries ==="
git ls-files -u

echo
echo "Expected: two stage-1-only entries:"
echo "  ... 1 a"
echo "  ... 1 b"

echo
echo "=== All unresolved paths according to git diff ==="
git diff --name-only --diff-filter=U

echo
echo "Expected:"
echo "  a"
echo "  b"

echo
echo "=== Paths according to 'git rerere remaining' ==="
git rerere remaining

echo
echo "BUG: on affected versions this incorrectly prints only:"
echo "  a"

echo
echo "=== Running plain 'git mergetool' and answering d twice ==="

set +e
printf 'd\nd\n' | git mergetool
mergetool_rc=$?
set -e

echo
echo "git mergetool exit status: $mergetool_rc"

echo
echo "=== Unresolved paths after git mergetool ==="
remaining="$(git diff --name-only --diff-filter=U)"
printf '%s\n' "$remaining"

echo
if test "$mergetool_rc" -eq 0 && test "$remaining" = "b"; then
     echo "BUG REPRODUCED:"
     echo "  git mergetool exited successfully after resolving only 'a',"
     echo "  while unresolved path 'b' remains."
     exit 0
else
     echo "Bug was NOT reproduced in the expected form."
     exit 1
fi
```


On an affected version, the important part of the output is:

```
=== Unmerged index entries ===
100644 <object> 1	a
100644 <object> 1	b

=== All unresolved paths according to git diff ===
a
b

=== Paths according to 'git rerere remaining' ===
a
```

(The 'git rerere remaining' should list both `a` and `b`.)

Plain `git mergetool` then processes only `a`, returns status 0, and
leaves `b` unresolved. If there were multiple files remaining,
running `git mergetool` again would resolve one additional file and
exit with 0 again. I originally had a rebase where I had about 50
files remaining and this was getting tedious fast.

I reproduced the original problem in my real rebase and also
reproduced it independently with the script above using git
version 2.43.0.

I haven't tried compiling the latest Git source to verify the issue
or reproducing script on tip. The checked `git blame` and related
code in git/rerere.c hasn't been changed during the last 8 years
so I would assume the exact same issue would happen in tip
version, too.

My interpretation is that the primary bug is in `rerere remaining`
missing conflicts. The `git mergetool` behavior is then just a
consequence of using the incomplete output of
`git rerere remaining` as its path list.

I don't consider any code in this mail as copyrightable because it
was mostly written by AI after my prompting but here's signed of
line just to be sure in case the code is worth using. Consider
this to cover the whole email too, in case somebody wants to use
any text in this mail for the commit that fixes the issue.

Signed-off-by: Mikko Rantalainen <mikko.rantalainen@peda.net>

-- 
Mikko
