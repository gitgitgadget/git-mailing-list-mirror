From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: match explicit-ident semantics for summary and
 template
Date: Sun, 17 Jan 2010 16:00:38 -0500
Message-ID: <20100117210038.GA3935@coredump.intra.peff.net>
References: <20100117193401.GA28448@coredump.intra.peff.net>
 <201001172153.44413.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 17 22:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcEp-0005Wb-I1
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab0AQVAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713Ab0AQVAo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:00:44 -0500
Received: from peff.net ([208.65.91.99]:56281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689Ab0AQVAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 16:00:43 -0500
Received: (qmail 29358 invoked by uid 107); 17 Jan 2010 21:05:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 16:05:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 16:00:38 -0500
Content-Disposition: inline
In-Reply-To: <201001172153.44413.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137321>

On Sun, Jan 17, 2010 at 09:53:44PM +0100, Johannes Sixt wrote:

> On Sonntag, 17. Januar 2010, Jeff King wrote:
> > -	if (!user_ident_explicitly_given) {
> > +	if (user_ident_explicitly_given != IDENT_ALL_GIVEN) {
> >  		strbuf_addstr(&format, "\n Committer: ");
> 
> Sorry for chiming in so late, but this new condition worries me a bit. On all 
> of my machines I have the GECOS field filled in with "Johannes Sixt", i.e., I 
> do not need user.name. But of course the automatically derived email address 
> is nonsense, so I've set up only user.email. Now I would always this hint, 
> wouldn't I? Do most others fill in GECOS in ways that are inappropriate for 
> git?

Yes, you are correctly analyzing the situation. I don't personally have
a preference (even though my GECOS field is correct, it always seemed
sensible to me to just explicitly set user.name along with user.email.
But presumably a user who has set one is clueful enough to know whether
they need to set the other one, too).

I do, however, think the summary behavior should match the behavior for
the commit message template, which was actually changed in 91c38a21.
Either this patch should be applied, or the other behavior should be
tweaked as below:

diff --git a/builtin-commit.c b/builtin-commit.c
index d4eef6d..ec1415e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -656,7 +656,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				author_ident);
 		free(author_ident);
 
-		if (user_ident_explicitly_given != IDENT_ALL_GIVEN)
+		if (!user_ident_explicitly_given)
 			fprintf(fp,
 				"%s"
 				"# Committer: %s\n",
