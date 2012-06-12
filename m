From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Tue, 12 Jun 2012 20:46:56 +0200
Message-ID: <4FD78EA0.2090306@lsrfire.ath.cx>
References: <20111022001704.3115.87464.reportbug@hejmo> <20120610090516.GA30177@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RWR1YXJkbyBUcsOhcGFuaQ==?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:47:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeW7o-0003Ab-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2FLSr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 14:47:29 -0400
Received: from india601.server4you.de ([85.25.151.105]:58151 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab2FLSr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 14:47:28 -0400
Received: from [192.168.2.105] (p4FFDAF57.dip.t-dialin.net [79.253.175.87])
	by india601.server4you.de (Postfix) with ESMTPSA id 015342F8061;
	Tue, 12 Jun 2012 20:47:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120610090516.GA30177@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199831>

Am 10.06.2012 11:05, schrieb Jonathan Nieder:
> Hi Eduardo,
>=20
> Eduardo Tr=C3=A1pani wrote[1]:
>=20
>> git clone ssh://[2001:0:53aa:64c:1845:430c:4179:d71f]:3333/deponejo/=
unua
>>
>> Will try to connect to port 22 and not 3333.  The port number seems =
to be
>> ignored.
>=20
> True.  How about something like this (untested)?
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> [1] http://bugs.debian.org/646178
>=20
>   connect.c |   14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)

How about this instead?  Except perhaps with a commit message that is v=
aguely
understandable?

-- >8 --
If we encounter an address part shaped like "[HOST]:PORT", we skip the =
opening
bracket and replace the closing one with a NUL.  The variable host then=
 points
to HOST and we've cut off the PORT part.  Thus, when we go looking for =
it using
host a bit later, we can't find it.  Start at end instead, which either=
 points
to the colon, if present, or is equal to host.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
We have similar code in daemon.c.  Can we share more?  And make it test=
able?

 connect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 912cdde..41b7400 100644
--- a/connect.c
+++ b/connect.c
@@ -536,7 +536,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	 * Add support for ssh port: ssh://host.xy:<port>/...
 	 */
 	if (protocol =3D=3D PROTO_SSH && host !=3D url)
-		port =3D get_port(host);
+		port =3D get_port(end);
=20
 	if (protocol =3D=3D PROTO_GIT) {
 		/* These underlying connection commands die() if they
--=20
1.7.10.2
