From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] AIX 5.2 - bug with 1.6.2.1
Date: Tue, 31 Mar 2009 08:29:23 -0400
Message-ID: <20090331122923.GA7173@coredump.intra.peff.net>
References: <3930158b0903301647o790f7381l37ba61089713ce80@mail.gmail.com> <20090331103703.GA1589@coredump.intra.peff.net> <3930158b0903310520h1f421518ka67de5f7aad0690b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Poissinger <pierre.poissinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lod8A-0003in-6S
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 14:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbZCaM3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 08:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbZCaM3g
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 08:29:36 -0400
Received: from peff.net ([208.65.91.99]:39465 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbZCaM3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 08:29:35 -0400
Received: (qmail 10010 invoked by uid 107); 31 Mar 2009 12:29:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 08:29:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 08:29:23 -0400
Content-Disposition: inline
In-Reply-To: <3930158b0903310520h1f421518ka67de5f7aad0690b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115256>

On Tue, Mar 31, 2009 at 02:20:17PM +0200, Pierre Poissinger wrote:

> > =C2=A0#define IS_RUN_COMMAND_ERR(x) ((-x) > ERR_RUN_COMMAND_FORK)
> oops... works for me with
> #define IS_RUN_COMMAND_ERR(x) (-(x) > ERR_RUN_COMMAND_FORK)

Oops, it should actually be "-(x) >=3D ERR_RUN_COMMAND_FORK". But it
shouldn't make a difference in your test, since x was '0' in your case.

Junio, I think this patch should take care of it.

-- >8 --
Subject: [PATCH] fix portability problem with IS_RUN_COMMAND_ERR

Some old versions of gcc don't seem to like us negating an
enum constant. Let's work around it by negating the other
half of the comparison instead.

Reported by Pierre Poissinger on gcc 2.9.
---
 run-command.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.h b/run-command.h
index 15e870a..e345502 100644
--- a/run-command.h
+++ b/run-command.h
@@ -10,7 +10,7 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_SIGNAL,
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
-#define IS_RUN_COMMAND_ERR(x) ((x) <=3D -ERR_RUN_COMMAND_FORK)
+#define IS_RUN_COMMAND_ERR(x) (-(x) >=3D ERR_RUN_COMMAND_FORK)
=20
 struct child_process {
 	const char **argv;
--=20
1.6.2.1.591.geb450
