From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/19] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Mon, 07 Apr 2014 10:29:46 -0700
Message-ID: <xmqqr459m4j9.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<7b307610fe214f47643a46b3e815487558db244e.1393257006.git.kirr@mns.spb.ru>
	<20140327142354.GD17333@mini.zxlink>
	<xmqqppkxos0w.fsf@gitster.dls.corp.google.com>
	<20140406214626.GA3843@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Mon Apr 07 19:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXDMq-0000yN-2n
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 19:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbaDGR3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 13:29:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbaDGR3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 13:29:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6EC78589;
	Mon,  7 Apr 2014 13:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CQeYNpPDC8L/
	tSpmtvkSs6iJTFA=; b=RJYWdIujaxUDs/prZ9Nwoyi9+wbFYQpZk02OSNGumxha
	Tv5nyiEtZ4fsryfFNnhpk2ro7FURZZBnswRdoNgr9SiBKqLxikUVS7U26Kfl3OdW
	TnM+5DbA0bZ1U51YMkQBfL5PtejKoUC6nPqefZRiLQ9xdFKluLOnF8ZKZ29awhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KQQk+0
	SYhna5B6DnxnkLEqvtiVNFIBvSSOvVf4hvEI4Oo93h+oPz5q28Y+vhd/6OOZP1eZ
	w80DLTLH2L5P1LgDv5+F4C+NuBUk4Z5lLNS+C5HtZPXdn5vffez7eCwUldzwcDuj
	rk7uTNNhi/PcN1uquNjqa0x/4Etd3MGGnoft0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67A3578588;
	Mon,  7 Apr 2014 13:29:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69EDB78587;
	Mon,  7 Apr 2014 13:29:49 -0400 (EDT)
In-Reply-To: <20140406214626.GA3843@mini.zxlink> (Kirill Smelkov's message of
	"Mon, 7 Apr 2014 01:46:26 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 38800C36-BE7A-11E3-943B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245869>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> The following
> ...
> maybe looks a bit simpler, but calls tree_entry_pathcmp twice more ti=
mes.
>
> Besides for important nparent=3D1 case we were not calling
> tree_entry_pathcmp at all and here we'll call it once, which would sl=
ow
> execution down a bit, as base_name_compare shows measurable enough in=
 profile.
> To avoid that we'll need to add 'if (i=3D=3Dimin) continue' and this =
won't
> be so simple then. And for general nparent case, as I've said, we'll =
be
> calling tree_entry_pathcmp twice more times...
>
> Because of all that I'd suggest to go with my original version.

OK.

> ... After some break on the topic,
> with a fresh eye I see a lot of confusion goes from the notation I've
> chosen initially (because of how I was reasoning about it on paper, w=
hen
> it was in flux) - i.e. xi for x[imin] and also using i as looping
> variable. And also because xi was already used for x[imin] I've used
> another letter 'k' denoting all other x'es, which leads to confusion.=
=2E.
>
>
> I propose we do the following renaming to clarify things:
>
>     A/a     ->      T/t     (to match resulting tree t name in the co=
de)
>     X/x     ->      P/p     (to match parents trees tp in the code)
>     i       ->      imin    (so that i would be free for other tasks)
>
> then the above (with a prologue) would look like
>
> ---- 8< ----
>  *       T     P1       Pn
>  *       -     -        -
>  *      |t|   |p1|     |pn|
>  *      |-|   |--| ... |--|      imin =3D argmin(p1...pn)
>  *      | |   |  |     |  |
>  *      |-|   |--|     |--|
>  *      |.|   |. |     |. |
>  *       .     .        .
>  *       .     .        .
>  *
>  * at any time there could be 3 cases:
>  *
>  *      1)  t < p[imin];
>  *      2)  t > p[imin];
>  *      3)  t =3D p[imin].
>  *
>  * Schematic deduction of what every case means, and what to do, foll=
ows:
>  *
>  * 1)  t < p[imin]  ->  =E2=88=80j t =E2=88=89 Pj  ->  "+t" =E2=88=88=
 D(T,Pj)  ->  D +=3D "+t";  t=E2=86=93
>  *
>  * 2)  t > p[imin]
>  *
>  *     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj=
)  ->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
>  *     2.2) =E2=88=80i  pi =3D p[imin]  ->  pi =E2=88=89 T  ->  "-pi"=
 =E2=88=88 D(T,Pi)  ->  D +=3D "-p[imin]";  =E2=88=80i pi=E2=86=93
>  *
>  * 3)  t =3D p[imin]
>  *
>  *     3.1) =E2=88=83j: pj > p[imin]  ->  "+t" =E2=88=88 D(T,Pj)  -> =
 only pi=3Dp[imin] remains to investigate
>  *     3.2) pi =3D p[imin]  ->  investigate =CE=B4(t,pi)
>  *      |
>  *      |
>  *      v
>  *
>  *     3.1+3.2) looking at =CE=B4(t,pi) =E2=88=80i: pi=3Dp[imin] - if=
 all !=3D =C3=B8  ->
>  *
>  *                       =E2=8E=A7=CE=B4(t,pi)  - if pi=3Dp[imin]
>  *              ->  D +=3D =E2=8E=A8
>  *                       =E2=8E=A9"+t"     - if pi>p[imin]
>  *
>  *
>  *     in any case t=E2=86=93  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
> ...
> now xk is gone and i matches p[i] (=3D pi) etc so variable names corr=
elate
> to algorithm description better.
>
> Does that maybe clarify things?

That sounds more consistent (modulo perhaps s/argmin/min/ at the
beginning?).

> P.S. Sorry for maybe some crept-in mistakes - I've tried to verify it
> thoroughly, but am too sleepy to be completely sure. On the other han=
d I
> think and hope the patch should be ok.

Thanks and do not be sorry for "mistakes"---we have the review
process exactly for catching them.
