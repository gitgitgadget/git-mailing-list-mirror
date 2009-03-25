From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/5] Document details of transport function APIs
Date: Tue, 24 Mar 2009 23:04:10 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242303250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJRC-00061j-0o
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945AbZCYDEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbZCYDEP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:04:15 -0400
Received: from iabervon.org ([66.92.72.58]:43754 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbZCYDEN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:04:13 -0400
Received: (qmail 11070 invoked by uid 1000); 25 Mar 2009 03:04:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:04:10 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114548>

In particular, explain which of the fields of struct ref is used for
what purpose in the input to and output from each function.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 transport.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/transport.h b/transport.h
index 489e96a..2e1650a 100644
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
1.6.2.1.476.g9bf04b
