From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] Add for_each_remote() function, and extend
 remote_find_tracking()
Date: Tue, 10 Jul 2007 18:48:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101848050.4047@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707100401070.4131@racer.site>
 <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Jws-0005zA-HY
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759068AbXGJR41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759053AbXGJR41
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:56:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:38686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758996AbXGJR40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 13:56:26 -0400
Received: (qmail invoked by alias); 10 Jul 2007 17:56:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 10 Jul 2007 19:56:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9Eyo6x6K93wp4d1OM1GUXZ6NGYX6fEJH7/1+em4
	bRnsM2qe1VfRgz
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52100>


The function for_each_remote() does exactly what the name suggests.

The function remote_find_tracking() was extended to be able to search
remote refs for a given local ref.  You have to set the parameter
"reverse" to true for that behavior.

Both changes are required for the next step: simplification of
git-branch's --track functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Thanks, Daniel and Junio, for your suggestions.

 remote.c    |   60 ++++++++++++++++++++++++++++++++++++++++++++--------------
 remote.h    |    5 +++-
 send-pack.c |    4 +-
 3 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/remote.c b/remote.c
index 09c4279..bb774d0 100644
--- a/remote.c
+++ b/remote.c
@@ -279,6 +279,25 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+int for_each_remote(each_remote_fn fn, void *priv)
+{
+	int i, result = 0;
+	read_config();
+	for (i = 0; i < allocated_remotes && !result; i++) {
+		struct remote *r = remotes[i];
+		if (!r)
+			continue;
+		if (!r->fetch)
+			r->fetch = parse_ref_spec(r->fetch_refspec_nr,
+					r->fetch_refspec);
+		if (!r->push)
+			r->push = parse_ref_spec(r->push_refspec_nr,
+					r->push_refspec);
+		result = fn(r, priv);
+	}
+	return result;
+}
+
 int remote_has_uri(struct remote *remote, const char *uri)
 {
 	int i;
@@ -291,32 +310,43 @@ int remote_has_uri(struct remote *remote, const char *uri)
 
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
+	int find_src = refspec->src == NULL;
+	char *needle, **result;
 	int i;
+
+	if (find_src) {
+		if (refspec->dst == NULL)
+			return error("find_tracking: need either src or dst");
+		needle = refspec->dst;
+		result = &refspec->src;
+	} else {
+		needle = refspec->src;
+		result = &refspec->dst;
+	}
+
 	for (i = 0; i < remote->fetch_refspec_nr; i++) {
 		struct refspec *fetch = &remote->fetch[i];
+		const char *key = find_src ? fetch->dst : fetch->src;
+		const char *value = find_src ? fetch->src : fetch->dst;
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
-			if (!prefixcmp(refspec->src, fetch->src)) {
-				refspec->dst =
-					xmalloc(strlen(fetch->dst) +
-						strlen(refspec->src) -
-						strlen(fetch->src) + 1);
-				strcpy(refspec->dst, fetch->dst);
-				strcpy(refspec->dst + strlen(fetch->dst),
-				       refspec->src + strlen(fetch->src));
-				refspec->force = fetch->force;
-				return 0;
-			}
-		} else {
-			if (!strcmp(refspec->src, fetch->src)) {
-				refspec->dst = xstrdup(fetch->dst);
+			if (!prefixcmp(needle, key)) {
+				*result = xmalloc(strlen(value) +
+						  strlen(needle) -
+						  strlen(key) + 1);
+				strcpy(*result, value);
+				strcpy(*result + strlen(value),
+				       needle + strlen(key));
 				refspec->force = fetch->force;
 				return 0;
 			}
+		} else if (!strcmp(needle, key)) {
+			*result = xstrdup(value);
+			refspec->force = fetch->force;
+			return 0;
 		}
 	}
-	refspec->dst = NULL;
 	return -1;
 }
 
diff --git a/remote.h b/remote.h
index 080b7da..17b8b5b 100644
--- a/remote.h
+++ b/remote.h
@@ -20,13 +20,16 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 
+typedef int each_remote_fn(struct remote *remote, void *priv);
+int for_each_remote(each_remote_fn fn, void *priv);
+
 int remote_has_uri(struct remote *remote, const char *uri);
 
 struct refspec {
 	unsigned force : 1;
 	unsigned pattern : 1;
 
-	const char *src;
+	char *src;
 	char *dst;
 };
 
diff --git a/send-pack.c b/send-pack.c
index fecbda9..9fc8a81 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -305,8 +305,8 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		if (remote) {
 			struct refspec rs;
 			rs.src = ref->name;
-			remote_find_tracking(remote, &rs);
-			if (rs.dst) {
+			rs.dst = NULL;
+			if (!remote_find_tracking(remote, &rs)) {
 				struct ref_lock *lock;
 				fprintf(stderr, " Also local %s\n", rs.dst);
 				if (will_delete_ref) {
-- 
1.5.3.rc0.2783.gf3f7
