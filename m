From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Make GIT_INDEX_FILE apply to git-commit
Date: Sun, 11 Nov 2007 11:59:40 -0800
Message-ID: <7vlk94d043.fsf@gitster.siamese.dyndns.org>
References: <87r6ixj7af.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIyh-0005nJ-E6
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 21:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbXKKT7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756987AbXKKT7s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:59:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43370 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210AbXKKT7q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 14:59:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 507092F2;
	Sun, 11 Nov 2007 15:00:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F6AD946D3;
	Sun, 11 Nov 2007 15:00:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64507>

R=C3=A9mi Vanicat <vanicat@debian.org> writes:

> @@ -26,7 +26,7 @@ refuse_partial () {
>  }
> =20
>  TMP_INDEX=3D
> -THIS_INDEX=3D"$GIT_DIR/index"
> +THIS_INDEX=3D"${GIT_INDEX_FILE:-$GIT_DIR/index}"
>  NEXT_INDEX=3D"$GIT_DIR/next-index$$"
>  rm -f "$NEXT_INDEX"
>  save_index () {

This is just a "purist" question, but I wonder if we want to
differentiate the case where GIT_INDEX_FILE is set to empty and
GIT_INDEX_FILE is not set at all?

> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
> index abbf54b..3e5abef 100755
> --- a/t/t7500-commit.sh
> +++ b/t/t7500-commit.sh
> @@ -93,4 +93,17 @@ test_expect_success 'commit message from file shou=
ld override template' '
>         commit_msg_is "standard input msg"
>  '
> =20
> +test_expect_success 'using GIT_INDEX_FILE' '
> +
> +       echo "some new content" >file &&
> +       GIT_INDEX_FILE=3D.git/another_index git add file &&
> +       GIT_INDEX_FILE=3D.git/another_index \
> +               git commit -m "commit using another index" &&

Tests that git-commit does not choke on committing the addion a
new 'file'.

> +       git reset HEAD &&
> +       git diff HEAD -- file >current &&
> +       touch empty-file &&
> +       diff empty-file current

Clobbers the index that the above GIT_INDEX_FILE trick should
not have touched before making sure of that, which is bad, and
then makes sure that the new file actually has the right
contents.

So, what I would suggest is:

 * Your "GIT_INDEX_FILE=3D... git-commit" test -- git-commit
   should not fail;

 + Test that the path you modified in the above commit (in this
   case, 'file') matches between index you used in the commit
   and the resulting commit;

 * Test that the path you modified in the above commit matches
   between the HEAD, the alternate index and the work tree (your
   latter test).

 + Test that the original index the above wanted to preserve was
   not clobbered by git-commit;

 + Test git-commit runs sensibly even when it is given a
   nonexistent file as GIT_INDEX_FILE.

Perhaps like this, instead of your patch to t/t7500:

	test_expect_success 'using alternate GIT_INDEX_FILE (1)' '
=09
		cp .git/index saved-index &&
		(
			echo some new content >file &&
		        GIT_INDEX_FILE=3D.git/another_index &&
			export GIT_INDEX_FILE &&
			git add file &&
			git commit -m "commit using another index" &&
			git diff-index --exit-code HEAD &&
			git diff-files --exit-code
		) &&
		cmp .git/index saved-index >/dev/null
=09
	'
=09
	test_expect_success 'using alternate GIT_INDEX_FILE (2)' '
=09
		cp .git/index saved-index &&
		(
			rm -f .git/no-such-index &&
			GIT_INDEX_FILE=3D.git/no-such-index &&
			export GIT_INDEX_FILE &&
			git commit -m "commit using nonexistent index" &&
			test -z "$(git ls-files)" &&
			test -z "$(git ls-tree HEAD)"
=09
		) &&
		cmp .git/index saved-index >/dev/null
=09
	'
