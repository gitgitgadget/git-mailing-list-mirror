From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Sun, 10 Jun 2012 04:05:16 -0500
Message-ID: <20120610090516.GA30177@burratino>
References: <20111022001704.3115.87464.reportbug@hejmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sde5R-0000c0-C6
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 11:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab2FJJFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 05:05:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56524 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2FJJFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 05:05:24 -0400
Received: by yenm10 with SMTP id m10so2004019yen.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 02:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SCjrZ1CoFzOZTHuMlEiriCkoJbrnhQR7pZHrz3jx9cw=;
        b=eggWa5WMQgOVBiRp9ceoNFiRngshMgrY0VPjSusHH5EzX7swOdG24s7E++nW2sbdbE
         3sQR4MhrtudIUkNVFaU3m1v4Am0ZZybvdBPSJpXEd9ks5No5MDVxNv3HEOIGrKFOzdxL
         rQ7FxZJ41GGw3n/+9yWeqvSeG4cA7wBc5Rz5WLcjFM2wlwP1XbaACWlZVL6gmzBs6DES
         gNnQu8MC1nmV1bQAe1BaFLGzj1ssq8rjkLAgbqNiUlcOPeNzDbl0gLCLP6iRKDKIKiOb
         rtsBGJ/TCmz+1/p4jZV1KsS6X050hriSRP2RgG5XLQzrW6jJTPvGUjKcIehJPnIERUXV
         FDAQ==
Received: by 10.236.73.4 with SMTP id u4mr15313590yhd.78.1339319124072;
        Sun, 10 Jun 2012 02:05:24 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id h3sm19231780anm.20.2012.06.10.02.05.22
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 02:05:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111022001704.3115.87464.reportbug@hejmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199579>

Hi Eduardo,

Eduardo Tr=C3=A1pani wrote[1]:

> git clone ssh://[2001:0:53aa:64c:1845:430c:4179:d71f]:3333/deponejo/u=
nua
>
> Will try to connect to port 22 and not 3333.  The port number seems t=
o be
> ignored.

True.  How about something like this (untested)?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[1] http://bugs.debian.org/646178

 connect.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git i/connect.c w/connect.c
index 912cddee..7ec1b258 100644
--- i/connect.c
+++ w/connect.c
@@ -494,11 +494,19 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
 	if (host[0] =3D=3D '[') {
 		end =3D strchr(host + 1, ']');
 		if (end) {
-			if (protocol !=3D PROTO_GIT) {
+			if (protocol =3D=3D PROTO_GIT)
+				end++;
+			else {
 				*end =3D 0;
 				host++;
+				end++;
+				if (!*end || *end =3D=3D c)
+					; /* good */
+				else if (protocol =3D=3D PROTO_SSH && c !=3D ':' && *end =3D=3D ':=
')
+					port =3D end + 1;
+				else
+					die("garbage after [] string in URL");
 			}
-			end++;
 		} else
 			end =3D host;
 	} else
@@ -535,7 +543,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	/*
 	 * Add support for ssh port: ssh://host.xy:<port>/...
 	 */
-	if (protocol =3D=3D PROTO_SSH && host !=3D url)
+	if (protocol =3D=3D PROTO_SSH && host !=3D url && !port)
 		port =3D get_port(host);
=20
 	if (protocol =3D=3D PROTO_GIT) {
