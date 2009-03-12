From: Jeff King <peff@peff.net>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 12:51:53 -0400
Message-ID: <20090312165153.GA28401@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de> <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com> <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302> <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com> <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com> <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl> <20090312153738.GA24690@coredump.intra.peff.net> <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com> <20090312163533.GA28205@coredump.intra.peff.net> <EAF5D3F1-32F2-4BF3-9B10-F91C17D06A6A@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhoA5-0003ic-Ca
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbZCLQwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 12:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbZCLQwD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:52:03 -0400
Received: from peff.net ([208.65.91.99]:51272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbZCLQwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 12:52:01 -0400
Received: (qmail 3054 invoked by uid 107); 12 Mar 2009 16:52:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Mar 2009 12:52:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2009 12:51:53 -0400
Content-Disposition: inline
In-Reply-To: <EAF5D3F1-32F2-4BF3-9B10-F91C17D06A6A@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113090>

On Thu, Mar 12, 2009 at 04:40:10PM +0000, Pieter de Bie wrote:

>> I think the future-proofing is probably not worth the effort.
>> Catching things that are ambiguous _now_ will cover the "oops, I
>> typed the wrong thing" case, which I think is really the issue.
>
> Exactly, that's the common case where things go wrong. I guess using
> dwim_ref should be DWIM enough? :)

Hmm. Yeah, I mispoke before: I should have said dwim_ref instead of
resolve_ref (which doesn't dwym :) ).

Here's a sloppy patch that I think does what you want; but it might make
more sense to just iterate over ref_rev_parse_rules ourselves, as
dwim_ref does more than we care about (and we should probably
differentiate between "a branch already exists" and "this would make an
ambiguous ref").

---
diff --git a/branch.c b/branch.c
index d20fb04..409f445 100644
--- a/branch.c
+++ b/branch.c
@@ -122,6 +122,7 @@ void create_branch(const char *head,
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
 	struct strbuf ref = STRBUF_INIT;
+	char *junk;
 	int forcing = 0;
 	int len;
 
@@ -135,7 +136,8 @@ void create_branch(const char *head,
 	if (check_ref_format(ref.buf))
 		die("'%s' is not a valid branch name.", name);
 
-	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
+	if (dwim_ref(name, strlen(name), sha1, &junk)) {
+		free(junk);
 		if (!force)
 			die("A branch named '%s' already exists.", name);
 		else if (!is_bare_repository() && !strcmp(head, name))
