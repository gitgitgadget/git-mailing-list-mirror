From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Add bundle transport
Date: Tue, 17 Jul 2007 23:49:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707172349360.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAvs9-0003xA-6D
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 00:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbXGQWuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756370AbXGQWuQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 18:50:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:42326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757308AbXGQWuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 18:50:15 -0400
Received: (qmail invoked by alias); 17 Jul 2007 22:50:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 18 Jul 2007 00:50:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jEApTPbjjEI0hOP7D96DA97wyAlw6YNszvCiFZv
	mB6I3lKeezqr1a
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52810>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index f444c5b..1532276 100644
--- a/transport.c
+++ b/transport.c
@@ -5,6 +5,7 @@
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "walker.h"
+#include "bundle.h"
 
 /* Generic functions for using commit walkers */
 
@@ -185,7 +186,55 @@ static const struct transport_ops curl_transport = {
 	/* disconnect */	disconnect_walker
 };
 
+struct bundle_transport_data {
+	int fd;
+	struct bundle_header header;
+};
+
+static struct ref *get_refs_from_bundle(const struct transport *transport)
+{
+	struct bundle_transport_data *data = transport->data;
+	struct ref *result = NULL;
+	int i;
+
+	if (data->fd > 0)
+		close(data->fd);
+	data->fd = read_bundle_header(transport->url, &data->header);
+	if (data->fd < 0)
+		die ("Could not read bundle '%s'.", transport->url);
+	for (i = 0; i < data->header.references.nr; i++) {
+		struct ref_list_entry *e = data->header.references.list + i;
+		struct ref *ref = alloc_ref(strlen(e->name));
+		hashcpy(ref->old_sha1, e->sha1);
+		strcpy(ref->name, e->name);
+		ref->next = result;
+		result = ref;
+	}
+	return result;
+}
+
+static int fetch_refs_from_bundle(const struct transport *transport,
+			       int nr_heads, char **heads)
+{
+	struct bundle_transport_data *data = transport->data;
+	return unbundle(&data->header, data->fd);
+}
+
+static int close_bundle(struct transport *transport)
+{
+	struct bundle_transport_data *data = transport->data;
+	if (data->fd > 0)
+		close(data->fd);
+	return 0;
+}
+
 static const struct transport_ops bundle_transport = {
+	/* set_option */	NULL,
+	/* get_refs_list */	get_refs_from_bundle,
+	/* fetch_refs */	fetch_refs_from_bundle,
+	/* fetch_objs */	NULL,
+	/* push */		NULL,
+	/* disconnect */	close_bundle
 };
 
 struct git_transport_data {
@@ -359,8 +408,9 @@ struct transport *transport_get(struct remote *remote, const char *url,
 		else
 			ret->data = NULL;
 	} else if (is_local(url) && is_file(url)) {
+		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret = xmalloc(sizeof(*ret));
-		ret->data = NULL;
+		ret->data = data;
 		ret->ops = &bundle_transport;
 	} else {
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
-- 
1.5.3.rc1.16.g9d6f-dirty
