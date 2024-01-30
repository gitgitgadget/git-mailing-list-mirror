Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CD155A32
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638139; cv=none; b=Wi/Y7KCtYctP8/h88JDelbwp0uuWu8vV1LMSQTva70+9s7ftwoHeL07W1rN5Fphlf1NpnEiSHZZDRWonn+2QSLmh+HkQ8aGpGJmXb+B27txNwaX5MDvS9T9ADIlJEfMwUMlRsXWdzpDdng753ilyLnYhnd8TmEUxs2arD8mYD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638139; c=relaxed/simple;
	bh=CWqn6cNz48Q2ICAPcY0dDTraQoOcr4E4703gjJzZ7xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQ0LzPEQw2rfXrt47UEx4mkgiDTg2L49pBG7A/ad2ldUs4CBT+jgvVtjQn2gGM/f7/H9gfmcDkox2ACNG6W9CT953VTKBoqdtFtwie/OfOkG88RdHU42AgeDJo+OUFHoaRr44x1FZX2LYxHRPebFZt0Y4aarAnzffxYb6N6ZhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u3wO+pps; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u3wO+pps"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C77BC298BC;
	Tue, 30 Jan 2024 13:08:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	Wqn6cNz48Q2ICAPcY0dDTraQoOcr4E4703gjJzZ7xY=; b=u3wO+pps/DT/4b2pd
	38NtUiPc/Dd1IP1VqcuxdoBtQnN5K/eXqIQJwtTBSsuYhxiY0qIOuq6pJXaDIcir
	gPK4PSS1cDZQTnXMq1kT8TAzgD7kBVF22o70nw/K31osSVH7I91q87OFOxZOMEHe
	h25deqX7AEXbYmL+20+6IjL2Hk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF491298BB;
	Tue, 30 Jan 2024 13:08:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EEB45298BA;
	Tue, 30 Jan 2024 13:08:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>
Subject: [RFH] disable bogus .maybe_tree suggestion by Coccinelle?
Date: Tue, 30 Jan 2024 10:08:46 -0800
Message-ID: <xmqq1q9ybsnl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D4C00E4-BF9A-11EE-89EB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh at $WORK noticed that "make coccicheck" shows tons of false
positives to tell us to avoid direct access to the .maybe_tree
member of a commit object, even for those that are meant to be
excluded from the rewrite rule, like this:

        diff -u -p a/commit-graph.c b/commit-graph.c
        --- a/commit-graph.c
        +++ b/commit-graph.c
        @@ -905,7 +905,7 @@ static void fill_commit_graph_info(struc

         static inline void set_commit_tree(struct commit *c, struct tree *t)
         {
        -	c->maybe_tree = t;
        +	repo_get_commit_tree(specify_the_right_repo_here, c) = t;
         }

         static int fill_commit_in_graph(struct repository *r,

It turns out that "make coccicheck" shows the same undesirable
suggestions, even in a checkout of 301b8c7f (commit.c: add
repo_get_commit_tree(), 2019-04-16) that added these rules.

If nobody has a better idea (which would obviously to "fix" it so
that we still are reminded to think twice before directly accessing
the .maybe_tree member without these false positives), I'd propose
to remove these rules.

The box I observed the sympotom had this

    $ spatch --version
    spatch version 1.1.1 compiled with OCaml version 4.14.1
    Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3 --enable-opt
    OCaml scripting support: yes
    Python scripting support: yes
    Syntax of regular expressions: Str


---
 contrib/coccinelle/commit.cocci | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git c/contrib/coccinelle/commit.cocci w/contrib/coccinelle/commit.cocci
index af6dd4c20c..397f01b9ff 100644
--- c/contrib/coccinelle/commit.cocci
+++ w/contrib/coccinelle/commit.cocci
@@ -10,29 +10,6 @@ expression c;
 - c->maybe_tree->object.oid.hash
 + get_commit_tree_oid(c)->hash
 
-@@
-identifier f !~ "^set_commit_tree$";
-expression c;
-expression s;
-@@
-  f(...) {<...
-- c->maybe_tree = s
-+ set_commit_tree(c, s)
-  ...>}
-
-// These excluded functions must access c->maybe_tree directly.
-// Note that if c->maybe_tree is written somewhere outside of these
-// functions, then the recommended transformation will be bogus with
-// repo_get_commit_tree() on the LHS.
-@@
-identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
-expression c;
-@@
-  f(...) {<...
-- c->maybe_tree
-+ repo_get_commit_tree(specify_the_right_repo_here, c)
-  ...>}
-
 @@
 struct commit *c;
 expression E;
