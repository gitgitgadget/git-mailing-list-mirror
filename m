From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] daemon.c: make sure kill_some_child() really kills
 somebody
Date: Sun, 24 Aug 2008 13:33:11 -0700
Message-ID: <7vk5e6kvaw.fsf_-_@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vd4jymdfn.fsf@gitster.siamese.dyndns.org>
 <7vwsi6kvow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMIm-0002aP-4e
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYHXUdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYHXUdT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:33:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYHXUdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:33:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F261266C21;
	Sun, 24 Aug 2008 16:33:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C4D8D66C1F; Sun, 24 Aug 2008 16:33:13 -0400 (EDT)
In-Reply-To: <7vwsi6kvow.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Aug 2008 13:24:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2729896-721B-11DD-9435-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93561>

We used to kill nobody if there is no existing connection from the same
address the new connection we are trying to handle, and dropped the new
connection.  Make sure we at least kill one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I am not sure about this one, but it may be more in spirit with the old
   behaviour that made sure at max connection limit we killed some to
   handle new ones.

   Actually I do think this is probably a bad idea.  What we really want
   to do is to detect an old one that is not making any progress instead.
   "old" we can detect by looking at its position in the queue (or we
   could even add an explicit timestamp to the child structure), but it is
   harder to measure "not making any progress", especially without going
   too platform specific, e.g. monitoring rusage or somesuch, which we
   would want to avoid.

 daemon.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 8d2755a..a0d8f65 100644
--- a/daemon.c
+++ b/daemon.c
@@ -641,8 +641,11 @@ static void kill_some_child(void)
 		if (!memcmp(&blanket->address, &next->address,
 			    sizeof(next->address))) {
 			kill(blanket->pid, SIGTERM);
-			break;
+			return;
 		}
+
+	/* Nobody from the same address?  Kill the youngest one, then. */
+	kill(firstborn->pid, SIGTERM);
 }
 
 static void check_dead_children(void)
-- 
1.6.0.129.ge10d2
