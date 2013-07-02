From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] CYGWIN: Use a TCP socket for pipe()
Date: Tue, 02 Jul 2013 16:57:21 +0200
Message-ID: <51D2EA51.5000807@web.de>
References: <201306271831.13865.tboegi@web.de> <7vvc4zsbbs.fsf@alter.siamese.dyndns.org> <51CCF91F.7080501@gmail.com> <51D08B58.8000103@web.de> <7vwqpbi4ws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	ramsay@ramsay1.demon.co.uk, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 16:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu21P-0006bd-DT
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 16:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab3GBO53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 10:57:29 -0400
Received: from mout.web.de ([212.227.15.3]:58544 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab3GBO51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 10:57:27 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LoYJu-1UHxAx31FC-00gVCx; Tue, 02 Jul 2013 16:57:22
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vwqpbi4ws.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:wApLmGU7iVP0X6k94DXibtWnuWqLCm+rnCs/BHDgJ6AlkBfzBgq
 vSSTslAcKUwhgMgzIVUwW5GYXFTZEEPhd4Mo+96iYMReG45fjxv3E1AAaESFBAzqmmaUb+S
 U1OE18M54h+yDm0TL32BJF4TbSo9UDFQvGpvk5rkkxq2/z3NhrDzXr065C57F3npQjyMGVc
 mkBGWravZypvD7zEEzWBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229398>

On 2013-07-01 00.56, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> I testet "rj/cygwin-remove-cheating-lstat" with the "socket pipe" on=
 top:
>> no hanging.
>>
>> Then I run "rj/cygwin-remove-cheating-lstat" without "socket pipe",
>> (or in other words git.git/pu):
>> No hanging.
>=20
> So an immediate conclusion is that we can forget about this patch?
Yes
>=20
>> So at the moment I don't have any problems to report for cygwin, whi=
ch is good.
>>
>> And it looks as if "rj/cygwin-remove-cheating-lstat" prevents the "h=
anging",
>> so there is another +1 to keep it and move it into next.
>=20
> Ramsay started a "mark places we call lstat() when we do not really
> need fully correct lstat" topic, and I think it may be a sane
> direction to go, as long as the helper function's semantic is
> clearly defined.
>=20
> It would be worth seeing where it leads us, before ripping that
> "cheating and incomplete lstat out, I think.
I currently run the test suite on it, based on next.
Got one hanging, but of a different kind:
git was running fetch, but the corresponding git-upload-pack.exe was no=
t in the
task list of the windows explorer, but it was in ps under cygwin.


diff --git a/run-command.c b/run-command.c
index aece872..ee588eb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,6 +226,9 @@ static inline void set_cloexec(int fd)
                fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
=20
+#if defined(__CYGWIN__)
+#define wait_or_whine(p, a) (p)
+#else
 static int wait_or_whine(pid_t pid, const char *argv0)
 {
        int status, code =3D -1;
@@ -268,6 +271,7 @@ static int wait_or_whine(pid_t pid, const char *arg=
v0)
        errno =3D failed_errno;
        return code;
 }
+#endif

(And I needed to remove the credential helper tests)

More info later
/Torsten
