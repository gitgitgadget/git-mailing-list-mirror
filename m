From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] daemon.c: simplify add_child() and kill_some_child()
 logic
Date: Sun, 24 Aug 2008 13:27:38 -0700
Message-ID: <7vod3ikvk5.fsf_-_@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vd4jymdfn.fsf@gitster.siamese.dyndns.org>
 <7vwsi6kvow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMCh-0001GV-Du
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYHXU1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYHXU1p
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:27:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbYHXU1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:27:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 194C266BD4;
	Sun, 24 Aug 2008 16:27:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C53566BD3; Sun, 24 Aug 2008 16:27:39 -0400 (EDT)
In-Reply-To: <7vwsi6kvow.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Aug 2008 13:24:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B6F22B4-721B-11DD-8A73-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93560>

kill_some_child() function walks the list of connections and kills the
first connection it finds from the same address.  There is not much point
to find the existing connection from the same address in add_child() to
insert the new one in front of it.  At the front of the whole queue is
just as good.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 daemon.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index 35bd34a..8d2755a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -596,18 +596,18 @@ static struct child {
 
 static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
 {
-	struct child *newborn, **cradle;
-	newborn = xcalloc(1, sizeof(*newborn));
+	struct child *newborn;
 
+	/*
+	 * This must be xcalloc() -- we'll compare the whole sockaddr_storage
+	 * later in kill_some_child().
+	 */
+	newborn = xcalloc(1, sizeof(*newborn));
 	live_children++;
 	newborn->pid = pid;
 	memcpy(&newborn->address, addr, addrlen);
-	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-		if (!memcmp(&(*cradle)->address, &newborn->address,
-			    sizeof(newborn->address)))
-			break;
-	newborn->next = *cradle;
-	*cradle = newborn;
+	newborn->next = firstborn;
+	firstborn = newborn;
 }
 
 static void remove_child(pid_t pid)
@@ -627,7 +627,8 @@ static void remove_child(pid_t pid)
  * This gets called if the number of connections grows
  * past "max_connections".
  *
- * We kill the newest connection from a duplicate IP.
+ * We kill the newest connection from the same address (add_child() queues
+ * new ones at the front).
  */
 static void kill_some_child(void)
 {
-- 
1.6.0.129.ge10d2
