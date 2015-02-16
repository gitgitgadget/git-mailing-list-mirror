From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Mon, 16 Feb 2015 19:23:02 +0100
Message-ID: <vpqtwyl90mx.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fairuzan Roslan <fairuzan.roslan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:24:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQLG-0002lG-EC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbbBPSXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 13:23:48 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33688 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbbBPSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:23:28 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1GIN0Yo029353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Feb 2015 19:23:00 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1GIN2Fn009655;
	Mon, 16 Feb 2015 19:23:02 +0100
In-Reply-To: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> (Fairuzan
	Roslan's message of "Tue, 17 Feb 2015 01:54:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Feb 2015 19:23:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1GIN0Yo029353
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424715782.18159@J4acxKhIzvYxIcIGJmk9Ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263910>

=46airuzan Roslan <fairuzan.roslan@gmail.com> writes:

> Hi,
>
> Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp (envi=
ronment.c) are
> causing a lot of issues (unable to unlink/write/rename) to those
> people who use AFP shares.

Is it a problem when using Git (like "git gc" failing to remove old
packs), or when trying to remove files outside Git?

> The issue was first introduced in
> https://github.com/git/git/blob/f80c7ae8fe9c0f3ce93c96a2dccaba34e456e=
33a/wrapper.c
> line 284.

I don't think so. The code before this commit did essentially a chmod
444 on the file, so object files were already read-only before.

The pack files have been read-only since d83c9af5c6a437ddaa9dd27 (Junio=
,
Apr 22 2007).

> To fix these issues the permission need to be adjusted to =E2=80=9Cin=
t mode =3D
> 0644;=E2=80=9D in odb_mkstemp (environment.c)

The issue is that having object and pack files read-only on the
filesystem is a safety feature to prevent accidental modifications (eve=
n
though it's actually not that effective, since brute-force "sed -i" or
"perl -i" still accept to modify read-only files).

So, I'd be a bit reluctant to remove this safety feature for all users
if it's only for the benefit of a minority of users. Not that I think
the problem shouldn't be fixed, but I'd rather investigate alternate
solutions before using this mode =3D 0644.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
