From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] format-patch: Make sure the subject is always a one-liner
Date: Wed, 16 Apr 2008 03:06:05 +0200
Message-ID: <20080416010605.GG8387@genesis.frugalware.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <m3ej97rmc0.fsf@localhost.localdomain> <20080416003725.GF8387@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:31:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlw6z-0008L2-7b
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 03:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYDPBGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 21:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYDPBGK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 21:06:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34591 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbYDPBGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 21:06:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 111D21B24F0;
	Wed, 16 Apr 2008 03:06:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 36D1B44659;
	Wed, 16 Apr 2008 03:02:40 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C4AF511904E0; Wed, 16 Apr 2008 03:06:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080416003725.GF8387@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79663>

If the commit message has no empty line after the first line, we need to
insert a newline after the first, so that the newlines won't be removed
from the commit message for example when they are applied using git-am.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Apr 16, 2008 at 02:37:25AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> If we are at it, I had a similar bugreport: If one doesn't use an
> empty
> line after the first line in the commit message, a git-format-patch +
> git-am combo will strip newlines from the commit message:
>
> http://article.gmane.org/gmane.comp.version-control.git/73755
>
> There, you suggested to modify git-format-patch, but I haven't come up
> with such a patch nor anybody else.
>
> Actually I recently tried to make one but I got lost in pretty.c and
> log-tree.c. :-)

Ok, here is a try. It does the trick for me, but this it the first time
I touch pretty.c so feel free to point out if I did something wrong ;-)

Thanks.

 pretty.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6c04176..45a5679 100644
--- a/pretty.c
+++ b/pretty.c
@@ -653,6 +653,7 @@ void pp_title_line(enum cmit_fmt fmt,
 
 	strbuf_init(&title, 80);
 
+	int check_empty = 1;
 	for (;;) {
 		const char *line = *msg_p;
 		int linelen = get_one_line(line);
@@ -666,7 +667,10 @@ void pp_title_line(enum cmit_fmt fmt,
 			if (fmt == CMIT_FMT_EMAIL) {
 				strbuf_addch(&title, '\n');
 			}
-			strbuf_addch(&title, ' ');
+			if (check_empty && strcmp(line, "\n")) {
+				check_empty = 0;
+				strbuf_addch(&title, '\n');
+			}
 		}
 		strbuf_add(&title, line, linelen);
 	}
-- 
1.5.5
