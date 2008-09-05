From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] Avoid warning when bisecting a merge
Date: Fri, 05 Sep 2008 09:18:10 +0200
Message-ID: <48C0DD32.5010008@isy.liu.se>
References: <1220562150-19962-1-git-send-email-hendeby@isy.liu.se> <200809050814.36937.chriscool@tuxfamily.org> <7vhc8vxg04.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 09:19:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbVbZ-0003DN-Ur
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 09:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbYIEHSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 03:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbYIEHSP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 03:18:15 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:42132 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbYIEHSO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 03:18:14 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id B6A8B25A5A;
	Fri,  5 Sep 2008 09:18:12 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 24044-03; Fri,  4 Jul 2008 02:08:54 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 94E1E25A5C;
	Fri,  5 Sep 2008 09:18:11 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vhc8vxg04.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94998>

On 09/05/2008 08:29 AM, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>=20
>> Le jeudi 4 septembre 2008, Gustaf Hendeby a =C3=A9crit :
>>> Trying to compare an empty string as a number results in an error,
>>> hence make sure checkout_done is set before using it.
>> This patch seems to work fine.=20
>>
>>> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
>> Acked-by: Christian Couder <chriscool@tuxfamily.org>
>=20
> Have you actually read the patch and thought about it before acking i=
t?
>=20
> Why does a variable that says "have we done checkout?" have three sta=
tes?
> Certainly it is not like "yes, no, dunno", right?  checkout_done=3D0 =
which
> was added by Gustaf, checkout_done=3D1 is the state the test checks w=
ith
> (presumably set by check_good_are_ancestors_of_bad), and checkout_don=
e=3D''
> which the code does before returning?
>=20
>> PS: After thinking about it, I wonder if we should remove $checkout_=
done=20
>> entirely and use the return value from "check_merge_bases"=20
>> and "check_good_are_ancestors_of_bad" to know if a checkout was done=
=2E
>=20
> Yup, that might make more sense. In the meantime, I suspect this make=
s
> more sense than introducing a new state "0".

I can't argue with that.  Junio, your suggestion makes more sense.  I
should have paid more attention to what I was doing.  Sorry about the n=
oise.

/Gustaf

>=20
> diff --git c/git-bisect.sh w/git-bisect.sh
> index 69a9a56..73f01bb 100755
> --- c/git-bisect.sh
> +++ w/git-bisect.sh
> @@ -30,6 +30,7 @@ OPTIONS_SPEC=3D
>  . git-sh-setup
>  require_work_tree
> =20
> +checkout_done=3D
>  _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> =20
> @@ -418,7 +419,7 @@ check_good_are_ancestors_of_bad() {
>  	_side=3D$(git rev-list $_good ^$_bad)
>  	if test -n "$_side"; then
>  		check_merge_bases "$_bad" "$_good" "$_skip" || return
> -		test "$checkout_done" -eq "1" && return
> +		test -n "$checkout_done" && return
>  	fi
> =20
>  	: > "$GIT_DIR/BISECT_ANCESTORS_OK"
> @@ -438,7 +439,7 @@ bisect_next() {
> =20
>  	# Maybe some merge bases must be tested first
>  	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
> -	test "$checkout_done" -eq "1" && checkout_done=3D'' && return
> +	test -n "$checkout_done" && checkout_done=3D'' && return
> =20
>  	# Get bisection information
>  	BISECT_OPT=3D''
>=20
>=20
