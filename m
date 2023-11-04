Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB586AA2
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNRaSz1C"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC24187
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 22:11:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DA2CE1D85B;
	Sat,  4 Nov 2023 01:11:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WIS1bliGiJgW
	WJQs/ukhJdneD4S1C70CNf5OO40yK7Y=; b=QNRaSz1CY3rB0GLyRMkghEmhj8zg
	cJPCpmEBoN71XQLzC6cdldEozUSc0yxZB56gmJZnXfpUlxs/tJtuP9b5PV8cn6eK
	AWeh96WAUphad1OXWza3yupJSV13+BtEHYFQDLH0umn8zrv+EXUIcPi6tE1NK+rc
	nzLZ0lp0qLUJcNg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C3FE51D85A;
	Sat,  4 Nov 2023 01:11:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A7911D859;
	Sat,  4 Nov 2023 01:11:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
In-Reply-To: <20231103163449.1578841-1-jojwang@google.com> (Joanna Wang's
	message of "Fri, 3 Nov 2023 16:34:48 +0000")
References: <20231103143508.896745-1-jojwang@google.com>
	<20231103163449.1578841-1-jojwang@google.com>
Date: Sat, 04 Nov 2023 14:11:48 +0900
Message-ID: <xmqqsf5mgl0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A8FB4FC6-7AD0-11EE-B858-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Thanks.  The compiled result from this version looks quite good.  As
you started a new round with typofix, let me start the final
nitpicking.

Joanna Wang <jojwang@google.com> writes:

> This lets users limit files or exclude files based on file
> attributes during git-add and git-stash.
> For example, the chromium project would like to use this like
> "git add --all ':(exclude,attr:submodule)'", as submodules are managed =
in a
> unique way and often results in submodule changes that users do not wan=
t in
> their commits.

I would say

    Allow users to limit or exclude files based on file attributes
    during git-add and git-stash.

    For example, the chromium project would like to use=20

        $ git add . ':(exclude,attr:submodule)'

    as submodules are managed in a unique way and often results in
    submodule changes that users do not want in their commits.

except that I would prefer to see "in a unique way" rephrased.
Would "are managed outside Git using external tools" be a more
accurate description?

It may be true that the chromium project handles submodules unlike
all the other projects, but you guys being alone is not an important
part of the reason why we might want this new feature to help users.
When another project adopts the way how chromium manages the
submodules, forbidding its end-users from running "git add" to
record the changes to their submodules, you guys will no longer be
"unique", but the need for this feature will still exist (and the
demand may even be stronger).  The reason why this feature helps
should be stated here.

> This does not change any attr magic implementation. It is only adding
> attr as an allowed pathspec in git-add and git-stash, which was previou=
sly
> blocked by GUARD_PATHSPEC and a pathspec mask in parse_pathspec()).

Add blank line here between paragraphs.

> However, this does fix a bug in prefix_magic() where attr values were u=
nintentionally removed.
> This was hit whenever parse_pathspec() is called with PATHSPEC_PREFIX_O=
RIGIN as a flag,
> which was the case for git-stash.
> (Bug originally filed here:

Wrap overlong lines here and in the rest of the proposed log message.

> diff --git a/pathspec.c b/pathspec.c
> index bb1efe1f39..2f8721cc15 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -109,16 +109,34 @@ static struct pathspec_magic {
>  	{ PATHSPEC_ATTR,    '\0', "attr" },
>  };
> =20
> -static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned ma=
gic)
> +static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned ma=
gic, const char *element)
>  {

This is overly long.

> +	/* No magic was found in element, just add prefix magic */
> +	if (magic =3D=3D 0) {

Style:

	if (!magic) {

> +		strbuf_addf(sb, ":(prefix:%d)", prefixlen);
> +		return;
> +	}
> +

> +	/*
> +	 * At this point we known that parse_element_magic() was able to extr=
act some pathspec
> +	 * magic from element. So we know element is correctly formatted in e=
ither shorthand
> +	 * or longhand form
> +	 */

Overly long, with a typo.  "At this point, we know that ...".

> +	if (element[1] !=3D '(') {
> +		/* Process an element in shorthand form (e.g. ":!/<match>") */
> +		strbuf_addstr(sb, ":(");
> +		for (int i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +			if ((magic & pathspec_magic[i].bit) && (pathspec_magic[i].mnemonic =
!=3D '\0')) {

Overly long, with a stylo.

> +				if (sb->buf[sb->len - 1] !=3D '(')
> +					strbuf_addch(sb, ',');
> +				strbuf_addstr(sb, pathspec_magic[i].name);
> +			}
>  		}
> +	} else {
> +		/* For the longhand form, we copy everything up to the final ')' */
> +		size_t len =3D strchr(element, ')') - element;
> +		strbuf_add(sb, element, len);
> +	}
>  	strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }

Here is what I ended up queuing.

Thanks.

---- >8 -------- >8 -------- >8 -------- >8 ----
From: Joanna Wang <jojwang@google.com>
Date: Fri, 3 Nov 2023 16:34:48 +0000
Subject: [PATCH] attr: enable attr pathspec magic for git-add and git-sta=
sh

Allow users to limit or exclude files based on file attributes
during git-add and git-stash.

For example, the chromium project would like to use

    $ git add . ':(exclude,attr:submodule)'

as submodules are managed by an external tool, forbidding end users
to record changes with "git add".  Allowing "git add" to often
records changes that users do not want in their commits.

This commit does not change any attr magic implementation. It is
only adding attr as an allowed pathspec in git-add and git-stash,
which was previously blocked by GUARD_PATHSPEC and a pathspec mask
in parse_pathspec()).

