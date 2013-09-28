From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] clone: tighten "local paths with colons" check a bit
Date: Sat, 28 Sep 2013 15:14:42 +0200
Message-ID: <5246D642.7060203@web.de>
References: <1380289693-593-1-git-send-email-pclouds@gmail.com> <20130927215631.GN9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Morten Stenshorne <mstensho@opera.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTg==?= =?UTF-8?B?Z+G7jWMgRHV5?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 15:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPuMF-0004Lo-5z
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 15:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab3I1NOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Sep 2013 09:14:47 -0400
Received: from mout.web.de ([212.227.15.4]:53156 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab3I1NOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 09:14:45 -0400
Received: from [192.168.37.101] ([87.146.140.158]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MK1s1-1VP50g0cE9-001Uvb for <git@vger.kernel.org>;
 Sat, 28 Sep 2013 15:14:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20130927215631.GN9464@google.com>
X-Provags-ID: V03:K0:KvfHmfgZgubGDFxr3YMd6Lo5vMKTFueX7k3DHlM3n9MLOP47La+
 it5wTuVFPgqqTBhtHvW3HVWiBC+aAZNIfVIHgYI3WASc73bJJA9t1bQcF+4eoBscrcPDR5D
 NpVvHROjoZ2vqOjQgrtLti5cdOJE5/nyeRG6p3mIDU2dvTCmDz937W2DtMHUammeAFZTUAR
 RCyE2CnDq6jBukD4p6D2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235503>

On 2013-09-27 23.56, Jonathan Nieder wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>=20
>> commit 6000334 (clone: allow cloning local paths with colons in them=
 -
>> 2013-05-04) is added to make it possible to specify a path that has
>> colons in it without file://, e.g. ../foo:bar/somewhere. But the che=
ck
>> is a bit loose.
> [...]
>> Make sure we only check so when no protocol is specified and the url
>> is not started with '['.
>=20
> More precisely, this disables the "'/' before ':'" check when the
> url has been mangled by '[]' unwrapping (which only happens if the
> URL starts with '[' and contains an ']' at some point later).
>=20
> If I try to clone "[foo]bar/baz:qux", after this change it will act a=
s
> though I specified the remote repository "foo:qux" instead of the loc=
al
> repository "./foo:qux" as before this change.  Both are wrong ---
> that's a bug for another day.
(Loud thinking)
Could it make sense to disable the SSH autodection logic
whenever the url starts with '.' (like in "../XX.git")=20
or with "/" like in /home/USER/projects/XX.git ?

diff --git a/connect.c b/connect.c
index a80ebd3..b382032 100644
--- a/connect.c
+++ b/connect.c
@@ -550,7 +550,8 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
                end =3D host;
=20
        path =3D strchr(end, c);
-       if (path && !has_dos_drive_prefix(end)) {
+       if (path && !has_dos_drive_prefix(end) &&
+           url[0] !=3D '/' && url[0] !=3D '.' ) {
                if (c =3D=3D ':') {
                        if (path < strchrnul(host, '/')) {
                                protocol =3D PROTO_SSH;
