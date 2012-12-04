From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t9402: sed -i is not portable
Date: Tue, 04 Dec 2012 12:52:00 -0800
Message-ID: <7vfw3lmtfz.fsf@alter.siamese.dyndns.org>
References: <201212042044.49477.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mmogilvi_git@miniinfo.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfzTc-0003Xs-AD
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 21:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab2LDUwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2012 15:52:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab2LDUwG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2012 15:52:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1363D8F1D;
	Tue,  4 Dec 2012 15:52:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wuIXHSWNdroi
	mh9qlT75qBHO0lY=; b=jtoogcvpXBM7UkBnjRzv6Ow9Tx7gPM1/aOFzA9uNYZdx
	Y1JoxRLPjfx4Q1R3zh3A+6iB4RfFXxSnr5w5nLLBOkeKzpzzFgtv+jA6HPRpFj83
	whyFove1rqjjWMc3L2Rm0AozvZqSLxT93Ofg007Yn3xZJnau2pZ5CDxSZpLud8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KTFEf6
	do1p16W32Q/IejQjk8ZoTkGpeZCrzWqiHEh8nWuAdBgjNIecaVPePZoJ1MC6D4vf
	FvcH/xyfjh30XDVHGPkqh6vyOfgrXHhqAw2850d8hQrFx5Kz42mSzqqoHjTcXrr4
	oMqZNZox85qTyeqSk/kjGfngWwNqJ0+1LjGK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B70488F1C;
	Tue,  4 Dec 2012 15:52:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 732C68F17; Tue,  4 Dec 2012
 15:52:02 -0500 (EST)
In-Reply-To: <201212042044.49477.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Tue, 4 Dec 2012 20:44:48
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 745A8F44-3E54-11E2-9721-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211097>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On some systems sed allows the usage of e.g.
> sed -i -e "s/line1/line2/" afile
> to edit the file "in place".
> Other systems don't allow that: one observed behaviour is that
> sed -i -e "s/line1/line2/" afile
> creates a backup file called afile-e, which breaks the test.
> As sed -i is not part of POSIX, avoid it.

Thanks.

The intention is good, but see comments on this part in the patch
below.

> Use test_cmp, makes the test easier to debug.

I see a few other remaining issues in the code after this patch is
applied.  If we are doing other fixes like these, we may want to fix
them as well:

 - test_must_fail is used to run cvs; it shouldn't (instead of
   saying "test_must_fail cvs ...", just say "! cvs ...").

 - A shell function should begin like this: "shellfunc () {"

 - Redirection should not have SP before the filename (i.e. ">out",
   not "> out").

 - It is OK to spell single-liner subshell like this:

    ( cd cvswork3 && ! cvs -f diff -N -u ) &&
    ...

   but a multi-line subshell should start its first command on a
   separate line, like this:

    (
        cd cvswork3 &&
        cvs update foo
    ) &&
    ...

 - quite a few "[cvswork$n]" comments are truncated to "[cvswork$n"
   in the test titles.

> Chain all shell commands with && to detect all kinds of failure.

I think you missed the one in 'merge early [cvswork3] b3 with b1'
where a merge is done in a subshell; a failed merge is not detected.

This is another reason why I asked you not to mix different things
in a single patch; if this patch is rerolled to cover missing "&&"
that you missed, it needs to be re-reviewed for the "sed -i" fix we
review during this round again.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since v1:
> No correction of TABs to make it easier to review
>
> If this is OK:
> Matthew would you like to send a complete re-roll,
> because the credit should be on you ?
>
>  t/t9402-git-cvsserver-refs.sh | 44 ++++++++++++++++++++++-----------=
----------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-re=
fs.sh
> index 858ef0f..5138f14 100755
> --- a/t/t9402-git-cvsserver-refs.sh
> +++ b/t/t9402-git-cvsserver-refs.sh
> @@ -28,27 +28,26 @@ check_file() {
>  }
> =20
>  check_end_tree() {
> -    sandbox=3D"$1"
> -    expectCount=3D$(wc -l < "$WORKDIR/check.list")
> -    cvsCount=3D$(find "$sandbox" -name CVS -prune -o -type f -print =
| wc -l)
> -    test x"$cvsCount" =3D x"$expectCount"
> -    stat=3D$?
> -    echo "check_end $sandbox : $stat cvs=3D$cvsCount expect=3D$expec=
tCount" \
> -	>> "$WORKDIR/check.log"
> -    return $stat
> +    sandbox=3D"$1" &&
> +    wc -l < "$WORKDIR/check.list" > expected &&
> +    find "$sandbox" -type f | grep -v "/CVS" > "$WORKDIR/check.cvsCo=
unt" &&
> +    wc -l < "$WORKDIR/check.cvsCount" >actual &&

You replaced the original "find" that was perfectly correct with
"pipe to grep -v" which is more expensive.  Why?

The file stores the lines to be counted; why is it called a "Count"?

As "check.list" is really the "expected list of files", it may want
to be renamed to "list.expected" or something like that.  Then the
output from this "find" would naturally become "list.actual", i.e.

	find "$sandbox" -name CVS -type d -prune \
            -o -type f -print >"$WORKDIR/list.actual"

Even though you are comparing only the number of lines in the file
in this function, are they expected to name the same set of paths?
The other function check_end_full_tree used to compare only the
count, but you changed it to compare the actul names of paths, which
may be a more robust and correct test, so it might make more sense
to redefine $WORKDIR/list.{expect,actual} to be a sorted list of
paths relative to the top of the working tree and do something like
this:

	(
        	cd "$sandbox" &&
	        find . -name CVS -type d -prune -o -type f -print
	) | sed -e "s|^./||" | sort >"$WORKDIR/list.actual"

and make sure "$WORKDIR/list.expect" is also sorted.  Then you can
lose the "wc -l" based check from here and compare the list of
paths.

> +    test_cmp expected actual &&
> +		rm expected actual &&
> +		sort < "$WORKDIR/check.list" > expected &&
> +		sort < "$WORKDIR/check.cvsCount" | sed -e "s%cvswork/%%" >actual &=
&

It is probably easier for a later patch to fix the indentation, if
these new lines followed the existing indentation.

> +    test_cmp expected actual &&
> +		rm expected actual
>  }
> =20
>  check_end_full_tree() {
> -    sandbox=3D"$1"
> -    ver=3D"$2"
> -    expectCount=3D$(wc -l < "$WORKDIR/check.list")
> -    cvsCount=3D$(find "$sandbox" -name CVS -prune -o -type f -print =
| wc -l)
> -    gitCount=3D$(git ls-tree -r "$2" | wc -l)
> -    test x"$cvsCount" =3D x"$expectCount" -a x"$gitCount" =3D x"$exp=
ectCount"
> -    stat=3D$?
> -    echo "check_end $sandbox : $stat cvs=3D$cvsCount git=3D$gitCount=
 expect=3D$expectCount" \
> -	>> "$WORKDIR/check.log"
> -    return $stat
> +    sandbox=3D"$1" &&
> +    sort < "$WORKDIR/check.list" >expected &&
> +    find "$sandbox" -name CVS -prune -o -type f -print | sed -e "s%$=
sandbox/%%" | sort >act1 &&
> +		test_cmp expected act1 &&
> +    git ls-tree -r "$2" | sed -e "s/^.*blob [0-9a-fA-F]*[	 ]*//" | s=
ort > act2 &&

You can say "git ls-tree --name-only -r" and lose the sed.
