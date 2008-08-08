From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] Enable parallel tests
Date: Fri, 08 Aug 2008 09:44:31 +0200
Message-ID: <489BF95F.1070000@lsrfire.ath.cx>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 09:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRMfO-0007at-Pn
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 09:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbYHHHoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 03:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYHHHoj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 03:44:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:38838 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbYHHHoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 03:44:38 -0400
Received: from [10.0.1.200] (p57B7DC37.dip.t-dialin.net [87.183.220.55])
	by india601.server4you.de (Postfix) with ESMTPSA id E03EB2F8067;
	Fri,  8 Aug 2008 09:44:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91629>

Johannes Schindelin schrieb:
> On multiprocessor machines, or with I/O heavy tests (that leave the
> CPU waiting a lot), it makes sense to parallelize the tests.
>=20
> However, care has to be taken that the different jobs use different
> trash directories.

Good idea!

> This commit does so, by inspecting the MAKEFLAGS variable to detect
> if the option "-j" or "--jobs" was passed to make.  In that case, the
> test is run with the new "--parallel" option.

How about making the test harness be able to run multiple tests in
parallel by default, i.e. always use a different trash directory name
for each test, without adding the new option?  The implementation would
be a bit simpler (no -j detection needed) and the documentation would b=
e
simpler, too.  We could say "look in 'trash directory/tNNNN'" instead o=
f
"look in this place unless you used -j".

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 11c0275..c5868c4 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -74,6 +74,7 @@ esac
>  	) &&
>  	color=3Dt
> =20
> +test=3D"trash directory"
>  while test "$#" -ne 0
>  do
>  	case "$1" in
> @@ -94,6 +95,10 @@ do
>  	--no-python)
>  		# noop now...
>  		shift ;;
> +	--parallel)
> +		test=3D"$test.$(basename "$0" .sh)"
> +		remove_trash=3D"$(pwd)/$test"
> +		shift ;;

test=3D"trash directory/$this_test"?

The advantage would be that all trash was still inside "trash
directory".  Not sure if the extra directory level would break
something.  (Note: $this_test is defined a bit later in the script.)

test=3D"trash for $this_test"?

This one still has a space in it..

>  	*)
>  		break ;;
>  	esac
> @@ -449,6 +454,11 @@ test_done () {
>  		# we will leave things as they are.
> =20
>  		say_color pass "passed all $msg"
> +
> +		test ! -z =3D "$remove_trash" &&

This test succeeds always, because =3D is not an empty string.

Ren=E9
