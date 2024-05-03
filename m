Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACC4F60D
	for <git@vger.kernel.org>; Fri,  3 May 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750474; cv=none; b=AFflJGe9hT6es24HoC49Fkne4SwcyDQbnn3bw2x0KWfFgaGeNOTVoO6NH7Uw9JJeyHcAass5sl/xLQopyPS/EjPIrsCrQuyvDctDPCOR0KbDAt9UYJnX1cI2O5H+78nMZV4LT6E45bXlOW5K6EfPKUreQaw0UZeH31SiZTIe778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750474; c=relaxed/simple;
	bh=XKAlBHsZG3JfPR0++FmwBGI7ykAe5JabaSKmPXfwE70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6wRIrkduyhoSqqKp0tySVA7zpt+Mbv6QL4vd8EwNqaEdb9qzyydNUtryqfhzJg9Kut+cKuJVx39G5kl+gpmQipFPt7nvTux9Soez1NQmvkqWbBM1n36y2FRZPDBKUpwf36g+BYqIB1NFOXazMwVjJ40No2srdVJD0g5xEVHBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=voNPVyoC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="voNPVyoC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5CD725DD6;
	Fri,  3 May 2024 11:34:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XKAlBHsZG3Jf
	PR0++FmwBGI7ykAe5JabaSKmPXfwE70=; b=voNPVyoCuRZWdrQC0dH71voxRPIP
	q9fDTCfSAMFjhcPIMx6pvv6Ke1jf/uX9amG5bZPtBaaFvB34Do5dY6U2zvDdUO1m
	VE6G8maNbcEtLn1e1wfx/9m6qH+AECO6ukb8LiRAnT7NIo8JkIC1NjVjBvNsc5ef
	GFHc/vRvp7q0Gys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C11125DD5;
	Fri,  3 May 2024 11:34:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE28825DD4;
	Fri,  3 May 2024 11:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Jeff King <peff@peff.net>,  John Cai <johncai86@gmail.com>, Dhruva
 Krishnamurthy <dhruvakm@gmail.com>
Subject: Re* using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git
 2.42
In-Reply-To: <CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
	(Dhruva Krishnamurthy's message of "Thu, 2 May 2024 22:37:59 -0700")
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
	<20240501220030.GA1442509@coredump.intra.peff.net>
	<ZjLfcCxjLq4o7hpw@nand.local> <ZjPOd83r+tkmsv3o@nand.local>
	<xmqqfrv0ds7f.fsf@gitster.g> <ZjPTlrMdpI+jXxyW@nand.local>
	<CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
	<xmqqbk5ndiqk.fsf@gitster.g>
	<CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
Date: Fri, 03 May 2024 08:34:27 -0700
Message-ID: <xmqqzft6aozg.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A1551C9A-0962-11EF-BDA6-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Dhruva Krishnamurthy <dhruvakm@gmail.com> writes:

> On Thu, May 2, 2024 at 2:08=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>> We could drop [1/2] from the series in the meantime to make it a
>> GitLab installation specific issue where they explicitly use
>> attr.tree to point at HEAD ;-) That is not solving anything for
>> those who set attr.tree (in a sense, they are buying the feature
>> with overhead of reading attributes from the named tree), but at
>> least for most people who are used to seeing the bare repository
>> ignoring the attributes, it would be an improvement to drop the
>> "bare repositories the tree of the HEAD commit is used to look up
>> attributes files by default" half from the series.
>>
>
> A hack (without knowing side effects if any) is to use an empty tree
> for attr source:
> $ git config --add attr.tree $(git hash-object -t tree /dev/null)
>
> This gives me performance comparable to git 2.42

That is clever.  Instead of crawling a potentially large tree that
is at the HEAD of the main project payload to find ".gitattributes"
files that may be relevant (and often not), folks can set an empty
tree to attr.tree to the configuration until this gets corrected.

And for folks who had been happy with the pre 2.42 behaviour,
we could do something like the attached as the first step to a real fix.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] stop using HEAD for attributes in bare repository by def=
ault

