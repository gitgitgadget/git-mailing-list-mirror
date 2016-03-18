From: Jeff King <peff@peff.net>
Subject: [PATCH] credential-cache--daemon: clarify "exit" action semantics
Date: Fri, 18 Mar 2016 02:12:01 -0400
Message-ID: <20160318061201.GA28102@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
 <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
 <20160316171535.GC4039@sigill.intra.peff.net>
 <CAKqreuw7Am_wZQjYYjvsxx0Ccr4OOwoF=EnLvMTK9jxeBUFv5Q@mail.gmail.com>
 <20160318050017.GA22327@sigill.intra.peff.net>
 <CAKqreuywzU2i42WzFCOOZWYfgeLXwQA_Ok1E4rZ94RcEaH_abA@mail.gmail.com>
 <CAKqreuwpjhLnttP4Z_KmYwjiRYxBVC6gLShKLAcjox1VVqfm7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>, git@vger.kernel.org
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:12:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agneY-0007dZ-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbcCRGMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 02:12:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:33924 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756946AbcCRGMG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 02:12:06 -0400
Received: (qmail 18177 invoked by uid 102); 18 Mar 2016 06:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 02:12:04 -0400
Received: (qmail 9186 invoked by uid 107); 18 Mar 2016 06:12:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 02:12:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2016 02:12:01 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuwpjhLnttP4Z_KmYwjiRYxBVC6gLShKLAcjox1VVqfm7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289201>

On Fri, Mar 18, 2016 at 02:02:08PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> I believe git-credential--daemon is a better place to comment on, but
> I'm not sure whether the comment should be included in this patch set=
=2E
> Above all, they are not quite related.

Yes, it could be completely separate from your series.

Here is what I think we should do:

-- >8 --
Subject: credential-cache--daemon: clarify "exit" action semantics

When this code was originally written, there wasn't much
thought given to the timing between a client asking for
"exit", the daemon signaling that the action is done (with
EOF), and the actual cleanup of the socket.

However, we need to care about this so that our test scripts
do not end up racy (e.g., by asking for an exit and checking
that the socket was cleaned up). The code that is already
there happens to behave very reasonably; let's add a comment
to make it clear that any changes should retain the same
behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential-cache--daemon.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index caef21e..291c0fd 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -126,8 +126,17 @@ static void serve_one_client(FILE *in, FILE *out)
 			fprintf(out, "password=3D%s\n", e->item.password);
 		}
 	}
-	else if (!strcmp(action.buf, "exit"))
+	else if (!strcmp(action.buf, "exit")) {
+		/*
+		 * It's important that we clean up our socket first, and then
+		 * signal the client only once we have finished the cleanup.
+		 * Calling exit() directly does this, because we clean up in
+		 * our atexit() handler, and then signal the client when our
+		 * process actually ends, which closes the socket and gives
+		 * them EOF.
+		 */
 		exit(0);
+	}
 	else if (!strcmp(action.buf, "erase"))
 		remove_credential(&c);
 	else if (!strcmp(action.buf, "store")) {
--=20
2.8.0.rc3.378.gf2f7872
