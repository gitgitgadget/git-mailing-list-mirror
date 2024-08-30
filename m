Received: from hu-is-mx-01.gaijin.team (hu-is-mx-01.gaijin.team [213.163.39.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81213136337
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.163.39.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055237; cv=none; b=VqdhIT0cHxbyXCG2tEF4GF+UJ4twG+Mcvs9bVBNwtFL22+ZzmnPFBcuEcSBE1RxVsXx+oGzislNq9SCkP8Sj5M29JEBH2AVqd6cYCBAIhHZZobXXO6GN9WSx9Z+ypZ7oernA0Tk6Ab5mopuMv0dkHgF2bkDJIWH3JAbyZRJ0dvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055237; c=relaxed/simple;
	bh=EXnrbd/pG4z7zO0StaQHgMHrc2V44hoxhBmWGg2Oi8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b1kpifBc5Wf9BSUbFFz2EhiWPxplme40llhjYFrlqL071AvsMoN+c+3XvxXe9V0H8kTer6ik383y+XLCizof5iT52Punvn0GHeA8c6mTrAEhpmCk3cuKmQOQOfnPYFacsQhI8PIdwoutMan1OdocrwLn1aOfjK1Z6vXKMRgDHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team; spf=pass smtp.mailfrom=gaijin.team; dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b=cYw0ygol; arc=none smtp.client-ip=213.163.39.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaijin.team
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b="cYw0ygol"
Message-ID: <b0fc652d-6a60-4ff8-9242-1fdf826d6339@gaijin.team>
DKIM-Filter: OpenDKIM Filter v2.11.0 hu-is-mx-01.gaijin.team D67CD3FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaijin.team; s=mail;
	t=1725055227; bh=I/DVyRi98XH57SHrxU+ihkLK5OhRhJReCAAAmFXj0V8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cYw0ygolpDHxF9v1OpHu44uNHhCTeUhi/RjARJ3gBsfPm4qrDo8WVIRRAiYRuiDhj
	 eyvzNaunppjhH3eVn0ciMyKyVGPia+mjGWXf+x7u4XiYNQh/kmAZfRThF2d382+Q1I
	 CmQgzdRKDhiSOrrOZfQovi2Bbpee4KHHzf6+MTj8=
Date: Sat, 31 Aug 2024 01:00:27 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Committing crimes with NTFS-3G
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
 <3eda2715-3b44-469e-85d5-f25504212928@gaijin.team>
 <ZtHe8Vi9aRmY-UMI@tapette.crustytoothpaste.net>
 <fe9d19fa-661d-4358-aa0a-ea419c419266@gaijin.team>
 <ZtHrV5dOlTpCDV8z@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Roman Sandu <r.sandu@gaijin.team>
In-Reply-To: <ZtHrV5dOlTpCDV8z@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

So I couldn't figure out how to make stat show me exactly the same 
format as the utility you have linked, but everything seems to match up 
(up to nsec c/m time which I could not get from stat).

BUT!
The Windows index is definitely corrupted. The utility crashes on it. 
After modifying the utility to compare `entry->ce_namelen` against 
`strlen(entry->name)`, I found out that they differ for a bunch of 
entries, which at some point causes an unfortunate jump which lands 
outside of the index.

Hence a question: shouldn't git validate this somehow? I get that the 
length of the name is stored separately for speed, but maybe we can have 
a special "validate the index" subcommand?

I have fixed the wrong name lengths via the same utility, hoping that it 
would help. But sadly, it didn't.

Modifying the script further, I made it stat every single cache entry's 
actual file and compare everything. Et voila: mode differs! Git for 
windows apparently defaults everything to 644, while NTFS-3G tries to 
support actual permissions with UserMapping enabled and so some files 
have 664, while others have 777, and more for other files on the drive 
but not in the repo.

But alas, backing up the index and changing the mode field to what stat 
actually reports didn't help either. It still seems to me like git 
should be updating this stuff on it's own if it needs to keep track of 
it, but whatever, the issue seems to lie somewhere else.

All in all, definitely seems like a git bug to me. Especially 
considering the name length corruption. I guess I'll try to check out 
the git sources sometime in the future and play around with them, maybe 
I'll find something then. For now, I will use the Linux-native checkout 
of my repo and be careful to synchronize the two checkouts via remote 
and not forget any unpushed commits. The crime was not perfect after all =(

On 8/30/24 18:55, brian m. carlson wrote:
> On 2024-08-30 at 19:25:56, Roman Sandu wrote:
>> The stat output for a random file in the root of the repository is as
>> follows:
>> ```
>>    File: <CENSORED>
>>    Size: 91876     	Blocks: 184        IO Block: 4096   regular file
>> Device: 259,2	Inode: 4630629     Links: 1
>> Access: (0664/-rw-rw-r--)  Uid: ( 1000/romasandu)   Gid: ( 1000/romasandu)
>> Access: 2024-08-29 17:41:04.855126300 +0300
>> Modify: 2024-08-29 17:41:04.855609000 +0300
>> Change: 2024-08-29 17:41:04.855609000 +0300
>>   Birth: -
>> ```
>> Maybe lack of a birth stat is what drives git crazy?
> 
> That doesn't exist in POSIX, so it isn't used in Git.
> 
> I looked at the Ubuntu git package and it doesn't use `USE_NSEC`, so
> your lack of nanosecond precision in timestamps probably isn't the
> problem here.
> 
> You may want to try using a utility like
> https://github.com/shogo82148/git-dump-index to dump the index and find
> out what might have changed.  You can use `stat -c` to write the data
> for the actual files in the same format, and then run `diff` on the two
> to find out where they disagree.  Or, perhaps you can just eyeball it,
> in case there's something obvious (like a `uid` difference).
> 
> Or, you could try instrumenting `match_stat_data` or
> `stat_validity_check` in `statinfo.c` and printing the data that's
> changed.
> 
> You might also try disabling untracked cache and see if that fixes the
> problem.  It might be that there _is_ a bug in that the untracked cache
> information isn't correctly refreshed when it was originally written on
> a different platform.  It's known that Windows writes different
> information into the index than Unix systems and perhaps that
> information doesn't get refreshed properly.
> 
> One other thought: Windows stores symlinks with a different size than
> most Unix systems.  Windows tends to give them a full block size,
> whereas Unix gives them a size of their length in bytes.  That
> definitely breaks using symlinks in a repository across Windows and WSL.
> I don't know if that's what's going on here, but of course it could be
> related.