However, we fix a bug in prefix_magic() where attr values were
unintentionally removed.  This was triggerable when parse_pathspec()
is called with PATHSPEC_PREFIX_ORIGIN as a flag, which was the case
for git-stash (Bug originally filed here [*])

Furthermore, while other commands hit this code path it did not
result in unexpected behavior because this bug only impacts the
pathspec->items->original field which is NOT used to filter
paths. However, git-stash does use pathspec->items->original when
building args used to call other git commands.  (See add_pathspecs()
usage and implementation in stash.c)

It is possible that when the attr pathspec feature was first added
in b0db704652 (pathspec: allow querying for attributes, 2017-03-13),
"PATHSPEC_ATTR" was just unintentionally left out of a few
GUARD_PATHSPEC() invocations.

Later, to get a more user-friendly error message when attr was used
with git-add, PATHSPEC_ATTR was added as a mask to git-add's
invocation of parse_pathspec() 84d938b732 (add: do not accept
pathspec magic 'attr', 2018-09-18).  However, this user-friendly
error message was never added for git-stash.

[Reference]
 * https://lore.kernel.org/git/CAMmZTi-0QKtj7Q=3DsbC5qhipGsQxJFOY-Qkk1jfk=
RYwfF5FcUVg@mail.gmail.com/)

