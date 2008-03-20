From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] New test for preserve merges and squash
Date: Wed, 19 Mar 2008 17:28:34 -0700
Message-ID: <7v1w661bnx.fsf@gitster.siamese.dyndns.org>
References: <1205971432-12641-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8f4-00065c-8W
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163190AbYCTA2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967318AbYCTA2v
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:28:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967306AbYCTA2t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2008 20:28:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A7122C58;
	Wed, 19 Mar 2008 20:28:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 93AD82C56; Wed, 19 Mar 2008 20:28:42 -0400 (EDT)
In-Reply-To: <1205971432-12641-1-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Thu, 20 Mar 2008 01:03:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77595>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
> ---
>  t/t3404-rebase-interactive.sh |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>
> The current version of git fails this test. I think it's a bug, becau=
se
> the patch is what I expect to happen. Or am I wrong?

Please mark such tests with test_expect_fail.

And also Cc: the guilty parties.

	$ git-blame master -- git-rebase--interactive.sh
        $ git shortlog -n -s master -- git-rebase--interactive.sh

would tell you who they are ;-).

> +test_expect_success 'squash and preserve merges' '
> +	test_tick &&
> +	git checkout -b squash-and-preserve-merges master &&
> +	echo A > file1 &&
> +	git commit -m SaPM-1 file1 &&
> +	echo B > file1 &&
> +	git commit -m SaPM-2 file1 &&
> +	git merge to-be-preserved &&
> +	echo C > file1 &&
> +	git commit -m SaPM-3 file1 &&
> +
> +        EXPECT_COUNT=3D4 FAKE_LINES=3D"1 2 squash 4 3" \
> +          git rebase -i -p --onto branch1 master &&
> +	test $(git rev-parse HEAD^2) =3D $(git rev-parse to-be-preserved) &=
&
> +	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
> +	test $(git show HEAD:file1) =3D C &&
> +	test $(git show HEAD~2:file1) =3D A
> +'

Please split such a test into two parts, a part that sets things up (wh=
ich
would succeed), and the part that runs the command it tries to test
("rebase -i" followed by the validation of the result, which you are
expecting to fail).  That way, somebody who is trying to fix the breaka=
ge
can stop the test script by inserting "exit" between the two, run the
rebase command by hand to see what is going on, etc. to diagnose the
issue.
