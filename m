From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Bug: pull --rebase with =?utf-8?Q?=C3=A9?= in name
Date: Mon, 5 Mar 2012 14:40:34 +0100
Message-ID: <87r4x7jhd9.fsf@thomas.inf.ethz.ch>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
	<20120305102657.GB29061@sigill.intra.peff.net>
	<87399nqqog.fsf@thomas.inf.ethz.ch>
	<F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
	<20120305115815.GA4550@sigill.intra.peff.net>
	<0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
	<87ipijkxlm.fsf@thomas.inf.ethz.ch>
	<20120305132913.GA15004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Haber <rene@habr.de>, <git@vger.kernel.org>,
	Will Palmer <wmpalmer@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 14:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Y9g-0006T9-03
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 14:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab2CENki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 08:40:38 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15233 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932326Ab2CENkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 08:40:37 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 14:40:35 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 14:40:34 +0100
In-Reply-To: <20120305132913.GA15004@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 5 Mar 2012 08:29:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192237>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 05, 2012 at 02:04:37PM +0100, Thomas Rast wrote:
>
>> Ren=C3=A9 Haber <rene@habr.de> writes:
>>=20
>> > sh -c '                                  =20
>> >    . /sw/lib/git-core/git-sh-setup
>> >     get_author_ident_from_commit 16b94413cbce12531e8f9462868515984=
49d3913
>> >  '
>> > GIT_AUTHOR_NAME=3D'Ren'=C3=A9 Haber
>> > GIT_AUTHOR_EMAIL=3D'rene@habr.de'
>> > GIT_AUTHOR_DATE=3D'@1329212923 +0100'
>> [...]
>> That is, the garbage (if you try to read it as UTF-8) in the printf
>> string was matched and replaced byte-by-byte with 'x'.  However,
>> Will was getting the unreplaced results
>>=20
>>   0000000: f89d 849e 0a                             .....
>>=20
>> I'm not sure he has followed up on that problem; the only hope may b=
e to
>> get a better 'sed'.
[...]
> It would be nice if the --pretty format placeholders had a "shell-quo=
te"
> modifier, and we could just do:
>
>   git show --format=3D'GIT_AUTHOR_NAME=3D%(an:shell)'
>
> or something similar. for-each-ref knows about shell-quoting, but we
> can't use it here, because we are looking at arbitrary commits, not j=
ust
> ones pointed to by refs.

Perhaps by using %an etc., line numbers and --sq-quote:

  $ git rev-list --no-walk --date=3Draw --format=3D"%an%n%ae%n%ad" --en=
coding=3DUTF-8 HEAD |
    while read -r s; do git rev-parse --sq-quote "$s"; done |
    sed -n -e '2s/^ /GIT_AUTHOR_NAME=3D/p' -e '3s/^ /GIT_AUTHOR_EMAIL=3D=
/p' -e '4s/^ /GIT_AUTHOR_DATE=3D/p'
  GIT_AUTHOR_NAME=3D'Thom'\''as R=C3=A0st'
  GIT_AUTHOR_EMAIL=3D'trast@inf.ethz.ch'
  GIT_AUTHOR_DATE=3D'1330935546 +0100'

This is for a commit where I deliberately mangled my author line to mak=
e
an interesting example, as in

  $ git cat-file commit HEAD | grep ^author
  author Thom'as R=C3=A0st <trast@inf.ethz.ch> 1330935546 +0100

I tried doing the quoting inside sed instead of the while...rev-parse
--sq-quote, but it made my head hurt.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
