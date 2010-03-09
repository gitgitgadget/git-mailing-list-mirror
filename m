From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Portability patches vs 1.7.0.2 [5/6]
Date: Tue, 9 Mar 2010 16:19:06 +0000
Message-ID: <20100309161906.GF99172@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+jhVVhN62yS6hEJ8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 17:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np29L-0004AX-0f
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 17:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab0CIQTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 11:19:08 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:51806 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0CIQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 11:19:07 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 007825CC4
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:38:12 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 007825CC4
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 6F33FD3B
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:19:06 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 69337BAB0; Tue,  9 Mar 2010 16:19:06 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141829>


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

## sockaddr_t->ss_family is not portable

Many of our supported platforms do not have this declaration, for
example solaris2.6 thru 2.8 (I can find a complete list of which of
our supported platforms have this problem).

Normally, I would solve this by importing the relevant modules from
gnulib and linking in the portable equivalent (hence the name of the
patch: gnulib.patch).  But in this case, since git is not built using
Automake, I decided that it would be easier to simply revert the part
of the code that was triggering this problem back to what was used in
git-1.6.6. So that is what this patch represents.

Actually, I'd like some advice on whether this was a good idea?  Was
the change to the code in git-1.7.0 introduced in response to a bug
(latent or reported) that is fixed by the code I reverted in this
patch?  If so, what is the right way to fix it (assuming you don't
want to introduce a dependency on gnulib and Automake into git)?

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)

--+jhVVhN62yS6hEJ8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="gnulib.patch"

Index: daemon.c
===================================================================
--- daemon.c.orig
+++ daemon.c
@@ -588,24 +588,6 @@ static int execute(struct sockaddr *addr
 	return -1;
 }
 
-static int addrcmp(const struct sockaddr_storage *s1,
-    const struct sockaddr_storage *s2)
-{
-	if (s1->ss_family != s2->ss_family)
-		return s1->ss_family - s2->ss_family;
-	if (s1->ss_family == AF_INET)
-		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
-		    &((struct sockaddr_in *)s2)->sin_addr,
-		    sizeof(struct in_addr));
-#ifndef NO_IPV6
-	if (s1->ss_family == AF_INET6)
-		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
-		    &((struct sockaddr_in6 *)s2)->sin6_addr,
-		    sizeof(struct in6_addr));
-#endif
-	return 0;
-}
-
 static int max_connections = 32;
 
 static unsigned int live_children;
@@ -625,7 +607,7 @@ static void add_child(pid_t pid, struct 
 	newborn->pid = pid;
 	memcpy(&newborn->address, addr, addrlen);
 	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-		if (!addrcmp(&(*cradle)->address, &newborn->address))
+		if (!memcmp(&(*cradle)->address, &newborn->address, sizeof(newborn->address)))
 			break;
 	newborn->next = *cradle;
 	*cradle = newborn;
@@ -658,7 +640,7 @@ static void kill_some_child(void)
 		return;
 
 	for (; (next = blanket->next); blanket = next)
-		if (!addrcmp(&blanket->address, &next->address)) {
+		if (!memcmp(&blanket->address, &next->address, sizeof(next->address))) {
 			kill(blanket->pid, SIGTERM);
 			break;
 		}

--+jhVVhN62yS6hEJ8--
