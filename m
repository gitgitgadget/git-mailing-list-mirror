Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99B2248B4
	for <git@vger.kernel.org>; Fri,  1 May 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641249; cv=none; b=C2JPqwq6wgGz/9OPzZqaAes9TAbLzM1ZLu9VdAhTo3BJFqKaPFR7QqusyBwhv2qH/dXrvpvjTwYyfSm8IPsY1zTC9YGxH2XF5tBv7HUO4SV6RoBeLQjCdWpPEHdSHmnjuH1Lg7AT3uTFpq2xxzcQz/Pf6XW5r9VS0e4DdOD8FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641249; c=relaxed/simple;
	bh=lGl2U5amqAEyUNoCttRh+Hw9eOvyD0DhmlXWhI7NwwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=OBzRCmtwUK7Ham3Z68Y6w4lzLpPPsQRqCtKgvocOsBvIXX78sDtRYwndBSmWaFeTtrnDUfG6/oP5JWT7EWNLRzz31SeSMc0z1DUOYZ6L39Hi4Xec9yqyekumETTesqp4cT8/VTz+CIZibPenHFYQAftGdNtXZrZ3kQIzSRN57mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4g6WhS1cF2z7RcQD
	for <git@vger.kernel.org>; Fri,  1 May 2026 15:14:00 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4g6WhF1rXhzRnPp;
	Fri,  1 May 2026 15:13:49 +0200 (CEST)
Message-ID: <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
Date: Fri, 1 May 2026 15:13:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>,
 Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 30.04.26 um 18:18 schrieb Mark Levedahl:
> 
> 
> On 4/30/26 6:02 AM, Shroom Moo wrote:
>> When git-gui is started from a directory that Git recognizes as a
>> valid repository but the working tree is not accessible (e.g., a
>> separated gitdir created by `git clone --separate-git-dir`, a bare
>> repository, or a case where the worktree directory was removed),
>> it previously called `rev-parse --show-toplevel` without error
>> handling, causing a fatal Tcl error ("this operation must be run
>> in a work tree").
>>
>> Wrap the call in a `catch` and handle the failure as follows:
>>
>> - For bare repositories, keep `_gitworktree` empty so that the
>>   existing `is_bare` check shows "Cannot use bare repository" and
>>   exits.  No behavioral change.
>>
>> - For non‑bare repositories, try to locate the worktree from the
>>   parent directory using `git -C $parent rev-parse --show-toplevel`.
>>   If the parent is a valid worktree, change to it; this covers the
>>   legitimate case of starting git-gui from within the .git
>>   subdirectory of a normal working tree.
>>
>> - If the parent directory is not a worktree, refuse to start with
>>   a clear error message.  This prevents dangerous operations in a
>>   separated gitdir, where ordinary Git commands like `git status`
>>   would themselves refuse to run.
>>
>> The approach intentionally avoids two pitfalls:
>>
>>   - Testing `--is-inside-git-dir` before calling `--show-toplevel`
>>     would break the normal use case of starting git-gui from within
>>     a .git subdirectory (where --show-toplevel would succeed).
>>
>>   - A simple “non‑bare” check after a failed --show-toplevel would
>>     reject a normal repository whose worktree was only temporarily
>>     removed.
>>
>> The chosen method keeps the original behavior for bare repositories
>> and for regular working trees, fixes the crash, and properly blocks
>> separated gitdirs without a reachable worktree.
>>
>> Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
>> ---
>>  git-gui/git-gui.sh | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 23fe76e498..2392282df3 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -1169,7 +1169,28 @@ if {![file isdirectory $_gitdir]} {
>>  load_config 0
>>  apply_config
>>  
>> -set _gitworktree [git rev-parse --show-toplevel]
>> +if {[catch {set _gitworktree [git rev-parse --show-toplevel]}]} {
>> +	# For bare repositories, use the existing error handling
>> +	if {![catch {set bare [git rev-parse --is-bare-repository]}] && $bare eq {true}} {
>> +		set _gitworktree {}
>> +	} else {
>> +		# Non-bare: try to find the worktree from the parent directory
>> +		set parent [file dirname [pwd]]
>> +		# Cannot go higher than the root directory; leave _gitworktree empty
>> +		if {[file normalize $parent] eq [file normalize [pwd]]} {
>> +			# Already at the filesystem root; let existing paths cope
>> +			set _gitworktree {}
>> +		} elseif {![catch {
>> +			set _gitworktree [git -C $parent rev-parse --show-toplevel]
>> +		}]} {
>> +			cd $parent
>> +		} else {
>> +			catch {wm withdraw .}
>> +			error_popup [mc "Cannot start git-gui from inside the Git directory."]
>> +			exit 1
>> +		}
>> +	}
>> +}
>>  
>>  if {$_prefix ne {}} {
>>  	if {$_gitworktree eq {}} {
> 
> A bare repository can be contained in a workdir / worktree pointing at a different gitdir:
> the logic above can thus a workdir that doesn't use the gitdir where git-gui was started.
> The bigger issue is that a gitdir can support multiple checked-out directories with no
> one-to-one mapping and no clear idea of which of those a user may have intended.
> 
> So, I believe the correct fix is to test "rev-parse --is-inside-git-dir, and if so throw a
> clear error message and exit. This will give the user something to start with to solve the
> problem of why they started git-gui in a gitdir, and not in a worktree.
We have quite a bit of code that attempts to make Git GUI work from the
.git directory and also in bare repositories.

87cd09f43e56 ("git-gui: work from the .git dir", 2010-01-23) made the
first step. The original code just used the $_gitdir as the working
directory. However, at that time we did not have alternate worktrees,
and the old code, when used today, does not work in a `git
worktree`-created worktree. Later, the `git rev-parse --show-toplevel`
call came with 38ec8d3e2652 ("git-gui: correct assignment of work-tree",
2010-10-20). However, it also changes the fall-back code slightly, so
that running Git GUI from the .git directory would not work the same way
as before and takes the .git directory as the work tree (because in the
.git directory --show-cdup is not "..", but empty).

I think we need to restructure the existing flow a bit and not just fix
a single spot in the code. I suggest this order of operation:

1. Handle the bare repository case. If not enabled, fail. Otherwise, we
can work with an empty $_gitworktree.

2. Collect --show-toplevel into $_gitworktree.

2a. If this failed: If --is-inside-git-dir is true, and the last
$_gitdir directory component is exactly ".git", take the parent
repository as $_gitworktree. Otherwise, fail.

3. Handle all the other edge cases, if any, with the so determined
$_gitworktree. (I didn't think through, yet, what needs to be done.)

-- Hannes

