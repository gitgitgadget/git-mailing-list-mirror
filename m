From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] parse-remote: support default reflist in get_remote_merge_branch
Date: Sun, 07 Jun 2009 09:59:03 -0700
Message-ID: <7vljo49e08.fsf@alter.siamese.dyndns.org>
References: <1244367862-6306-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLiC-0002bo-RF
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbZFGQ7D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 12:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbZFGQ7D
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:59:03 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33656 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbZFGQ7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 12:59:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090607165904.IZJI20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jun 2009 12:59:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 14z31c0074aMwMQ044z3nQ; Sun, 07 Jun 2009 12:59:03 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=81I7cBsdlBAA:10 a=KhWuyMR739sA:10
 a=3yCQnsJiAAAA:8 a=aGHDysR1WuQBXqUuO-4A:9 a=VAtAE8w4mzF3iNpTrL8A:7
 a=ZulldneeE6Ghhk0H21ZnLN3fm0AA:4 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120985>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Expand get_remote_merge_branch to compute the tracking branch to merg=
e
> when called without arguments (or only the remote name). This allows
> "git pull --rebase" without arguments (default upstream branch) to
> work with a rebased upstream.

The last sentence leaves readers wondering...  "Ok, with this patch, X
without Y now works.  What about X _with_ Y?  Is it left unfixed?  Was =
it
already working before this patch?  What is going on???"

> Also add a test to check for this case and another one (failing) to
> test rebasing two branches on top of a rebased upstream using just
> 'git pull --rebase'.

"test doing X using just Y" _sounds as if_ you are implying

	Doing X using Z (that is more cumbersome to type than Y) works but
        doing X using Y (that ought to be the equivalent to Z) does not=
=2E
	Let's expose this inconsistent breakage.

without saying what Z is, and/or why Y is preferred.  So if that is wha=
t
is going on, please spell these out.

If that is not the case please drop "just"; it is confusing.

> +test_expect_success '--rebase with rebased default upstream' '
> +
> +	git update-ref refs/remotes/me/copy copy-orig &&
> +	git checkout --track -b to-rebase2 me/copy &&
> +	git reset --hard to-rebase-orig &&
> +	git pull --rebase &&
> +	test "conflicting modification" =3D "$(cat file)" &&
> +	test file =3D $(cat file2)
> +
> +'
> +
> +test_expect_failure '--rebase with rebased upstream and two branches=
' '
> +
> +	git update-ref refs/remotes/me/copy copy-orig &&
> +	git reset --hard to-rebase-orig &&
> +	git checkout --track -b to-rebase3 me/copy &&
> +	git reset --hard to-rebase-orig &&
> +	git pull --rebase &&
> +	test "conflicting modification" =3D "$(cat file)" &&
> +	test file =3D $(cat file2) &&
> +	git checkout to-rebase2 &&
> +	git pull --rebase me copy
> +
> +'
> +
>  test_expect_success 'pull --rebase dies early with dirty working dir=
ectory' '
> =20
> +	git rebase --abort &&
> +	git checkout to-rebase &&

Hmm, saying "--abort" when rebase is not in progress (i.e. after your n=
ext
patch fixes the above "expect_failure" to pass) does not error out?  It=
 is
not very nice...

>  	git update-ref refs/remotes/me/copy copy^ &&
>  	COPY=3D$(git rev-parse --verify me/copy) &&
>  	git rebase --onto $COPY copy &&
> --=20
> 1.6.3.1.308.g426b5
