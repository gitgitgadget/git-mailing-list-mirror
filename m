Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424A14ABB
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZHryYgu"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA693
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:10:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B89B2CFB6;
	Tue, 24 Oct 2023 15:10:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+hWOnz1Dr9I5
	lKNF61QxA8Ej/Xm/oGbIOAygcKp42OM=; b=JZHryYguAV4dCpiFW2+J555woe2w
	f2nSowQ/juQaPULr2QL9cMK5SIzb+TPhTIdL/zf5FD3RDhqCjbqIVULQjX5583hy
	Oj9p+3GKg5B83RTixhtHPzm/AFSjW9zStvdDlDP/FifyG3l/jLBY2zNYcNYvyDMn
	oHMRFICd+PUNo4c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 548922CFB5;
	Tue, 24 Oct 2023 15:10:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4B842CFB4;
	Tue, 24 Oct 2023 15:10:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Taylor
 Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] commit: detect commits that exist in
 commit-graph but not in the ODB
In-Reply-To: <0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 23 Oct 2023 13:27:20 +0200")
References: <cover.1698060036.git.ps@pks.im>
	<0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>
Date: Tue, 24 Oct 2023 12:10:13 -0700
Message-ID: <xmqqy1fr3kh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F655D3F0-72A0-11EE-B25F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Commit graphs can become stale and contain references to commits that d=
o
> not exist in the object database anymore. Theoretically, this can lead
> to a scenario where we are able to successfully look up any such commit
> via the commit graph even though such a lookup would fail if done via
> the object database directly.
>
> As the commit graph is mostly intended as a sort of cache to speed up
> parsing of commits we do not want to have diverging behaviour in a
> repository with and a repository without commit graphs, no matter
> whether they are stale or not. As commits are otherwise immutable, the
> only thing that we really need to care about is thus the presence or
> absence of a commit.
>
> To address potentially stale commit data that may exist in the graph,
> our `lookup_commit_in_graph()` function will check for the commit's
> existence in both the commit graph, but also in the object database. So
> even if we were able to look up the commit's data in the graph, we woul=
d
> still pretend as if the commit didn't exist if it is missing in the
> object database.
>
> We don't have the same safety net in `parse_commit_in_graph_one()`
> though. This function is mostly used internally in "commit-graph.c"
> itself to validate the commit graph, and this usage is fine. We do
> expose its functionality via `parse_commit_in_graph()` though, which
> gets called by `repo_parse_commit_internal()`, and that function is in
> turn used in many places in our codebase.
>
> For all I can see this function is never used to directly turn an objec=
t
> ID into a commit object without additional safety checks before or afte=
r
> this lookup. What it is being used for though is to walk history via th=
e
> parent chain of commits. So when commits in the parent chain of a graph
> walk are missing it is possible that we wouldn't notice if that missing
> commit was part of the commit graph. Thus, a query like `git rev-parse
> HEAD~2` can succeed even if the intermittent commit is missing.
>
> It's unclear whether there are additional ways in which such stale
> commit graphs can lead to problems. In any case, it feels like this is =
a
> bigger bug waiting to happen when we gain additional direct or indirect
> callers of `repo_parse_commit_internal()`. So let's fix the inconsisten=
t
> behaviour by checking for object existence via the object database, as
> well.
>
> This check of course comes with a performance penalty. The following
> benchmarks have been executed in a clone of linux.git with stable tags
> added:
>
>     Benchmark 1: git -c core.commitGraph=3Dtrue rev-list --topo-order -=
-all (git =3D master)
>       Time (mean =C2=B1 =CF=83):      2.913 s =C2=B1  0.018 s    [User:=
 2.363 s, System: 0.548 s]
>       Range (min =E2=80=A6 max):    2.894 s =E2=80=A6  2.950 s    10 ru=
ns
>
>     Benchmark 2: git -c core.commitGraph=3Dtrue rev-list --topo-order -=
-all (git =3D pks-commit-graph-inconsistency)
>       Time (mean =C2=B1 =CF=83):      3.834 s =C2=B1  0.052 s    [User:=
 3.276 s, System: 0.556 s]
