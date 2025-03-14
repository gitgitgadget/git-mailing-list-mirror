Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE81953A9
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991197; cv=none; b=nFGm6oAVKOfuuhsVGVCLsU7fvNcS0DL2gnDDo/AKyDqBa46nTh+HcsL9UHjtMKpQvIQhxsD4fDL/7nheAtoBftL5tK3C5VAnAgF5oQqh7qkJbaCloGdgsjedvJ1BmIn5pCxgwnV/BWlz3g+G1K/nvMpXRLMwo6SDvu7s6xai2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991197; c=relaxed/simple;
	bh=zrcFNgnS4MSqoZeoNePNFfutyyHvYhPExturYamvYrM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lExKknVzmBMXvxm8QAP10SczSKXJzXUJ1AKsNY0ApJ9ZTiWhSTBK571LJvATV5/KN3nphvse9MjpszZ9tTWrdmWwaZoADmNEKuft1D9jqJGH2gPbIwO1Lg1YkW5LD8XHgqn/R1bRYoYwKYH5H6/DDNqPV7VRNrQ+wTmgcJJuN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 52EMOwTQ2609826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 22:24:59 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, "'Simon Josefsson'" <simon@josefsson.org>
Cc: <git@vger.kernel.org>
References: <871pv2jx4a.fsf@josefsson.org> <20250313051538.GA94015@coredump.intra.peff.net> <87msdo1yal.fsf@josefsson.org> <20250314024218.GA114103@coredump.intra.peff.net>
In-Reply-To: <20250314024218.GA114103@coredump.intra.peff.net>
Subject: RE: Making bit-by-bit reproducible Git Bundles?
Date: Fri, 14 Mar 2025 18:24:53 -0400
Organization: Nexbridge Inc.
Message-ID: <011101db952f$ebcffe80$c36ffb80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJRTAi2uH964rwFOYZA85DZj960hQIwTkbYAktuqEECJzbA6rJSroRw
X-Antivirus: Norton (VPS 250314-6, 3/14/2025), Outbound message
X-Antivirus-Status: Clean

