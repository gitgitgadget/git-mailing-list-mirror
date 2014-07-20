From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Sun, 20 Jul 2014 10:00:41 +0200
Message-ID: <53CB7729.40101@web.de>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com> <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com> <53CB0D81.1070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 20 10:01:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8m3v-000794-2r
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 10:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbaGTIBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 04:01:34 -0400
Received: from mout.web.de ([212.227.15.4]:58202 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbaGTIBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 04:01:33 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MfYTr-1WsTBO1cux-00P6E1; Sun, 20 Jul 2014 10:01:01
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CB0D81.1070404@gmail.com>
X-Provags-ID: V03:K0:WdWRpoOA4z4CcMJ7SEpYEebrMGgb0xfvOXKydQKO9l0voJJXoa7
 Jp5WPjPp7EWMfBCJOLmv9PuxoF+Lx2WG7a3qPuFS2SELO6GFchJBGfgaz0STBELRaVF/aIw
 ORGt1WeOUaOPi8RCSHWZraRrTwcKvh+lSRa5utZ+Gea7NUk3Hoibb6cvejm18UOwVA2ensO
 Mzm25G24zNRcnU8rUnCGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253913>

Am 20.07.2014 02:29, schrieb Karsten Blees:
> unix-socket.c: This looks pretty broken. The cd / cd back logic is only
> ever used if the socket path is too long. In this case, after cd'ing to
> the parent directory of the socket, unix_stream_listen tries to unlink
> the *original* socket path, instead of the remaining socket basename in
> sockaddr_un.sun_path. I.e. the subsequent bind() will fail on second
> invocation of the credential daemon.

-- >8 --
Subject: [PATCH] unix-socket: remove stale socket before calling chdir()

unix_stream_listen() is given a path.  It calls unix_sockaddr_init(),
which in turn can call chdir().  After that a relative path doesn't
mean the same as before.  Any use of the original path should thus
happen before that call.  For that reason, unlink the given path
(to get rid of a possibly existing stale socket) right at the
beginning of the function.

Noticed-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 unix-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unix-socket.c b/unix-socket.c
index 01f119f..91bd6b8 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -99,11 +99,12 @@ int unix_stream_listen(const char *path)
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
+	unlink(path);
+
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
 	fd = unix_stream_socket();
 
-	unlink(path);
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
 
-- 
2.0.2
