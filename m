From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Mon, 12 Nov 2012 19:02:17 -0500
Message-ID: <20121113000217.GH10531@sigill.intra.peff.net>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:02:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3xh-0002K0-2p
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab2KMACW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:02:22 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45235 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab2KMACV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:02:21 -0500
Received: (qmail 16157 invoked by uid 107); 13 Nov 2012 00:03:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 19:03:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 19:02:17 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209550>

On Tue, Nov 13, 2012 at 12:42:02AM +0100, Felipe Contreras wrote:

> > Why not use Git::ident_person() here? It saves some code, and would also
> > respect environment variables. Or better yet...
> 
> I assume there was a reason why that code was asking for input;
> precisely because it would use the environment variables. For some
> reason the user might have exported GIT_AUTHOR_EMAIL, or maybe EMAIL
> is not right, or the full name config.
> 
> OTOH user.name/.email configurations come clearly from the user.

But we use the environment to default the field, so the distinction
doesn't make much sense to me.  Plus, it has always been the case that
you can use git without setting user.*, but instead only using the
environment. I don't see any reason not to follow that principle here,
too.

The one distinction that would make sense to me is pausing to ask when
we use "implicit" methods to look up the ident, like concatenating the
username with the hostname to get the email.

Git::ident uses "git var" to do its lookup, which will use IDENT_STRICT;
that stops most junk like empty names and bogus domains. But I think we
would want to go one step further and actually check
user_ident_sufficiently_given.  Unfortunately, that is not currently
available outside of C. You'd probably want something like:

diff --git a/builtin/var.c b/builtin/var.c
index aedbb53..eaf324e 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -26,6 +26,12 @@ static const char *pager(int flag)
 	return pgm;
 }
 
+static const char *explicit_ident(int flag)
+{
+	git_committer_info(flag);
+	return user_ident_sufficiently_given() ? "1" : "0";
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -35,6 +41,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
 	{ "GIT_PAGER", pager },
+	{ "GIT_EXPLICIT_IDENT", explicit_ident },
 	{ "", NULL },
 };

-Peff