On March 13, 2025 10:42 PM, Jeff King wrote:
>On Thu, Mar 13, 2025 at 09:16:34PM +0100, Simon Josefsson wrote:
>
>> >   2. There is no way to pass pack-objects options down through
>> >      git-bundle. So you'd have to either assemble the bundle =
yourself,
>> >      or perhaps generate a stable on-disk pack state, and then =
generate
>> >      the bundle. Perhaps something like:
>> >
>> >        # make one single pack, with no reuse, using the default =
options
>> >        git -c pack.threads=3D1 repack -adf
>>
>> Yay!  You may have solved this for me.  I have to verify this a bit
>> more, but this looks promising (these are two different git clones):
>>
>> jas@kaka:~/t/gnulib-1$ git -c pack.threads=3D1 repack -adf
>> jas@kaka:~/t/gnulib-1$ git -c 'pack.threads=3D1' bundle create
>> gnulib.bundle --all jas@kaka:~/t/gnulib-1$ sha256sum gnulib.bundle
>> c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890
>> gnulib.bundle jas@kaka:~/t/gnulib-1$ cd ../gnulib-2
>> jas@kaka:~/t/gnulib-2$ git -c pack.threads=3D1 repack -adf
>> jas@kaka:~/t/gnulib-2$ git -c 'pack.threads=3D1' bundle create
>> gnulib.bundle --all jas@kaka:~/t/gnulib-2$ sha256sum gnulib.bundle
>> c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890
>> gnulib.bundle jas@kaka:~/t/gnulib-2$
>
>One thing to watch out for here: that repack is going to look at _all_ =
objects in the
>repository. So you will get different output if you make a bundle of a =
tag "v1.0"
>today than you would get later, when "v1.1"
>also exists. Ditto for any other activity in the repository, like =
writes to unrelated
>branches, or even reflog entries.
>
>So you'd probably want to make an absolute minimal repository with the =
reachable
>objects, perhaps like:
>
>  git clone --bare --no-local --single-branch -b v1.0 . just-v1.0.git
>  cd just-v1.0.git
>  git -c pack.threads=3D1 repack -adf
>
>It doesn't have to be just one ref, of course; you might want to =
snapshot the whole
>set of refs at the time you make the bundle. E.g., by fetching into the =
empty repo
>using a refspec.
>
>This would all be a non-issue if you could ask git-bundle to directly =
pass the
>equivalent of "-f" to pack-objects (at that layer it is called =
"--no-reuse-delta"). Since
>then it would be computing the full set of objects itself. But without =
a patch to Git, I
>don't think there's a way to do that.
>
>The bundle format is pretty simple, so you _could_ hack around it =
yourself, like:
>
>  # list refs we care about; you can pick whatever subset you want
>  # here.
>  git for-each-ref --format=3D'%(objectname) %(refname)' refs/heads/ =
>refs
>
>  {
>	# bundle header plus list of refs, plus blank line terminator
>	echo "# v2 git bundle"
>	cat refs
>	echo
>
>	# and now the pack. We just need to feed it the object ids for
>	# all of the refs. It will handle sorting and de-duping for us.
>	cut -d' ' -f1 <refs |
>	git -c pack.threads=3D1 pack-objects \
>		--stdout --revs --delta-base-offset --no-reuse-delta
>  } >foo.bundle
>
>I dunno if that is more or less gross than teaching git-bundle to pass =
--no-reuse-
>delta itself. It's certainly more intimate with the details, but OTOH =
it is less likely to
>change in other versions of Git (e.g., if we started making "v3" =
bundles by default).
>
>> >   # print all commits in topological order, with ties broken by
>> >   # committer date, which should be stable. And then follow up with =
the
>> >   # trees and blobs for each.
>> >   git rev-list --topo-order --objects HEAD >objects
>> >
>> >   # now print the contents of each object (preceded by its name, =
type,
>> >   # and length, so there's no chance of weird prepending or =
appending
>> >   # attacks). We cut off the path information from rev-list here, =
since
>> >   # the ordered set of objects is all we care about.
>> >   cut -d' ' -f1 objects |
>> >   git cat-file --batch >content
>> >
>> >   # and then take a hash over that content; this will be =
unambiguous.
>> >   sha256sum <content
>>
>> How to read this output?  Could this be made git bundle compatible?
>
>You'd have to compare the result of doing that after fetching from the =
bundle into
>an empty repo. I don't think there's a great way to operate directly on =
the bundle
>packfile (it has to be indexed first to see what's in it).
>
>The closest I could get is:
>
>  input=3Dfoo.bundle
>
>  # split the bundle into header and packfile sections on the first
>  # blank line
>  sed '/^$/q' <$input >header
>  size=3D$(stat --format=3D%s header)
>  tail -c +$((size+1)) <$input >bundle.pack
>
>  # we can first do a byte-level comparison of the header; if this =
isn't
>  # the same, the bundles do not match.
>  sha256sum <header
>
>  # now index the pack, so we know what's in it; this makes bundle.idx
>  git index-pack -v bundle.pack
>
>  # and now we want to dump the full logical contents (not the
>  # delta-compressed versions) of each object. First we need a list of
>  # the objects. This will come out in lexical order of object id, =
which
>  # is good for us since it will be stable.
>  git show-index <bundle.idx  | awk '{print $2}' >objects
>
>  # unfortunately here things break down. There is no command to read
>  # the data directly out of the pack/idx pair without a repository
>  # (even though it could be done technically). So we hack around it
>  # with a temp repo.
>  git init --bare tmp.git
>  mv bundle.idx bundle.pack tmp.git/objects/pack/
>  git -C tmp.git cat-file --batch <objects | sha256sum
>
>So...also kind of gross. And not really all that different than what:
>
>  git init --bare tmp.git
>  cd tmp.git
>  git fetch ../foo.bundle refs/*:refs/*
>
>would do (you end up with the same pack/idx pair). So I dunno. I guess =
it depends
>how many and which Git commands you're willing to trust. ;)

I would go one step further on this. Using --depth=3D1 and potentially a =
--sparse checkout
with only what you specifically need to verify.

However, Junio's point on checking end-point commit and tags is useful =
and significant
on verifying that the Merkel Tree itself is intact and not modified =
using signing is usually
sufficient verification and more reliable than a bit-for bit comparison, =
which may have
dependencies on the underlying  operating system, particularly if the =
originating
directory inode contents differ from the destination - an example is =
using a Windows
server for the upstream and a NonStop server for the clone (not so much =
with Linux vs.
NonStop). It is pretty much guaranteed that the inodes will be =
different.

--Randall

