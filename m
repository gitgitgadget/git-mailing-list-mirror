Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CED1E481
	for <git@vger.kernel.org>; Wed,  1 May 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603049; cv=none; b=bgkV0fXCJ7JXmdiSG1/LJBPT7mX1ln+JEpLIaj/Seiw3f3IDKRi4RDRpIbRUFeZEYinXJhT8utVMdNezZ5pZ8iAwmY/RSvI3LI7lHmtSkdetjJVdkH/91MrLT6SP3MotAfY68JKM8Sd802CknTsWryHxg1qadxGX45WddAF/CeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603049; c=relaxed/simple;
	bh=PZaXgrAhhaw9XsuLLGqjZUHCIT0Z9wrZt2TRdXlSR3A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HB7TphhPBPtwbnts6QXQril2VGBJAKFqVtlw9EIfBDK0M1twJ/nJDT4s/cLl+IW0fzq/J9Egv+/GPRPoBGzTpp9ycBaQkMz23N/sFu463wA8DTwum5GVPPXsxWoFAzHCyTv8iyJ342F+nf+Gia+tAEqjeG7G/QPbD8pHxf6YYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 441MbF2r1528480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 22:37:16 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>,
        "'Dhruva Krishnamurthy'" <dhruvakm@gmail.com>
Cc: "'John Cai'" <johncai86@gmail.com>,
        "'Karthik Nayak'" <karthik.188@gmail.com>, <git@vger.kernel.org>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com> <20240501220030.GA1442509@coredump.intra.peff.net>
In-Reply-To: <20240501220030.GA1442509@coredump.intra.peff.net>
Subject: RE: using tree as attribute source is slow, was Re: Help troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Date: Wed, 1 May 2024 18:37:09 -0400
Organization: Nexbridge Inc.
Message-ID: <0c2501da9c18$1de0c970$59a25c50$@nexbridge.com>
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
Thread-Index: AQF+fpGhaWClvcfZMusC4UmsCUPoNQFi6e0asjAZSmA=
Content-Language: en-ca

