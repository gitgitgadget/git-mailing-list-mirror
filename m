From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test-script for git-tag
Date: Fri, 15 Jun 2007 22:14:48 -0700
Message-ID: <7vy7ik4h13.fsf@assigned-by-dhcp.pobox.com>
References: <1b46aba20706140945i2545c06fxce3fda71fe59a7af@mail.gmail.com>
	<Pine.LNX.4.64.0706141851160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 07:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzQcg-0004Vn-Vt
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 07:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXFPFOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 01:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbXFPFOu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 01:14:50 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51055 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbXFPFOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 01:14:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070616051450.TMUD17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 01:14:50 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id C5Eo1X00T1kojtg0000000; Sat, 16 Jun 2007 01:14:49 -0400
In-Reply-To: <Pine.LNX.4.64.0706141851160.4059@racer.site> (Johannes
	Schindelin's message of "Thu, 14 Jun 2007 18:58:46 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50286>

Johannes Schindelin <Johannes.Schindelin@gmx.de> forwarded:

> +# creating and listing lightweight tags:
> +
> +tag_exists () {
> +	git show-ref --quiet --verify refs/tags/$1
> +}

It would be better if you _always_ quoted "$1" for my eyes, as
it would let my brain coast over it without thinking.  This does
not matter in practice as we do not allow metacharacters nor
whitespaces in tagnames, but that comes _after_ having to think
about it.

> +test_expect_success 'listing all tags in an empty tree now should succeed' \
> +	'git tag -l'

A recent patch made it not to exit with non-zero, but I think
that is probably a bug we might want to fix.

> +test_expect_success \
> +	'listing a tag using a matching pattern should output that tag' \
> +	'test `git-tag -l mytag` = mytag'
> +
> +test_expect_success \
> +	'listing tags using a non-matching pattern now should suceed' \
> +	'git-tag -l xxx'
> +
> +test_expect_success \
> +	'listing tags using a non-matching pattern should output nothing' \
> +	'test `git-tag -l xxx | wc -l` -eq 0'
> +

Additional test would be to see git-tag -l "my*" should succeed,
and git-tag -l "my.*" should fail, as the pattern should match
with fnmatch() not regexp().

> +# special cases for creating tags:
> +
> +test_expect_failure \
> +	'trying to create a tag with the name of one existing should fail' \
> +	'git tag mytag'
> +
> +test_expect_failure 'trying to create a tag with a non-valid name should fail' '
> +	test `git-tag -l | wc -l` -ne 1 ||
> +	git tag .othertag ||
> +	git tag "other tag" ||
> +	git tag "othertag^" ||
> +	git tag "other~tag" ||
> +	test `git-tag -l | wc -l` -ne 1
> +'

While it is logically correct to string error conditions with ||
and test inside expect-failure (you are saying "it is a failure
if any of these succeeds"), it needs a bit of brain-twisting to
get what is going on.  But I think this is a valid way to use
expect-failure.

> +test_expect_success \
> +	'listing tags with substring as pattern now must print those matching' '
> ...
> +test_expect_success \
> +	'listing tags with substring as pattern now must print those matching' '
> ...
> +test_expect_success \
> +	'listing tags with substring as pattern now must print those matching' '
> ...
> +test_expect_success \
> +	'listing tags using a name as pattern now must print those matching' '
> ...
> +test_expect_success \
> +	'listing tags using a name as pattern now must print those matching' '
> ...

Somehow, "now" gets quite irritating.

> +
> +cat >expect <<EOF
> +v1.1.3
> +EOF
> +test_expect_success \
> +	'listing tags with ? in the pattern should print those matching' '
> +	git-tag -l 1.1? > actual &&
> +	git-diff expect actual
> +'

I know that there is no such file as 1.1X in the working tree,
but I would feel better if the test protected the ? from the
shell, as in "git tag -l 1.1\? >actual".

> +# creating and verifying lightweight tags:
> +
> +test_expect_success \
> +	'a non-annotated tag created without parameters should point to HEAD' '
> +	git-tag non-annotated-tag &&
> +	! git cat-file tag non-annotated-tag &&
> +	test "$(git rev-parse non-annotated-tag^{commit})" = \
> +		"$(git rev-parse HEAD)"
> +'

I think testing the type directly is more to the point, as in

	test $(git-cat-file -t non-annotated-tag) = commit &&
        test $(git-rev-parse non-annotated-tag) = $(git-rev-parse HEAD)

> +
> +test_expect_failure 'trying to verify an unknown tag should fail' \
> +	'git-tag -v unknown-tag'
> +
> +test_expect_failure \
> +	'trying to verify a non-annotated and non-signed tag should fail' \
> +	'git-tag -v non-annotated-tag'
> +
> +# creating annotated tags:
> +
> +get_tag_msg () {
> +	git cat-file tag "$1" | sed -n -e "1,/BEGIN PGP/p"
> +}
> +

I would write that as "sed -e '/BEGIN PGP/q'", shorter and more
to the point.

> +get_tag_header () {
> +cat >expect <<EOF
> +object $2
> +type commit
> +tag $1
> +tagger C O Mitter <committer@example.com> $3 -0700
> +
> +EOF
> +}

Maybe -0700 deserves a comment --- test_tick always gives time
in that timezone.

You probably would want to also test annotated tags on non
commits (i.e. trees, blobs and tags).

> +
> +commit=$(git rev-parse HEAD)
> +time=$test_tick
> +
> +get_tag_header annotated-tag $commit $time >expect

Huh? get_tag_header stores into "expect" file without saying
anything itself, and you redirect that nothingless to the same
file?

> +touch emptyfile

Maybe it's just me being old-fashioned, but I prefer creation of
an empty file be done with:

	: >emptyfile
or just

	>emptyfile

and avoid using "touch".  Some broken systems did not create a
new file with "touch non-existing-file" (I think it was old AIX).

> +# creating and verifying signed tags:
> +
> +gpg --version >/dev/null
> +if [ $? -eq 127 ]; then
> +	echo "Skipping signed tags tests, because gpg was not found"
> +	test_done
> +	exit
> +fi
> +
> +# key generation info: gpg --homedir t/t7003 --gen-key
> +# Type DSA and Elgamal, size 2048 bits, no expiration date.
> +# Name and email: C O Mitter <committer@example.com>
> +# No password given, to enable non-interactive operation.
> +
> +cp -R ../t7003 ./gpghome
> +chmod 0700 gpghome
> +export GNUPGHOME="$(pwd)/gpghome"
> +
> +get_tag_header signed-tag $commit $time >expect
> +echo 'A signed tag message' >>expect
> +echo '-----BEGIN PGP SIGNATURE-----' >>expect
> +test_expect_success 'creating a signed tag with -m message should succeed' '
> +	git-tag -s -m "A signed tag message" signed-tag &&
> +	get_tag_msg signed-tag >actual &&
> +	git-diff expect actual
> +'
> +

This is just me being curious, but I wonder if this test is safe
to run on an otherwise idle server without moving parts and
keyboard (i.e. lack of sufficient entropy).  I think you made a
prudent choice of not generating a test key in the test script,
by the way.

> +test_expect_success 'verifying a signed tag should succeed' \
> +	'git-tag -v signed-tag'
> +

Forging the tag at this point and make sure it does not verify
would also be interesting, as in:

	forged=$(git cat-file tag signed-tag |
		sed -e "s/signed-tag/forged-tag/" |
		git mktag) &&
	git tag forged-tag $forged &&
        if git-tag -v forged-tag
        then
        	echo Oops
		false
	else
        	: happy
	fi

> diff --git a/t/t7003/random_seed b/t/t7003/random_seed
> new file mode 100644
> index 0000000000000000000000000000000000000000..8fed1339ed0a744e5663f4a5e6b6ac9bae3d8524
> GIT binary patch
> literal 600
> zcmV-e0;m1=h9nBV>1C6QsKJEiEJaD@Q3F8s5u<$E+<2(By)JAZSxviTsXg(wKC+O%
> zzvV{Z>W3*k?r7~pgmmkbw8-x{Am!eeN)z?cwIHcT2jqgiA(SXo<iO=E?cY80`p#w8

Is it necessary to ship random_seed, or is it created as needed
during the test?
