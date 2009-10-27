From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix memory leak in transport-helper
Date: Tue, 27 Oct 2009 00:55:46 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910270032170.14365@iabervon.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net> <20091015154142.GL10505@spearce.org> <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 05:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2e6j-0000Il-FY
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 05:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbZJ0Ezm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 00:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbZJ0Ezm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 00:55:42 -0400
Received: from iabervon.org ([66.92.72.58]:50139 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbZJ0Ezm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 00:55:42 -0400
Received: (qmail 18210 invoked by uid 1000); 27 Oct 2009 04:55:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2009 04:55:46 -0000
In-Reply-To: <20091015204543.GP10505@spearce.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131311>

On Thu, 15 Oct 2009, Shawn O. Pearce wrote:

> The disconnect_helper function is not prepared to be called twice:
> 
> static int disconnect_helper(struct transport *transport)
> {
> 	struct helper_data *data = transport->data;
> 	if (data->helper) {
> 	...
> 	}
> 	free(data);
> 	return 0;
> }

Actually, my version just leaks transport->data; it looks like the 
"free(data);" line comes from your patch "remote-helpers: Support custom 
transport options". Here's a version (against origin/master) that neither 
leaks memory nor frees too much for disconnecting temporarily. 

commit 8731d804c20828d20130e286f088613b5d33d57a
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Tue Oct 27 00:42:16 2009 -0400

    Fix memory leak in helper method for disconnect.
    
    Since some cases may need to disconnect from the helper and reconnect,
    wrap the function that just disconnects in a function that also frees
    transport->data.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..479539d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -67,6 +67,13 @@ static int disconnect_helper(struct transport *transport)
 	return 0;
 }
 
+static int close_helper(struct transport *transport)
+{
+	disconnect_helper(transport);
+	free(transport->data);
+	return 0;
+}
+
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
@@ -163,6 +170,6 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
-	transport->disconnect = disconnect_helper;
+	transport->disconnect = close_helper;
 	return 0;
 }
