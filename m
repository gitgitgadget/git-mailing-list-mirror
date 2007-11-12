From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH v3] Make GIT_INDEX_FILE apply to git-commit
Date: Mon, 12 Nov 2007 19:41:29 +0100
Message-ID: <87d4ufi9wm.dlv@vanicat.homelinux.org>
References: <87r6ixj7af.dlv@vanicat.homelinux.org>
 <7vlk94d043.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 19:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IreFp-0002jQ-KX
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 19:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXKLSnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 13:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbXKLSnE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 13:43:04 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:44445 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751657AbXKLSnB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 13:43:01 -0500
Received: from vanicat.homelinux.org ([77.193.67.174])
 by sp604001mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JRE00D8BP988J20@sp604001mt.gpm.neuf.ld> for
 git@vger.kernel.org; Mon, 12 Nov 2007 19:41:34 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)	id 1IreDx-0005AS-7W; Mon,
 12 Nov 2007 19:41:29 +0100
In-reply-to: <7vlk94d043.fsf@gitster.siamese.dyndns.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64684>

Junio C Hamano <gitster@pobox.com> writes:

> R=C3=A9mi Vanicat <vanicat@debian.org> writes:
>
>> @@ -26,7 +26,7 @@ refuse_partial () {
>>  }
>> =20
>>  TMP_INDEX=3D
>> -THIS_INDEX=3D"$GIT_DIR/index"
>> +THIS_INDEX=3D"${GIT_INDEX_FILE:-$GIT_DIR/index}"
>>  NEXT_INDEX=3D"$GIT_DIR/next-index$$"
>>  rm -f "$NEXT_INDEX"
>>  save_index () {
>
> This is just a "purist" question, but I wonder if we want to
> differentiate the case where GIT_INDEX_FILE is set to empty and
> GIT_INDEX_FILE is not set at all?

Well, It's my first patch to git, and I overlook it

> So, what I would suggest is:
>
>  * Your "GIT_INDEX_FILE=3D... git-commit" test -- git-commit
>    should not fail;
>
>  + Test that the path you modified in the above commit (in this
>    case, 'file') matches between index you used in the commit
>    and the resulting commit;
>
>  * Test that the path you modified in the above commit matches
>    between the HEAD, the alternate index and the work tree (your
>    latter test).
>
>  + Test that the original index the above wanted to preserve was
>    not clobbered by git-commit;
>
>  + Test git-commit runs sensibly even when it is given a
>    nonexistent file as GIT_INDEX_FILE.
>
> Perhaps like this, instead of your patch to t/t7500:
>
> 	test_expect_success 'using alternate GIT_INDEX_FILE (1)' '
> =09
> 		cp .git/index saved-index &&
> 		(
> 			echo some new content >file &&
> 		        GIT_INDEX_FILE=3D.git/another_index &&
> 			export GIT_INDEX_FILE &&
> 			git add file &&
> 			git commit -m "commit using another index" &&
> 			git diff-index --exit-code HEAD &&
> 			git diff-files --exit-code
> 		) &&
> 		cmp .git/index saved-index >/dev/null
> =09
> 	'
> =09
> 	test_expect_success 'using alternate GIT_INDEX_FILE (2)' '
> =09
> 		cp .git/index saved-index &&
> 		(
> 			rm -f .git/no-such-index &&
> 			GIT_INDEX_FILE=3D.git/no-such-index &&
> 			export GIT_INDEX_FILE &&
> 			git commit -m "commit using nonexistent index" &&
> 			test -z "$(git ls-files)" &&
> 			test -z "$(git ls-tree HEAD)"
> =09
> 		) &&
> 		cmp .git/index saved-index >/dev/null
> =09
> 	'

Seem, good, I will use this.

--=20
R=C3=A9mi Vanicat
