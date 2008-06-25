From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Ask for "git program" even against git-daemon
Date: Wed, 25 Jun 2008 15:58:43 -0700
Message-ID: <7vr6alw28s.fsf_-_@gitster.siamese.dyndns.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
 <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
 <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBdyc-0000zz-Fq
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYFYW7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755661AbYFYW7I
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 18:59:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbYFYW7G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 18:59:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9129A85C;
	Wed, 25 Jun 2008 18:59:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EAB4DA858; Wed, 25 Jun 2008 18:58:51 -0400 (EDT)
In-Reply-To: <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Wed, 25 Jun 2008 15:55:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4CDF3B76-430A-11DD-862C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86363>

This drops backward compatibility support to ask for "git-program"
form when talking to git-daemon.  Now all git native requests use
"git program" form over ssh, local and git transports.

This needs to be held back until everybody runs git-daemon from 1.5.6.1 or
1.6.0 or newer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * According to the roadmap we exchanged earlier, this should happen in a
   major release (that increments the second dewey-decimal digit from the
   left) that ships at least 6 months after 1.5.6.1 and 1.6.0 (which will
   have the "git daemon preparation" patch included) are released.

 connect.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/connect.c b/connect.c
index 4a32ba4..f2e72c2 100644
--- a/connect.c
+++ b/connect.c
@@ -567,7 +567,6 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * cannot connect.
 		 */
 		char *target_host = xstrdup(host);
-		const char *program_prefix = "";
 
 		if (git_use_proxy(host))
 			git_proxy_connect(fd, host);
@@ -577,13 +576,9 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * Separate original protocol components prog and path
 		 * from extended components with a NUL byte.
 		 */
-		if (!prefixcmp(prog, "git ")) {
-			program_prefix = "git-";
-			prog += 4;
-		}
 		packet_write(fd[1],
-			     "%s%s %s%chost=%s%c",
-			     program_prefix, prog, path, 0,
+			     "%s %s%chost=%s%c",
+			     prog, path, 0,
 			     target_host, 0);
 		free(target_host);
 		free(url);
-- 
1.5.6.86.ge2da6
