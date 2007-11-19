From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon
Date: Mon, 19 Nov 2007 14:23:41 -0800
Message-ID: <7vbq9pnac2.fsf@gitster.siamese.dyndns.org>
References: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Medve Emilian" <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuF2H-0006I2-TQ
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbXKSWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXKSWXr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:23:47 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53437 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbXKSWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:23:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4A8B52F0;
	Mon, 19 Nov 2007 17:24:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EE389793A;
	Mon, 19 Nov 2007 17:24:04 -0500 (EST)
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net>
	(Medve Emilian's message of "Mon, 19 Nov 2007 14:13:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65509>

"Medve Emilian" <Emilian.Medve@freescale.com> writes:

> It seems that something changed since maint/v.1.5.3.6 such that on
> master and next git-daemon doesn't seem to be working anymore in inetd
> mode. Can somebody please confirm this?

Sorry, I cannot quite parse.  Do you mean:

	master and next used to work.  Recently 'maint' was
	merged to them after v1.5.3.6 was cut.  master and next
	does not work anymore after that.

Or do you mean:

	maint (specifically at v1.5.3.6) works, but master and
	next contain more changes on top of them, and they do
	not work.

In either case, the only change to the daemon code between
v1.5.3.5 and master is this one:

commit c67359be45be74e1056d6293c6bb09ee6d00a54a
Author: Gerrit Pape <pape@smarden.org>
Date:   Mon Nov 5 09:16:22 2007 +0000

    git-daemon: fix remote port number in log entry
    
    The port number in struct sockaddr_in needs to be converted from network
    byte order to host byte order (on some architectures).
    
    Signed-off-by: Gerrit Pape <pape@smarden.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 daemon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 660e155..b8df980 100644
--- a/daemon.c
+++ b/daemon.c
@@ -540,7 +540,7 @@ static int execute(struct sockaddr *addr)
 		if (addr->sa_family == AF_INET) {
 			struct sockaddr_in *sin_addr = (void *) addr;
 			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-			port = sin_addr->sin_port;
+			port = ntohs(sin_addr->sin_port);
 #ifndef NO_IPV6
 		} else if (addr && addr->sa_family == AF_INET6) {
 			struct sockaddr_in6 *sin6_addr = (void *) addr;
@@ -550,7 +550,7 @@ static int execute(struct sockaddr *addr)
 			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
 			strcat(buf, "]");
 
-			port = sin6_addr->sin6_port;
+			port = ntohs(sin6_addr->sin6_port);
 #endif
 		}
 		loginfo("Connection from %s:%d", addrbuf, port);

I do not see anything wrong in it.  The "port" variable is very
local to this function and is used only for that loginfo() call
at the end of the context.  So I am quite puzzled.

We have another irrelevant style change that is full of things
like this, but I do not think that makes any behaviour
difference either.

@@ -406,7 +406,8 @@ static struct daemon_service daemon_service[] = {
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
 };
 
-static void enable_service(const char *name, int ena) {
+static void enable_service(const char *name, int ena)
+{
 	int i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
