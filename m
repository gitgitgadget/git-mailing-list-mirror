From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse-options: fix parsing of "--foobar=" with no value
Date: Tue, 22 Jul 2008 16:09:11 -0400
Message-ID: <20080722200911.GA3097@sigill.intra.peff.net>
References: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr> <20080722185427.GA10453@artemis.madism.org> <48863436.50309@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOBb-0007OY-Mk
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbYGVUJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYGVUJP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:09:15 -0400
Received: from peff.net ([208.65.91.99]:3679 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbYGVUJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:09:14 -0400
Received: (qmail 8317 invoked by uid 111); 22 Jul 2008 20:09:13 -0000
Received: from lawn-128-61-16-226.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.16.226)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 16:09:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 16:09:11 -0400
Content-Disposition: inline
In-Reply-To: <48863436.50309@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89519>

On Tue, Jul 22, 2008 at 09:25:42PM +0200, Olivier Marin wrote:

> I found the "random bug" while migrating "git init" to parse-options. I
> think you can reproduce it with:
> 
> $ git clone --template= <repo>
> error: ignoring template /var/run/synaptic.socket
> fatal: cannot opendir /var/run/sudo
> 
> But now, it appears the problem is not in parse-options, sorry.

Yes, the problem is that copy_templates in builtin-init-db.c is totally
broken for an empty template name. It writes past the beginning of the
string, and then starts copying at "/". Oops.

Maybe something like this is better? It should define --template= to
mean "don't copy any templates" (and I haven't tested it at all).

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 38b4fcb..baf0d09 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -117,6 +117,8 @@ static void copy_templates(const char *template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
+	if (!template_dir[0])
+		return;
 	strcpy(template_path, template_dir);
 	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
