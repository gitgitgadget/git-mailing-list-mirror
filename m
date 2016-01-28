From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] pass transport verbosity down to git_connect
Date: Thu, 28 Jan 2016 22:51:23 +0000
Message-ID: <20160128225123.GA20045@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:51:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOvPn-0008CG-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 23:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbcA1Wv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 17:51:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51757 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438AbcA1WvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 17:51:24 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736AE1F736;
	Thu, 28 Jan 2016 22:51:23 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285041>

While working in connect.c to perform non-blocking connections,
I noticed calling "git fetch -v" was not causing the progress
messages inside git_tcp_connect_sock to be emitted as I
expected.

Looking at history, it seems connect_setup has never been called
with the verbose parameter.  Since transport already has a
"verbose" field, use that field instead of another parameter
in connect_setup.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Related, but independent of my other change to connect.c:
  http://mid.gmane.org/20160128115720.GA1827@dcvr.yhbt.net
  ("attempt connects in parallel for IPv6-capable builds")

 transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/transport.c b/transport.c
index 67f3666..9ae7184 100644
--- a/transport.c
+++ b/transport.c
@@ -481,9 +481,10 @@ static int set_git_option(struct git_transport_options *opts,
 	return 1;
 }
 
-static int connect_setup(struct transport *transport, int for_push, int verbose)
+static int connect_setup(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
+	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
 
 	if (data->conn)
 		return 0;
@@ -491,7 +492,7 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
-				 verbose ? CONNECT_VERBOSE : 0);
+				 flags);
 
 	return 0;
 }
@@ -501,7 +502,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
 
-	connect_setup(transport, for_push, 0);
+	connect_setup(transport, for_push);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
 			 for_push ? REF_NORMAL : 0,
 			 &data->extra_have,
@@ -536,7 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 
 	if (!data->got_remote_heads) {
-		connect_setup(transport, 0, 0);
+		connect_setup(transport, 0);
 		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
 				 NULL, &data->shallow);
 		data->got_remote_heads = 1;
@@ -812,7 +813,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	if (!data->got_remote_heads) {
 		struct ref *tmp_refs;
-		connect_setup(transport, 1, 0);
+		connect_setup(transport, 1);
 
 		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
 				 NULL, &data->shallow);
-- 
EW
