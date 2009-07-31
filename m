From: Johan Herland <johan@herland.net>
Subject: [RFCv2 02/12] Document details of transport function APIs
Date: Fri, 31 Jul 2009 12:00:22 +0200
Message-ID: <1249034432-31437-3-git-send-email-johan@herland.net>
References: <1249034432-31437-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:03:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWox2-0008BK-0I
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZGaKB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZGaKB3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:01:29 -0400
Received: from mx.getmail.no ([84.208.15.66]:61298 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751315AbZGaKB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 06:01:28 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN00B5Q56GZJ70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:28 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN005FA55FU840@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:28 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.31.94825
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1249034432-31437-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124523>

From: Daniel Barkalow <barkalow@iabervon.org>

In particular, explain which of the fields of struct ref is used for
what purpose in the input to and output from each function.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 transport.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/transport.h b/transport.h
index 3cb0abc..b45e6c5 100644
--- a/transport.h
+++ b/transport.h
@@ -18,11 +18,49 @@ struct transport {
 	int (*set_option)(struct transport *connection, const char *name,
 			  const char *value);
 
+	/**
+	 * Returns a list of the remote side's refs. In order to allow
+	 * the transport to try to share connections, for_push is a
+	 * hint as to whether the ultimate operation is a push or a fetch.
+	 *
+	 * If the transport is able to determine the remote hash for
+	 * the ref without a huge amount of effort, it should store it
+	 * in the ref's old_sha1 field; otherwise it should be all 0.
+	 **/
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
+
+	/**
+	 * Fetch the objects for the given refs. Note that this gets
+	 * an array, and should ignore the list structure.
+	 *
+	 * If the transport did not get hashes for refs in
+	 * get_refs_list(), it should set the old_sha1 fields in the
+	 * provided refs now.
+	 **/
 	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+
+	/**
+	 * Push the objects and refs. Send the necessary objects, and
+	 * then tell the remote side to update each ref in the list
+	 * from old_sha1 to new_sha1.
+	 *
+	 * Where possible, set the status for each ref appropriately.
+	 *
+	 * If, in the process, the transport determines that the
+	 * remote side actually responded to the push by updating the
+	 * ref to a different value, the transport should modify the
+	 * new_sha1 in the ref. (Note that this is a matter of the
+	 * remote accepting but rewriting the change, not rejecting it
+	 * and reporting that a different update had already taken
+	 * place)
+	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
+	/** get_refs_list(), fetch(), and push_refs() can keep
+	 * resources (such as a connection) reserved for futher
+	 * use. disconnect() releases these resources.
+	 **/
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
 	signed verbose : 2;
-- 
1.6.4.rc3.138.ga6b98.dirty