With 23865355 (attr: read attributes from HEAD when bare repo,
2023-10-13), we started to use the HEAD tree as the default
attribute source in a bare repository.  One argument for such a
behaviour is that it would make things like "git archive" run in
bare and non-bare repositories for the same commit consistent.
This changes was merged to Git 2.43 but without an explicit mention
in its release notes.

It turns out that this change destroys performance of shallowly
cloning from a bare repository.  As the "server" installations are
expected to be mostly bare, and "git pack-objects", which is the
core of driving the other side of "git clone" and "git fetch" wants
to see if a path is set not to delta with blobs from other paths via
the attribute system, the change forces the server side to traverse
the tree of the HEAD commit needlessly to find if each and every
paths the objects it sends out has the attribute that controls the
deltification.  Given that (1) most projects do not configure such
an attribute, and (2) it is dubious for the server side to honor
such an end-user supplied attribute anyway, this was a poor choice
of the default.

To mitigate the current situation, let's revert the change that uses
the tree of HEAD in a bare repository by default as the attribute
source.  This will help most people who have been happy with the
behaviour of Git 2.42 and before.

Two things to note:

 * If you are stuck with versions of Git 2.43 or newer, that is
   older than the release this fix appears in, you can explicitly
   set the attr.tree configuration variable to point at an empty
   tree object, i.e.

	$ git config attr.tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

 * If you like the behaviour we are reverting, you can explicitly
   set the attr.tree configuration variable to HEAD, i.e.

	$ git config attr.tree HEAD

The right fix for this is to optimize the code paths that allow
accesses to attributes in tree objects, but that is a much more
involved change and is left as a longer-term project, outside the
scope of this "first step" fix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c                  |  7 -------
 t/t0003-attributes.sh   | 10 ++++++++--
 t/t5001-archive-attr.sh |  3 ++-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git c/attr.c w/attr.c
index 679e42258c..6af7151088 100644
--- c/attr.c
+++ w/attr.c
@@ -1223,13 +1223,6 @@ static void compute_default_attr_source(struct obj=
ect_id *attr_source)
 		ignore_bad_attr_tree =3D 1;
 	}
=20
-	if (!default_attr_source_tree_object_name &&
-	    startup_info->have_repository &&
-	    is_bare_repository()) {
-		default_attr_source_tree_object_name =3D "HEAD";
-		ignore_bad_attr_tree =3D 1;
-	}
-
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
=20
diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
index 774b52c298..d755cc3c29 100755
--- c/t/t0003-attributes.sh
+++ w/t/t0003-attributes.sh
@@ -398,13 +398,19 @@ test_expect_success 'bad attr source defaults to re=
ading .gitattributes file' '
 	)
 '
=20
-test_expect_success 'bare repo defaults to reading .gitattributes from H=
EAD' '
+test_expect_success 'bare repo no longer defaults to reading .gitattribu=
tes from HEAD' '
 	test_when_finished rm -rf test bare_with_gitattribute &&
 	git init test &&
 	test_commit -C test gitattributes .gitattributes "f/path test=3Dval" &&
 	git clone --bare test bare_with_gitattribute &&
-	echo "f/path: test: val" >expect &&
+
+	echo "f/path: test: unspecified" >expect &&
 	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
+	test_cmp expect actual &&
+
+	echo "f/path: test: val" >expect &&
+	git -C bare_with_gitattribute -c attr.tree=3DHEAD \
+		check-attr test -- f/path >actual &&
 	test_cmp expect actual
 '
=20
diff --git c/t/t5001-archive-attr.sh w/t/t5001-archive-attr.sh
index eaf959d8f6..7310774af5 100755
--- c/t/t5001-archive-attr.sh
+++ w/t/t5001-archive-attr.sh
@@ -133,7 +133,8 @@ test_expect_success 'git archive vs. bare' '
 '
=20
 test_expect_success 'git archive with worktree attributes, bare' '
-	(cd bare && git archive --worktree-attributes HEAD) >bare-worktree.tar =
&&
+	(cd bare &&
+	git -c attr.tree=3DHEAD archive --worktree-attributes HEAD) >bare-workt=
ree.tar &&
 	(mkdir bare-worktree && cd bare-worktree && "$TAR" xf -) <bare-worktree=
.tar
 '
=20