>       Range (min =E2=80=A6 max):    3.780 s =E2=80=A6  3.961 s    10 ru=
ns
>
>     Benchmark 3: git -c core.commitGraph=3Dfalse rev-list --topo-order =
--all (git =3D master)
>       Time (mean =C2=B1 =CF=83):     13.841 s =C2=B1  0.084 s    [User:=
 13.152 s, System: 0.687 s]
>       Range (min =E2=80=A6 max):   13.714 s =E2=80=A6 13.995 s    10 ru=
ns
>
>     Benchmark 4: git -c core.commitGraph=3Dfalse rev-list --topo-order =
--all (git =3D pks-commit-graph-inconsistency)
>       Time (mean =C2=B1 =CF=83):     13.762 s =C2=B1  0.116 s    [User:=
 13.094 s, System: 0.667 s]
>       Range (min =E2=80=A6 max):   13.645 s =E2=80=A6 14.038 s    10 ru=
ns
>
>     Summary
>       git -c core.commitGraph=3Dtrue rev-list --topo-order --all (git =3D=
 master) ran
>         1.32 =C2=B1 0.02 times faster than git -c core.commitGraph=3Dtr=
ue rev-list --topo-order --all (git =3D pks-commit-graph-inconsistency)
>         4.72 =C2=B1 0.05 times faster than git -c core.commitGraph=3Dfa=
lse rev-list --topo-order --all (git =3D pks-commit-graph-inconsistency)
>         4.75 =C2=B1 0.04 times faster than git -c core.commitGraph=3Dfa=
lse rev-list --topo-order --all (git =3D master)
>
> We look at a ~30% regression in general, but in general we're still a
> whole lot faster than without the commit graph. To counteract this, the
> new check can be turned off with the `GIT_COMMIT_GRAPH_PARANOIA` envvar=
.

Very nicely described.  Will queue.  I'll go offline for the rest of
the week but if there are no significant issues discovered by the
time I come back, let's declare a victory and merge these two
patches down to 'next'.

Thanks.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit.c                | 16 +++++++++++++++-
>  t/t5318-commit-graph.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index b3223478bc..7399e90212 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -28,6 +28,7 @@
>  #include "shallow.h"
>  #include "tree.h"
>  #include "hook.h"
> +#include "parse.h"
> =20
>  static struct commit_extra_header *read_commit_extra_header_lines(cons=
t char *buf, size_t len, const char **);
> =20
> @@ -572,8 +573,21 @@ int repo_parse_commit_internal(struct repository *=
r,
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> -	if (use_commit_graph && parse_commit_in_graph(r, item))
> +	if (use_commit_graph && parse_commit_in_graph(r, item)) {
> +		static int object_paranoia =3D -1;
> +
> +		if (object_paranoia =3D=3D -1)
> +			object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> +
> +		if (object_paranoia && !has_object(r, &item->object.oid, 0)) {
> +			unparse_commit(r, &item->object.oid);
> +			return quiet_on_missing ? -1 :
> +				error(_("commit %s exists in commit-graph but not in the object da=
tabase"),
> +				      oid_to_hex(&item->object.oid));
> +		}
> +
>  		return 0;
> +	}
> =20
>  	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
>  		return quiet_on_missing ? -1 :
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index c0cc454538..79467d7926 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -842,4 +842,31 @@ test_expect_success 'stale commit cannot be parsed=
 when given directly' '
>  	)
>  '
> =20
> +test_expect_success 'stale commit cannot be parsed when traversing gra=
ph' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit A &&
> +		test_commit B &&
> +		test_commit C &&
> +		git commit-graph write --reachable &&
> +
> +		# Corrupt the repository by deleting the intermittent commit
> +		# object. Commands should notice that this object is absent and
> +		# thus that the repository is corrupt even if the commit graph
> +		# exists.
> +		oid=3D$(git rev-parse B) &&
> +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
> +
> +		# Again, we should be able to parse the commit when not
> +		# being paranoid about commit graph staleness...
> +		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-parse HEAD~2 &&
> +		# ... but fail when we are paranoid.
> +		test_must_fail git rev-parse HEAD~2 2>error &&
> +		grep "error: commit $oid exists in commit-graph but not in the objec=
t database" error
> +	)
> +'
> +
>  test_done
