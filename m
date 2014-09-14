From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 2/3] make update-server-info more robust
Date: Sun, 14 Sep 2014 19:38:17 +0200
Message-ID: <5415D289.9080507@web.de>
References: <20140913201538.GA24854@peff.net> <20140913201920.GB27082@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 19:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTDlV-0005Rf-NK
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 19:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaINRjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2014 13:39:04 -0400
Received: from mout.web.de ([212.227.17.12]:51448 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbaINRjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 13:39:03 -0400
Received: from [192.168.178.27] ([79.253.153.35]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MHXxg-1XUKlB3D80-003Okj; Sun, 14 Sep 2014 19:38:57
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20140913201920.GB27082@peff.net>
X-Provags-ID: V03:K0:QC0rDx5JLCKpxzqKzmWHYoXunnN4L2WotezOA0j3kGLNY8Sp5wq
 ZvoTm3h259nRLr0M5YwxzVaaRGmxURyr9q34pfe8qUi7EpLhnFIpTfAAjwnr4iMwV1hg0MG
 mJ27PyZRp1bUhoZelmhM3zmdj1m/P6NYLSDVaDQw47Uikzkt9GkwgJkli2RK6PNpMtlub+M
 BXetkoplHPw5jZXXCaHNw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257021>

Am 13.09.2014 um 22:19 schrieb Jeff King:
> Since "git update-server-info" may be called automatically
> as part of a push or a "gc --auto", we should be robust
> against two processes trying to update it simultaneously.
> However, we currently use a fixed tempfile, which means that
> two simultaneous writers may step on each other's toes and
> end up renaming junk into place.
>=20
> Let's instead switch to using a unique tempfile via mkstemp.
> We do not want to use a lockfile here, because it's OK for
> two writers to simultaneously update (one will "win" the
> rename race, but that's OK; they should be writing the same
> information).
>=20
> While we're there, let's clean up a few other things:
>=20
>    1. Detect write errors. Report them and abort the update
>       if any are found.
>=20
>    2. Free path memory rather than leaking it (and clean up
>       the tempfile when necessary).
>=20
>    3. Use the pathdup functions consistently rather than
>       static buffers or manually calculated lengths.
>=20
> This last one fixes a potential overflow of "infofile" in
> update_info_packs (e.g., by putting large junk into
> $GIT_OBJECT_DIRECTORY). However, this overflow was probably
> not an interesting attack vector for two reasons:
>=20
>    a. The attacker would need to control the environment to
>       do this, in which case it was already game-over.
>=20
>    b. During its setup phase, git checks that the directory
>       actually exists, which means it is probably shorter
>       than PATH_MAX anyway.
>=20
> Because both update_info_refs and update_info_packs share
> these same failings (and largely duplicate each other), this
> patch factors out the improved error-checking version into a
> helper function.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess point (b) may not apply on systems that have a really small
> PATH_MAX that does not reflect what you can actually create in the
> filesystem (Windows?).

It's the other way around: PATH_MAX is an actual limit basically only
on Windows [1] unless you avoid using the Windows API [2].

Regardless of the security implications, getting rid of more PATH_MAX
buffers is a good move.

And I looked only briefly at your patch, but I like the three bullet
points above. :)

Ren=C3=A9


[1] http://insanecoding.blogspot.de/2007/11/pathmax-simply-isnt.html
[2] http://msdn.microsoft.com/en-us/library/windows/desktop/aa365247(v=3D=
vs.85).aspx