Signed-off-by: Joanna Wang <jojwang@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c                  |   7 ++-
 dir.c                          |   3 +-
 pathspec.c                     |  39 +++++++++---
 t/t6135-pathspec-with-attrs.sh | 108 +++++++++++++++++++++++++++++++--
 4 files changed, 139 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5126d2ede3..d46e4d10e9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -424,7 +424,7 @@ int cmd_add(int argc, const char **argv, const char *=
prefix)
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_ATTR,
+	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
@@ -433,7 +433,7 @@ int cmd_add(int argc, const char **argv, const char *=
prefix)
 		if (pathspec.nr)
 			die(_("'%s' and pathspec arguments cannot be used together"), "--path=
spec-from-file");
=20
-		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
+		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_FULL |
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
@@ -504,7 +504,8 @@ int cmd_add(int argc, const char **argv, const char *=
prefix)
 			       PATHSPEC_LITERAL |
 			       PATHSPEC_GLOB |
 			       PATHSPEC_ICASE |
-			       PATHSPEC_EXCLUDE);
+			       PATHSPEC_EXCLUDE |
+			       PATHSPEC_ATTR);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
diff --git a/dir.c b/dir.c
index 16fdb03f2a..4d1cd039be 100644
--- a/dir.c
+++ b/dir.c
@@ -2179,7 +2179,8 @@ static int exclude_matches_pathspec(const char *pat=
h, int pathlen,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
=20
 	for (i =3D 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item =3D &pathspec->items[i];
diff --git a/pathspec.c b/pathspec.c
index bb1efe1f39..d132eefac2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -109,16 +109,37 @@ static struct pathspec_magic {
 	{ PATHSPEC_ATTR,    '\0', "attr" },
 };
=20
-static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magi=
c)
+static void prefix_magic(struct strbuf *sb, int prefixlen,
+			 unsigned magic, const char *element)
 {
-	int i;
-	strbuf_addstr(sb, ":(");
-	for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
-		if (magic & pathspec_magic[i].bit) {
-			if (sb->buf[sb->len - 1] !=3D '(')
-				strbuf_addch(sb, ',');
-			strbuf_addstr(sb, pathspec_magic[i].name);
+	/* No magic was found in element, just add prefix magic */
+	if (!magic) {
+		strbuf_addf(sb, ":(prefix:%d)", prefixlen);
+		return;
+	}
+
+	/*
+	 * At this point, we know that parse_element_magic() was able
+	 * to extract some pathspec magic from element. So we know
+	 * element is correctly formatted in either shorthand or
+	 * longhand form
+	 */
+	if (element[1] !=3D '(') {
+		/* Process an element in shorthand form (e.g. ":!/<match>") */
+		strbuf_addstr(sb, ":(");
+		for (int i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if ((magic & pathspec_magic[i].bit) &&
+			    (pathspec_magic[i].mnemonic)) {
+				if (sb->buf[sb->len - 1] !=3D '(')
+					strbuf_addch(sb, ',');
+				strbuf_addstr(sb, pathspec_magic[i].name);
+			}
 		}
+	} else {
+		/* For the longhand form, we copy everything up to the final ')' */
+		size_t len =3D strchr(element, ')') - element;
+		strbuf_add(sb, element, len);
+	}
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
=20
@@ -493,7 +514,7 @@ static void init_pathspec_item(struct pathspec_item *=
item, unsigned flags,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		/* Preserve the actual prefix length of each pattern */
-		prefix_magic(&sb, prefixlen, element_magic);
+		prefix_magic(&sb, prefixlen, element_magic, elt);
=20
 		strbuf_addstr(&sb, match);
 		item->original =3D strbuf_detach(&sb, NULL);
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs=
.sh
index f70c395e75..e46fa176ed 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -64,12 +64,24 @@ test_expect_success 'setup .gitattributes' '
 	fileSetLabel label
 	fileValue label=3Dfoo
 	fileWrongLabel label=E2=98=BA
+	newFileA* labelA
+	newFileB* labelB
 	EOF
 	echo fileSetLabel label1 >sub/.gitattributes &&
 	git add .gitattributes sub/.gitattributes &&
 	git commit -m "add attributes"
 '
=20
+test_expect_success 'setup .gitignore' '
+	cat <<-\EOF >.gitignore &&
+	actual
+	expect
+	pathspec_file
+	EOF
+	git add .gitignore &&
+	git commit -m "add gitignore"
+'
+
 test_expect_success 'check specific set attr' '
 	cat <<-\EOF >expect &&
 	fileSetLabel
@@ -150,6 +162,7 @@ test_expect_success 'check specific value attr (2)' '
 test_expect_success 'check unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
+	.gitignore
 	fileA
 	fileAB
 	fileAC
@@ -175,6 +188,7 @@ test_expect_success 'check unspecified attr' '
 test_expect_success 'check unspecified attr (2)' '
 	cat <<-\EOF >expect &&
 	HEAD:.gitattributes
+	HEAD:.gitignore
 	HEAD:fileA
 	HEAD:fileAB
 	HEAD:fileAC
@@ -200,6 +214,7 @@ test_expect_success 'check unspecified attr (2)' '
 test_expect_success 'check multiple unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
+	.gitignore
 	fileC
 	fileNoLabel
 	fileWrongLabel
@@ -239,16 +254,99 @@ test_expect_success 'fail on multiple attr specifie=
rs in one pathspec item' '
 	test_i18ngrep "Only one" actual
 '
=20
-test_expect_success 'fail if attr magic is used places not implemented' =
'
+test_expect_success 'fail if attr magic is used in places not implemente=
d' '
 	# The main purpose of this test is to check that we actually fail
 	# when you attempt to use attr magic in commands that do not implement
-	# attr magic. This test does not advocate git-add to stay that way,
-	# though, but git-add is convenient as it has its own internal pathspec
-	# parsing.
-	test_must_fail git add ":(attr:labelB)" 2>actual &&
+	# attr magic. This test does not advocate check-ignore to stay that way=
.
+	# When you teach the command to grok the pathspec, you need to find
+	# another command to replace it for the test.
+	test_must_fail git check-ignore ":(attr:labelB)" 2>actual &&
 	test_i18ngrep "magic not supported" actual
 '
=20
+test_expect_success 'check that attr magic works for git stash push' '
+	cat <<-\EOF >expect &&
+	A	sub/newFileA-foo
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	git stash push --include-untracked -- ":(exclude,attr:labelB)" &&
+	git stash show --include-untracked --name-status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add --all' '
+	cat <<-\EOF >expect &&
+	sub/newFileA-foo
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	git add --all ":(exclude,attr:labelB)" &&
+	git diff --name-only --cached >actual &&
+	git restore -W -S . &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add -u' '
+	cat <<-\EOF >expect &&
+	sub/fileA
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	>sub/fileA &&
+	>sub/fileB &&
+	git add -u ":(exclude,attr:labelB)" &&
+	git diff --name-only --cached  >actual &&
+	git restore -S -W . && rm sub/new* &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add <path>' '
+	cat <<-\EOF >expect &&
+	fileA
+	fileB
+	sub/fileA
+	EOF
+	>fileA &&
+	>fileB &&
+	>sub/fileA &&
+	>sub/fileB &&
+	git add ":(exclude,attr:labelB)sub/*" &&
+	git diff --name-only --cached >actual &&
+	git restore -S -W . &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git -add .' '
+	cat <<-\EOF >expect &&
+	sub/fileA
+	EOF
+	>fileA &&
+	>fileB &&
+	>sub/fileA &&
+	>sub/fileB &&
+	cd sub &&
+	git add . ":(exclude,attr:labelB)" &&
+	cd .. &&
+	git diff --name-only --cached >actual &&
+	git restore -S -W . &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add --pathspec-=
from-file' '
+	cat <<-\EOF >pathspec_file &&
+	:(exclude,attr:labelB)
+	EOF
+	cat <<-\EOF >expect &&
+	sub/newFileA-foo
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	git add --all --pathspec-from-file=3Dpathspec_file &&
+	git diff --name-only --cached >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'abort on giving invalid label on the command line' =
'
 	test_must_fail git ls-files . ":(attr:=E2=98=BA)"
 '
--=20
2.43.0-rc0