On Wednesday, May 1, 2024 6:01 PM, Jeff King wrote:
>On Tue, Apr 30, 2024 at 10:26:32PM -0700, Dhruva Krishnamurthy wrote:
>
>> Cloning by specifying depth exhibits performance regression in
>> pack-objects (~20x). The repository I am cloning is on NFS (mounted
>> with NFSv3 & positive lookup cache enabled).
>>
>> Ran under 'perf' command to capture profiling information to see if
>> something really stands out. There is a significant overhead in calls
>> to file open/open64, fstat64 & mmap/munmap in git 2.44 compared to =
git
>> 2.42. Not sure if there is an increase in the number of calls or
>> something more is done.
>>
>> Could someone please guide me on how to troubleshoot this better?
>
>Oof. I was able to reproduce this regression, and the impact can be =
pretty severe.
>You can reproduce it without NFS and without shallow clones. Get a bare =
clone of
>something big like the kernel:
>
>  git clone --bare https://github.com/torvalds/linux
>  cd linux.git
>
>and then do something similar to the server side of a clone:
>
>  time git pack-objects --all --stdout </dev/null >/dev/null
>
>Most of the time will be spent in the "Enumerating objects" phase, =
walking the
>graph (since the repo is fully packed, delta searching and writing are =
fairly quick).
>
>With v2.42.0, I get:
>
>  real	1m12.409s
>  user	1m13.021s
>  sys	0m6.091s
>
>With v2.44.0, I get:
>
>  real	4m12.075s
>  user	4m12.763s
>  sys	0m5.546s
>
>Bisecting show the culprit is 2386535511 (attr: read attributes from =
HEAD when
>bare repo, 2023-10-13), which is in v2.43.0. Before that, a bare =
repository would
>only look for attributes in the info/attributes file. But after, we =
look at the HEAD
>tree-ish, too. And pack-objects will check the "delta" attribute for =
every path of
>every object we are packing. And remember that in-tree lookups for =
foo/bar/baz
>require looking not just for .gitattributes, but also =
foo/.gitattributes,
>foo/bar/.gitattributes, and foo/bar/baz/.gitattributes.
>
>In a non-bare repo, this isn't _too_ bad. We'll try an open() for each =
path, but the
>common case is that we don't have such a file, so the total cost is the =
one syscall per
>object. But when we're pulling attributes from HEAD, each lookup =
requires walking
>the whole chain of trees (so for the final one, tree foo points to tree =
bar points to
>tree baz, where we see there is no .gitattributes entry). And so all of =
that extra time
>goes to reading in trees over and over.
>
>You can repeat the same test with git.git. It gets slower, but it's =
barely perceptible.
>This is because we have a relatively shallow tree, so most lookups are =
hitting root-
>level .gitattributes or maybe one or two levels deep. The kernel has a =
much deeper
>tree, so those lookups are more expensive (and of course there are a =
lot more of
>them).
>
>Getting back to shallow clones and NFS:
>
>  - the effect is more pronounced on NFS because the cost to access
>    objects is higher. With git.git I was even able to see some
>    slowdown, probably just from the cost/latency of opening up all of
>    those objects.
>
>  - the problem doesn't show up if the repo has reachability bitmaps.
>    This is because the bitmap result doesn't have the pathnames of =
each
>    object (we do have the "name hash", but it's not enough for us to =
do
>    an attr lookup), and so objects we get from a bitmap do not
>    respect the delta attribute at all.
>
>    But when doing a shallow clone, we have to disable bitmaps and do a
>    regular traversal. So even if you have bitmaps, you still run into
>    the problem.
>
>    The example above should not have bitmaps (we do build them by
>    default when repacking bare repos these days, but I don't think
>    we'll do so right after cloning). If you have a local repo that
>    already has bitmaps, you should be able to see the difference by
>    using "git -c pack.usebitmaps=3Dfalse pack-objects".
>
>    So even if you are a server which generally enables bitmaps, you =
can
>    still get bit by this for shallow clones, but also for other
>    non-bitmap invocations, like say "git repack -ad". There I see the
>    same 3-minute slowdown in the enumeration phase.
>
>So what to do? It seems like some kind of caching would help here. =
We're looking
>up the same paths over and over, for two reasons:
>
>  1. We'll have many objects with the same paths, one for each time the
>     path was modified through history.
>
>  2. Adjacent objects share the higher-level lookups. Both "dir/a" and
>     "dir/b" will need to look up "dir/.gitattributes" (and all the way
>     up to ".gitattributes").
>
>So even something simple and stupid like this:
>
>diff --git a/attr.c b/attr.c
>index 679e42258c..b32af9a78b 100644
>--- a/attr.c
>+++ b/attr.c
>@@ -24,6 +24,7 @@
> #include "thread-utils.h"
> #include "tree-walk.h"
> #include "object-name.h"
>+#include "strmap.h"
>
> const char *git_attr_tree;
>
>@@ -795,25 +796,31 @@ static struct attr_stack =
*read_attr_from_blob(struct
>index_state *istate,
> 					      const struct object_id *tree_oid,
> 					      const char *path, unsigned flags)  {
>-	struct object_id oid;
>-	unsigned long sz;
>-	enum object_type type;
>+	static struct strmap cache =3D STRMAP_INIT;
>+	void *CACHE_MISSING =3D (void *)1;
> 	void *buf;
>-	unsigned short mode;
>
> 	if (!tree_oid)
> 		return NULL;
>
>-	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
>-		return NULL;
>-
>-	buf =3D repo_read_object_file(istate->repo, &oid, &type, &sz);
>-	if (!buf || type !=3D OBJ_BLOB) {
>-		free(buf);
>-		return NULL;
>+	buf =3D strmap_get(&cache, path);
>+	if (!buf) {
>+		struct object_id oid;
>+		unsigned short mode;
>+		if (!get_tree_entry(istate->repo, tree_oid, path, &oid, &mode)) {
>+			unsigned long sz;
>+			enum object_type type;
>+			buf =3D repo_read_object_file(istate->repo, &oid, &type,
>&sz);
>+			if (!buf || type !=3D OBJ_BLOB) {
>+				free(buf);
>+				buf =3D NULL;
>+			}
>+		}
>+		strmap_put(&cache, path, buf ? buf : CACHE_MISSING);
> 	}
>
>-	return read_attr_from_buf(buf, path, flags);
>+	return buf =3D=3D CACHE_MISSING ? NULL :
>+		read_attr_from_buf(buf, path, flags);
> }
>
> static struct attr_stack *read_attr_from_index(struct index_state =
*istate,
>
>restores the v2.42 performance. But there are probably better options:
>
>  - this is caching whole .gitattributes buffers. In pack-objects we
>    only care about a single bit for try_delta. For linux.git it =
doesn't
>    really matter, as 99% of our entries are just CACHE_MISSING and the
>    real value is avoiding the negative lookups. But the same problem
>    exists to a lesser degree for "git log -p" in a bare repo. So I
>    think it makes sense to try to solve it in the attr layer.
>
>  - the string keys have a lot of duplication. You'll have
>    "foo/.gitattributes", "foo/bar/.gitattributes", and so on. A trie
>    structure split by path component would let you store each =
component
>    just once. And perhaps have even faster lookups. I think this is
>    roughly the same issue faced by the kernel VFS for doing path
>    lookups, so something dentry/dcache-like would help.
>
>    I don't know how much it matters in practice, though. The sum of =
all
>    of the paths in HEAD for linux.git is ~3.5MB, which is a rounding
>    error on the needs of the rest of the packing process.
>
>  - Something dcache-like could also be pushed down lower, to the
>    get_tree_entry() API (imagine it quietly caching uncompressed trees
>    behind the scenes and then using them to traverse). That depends on
>    high locality of requests, though. I don't know if we have that
>    here, because we do our lookups in traversal order. So you'd look =
at
>    entries in HEAD^{tree}, then HEAD~1^{tree}, then HEAD~2^{tree}, and
>    so on.
>
>  - Speaking of locality, the attr code tries to make use of request
>    locality in its stack (so if we ask for attributes for "foo/bar",
>    then "foo/baz", we should be able to keep the parsed data for
>    "foo/.gitattributes" available between them). But our pattern here
>    violates that. Again, not that big an issue if you don't have that
>    many .gitattributes files in the first place, so it might not be
>    worth worrying about. But if we did want to rearrange the lookups =
to
>    exploit locality, it might change the overall caching strategy.
>
>  - As noted above, most entries are just CACHE_MISSING. So rather than
>    lazily looking up and caching entries, we could just prepopulate =
the
>    cache. And then you know that if an entry isn't present in the
>    cache, it does not exist in the tree. The downside is that you pay
>    to walk the all of HEAD^{tree}, even if you only have a few lookups
>    to do. That's a good tradeoff for pack-objects (which usually ends
>    up looking for every path anyway), but not for "git diff" (where =
you
>    only care about a few changed paths.
>
>  - the cache here is static-local in the function. It should probably
>    at least be predicated on the tree_oid, and maybe attached to the
>    repository object? I think having one per repository at a time =
would
>    be fine (generally the tree_oid is set once per process, so it's =
not
>    like you're switching between multiple options).
>
>I've cc'd John as the author of 2386535511. But really, that was just =
enabling by
>default the attr-tree code added by 47cfc9bd7d (attr: add flag =
`--source` to work
>with tree-ish, 2023-01-14). Although in that original context (git =
check-attr) the
>lack of caching would be much less important.

Although this is an unbaked thought...=20

I am not sure this will help, but I have been considering this since the =
trie data structure was introduced. Should we consider moving to a =
sparse trie with a lazy load approach? There is no current indication in =
the trie structure in path.c that a node is incomplete (not as far as I =
can tell anyway), so the assumption is the trie must be fully populated. =
Loading tries are generally the same performance as searching - Order(1) =
- given there are limited numbers of splits compared to a balanced or =
red-black tree; so a lazy load would not significantly change the trie =
load time. Each lookup might expand the node population but could cut =
down times where parts of the trie are ignored. Although this would be a =
non-trivial change, knowing that the trie is incomplete in a sparse =
situation might help here.

--Randall

