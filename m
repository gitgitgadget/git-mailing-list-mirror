From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Clean up connection correctly if object fetch wasn't done
Date: Sat, 26 Jan 2008 16:49:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801261647310.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 26 22:50:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIsuT-0000gv-GO
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 22:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYAZVt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 16:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754354AbYAZVt1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 16:49:27 -0500
Received: from iabervon.org ([66.92.72.58]:56709 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058AbYAZVt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 16:49:26 -0500
Received: (qmail 31852 invoked by uid 1000); 26 Jan 2008 21:49:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2008 21:49:25 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71791>

Further optimization allowed the fetch_objs call to be skipped if it
isn't necessary. However, this leaves the connection in need of
cleaning up to avoid getting an error message from the remote end when
ssh is used. Fix this.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This fixes the "fatal: The remote end hung up unexpectedly" message in the 
case I reproduced. It should probably get squashed into the other 
single-connect commit, but I'm sending it separately for easier testing 
for now.

 builtin-fetch.c |    2 ++
 transport.c     |   10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 320e235..ac335f2 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -557,6 +557,8 @@ static int do_fetch(struct transport *transport,
 
 	free_refs(fetch_map);
 
+	transport_disconnect(transport);
+
 	return 0;
 }
 
diff --git a/transport.c b/transport.c
index 53fb2ec..199e9e6 100644
--- a/transport.c
+++ b/transport.c
@@ -677,7 +677,15 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 
 static int disconnect_git(struct transport *transport)
 {
-	free(transport->data);
+	struct git_transport_data *data = transport->data;
+	if (data->conn) {
+		packet_flush(data->fd[1]);
+		close(data->fd[0]);
+		close(data->fd[1]);
+		finish_connect(data->conn);
+	}
+
+	free(data);
 	return 0;
 }
 
-- 
1.5.4.rc3.4.g16335
